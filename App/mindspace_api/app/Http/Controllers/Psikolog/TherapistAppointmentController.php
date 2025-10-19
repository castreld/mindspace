<?php

namespace App\Http\Controllers\Psikolog;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
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

        $userOneId = min(Auth::id(), $appointment->client_id);
        $userTwoId = max(Auth::id(), $appointment->client_id);

        Conversation::updateOrCreate(
            ['user_one_id' => $userOneId, 'user_two_id' => $userTwoId],
            [
                'status' => 'accepted',
                'initiator_id' => Auth::id()
            ]
        );

        $appointment->status = 'scheduled';
        $appointment->save();

        Log::info("Appointment approved and conversation created/updated.", ['appointment_id' => $appointment->id, 'therapist_id' => Auth::id()]);

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
}