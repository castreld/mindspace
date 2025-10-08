<?php
use App\Models\User;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {

        User::all()->each(function ($user) {
            DB::table('users')
                ->where('id', $user->id)
                ->update(['email' => $user->email]);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {

    }
};