<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use App\Models\Appointment;
use Carbon\Carbon;

class AppointmentController extends Controller
{
    public function index(Request $request)
    {
        $client = Auth::user();

        $appointments = Appointment::where('client_id', $client->id)
                                      ->with('therapist:id,full_name')
                                      ->orderBy('appointment_time', 'desc')
                                      ->get();

        return response()->json($appointments);
    }

    public function destroy($id)
    {
        $appointment = Appointment::find($id);

        if (!$appointment) {
            return response()->json(['message' => 'Appointment not found.'], 404);
        }

        if (Auth::id() !== $appointment->client_id) {
            return response()->json(['message' => 'Forbidden'], 403);
        }
        
        if ($appointment->status === 'completed') {
            return response()->json(['message' => 'Cannot delete a completed appointment.'], 400);
        }

        $appointment->delete();

        Log::info("Appointment deleted by client.", ['appointment_id' => $appointment->id, 'client_id' => Auth::id()]);

        return response()->json(['message' => 'Appointment successfully deleted.'], 200);
    }

    public function store(Request $request)
    {
        $user = $request->user();

        $validator = Validator::make($request->all(), [
            'therapist_id' => 'required|exists:users,id',
            'appointment_time' => 'required|date',
            'duration_minutes' => 'required|integer|min:60',
            'client_notes' => 'nullable|string|max:1000',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors(), 'message' => 'Validasi gagal. Periksa input Anda.'], 422);
        }

        $appointmentTime = Carbon::parse($request->input('appointment_time'));
        
        $minAllowed = Carbon::now()->addHours(24);
        if ($appointmentTime->lessThan($minAllowed)) {
            return response()->json(['error' => 'Booking harus dibuat minimal 24 jam sebelum waktu sesi.'], 422);
        }

        $therapistId = $request->input('therapist_id');
        $duration = (int) $request->input('duration_minutes');
        $appointmentEnd = $appointmentTime->copy()->addMinutes($duration);
        
        
        $conflict = Appointment::where('therapist_id', $therapistId)
            ->where(function ($q) use ($appointmentTime, $appointmentEnd) { 
                $q->whereBetween('appointment_time', [$appointmentTime, $appointmentEnd]) 
                  ->orWhereRaw("DATE_ADD(appointment_time, INTERVAL duration_minutes MINUTE) > ? AND appointment_time < ?", [$appointmentTime, $appointmentEnd]); 
            })->exists();

        if ($conflict) {
            return response()->json(['error' => 'Waktu yang dipilih bertabrakan dengan jadwal terapis yang sudah ada. Silakan pilih waktu lain.'], 422);
        }

        $appointment = Appointment::create([
            'client_id' => $user->id,
            'therapist_id' => $therapistId,
            'availability_id' => $request->input('availability_id'),
            'appointment_time' => $appointmentTime->toDateTimeString(),
            'duration_minutes' => $duration,
            'client_notes' => $request->input('client_notes'),
            'status' => 'pending_payment',
        ]);

        return response()->json($appointment, 201);
    }
}