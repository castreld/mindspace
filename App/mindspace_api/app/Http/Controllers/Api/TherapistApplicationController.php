<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\TherapistProfile;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

use App\Models\TherapistAvailability;
use Illuminate\Container\Attributes\Log;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class TherapistApplicationController extends Controller
{
    /**
     * Store a newly created therapist application in storage.
     */
    public function store(Request $request)
{
    $user = $request->user();

    if (TherapistProfile::where('user_id', $user->id)->exists()) {
        return response()->json(['message' => 'You have already submitted an application.'], 409);
    }

    $validatedData = $request->validate([
        'profile_picture' => 'required|image|mimes:jpeg,png,jpg|max:2048',
        'education_history' => 'required|string|max:255',
        'hourly_rate' => 'required|integer|min:0',
        'experience_years' => 'required|integer|min:0',
        'specializations' => 'required|array',
        'specializations.*' => ['string', Rule::in(['Klinis Dewasa', 'Klinis Anak dan Remaja', 'Klinis Pendidikan'])],
        'problem_areas' => 'required|string|max:255',
        
        'availabilities' => 'required|string', 
    ]);

    
    $availabilities = json_decode($validatedData['availabilities'], true);
    if (json_last_error() !== JSON_ERROR_NONE || !is_array($availabilities)) {
        throw ValidationException::withMessages(['availabilities' => 'Invalid availability format.']);
    }

    

    DB::beginTransaction();
    try {
        $filePath = $request->file('profile_picture')->store('public/therapist_pictures');
        
        $therapistProfile = TherapistProfile::create([
            'user_id' => $user->id,
            'profile_picture_path' => str_replace('public/', 'storage/', $filePath),
            'education_history' => $validatedData['education_history'],
            'hourly_rate' => $validatedData['hourly_rate'],
            'experience_years' => $validatedData['experience_years'],
            'specializations' => $validatedData['specializations'],
            'problem_areas' => $validatedData['problem_areas'],
        ]);

        
        foreach ($availabilities as $slot) {
            TherapistAvailability::create([
                'user_id' => $user->id,
                'day_of_week' => $slot['day_of_week'], 
                'start_time' => $slot['start_time'],   
                'end_time' => $slot['end_time'],     
            ]);
        }
        
        DB::commit();

        return response()->json([
            'message' => 'Application submitted successfully!',
            'therapist_profile' => $therapistProfile,
        ], 201);

    } catch (\Exception $e) {
        DB::rollBack();
        
        return response()->json(['message' => 'An unexpected error occurred. Please try again later.'], 500);
    }
}
}