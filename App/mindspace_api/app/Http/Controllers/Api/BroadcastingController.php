<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use App\Models\Conversation;

class BroadcastingController extends Controller
{
    public function auth(Request $request)
    {
        $user = $request->user();
        $socketId = $request->input('socket_id');
        $channelName = $request->input('channel_name');

        Log::info('Broadcasting Auth Request', [
            'user_id' => $user?->id,
            'socket_id' => $socketId,
            'channel_name' => $channelName,
        ]);

        if (!$user) {
            Log::warning('No authenticated user for broadcasting auth');
            return response()->json(['error' => 'Unauthenticated'], 401);
        }

        if (!$socketId || !$channelName) {
            Log::error('Missing socket_id or channel_name', [
                'socket_id' => $socketId,
                'channel_name' => $channelName,
            ]);
            return response()->json(['error' => 'Missing required fields'], 400);
        }

        // Parse the channel name: private-chat.{conversationId}
        $parts = explode('.', $channelName);
        
        if (count($parts) !== 2 || $parts[0] !== 'private-chat') {
            Log::error('Invalid channel name format', ['channel_name' => $channelName]);
            return response()->json(['error' => 'Invalid channel format'], 400);
        }

        // Get the conversation ID from channel name
        $conversationId = (int) $parts[1];
        $currentUserId = (int) $user->id;

        Log::info('Channel Authorization Check', [
            'current_user' => $currentUserId,
            'conversation_id' => $conversationId,
        ]);

        // Check if the user is part of this conversation
        $conversation = Conversation::find($conversationId);

        if (!$conversation) {
            Log::warning('Conversation not found', [
                'conversation_id' => $conversationId,
            ]);
            return response()->json(['error' => 'Conversation not found'], 404);
        }

        // Authorize: user must be either user_one_id or user_two_id in the conversation
        $authorized = $currentUserId === $conversation->user_one_id || 
                     $currentUserId === $conversation->user_two_id;

        if (!$authorized) {
            Log::warning('User not authorized for channel', [
                'user_id' => $currentUserId,
                'channel' => $channelName,
                'conversation_user_one_id' => $conversation->user_one_id,
                'conversation_user_two_id' => $conversation->user_two_id,
            ]);
            return response()->json(['error' => 'Unauthorized'], 403);
        }

        // Generate the auth signature manually for Reverb (Pusher protocol)
        try {
            $appKey = config('broadcasting.connections.reverb.key');
            $appSecret = config('broadcasting.connections.reverb.secret');
            
            if (!$appKey || !$appSecret) {
                Log::error('Missing Reverb credentials');
                return response()->json(['error' => 'Server configuration error'], 500);
            }

            // Create the string to sign: socket_id:channel_name
            $stringToSign = $socketId . ':' . $channelName;
            
            // Generate the auth signature using HMAC SHA256
            $authSignature = hash_hmac('sha256', $stringToSign, $appSecret);
            
            // Format: app_key:signature
            $auth = $appKey . ':' . $authSignature;
            
            Log::info('Broadcasting auth successful', [
                'user_id' => $currentUserId,
                'channel' => $channelName,
                'auth' => substr($auth, 0, 20) . '...',
            ]);

            return response()->json(['auth' => $auth]);
        } catch (\Exception $e) {
            Log::error('Broadcasting auth failed', [
                'error' => $e->getMessage(),
                'channel' => $channelName,
                'trace' => $e->getTraceAsString(),
            ]);
            return response()->json(['error' => 'Auth failed'], 500);
        }
    }
}