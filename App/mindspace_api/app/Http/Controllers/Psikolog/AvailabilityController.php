<?php

namespace App\Http\Controllers\Psikolog;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\TherapistAvailability;

class AvailabilityController extends Controller
{
    /**
     * Get the current authenticated psychologist's availability.
     */
    public function get(Request $request)
    {
        $availabilities = $request->user()->availabilities()->get();
        return response()->json($availabilities);
    }

    /**
     * Update the current authenticated psychologist's availability.
     */
    public function update(Request $request)
    {
        $validated = $request->validate([
            'availabilities' => 'required|array',
            'availabilities.*.day_of_week' => 'required|integer|between:1,7',
            'availabilities.*.start_time' => 'required|date_format:H:i',
            'availabilities.*.end_time' => 'required|date_format:H:i|after:availabilities.*.start_time',
        ]);

        $user = $request->user();

        DB::transaction(function () use ($user, $validated) {
            $user->availabilities()->delete();

            foreach ($validated['availabilities'] as $slot) {
                TherapistAvailability::create([
                    'user_id' => $user->id,
                    'day_of_week' => $slot['day_of_week'],
                    'start_time' => $slot['start_time'],
                    'end_time' => $slot['end_time'],
                ]);
            }
        });

        return response()->json(['message' => 'Availability updated successfully.']);
    }
}