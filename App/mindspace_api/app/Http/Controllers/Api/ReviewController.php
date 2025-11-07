<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Appointment;
use App\Models\Review;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class ReviewController extends Controller
{
    public function store(Request $request, Appointment $appointment)
    {
        $user = Auth::user();

        if ($appointment->client_id !== $user->id) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }
        
        if ($appointment->status !== 'completed') {
            return response()->json(['message' => 'Review can only be submitted for completed appointments.'], 400);
        }
        
        if ($appointment->review()->exists()) {
             return response()->json(['message' => 'Review already submitted for this appointment.'], 409); 
        }
        
        $validator = Validator::make($request->all(), [
            'rating' => ['required', 'integer', 'min:1', 'max:5'],
            'comment' => ['nullable', 'string', 'max:1000'],
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        
        $review = $appointment->review()->create([
            'client_id' => $user->id,
            'therapist_id' => $appointment->therapist_id,
            'rating' => $request->input('rating'),
            'comment' => $request->input('comment'),
        ]);
        
        return response()->json($review, 201);
    }
}