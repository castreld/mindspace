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
        Schema::create('appointments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('client_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('therapist_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('availability_id')->constrained()->cascadeOnDelete();
            $table->dateTime('appointment_time');
            $table->enum('status', ['scheduled', 'completed', 'cancelled', 'no_show'])->default('scheduled');
            $table->text('client_notes')->nullable();
            $table->text('therapist_notes')->nullable();
            $table->timestamps();
            $table->softDeletes(); // For handling cancellations without permanent deletion
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('appointments');
    }
};