<?php

namespace App\Http\Controllers\Api;

use App\Events\MessageSent;
use App\Events\MessageDeleted;
use App\Http\Controllers\Controller;
use App\Models\ChatMessage;
use App\Models\Conversation;
use Illuminate\Support\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class ChatController extends Controller
{
    public function sendMessage(Request $request)
    {
        $validated = $request->validate([
            'receiver_id' => 'required|exists:users,id',
            'message' => 'required|string|max:1000',
        ]);

        $sender = Auth::user();
        $senderId = $sender->id;
        $receiverId = $validated['receiver_id'];

        $userOneId = min($senderId, $receiverId);
        $userTwoId = max($senderId, $receiverId);

        
        $conversation = Conversation::where('user_one_id', $userOneId)
            ->where('user_two_id', $userTwoId)
            ->where('status', 'accepted')
            ->first();

        if (!$conversation) {
            return response()->json(['message' => 'Cannot send message. No accepted conversation found.'], 403);
        }

        
        if ($conversation->appointment_id !== null) {
            
            
            if ($sender->role === 'klien') {
                
                
                if ($conversation->session_status === 'ended') {
                    return response()->json(['message' => 'Sesi telah berakhir. Anda tidak dapat mengirim pesan lagi.'], 403);
                }

                
                if ($conversation->session_started_at !== null) {
                    $startTime = Carbon::parse($conversation->session_started_at);
                    $duration = $conversation->session_duration_minutes ?? 5;
                    $overtime = 10;
                    $totalDuration = $duration + $overtime;

                    
                    if (now()->isAfter($startTime->addMinutes($totalDuration))) {
                        
                        $conversation->session_status = 'ended';
                        $conversation->save();
                        return response()->json(['message' => 'Sesi telah berakhir. Anda tidak dapat mengirim pesan lagi.'], 403);
                    }
                }
            }
            
        }
        

        $message = ChatMessage::create([
            'conversation_id' => $conversation->id,
            'sender_id' => $senderId,
            'receiver_id' => $receiverId,
            'message_type' => 'text',
            'message' => $validated['message'],
        ]);

        broadcast(new MessageSent($message->load('sender')));
        return response()->json($message, 201);
    }

    public function sendFile(Request $request)
    {
        $validated = $request->validate([
            'receiver_id' => 'required|exists:users,id',
            'file' => 'required|file|mimes:jpg,jpeg,png,gif,mp4,mov,pdf,doc,docx,txt|max:10240',
        ]);

        $sender = Auth::user();
        $senderId = $sender->id;
        $receiverId = $validated['receiver_id'];

        $userOneId = min($senderId, $receiverId);
        $userTwoId = max($senderId, $receiverId);

        $conversation = Conversation::where('user_one_id', $userOneId)
            ->where('user_two_id', $userTwoId)
            ->where('status', 'accepted')
            ->first();

        if (!$conversation) {
            return response()->json(['message' => 'Cannot send message. No accepted conversation found.'], 403);
        }

        if ($conversation->appointment_id !== null) {
            if ($sender->role === 'klien') {
                if ($conversation->session_status === 'ended') {
                    return response()->json(['message' => 'Sesi telah berakhir. Anda tidak dapat mengirim pesan lagi.'], 403);
                }

                if ($conversation->session_started_at !== null) {
                    $startTime = Carbon::parse($conversation->session_started_at);
                    $duration = $conversation->session_duration_minutes ?? 5;
                    $overtime = 10;
                    $totalDuration = $duration + $overtime;
                    if (now()->isAfter($startTime->addMinutes($totalDuration))) {
                        $conversation->session_status = 'ended';
                        $conversation->save();
                        return response()->json(['message' => 'Sesi telah berakhir. Anda tidak dapat mengirim pesan lagi.'], 403);
                    }
                }
            }
        }

        $file = $request->file('file');
        $originalName = $file->getClientOriginalName();
        
        
        $path = $file->store('chat_files', 'public');
        
        $fullUrl = asset('api' . Storage::url($path));

        $mime = $file->getMimeType();
        $type = 'file';
        if (str_starts_with($mime, 'image/')) {
            $type = 'image';
        } else if (str_starts_with($mime, 'video/')) {
            $type = 'video';
        }

        $message = ChatMessage::create([
            'conversation_id' => $conversation->id,
            'sender_id' => $senderId,
            'receiver_id' => $receiverId,
            'message_type' => $type,
            'message' => null, 
            'file_path' => $fullUrl, 
            'original_file_name' => $originalName,
        ]);

        broadcast(new MessageSent($message->load('sender')));
        return response()->json($message, 201);
    }

    public function deleteMessage(ChatMessage $message)
    {
        if ($message->sender_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized. You can only delete your own messages.'], 403);
        }

        $messageId = $message->id;
        $conversationId = $message->conversation_id;

        $message->delete();

        broadcast(new MessageDeleted($messageId, $conversationId))->toOthers();

        return response()->json(['message' => 'Message deleted successfully.'], 200);
    }
}