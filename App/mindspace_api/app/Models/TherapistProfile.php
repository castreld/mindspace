<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TherapistProfile extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'user_id',
        'profile_picture_path',
        'education_history',
        'hourly_rate',
        'experience_years',
        'specializations',
        'problem_areas',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'specializations' => 'array',
    ];

    /**
     * Get the user that owns the therapist profile.
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}