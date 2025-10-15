<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Appointment extends Model
{
    use HasFactory;

    protected $fillable = [
        'client_id', 'therapist_id', 'availability_id', 'appointment_time', 'duration_minutes', 'client_notes', 'status'
    ];

    protected $casts = [
        'appointment_time' => 'datetime',
    ];
}
