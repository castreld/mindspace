<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Conversation;
use App\Models\ChatMessage;
use App\Models\User;
use App\Models\Appointment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;

class MessageRequestController extends Controller
{
    /**
     * Get pending message requests for the authenticated user.
     */
    public function index()
    {
        $userId = Auth::id();

        $requests = Conversation::where('status', 'pending')
            ->where(function ($query) use ($userId) {
                $query->where('user_one_id', $userId)
                      ->orWhere('user_two_id', $userId);
            })
            ->where('initiator_id', '!=', $userId) 
            ->with('initiator:id,full_name,profile_picture')
            ->get();

        return response()->json($requests);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'receiver_id' => ['required', 'exists:users,id', Rule::notIn([Auth::id()])],
            'message' => 'required|string|max:1000',
        ]);

        $sender = Auth::user();
        $receiver = User::find($validated['receiver_id']);

        if ($sender->role === 'klien' && $receiver->role === 'psikolog') {
            return response()->json(['message' => 'Anda tidak dapat mengirim permintaan pesan ke psikolog. Silakan lakukan booking.'], 403);
        }

        $senderId = $sender->id;
        $receiverId = $receiver->id;
        $userOneId = min($senderId, $receiverId);
        $userTwoId = max($senderId, $receiverId);

        return DB::transaction(function () use ($userOneId, $userTwoId, $sender, $receiver, $validated) {
            
            if ($sender->role === 'psikolog' && $receiver->role === 'klien') {
                
                $appointment = Appointment::where('therapist_id', $sender->id)
                    ->where('client_id', $receiver->id)
                    ->where('status', 'scheduled') 
                    ->where('appointment_time', '>', now()->subHours(1)) 
                    ->where('appointment_time', '<', now()->addHours(1)) 
                    ->first();

                if (!$appointment) {
                    return response()->json(['message' => 'Tidak ada jadwal konsultasi aktif dengan klien ini.'], 403);
                }

                $conversation = Conversation::firstOrCreate(
                    ['user_one_id' => $userOneId, 'user_two_id' => $userTwoId, 'appointment_id' => $appointment->id],
                    [
                        'initiator_id' => $sender->id,
                        'status' => 'accepted', 
                        'session_status' => 'active', 
                        'session_started_at' => now(), 
                        'session_duration_minutes' => $appointment->duration_minutes ?? 60,
                    ]
                );

                if (!$conversation->wasRecentlyCreated) {
                    if ($conversation->session_status == 'active') {
                        return response()->json(['message' => 'Sesi konsultasi sudah berjalan.'], 409);
                    }
                }
            } 
            else {
                $conversation = Conversation::firstOrCreate(
                    ['user_one_id' => $userOneId, 'user_two_id' => $userTwoId],
                    ['initiator_id' => $sender->id, 'status' => 'pending', 'session_status' => 'pending']
                );
                if ($conversation->status === 'rejected') {
                    $conversation->status = 'pending';
                    $conversation->session_status = 'pending';
                    $conversation->initiator_id = $sender->id;
                    $conversation->save();
                }
                if (!$conversation->wasRecentlyCreated && $conversation->status === 'pending') {
                    return response()->json(['message' => 'A message request is already pending.'], 409);
                }
                if ($conversation->status === 'accepted') {
                    return response()->json(['message' => 'Anda sudah terhubung dengan pengguna ini.'], 409);
                }
            }
            
            $message = ChatMessage::create([
                'conversation_id' => $conversation->id,
                'sender_id' => $sender->id,
                'receiver_id' => $validated['receiver_id'],
                'message' => $validated['message'],
            ]);

            return response()->json(['message' => 'Message request sent.', 'data' => $conversation], 201);
        });
    }

    public function accept(Conversation $conversation)
    {
        if ($conversation->initiator_id === Auth::id() || $conversation->status !== 'pending') {
            return response()->json(['message' => 'Forbidden or request is not pending.'], 403);
        }

        $conversation->status = 'accepted';
        $conversation->save();

        return response()->json(['message' => 'Request accepted.', 'data' => $conversation]);
    }

    public function reject(Conversation $conversation)
    {
        if ($conversation->initiator_id === Auth::id() || $conversation->status !== 'pending') {
            return response()->json(['message' => 'Forbidden or request is not pending.'], 403);
        }

        $conversation->status = 'rejected';
        $conversation->save();

        return response()->json(['message' => 'Request rejected.']);
    }
}