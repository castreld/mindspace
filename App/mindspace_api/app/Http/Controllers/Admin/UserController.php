<?php

namespace App\Http\Controllers\Admin;

use App\Events\UserSuspended;
use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Display a listing of the client users.
     */
    public function index(Request $request)
    {
        $query = User::where('role', 'klien');

        // Add search functionality
        $query->when($request->search, function ($q, $search) {
            $q->where(function ($subQuery) use ($search) {
                $subQuery->where('full_name', 'like', "%{$search}%")
                         ->orWhere('email', 'like', "%{$search}%");
            });
        });

        $users = $query->orderBy('created_at', 'desc')->get();
        return response()->json($users);
    }

    /**
     * Suspend a client user.
     */
    public function suspend(Request $request, User $user)
    {
        if ($user->role !== 'klien') {
            return response()->json(['message' => 'This user is not a client.'], 400);
        }

        $validated = $request->validate([
            'days' => 'required|integer|min:1',
            'reason' => 'required|string|max:1000',
        ]);

        $user->suspended_until = now()->addDays($validated['days']);
        $user->suspended_reason = $validated['reason'];
        $user->save();

        event(new UserSuspended($user));

        return response()->json([
            'message' => 'User suspended successfully until ' . $user->suspended_until->toFormattedDateString(),
            'user' => $user
        ]);
    }

    /**
     * Unsuspend a client user.
     */
    public function unsuspend(User $user)
    {
        if ($user->role !== 'klien') {
            return response()->json(['message' => 'This user is not a client.'], 400);
        }

        $user->suspended_until = null;
        $user->suspended_reason = null;
        $user->save();

        event(new UserSuspended($user));

        return response()->json([
            'message' => 'User suspension lifted successfully.',
            'user' => $user
        ]);
    }
}