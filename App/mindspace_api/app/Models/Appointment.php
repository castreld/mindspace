<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Appointment extends Model
{
    use HasFactory;

    protected $fillable = [
        'client_id', 'therapist_id', 'availability_id', 'appointment_time', 'duration_minutes', 'client_notes', 'status', 'therapist_notes'
    ];

    protected $casts = [
        'appointment_time' => 'datetime',
        'client_notes' => 'encrypted',
        'therapist_notes' => 'encrypted',
    ];

    public function client(): BelongsTo
    {
        return $this->belongsTo(User::class, 'client_id');
    }

    public function therapist(): BelongsTo
    {
        return $this->belongsTo(User::class, 'therapist_id');
    }

    public function review(): HasOne
    {
        return $this->hasOne(Review::class);
    }
}