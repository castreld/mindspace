<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class TherapistManagementController extends Controller
{
    public function index()
    {
        $applications = User::whereHas('therapistProfile')->with('therapistProfile')->get();
        return response()->json($applications);
    }

    public function approve(User $user)
    {
        if ($user->therapistProfile && $user->role === 'klien') {
            $user->role = 'psikolog';
            $user->save();
            return response()->json(['message' => 'Application approved successfully.']);
        }
        return response()->json(['message' => 'Invalid application or user already a psychologist.'], 400);
    }

    public function reject(User $user)
    {
        if ($therapistProfile = $user->therapistProfile) {
            $filePath = str_replace('storage/', 'public/', $therapistProfile->profile_picture_path);
            Storage::delete($filePath);
            
            $therapistProfile->delete();
            return response()->json(['message' => 'Application rejected successfully.']);
        }
        return response()->json(['message' => 'No application found for this user.'], 404);
    }
}