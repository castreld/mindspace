<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\SuspensionAppeal;
use App\Models\User;
use Illuminate\Http\Request;

class AppealController extends Controller
{
    public function index(Request $request)
    {
        $status = $request->query('status', 'pending');

        $appeals = SuspensionAppeal::where('status', $status)
            ->with('user:id,full_name,email,role')
            ->orderBy('created_at', 'asc')
            ->paginate(15);

        return response()->json($appeals);
    }

    public function update(Request $request, SuspensionAppeal $appeal)
    {
        $validated = $request->validate([
            'status' => 'required|in:approved,rejected',
            'admin_notes' => 'nullable|string|max:1000',
        ]);

        $appeal->status = $validated['status'];
        $appeal->admin_notes = $validated['admin_notes'];
        $appeal->save();

        if ($validated['status'] === 'approved') {
            $user = $appeal->user;
            $user->suspended_until = null;
            $user->suspended_reason = null;
            $user->save();
        }

        return response()->json([
            'message' => 'Appeal has been ' . $validated['status'],
            'appeal' => $appeal,
        ]);
    }
}