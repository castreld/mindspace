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
        $currentUserId = (int) $user->id;

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

        $authorized = false;

        if (str_starts_with($channelName, 'private-chat.')) {
            $conversationId = (int) str_replace('private-chat.', '', $channelName);
            $conversation = Conversation::find($conversationId);

            if ($conversation && ($currentUserId === $conversation->user_one_id || $currentUserId === $conversation->user_two_id)) {
                $authorized = true;
            } else {
                Log::warning('User not authorized for chat channel', [
                    'user_id' => $currentUserId,
                    'channel' => $channelName,
                ]);
                return response()->json(['error' => 'Unauthorized for chat'], 403);
            }
        } 
        else if (str_starts_with($channelName, 'App.Models.User.')) {
            $channelUserId = (int) str_replace('App.Models.User.', '', $channelName);

            if ($currentUserId === $channelUserId) {
                $authorized = true;
            } else {
                Log::warning('User not authorized for user channel', [
                    'user_id' => $currentUserId,
                    'channel' => $channelName,
                ]);
                return response()->json(['error' => 'Unauthorized for user channel'], 403);
            }
        }

        if (!$authorized) {
            Log::error('Invalid channel name format or unhandled channel', ['channel_name' => $channelName]);
            return response()->json(['error' => 'Invalid channel format'], 400);
        }

        try {
            $appKey = config('broadcasting.connections.reverb.key');
            $appSecret = config('broadcasting.connections.reverb.secret');
            
            if (!$appKey || !$appSecret) {
                Log::error('Missing Reverb credentials');
                return response()->json(['error' => 'Server configuration error'], 500);
            }

            $stringToSign = $socketId . ':' . $channelName;

            $authSignature = hash_hmac('sha256', $stringToSign, $appSecret);
            
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