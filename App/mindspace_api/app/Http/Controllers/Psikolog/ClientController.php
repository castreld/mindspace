<?php

namespace App\Http\Controllers\Psikolog;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use App\Models\Appointment;

class ClientController extends Controller
{
    public function show(User $client)
    {
        $therapist = Auth::user();

        
        $hasAppointment = Appointment::where('therapist_id', $therapist->id)
                                     ->where('client_id', $client->id)
                                     ->exists();

        if (!$hasAppointment) {
            return response()->json(['message' => 'Forbidden: You do not have access to this client.'], 403);
        }

        
        
        return response()->json($client);
    }
}