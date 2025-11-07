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

    public function show(Appointment $appointment)
    {
        $user = Auth::user();

        if ($user->id !== $appointment->client_id && $user->id !== $appointment->therapist_id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $appointment->load(['client:id,full_name,username', 'therapist:id,full_name', 'review']);

        if ($appointment->status !== 'completed') {
             if ($user->role == 'klien') {
                 $appointment->makeHidden(['therapist_notes']);
             }
        }
         if ($user->role == 'psikolog') {
            $appointment->makeHidden(['client_notes']);
         }


        return response()->json($appointment);
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
            'availability_id' => 'required|exists:therapist_availabilities,id',
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
            ->where('status', '!=', 'cancelled')
            ->where('status', '!=', 'payment_failed') 
            ->where(function ($q) use ($appointmentTime, $appointmentEnd) {
                 $q->where(function ($subQ) use ($appointmentTime) {
                     $subQ->where('appointment_time', '<=', $appointmentTime)
                          ->whereRaw('DATE_ADD(appointment_time, INTERVAL duration_minutes MINUTE) > ?', [$appointmentTime]);
                 })
                 ->orWhere(function ($subQ) use ($appointmentEnd) {
                     $subQ->where('appointment_time', '<', $appointmentEnd)
                          ->whereRaw('DATE_ADD(appointment_time, INTERVAL duration_minutes MINUTE) >= ?', [$appointmentEnd]);
                 })
                 ->orWhere(function ($subQ) use ($appointmentTime, $appointmentEnd) {
                      $subQ->where('appointment_time', '>=', $appointmentTime)
                           ->whereRaw('DATE_ADD(appointment_time, INTERVAL duration_minutes MINUTE) <= ?', [$appointmentEnd]);
                 });
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

    public function getHistory(Request $request)
    {
        $user = Auth::user();
        $query = Appointment::query();

        if ($user->role == 'klien') {
            $query->where('client_id', $user->id)
                  ->with(['therapist:id,full_name', 'review']);
        } elseif ($user->role == 'psikolog') {
            $query->where('therapist_id', $user->id)
                  ->with(['client:id,full_name,username', 'review']);
        } else {
             return response()->json(['message' => 'Unauthorized role for history'], 403);
        }
        if ($request->has('status') && $request->status !== 'Semua') {
            $statusMapping = [
                'Selesai' => 'completed',
                'Dibatalkan' => 'cancelled',
            ];
            $dbStatus = $statusMapping[$request->status] ?? null;
            if ($dbStatus) {
                $query->where('status', $dbStatus);
            }
        }
        if ($request->has('search') && !empty($request->search)) {
            $searchTerm = '%' . strtolower($request->search) . '%';

            $query->where(function ($q) use ($searchTerm, $user, $request, $query) {
                if ($user->role == 'klien') {
                     $q->whereHas('therapist', function ($subQ) use ($searchTerm) {
                        $subQ->whereRaw('LOWER(full_name) LIKE ?', [$searchTerm]);
                    });
                } else {
                     $q->whereHas('client', function ($subQ) use ($searchTerm) {
                        $subQ->whereRaw('LOWER(full_name) LIKE ?', [$searchTerm])
                             ->orWhereRaw('LOWER(username) LIKE ?', [$searchTerm]);
                    });
                }
                 try {
                     $allAppointmentsForSearch = (clone $query)->get(['id', 'client_notes']);
                     $matchingIds = [];
                     foreach ($allAppointmentsForSearch as $app) {
                         if (stripos($app->client_notes ?? '', $request->search) !== false) {
                             $matchingIds[] = $app->id;
                         }
                     }
                     $q->orWhereIn('id', $matchingIds);

                 } catch (\Exception $e) {
                      Log::error('Error attempting to search encrypted client_notes: ' . $e->getMessage());
                 }
            });
        }

        $appointments = $query->orderBy('appointment_time', 'desc')->get();

        $appointments->each(function ($appointment) {
            if ($appointment->status === 'completed') {
            } else {
                if (Auth::user()->role == 'klien') {
                    unset($appointment->therapist_notes);
                }
            }
            if (Auth::user()->role == 'psikolog') {
                unset($appointment->client_notes);
            }

        });


        return response()->json($appointments);
    }
}