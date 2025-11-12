<?php
namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class TherapistManagementController extends Controller
{
    public function index(Request $request)
    {
        $query = User::whereHas('therapistProfile')->with('therapistProfile');

        // Add search functionality
        $query->when($request->search, function ($q, $search) {
            $q->where(function ($subQuery) use ($search) {
                $subQuery->where('full_name', 'like', "%{$search}%")
                         ->orWhere('email', 'like', "%{$search}%");
            });
        });

        $applications = $query->get();
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

    public function suspend(Request $request, User $user)
    {
        if ($user->role !== 'psikolog') {
            return response()->json(['message' => 'This user is not a psychologist.'], 400);
        }

        $validated = $request->validate([
            'days' => 'required|integer|min:1',
            'reason' => 'required|string|max:1000',
        ]);

        $user->suspended_until = now()->addDays($validated['days']);
        $user->suspended_reason = $validated['reason'];
        $user->save();

        return response()->json([
            'message' => 'User suspended successfully until ' . $user->suspended_until->toFormattedDateString(),
            'user' => $user
        ]);
    }

    public function unsuspend(User $user)
    {
        if ($user->role !== 'psikolog') {
            return response()->json(['message' => 'This user is not a psychologist.'], 400);
        }

        $user->suspended_until = null;
        $user->suspended_reason = null;
        $user->save();

        return response()->json([
            'message' => 'User suspension lifted successfully.',
            'user' => $user
        ]);
    }
}