<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\UserReport;
use App\Models\ConversationReport;

class ReportController extends Controller
{
    /**
     * Store a new user report.
     */
    public function storeUserReport(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'reported_user_id' => 'required|exists:users,id',
            'reason' => 'required|string|max:1000',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        if ($request->reported_user_id == Auth::id()) {
             return response()->json(['message' => 'You cannot report yourself.'], 403);
        }

        $report = UserReport::create([
            'reporter_id' => Auth::id(),
            'reported_user_id' => $request->reported_user_id,
            'reason' => $request->reason,
        ]);

        return response()->json([
            'message' => 'User report submitted successfully.',
            'report' => $report
        ], 201);
    }

    /**
     * Store a new conversation report.
     */
    public function storeConversationReport(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'conversation_id' => 'required|exists:conversations,id',
            'reason' => 'required|string|max:1000',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $conversation = \App\Models\Conversation::find($request->conversation_id);

        if ($conversation->user_one_id != Auth::id() && $conversation->user_two_id != Auth::id()) {
             return response()->json(['message' => 'You are not a participant in this conversation.'], 403);
        }

        $report = ConversationReport::create([
            'reporter_id' => Auth::id(),
            'conversation_id' => $request->conversation_id,
            'reason' => $request->reason,
        ]);

        return response()->json([
            'message' => 'Conversation report submitted successfully.',
            'report' => $report
        ], 201);
    }
}