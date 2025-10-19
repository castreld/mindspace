<?php

use App\Models\Conversation;
use App\Models\User;
use Illuminate\Support\Facades\Broadcast;
use Illuminate\Support\Facades\Log;

Broadcast::channel('chat.{conversation}', function (User $user, Conversation $conversation) {
    Log::info("--- Broadcasting Auth Check for chat.{$conversation->id} ---");
    Log::info("Authenticated User ID: {$user->id}");
    Log::info("Conversation Participants: User {$conversation->user_one_id} and User {$conversation->user_two_id}");

    return (int)$user->id === (int)$conversation->user_one_id || 
           (int)$user->id === (int)$conversation->user_two_id;
});