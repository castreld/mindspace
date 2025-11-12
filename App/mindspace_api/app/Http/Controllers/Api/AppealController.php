<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\SuspensionAppeal;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AppealController extends Controller
{
    public function store(Request $request)
    {
        $user = Auth::user();

        if (!$user->suspended_until || $user->suspended_until <= now()) {
            return response()->json(['message' => 'Your account is not suspended.'], 400);
        }

        $existingAppeal = SuspensionAppeal::where('user_id', $user->id)
                                          ->where('status', 'pending')
                                          ->first();
                                          
        if ($existingAppeal) {
            return response()->json(['message' => 'You already have a pending appeal.'], 409);
        }

        $validated = $request->validate([
            'reason' => 'required|string|min:20|max:2000',
        ]);

        $appeal = SuspensionAppeal::create([
            'user_id' => $user->id,
            'reason' => $validated['reason'],
        ]);

        return response()->json([
            'message' => 'Your appeal has been submitted successfully.',
            'appeal' => $appeal,
        ], 201);
    }
}