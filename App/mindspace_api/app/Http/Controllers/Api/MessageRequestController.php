<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Conversation;
use App\Models\ChatMessage;
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

        $senderId = Auth::id();
        $receiverId = $validated['receiver_id'];

        
        $userOneId = min($senderId, $receiverId);
        $userTwoId = max($senderId, $receiverId);

        
        return DB::transaction(function () use ($userOneId, $userTwoId, $senderId, $validated) {
            $conversation = Conversation::firstOrCreate(
                ['user_one_id' => $userOneId, 'user_two_id' => $userTwoId],
                ['initiator_id' => $senderId, 'status' => 'pending']
            );

            
            if ($conversation->status === 'rejected') {
                $conversation->status = 'pending';
                $conversation->initiator_id = $senderId;
                $conversation->save();
            }

            
            if ($conversation->wasRecentlyCreated || ($conversation->status === 'pending' && $conversation->initiator_id !== $senderId)) {
                $message = ChatMessage::create([
                    'conversation_id' => $conversation->id,
                    'sender_id' => $senderId,
                    'receiver_id' => $validated['receiver_id'],
                    'message' => $validated['message'],
                ]);
    
                return response()->json(['message' => 'Message request sent.', 'data' => $conversation], 201);
            }

            return response()->json(['message' => 'A message request is already pending.'], 409); 
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