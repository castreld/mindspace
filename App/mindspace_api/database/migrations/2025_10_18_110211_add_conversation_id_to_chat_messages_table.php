<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('chat_messages', function (Blueprint $table) {
            // Drop the old appointment_id foreign key
            $table->dropForeign(['appointment_id']);
            $table->dropColumn('appointment_id');

            // Add the new conversation_id column
            $table->unsignedBigInteger('conversation_id')->after('id');
            $table->foreign('conversation_id')->references('id')->on('conversations')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('chat_messages', function (Blueprint $table) {
            // Revert the changes if we roll back
            $table->dropForeign(['conversation_id']);
            $table->dropColumn('conversation_id');

            $table->unsignedBigInteger('appointment_id')->after('id');
            $table->foreign('appointment_id')->references('id')->on('appointments')->onDelete('cascade');
        });
    }
};