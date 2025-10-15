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
        Schema::table('appointments', function (Blueprint $table) {
            // Drop the old foreign key that points to the 'availabilities' table
            $table->dropForeign('appointments_availability_id_foreign');

            // Add the new, correct foreign key that points to 'therapist_availabilities'
            $table->foreign('availability_id')
                  ->references('id')
                  ->on('therapist_availabilities')
                  ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('appointments', function (Blueprint $table) {
            // Drop the new foreign key
            $table->dropForeign(['availability_id']);

            // Re-add the old, incorrect one if we roll back
            $table->foreign('availability_id')
                  ->references('id')
                  ->on('availabilities')
                  ->onDelete('cascade');
        });
    }
};