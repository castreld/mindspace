<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\ActivityLog;
use App\Models\ConversationReport;
use App\Models\SuspensionAppeal;
use App\Models\User;
use App\Models\UserReport;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function getStats()
    {
        $totalClients = User::where('role', 'klien')->count();
        $totalTherapists = User::where('role', 'psikolog')->count();

        $pendingApplications = User::where('role', 'klien')
                                    ->whereHas('therapistProfile')
                                    ->count();
        
        $pendingUserReports = UserReport::where('status', 'pending')->count();
        $pendingConvReports = ConversationReport::where('status', 'pending')->count();
        $totalPendingReports = $pendingUserReports + $pendingConvReports;

        $pendingAppeals = SuspensionAppeal::where('status', 'pending')->count();

        $recentLogins = ActivityLog::with('user:id,full_name')
                                ->orderBy('created_at', 'desc')
                                ->limit(5)
                                ->get();

        return response()->json([
            'summary' => [
                'total_clients' => $totalClients,
                'total_therapists' => $totalTherapists,
                'pending_applications' => $pendingApplications,
                'total_pending_reports' => $totalPendingReports,
                'pending_appeals' => $pendingAppeals,
            ],
            'recent_logins' => $recentLogins,
        ]);
    }
}