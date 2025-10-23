<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Conversation;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ConversationController extends Controller
{
    public function index()
    {
        $currentUserId = Auth::id();

        $conversations = Conversation::where('status', 'accepted')
            ->where(function ($query) use ($currentUserId) {
                $query->where('user_one_id', $currentUserId)
                      ->orWhere('user_two_id', $currentUserId);
            })
            ->with(['userOne', 'userTwo', 'latestMessage'])
            ->get()
            ->map(function ($conversation) use ($currentUserId) {
                $otherUser = $conversation->user_one_id === $currentUserId 
                    ? $conversation->userTwo 
                    : $conversation->userOne;

                return [
                    'id' => $conversation->id,
                    'user_one_id' => $conversation->user_one_id,  
                    'user_two_id' => $conversation->user_two_id,  
                    'other_user_id' => $otherUser->id,            
                    'full_name' => $otherUser->full_name,
                    'profile_picture' => $otherUser->profile_picture,
                    'last_message_text' => $conversation->latestMessage?->message ?? 'No messages yet',
                    'last_message_time' => $conversation->latestMessage?->created_at 
                        ?? $conversation->created_at,
                ];
            });

        return response()->json($conversations);
    }

    public function show(User $user)
    {
        $currentUserId = Auth::id();
        
        $userOneId = min($currentUserId, $user->id);
        $userTwoId = max($currentUserId, $user->id);

        $conversation = Conversation::where('user_one_id', $userOneId)
            ->where('user_two_id', $userTwoId)
            ->where('status', 'accepted')
            ->with(['messages' => function ($query) {
                $query->orderBy('created_at', 'asc');
            }])
            ->firstOrFail();

        return response()->json([
            'id' => $conversation->id,
            'user_one_id' => $conversation->user_one_id,
            'user_two_id' => $conversation->user_two_id,
            'full_name' => $user->full_name,
            'profile_picture' => $user->profile_picture,
            'messages' => $conversation->messages,
        ]);
    }

    public function getMessages(Conversation $conversation)
    {
        $currentUserId = Auth::id();

        if ($conversation->user_one_id !== $currentUserId && 
            $conversation->user_two_id !== $currentUserId) {
            return response()->json(['error' => 'Unauthorized'], 403);
        }

        
        if ($conversation->status !== 'accepted' && $conversation->appointment_id === null) {
            return response()->json(['error' => 'Conversation not accepted'], 403);
        }

        $messages = $conversation->messages()
            ->orderBy('created_at', 'asc')
            ->get();

        
        return response()->json([
            'conversation' => $conversation,
            'messages' => $messages,
        ]);
    }

    public function deleteConversation(Conversation $conversation)
    {
        $currentUserId = Auth::id();

        if ($conversation->user_one_id !== $currentUserId && $conversation->user_two_id !== $currentUserId) {
            return response()->json(['message' => 'Unauthorized.'], 403);
        }

        try {
            DB::transaction(function () use ($conversation) {
                $conversation->messages()->delete();
                $conversation->delete();
            });

            return response()->json(['message' => 'Conversation deleted successfully.'], 200);

        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to delete conversation.'], 500);
        }
    }

    public function stopSession(Conversation $conversation)
    {
        $user = Auth::user();

        if ($user->role !== 'klien' || 
        ($conversation->user_one_id !== $user->id && $conversation->user_two_id !== $user->id)) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        if ($conversation->appointment_id === null || $conversation->session_status !== 'active') {
            
            if ($conversation->session_status === 'ended') {
                return response()->json(['message' => 'Sesi sudah berakhir.'], 400);
            }
        }

        $conversation->session_status = 'ended';
        $conversation->save();

        return response()->json(['message' => 'Session ended successfully.']);
    }
}