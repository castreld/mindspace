<?php

namespace App\Http\Controllers\Psikolog;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use App\Models\Appointment;
use App\Models\Conversation; 
use Throwable;

class TherapistAppointmentController extends Controller
{
    public function index(Request $request)
    {
        try {
            $therapist = Auth::user();

            if (!$therapist) {
                return response()->json(['message' => 'Unauthenticated.'], 401);
            }

            Log::info("Fetching appointments for therapist ID: {$therapist->id}");

            $appointments = Appointment::where('therapist_id', $therapist->id)
                                        ->with(['client' => function ($query) {
                                            $query->select('id', 'full_name', 'profile_picture');
                                        }])
                                        ->orderBy('appointment_time', 'asc')
                                        ->get();

            return response()->json($appointments);

        } catch (Throwable $e) {
            Log::error("Failed to fetch therapist appointments: " . $e->getMessage());

            return response()->json([
                'message' => 'An internal server error occurred.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function approve(Appointment $appointment)
    {
        if (Auth::id() !== $appointment->therapist_id) {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $appointment->status = 'scheduled';
        $appointment->save();

        Log::info("Appointment approved.", ['appointment_id' => $appointment->id, 'therapist_id' => Auth::id()]);

        return response()->json($appointment);
    }

    public function reject(Request $request, Appointment $appointment)
    {
        if (Auth::id() !== $appointment->therapist_id) {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $request->validate(['reason' => 'required|string|max:1000']);

        $appointment->status = 'cancelled';
        $appointment->therapist_notes = $request->input('reason');
        $appointment->save();

        Log::info("Appointment rejected by therapist.", ['appointment_id' => $appointment->id, 'therapist_id' => Auth::id()]);

        return response()->json($appointment);
    }

    public function addNotes(Request $request, Appointment $appointment)
    {
        $therapist = Auth::user();

        if ($appointment->therapist_id !== $therapist->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        if ($appointment->status !== 'completed' && $appointment->conversation?->session_status !== 'ended') {
             return response()->json(['message' => 'Notes can only be added after the session has ended.'], 400);
        }

        $validator = Validator::make($request->all(), [
            'notes' => ['required', 'string', 'max:2000'],
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $appointment->therapist_notes = $request->input('notes');
        $appointment->save();

        Log::info("Therapist notes added/updated.", ['appointment_id' => $appointment->id, 'therapist_id' => $therapist->id]);

        return response()->json($appointment);
    }
}