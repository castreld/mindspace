<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class ActivityController extends Controller
{
    public function getActivityHistory(Request $request)
    {
        /** @var User $user */
        $user = Auth::user();
        
        $activities = $user->activityLogs()->latest()->paginate(15);

        return response()->json($activities);
    }
}