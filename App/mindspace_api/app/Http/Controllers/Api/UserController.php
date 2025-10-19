<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    public function index()
    {
        $users = User::all();

        return response()->json($users);
    }
    
    public function searchClients(Request $request)
    {
        $validated = $request->validate([
            'query' => 'required|string|min:1|max:100',
        ]);

        $query = $validated['query'];
        $currentUserId = Auth::id();

        $clients = User::where('role', 'klien')
            ->where('id', '!=', $currentUserId)
            ->where(function ($q) use ($query) {
                $q->where('full_name', 'like', "%{$query}%")
                  ->orWhere('email', 'like', "%{$query}%");
            })
            ->select('id', 'full_name', 'email', 'profile_picture')
            ->limit(20)
            ->get();

        return response()->json($clients);
    }
}