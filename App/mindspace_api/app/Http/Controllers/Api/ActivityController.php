<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ActivityController extends Controller
{
    public function getActivityHistory(Request $request)
    {
        $activities = Auth::user()->activityLogs()->latest()->paginate(15);

        return response()->json($activities);
    }
}