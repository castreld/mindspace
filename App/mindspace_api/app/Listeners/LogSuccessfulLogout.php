<?php

namespace App\Listeners;

use Illuminate\Auth\Events\Logout;
use Illuminate\Http\Request;
use App\Models\ActivityLog;

class LogSuccessfulLogout
{
    protected $request;

    public function __construct(Request $request)
    {
        $this->request = $request;
    }

    public function handle(Logout $event): void
    {
        if ($event->user) {
            ActivityLog::create([
                'user_id' => $event->user->id,
                'activity_type' => 'logout',
                'ip_address' => $this->request->ip(),
                'user_agent' => $this->request->userAgent(),
            ]);
        }
    }
}
