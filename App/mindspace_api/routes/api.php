<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ActivityController;
use App\Http\Controllers\Api\ProfileController;
use App\Http\Controllers\Api\ImageController;
use App\Http\Controllers\Api\TherapistApplicationController;
use App\Http\Controllers\Admin\TherapistManagementController;
use App\Http\Controllers\Psikolog\AvailabilityController;
use App\Http\Controllers\Api\TherapistController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::get('/therapists', [TherapistController::class, 'index']);
Route::get('/therapists/{user}', [TherapistController::class, 'show']);

Route::get('/{path}', [ImageController::class, 'show'])->where('path', 'storage/.*');

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::post('/logout', [AuthController::class, 'logout']);

    Route::get('/activity-history', [ActivityController::class, 'getActivityHistory']);
    
    Route::post('/therapist-applications', [TherapistApplicationController::class, 'store']);

    Route::post('/user/profile', [ProfileController::class, 'update']);
    Route::put('/user/password', [ProfileController::class, 'updatePassword']);
    Route::delete('/user', [ProfileController::class, 'destroy']);

    Route::middleware('admin')->prefix('admin')->group(function () {
        Route::get('/therapist-applications', [TherapistManagementController::class, 'index']);
        Route::post('/therapist-applications/{user}/approve', [TherapistManagementController::class, 'approve']);
        Route::post('/therapist-applications/{user}/reject', [TherapistManagementController::class, 'reject']);
    });

    Route::prefix('psikolog')->middleware('auth:sanctum')->group(function () {
        Route::get('/availability', [AvailabilityController::class, 'get']);
        Route::put('/availability', [AvailabilityController::class, 'update']);
    });
});