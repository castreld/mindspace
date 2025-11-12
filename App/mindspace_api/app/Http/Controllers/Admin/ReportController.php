<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\UserReport;
use App\Models\ConversationReport;
use Illuminate\Validation\Rule;

class ReportController extends Controller
{
    /**
     * Get all user reports.
     */
    public function indexUserReports(Request $request)
    {
        $status = $request->query('status', 'pending');
        
        $reports = UserReport::with('reporter:id,full_name,email', 'reportedUser:id,full_name,email,role')
            ->where('status', $status)
            ->orderBy('created_at', 'desc')
            ->paginate(15);

        return response()->json($reports);
    }

    /**
     * Get all conversation reports.
     */
    public function indexConversationReports(Request $request)
    {
        $status = $request->query('status', 'pending');

        $reports = ConversationReport::with(
            'reporter:id,full_name,email', 
            'conversation.userOne:id,full_name', 
            'conversation.userTwo:id,full_name'
            )
            ->where('status', $status)
            ->orderBy('created_at', 'desc')
            ->paginate(15);

        return response()->json($reports);
    }

    /**
     * Update a user report.
     */
    public function updateUserReport(Request $request, UserReport $userReport)
    {
        $validator = Validator::make($request->all(), [
            'status' => ['required', Rule::in(['pending', 'under_review', 'resolved', 'dismissed'])],
            'admin_notes' => 'nullable|string|max:2000',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $userReport->update([
            'status' => $request->status,
            'admin_notes' => $request->admin_notes,
        ]);

        return response()->json([
            'message' => 'User report updated successfully.',
            'report' => $userReport
        ]);
    }

    /**
     * Update a conversation report.
     */
    public function updateConversationReport(Request $request, ConversationReport $conversationReport)
    {
        $validator = Validator::make($request->all(), [
            'status' => ['required', Rule::in(['pending', 'under_review', 'resolved', 'dismissed'])],
            'admin_notes' => 'nullable|string|max:2000',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $conversationReport->update([
            'status' => $request->status,
            'admin_notes' => $request->admin_notes,
        ]);

        return response()->json([
            'message' => 'Conversation report updated successfully.',
            'report' => $conversationReport
        ]);
    }
}