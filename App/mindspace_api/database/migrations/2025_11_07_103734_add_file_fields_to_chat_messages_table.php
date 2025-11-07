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
            $table->string('message_type')->default('text')->after('receiver_id');
            $table->string('file_path')->nullable()->after('message');
            $table->string('original_file_name')->nullable()->after('file_path');
            $table->text('message')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('chat_messages', function (Blueprint $table) {
            $table->dropColumn(['message_type', 'file_path', 'original_file_name']);
            $table->text('message')->nullable(false)->change();
        });
    }
};
