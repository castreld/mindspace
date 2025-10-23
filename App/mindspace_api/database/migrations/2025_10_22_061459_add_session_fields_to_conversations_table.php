<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::table('conversations', function (Blueprint $table) {
            // This links the chat to a paid/scheduled appointment
            $table->foreignId('appointment_id')->nullable()->after('id')->constrained()->onDelete('set null');

            // This is the trigger for the timer
            $table->timestamp('session_started_at')->nullable()->after('status');

            // This is the base duration (e.g., 60 minutes)
            $table->integer('session_duration_minutes')->nullable()->after('session_started_at');

            // This tracks if the 'klien' ended it early or if it's over
            $table->enum('session_status', ['pending', 'accepted', 'rejected', 'active', 'ended'])
                  ->default('pending')
                  ->after('status');
        });
    }

    public function down(): void {
        Schema::table('conversations', function (Blueprint $table) {
            $table->dropForeign(['appointment_id']);
            $table->dropColumn(['appointment_id', 'session_started_at', 'session_duration_minutes', 'session_status']);
            // Note: We're not dropping session_status, just changing the 'status' column back if needed
            // For simplicity, we'll just drop the new columns.
        });
        // You may also need to re-add the original 'status' enum if you drop session_status
    }
};