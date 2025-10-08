<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\TherapistProfile;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

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
        ]);

        
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

        
        

        return response()->json([
            'message' => 'Application submitted successfully!',
            'therapist_profile' => $therapistProfile,
        ], 201);
    }
}