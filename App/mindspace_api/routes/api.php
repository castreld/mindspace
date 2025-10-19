<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Broadcast;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ActivityController;
use App\Http\Controllers\Api\ProfileController;
use App\Http\Controllers\Api\ImageController;
use App\Http\Controllers\Api\TherapistApplicationController;
use App\Http\Controllers\Admin\TherapistManagementController;
use App\Http\Controllers\Psikolog\AvailabilityController;
use App\Http\Controllers\Api\TherapistController;
use App\Http\Controllers\Api\PaymentController;
use App\Http\Controllers\Api\AppointmentController;
use App\Http\Controllers\Psikolog\TherapistAppointmentController;
use App\Http\Controllers\Psikolog\ClientController;
use App\Http\Controllers\Api\ChatController;
use App\Http\Controllers\Api\ConversationController;
use App\Http\Controllers\Api\MessageRequestController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::get('/therapists', [TherapistController::class, 'index']);
Route::get('/therapists/{user}', [TherapistController::class, 'show']);

Route::get('/{path}', [ImageController::class, 'show'])->where('path', 'storage/.*');

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/broadcasting/auth', [\App\Http\Controllers\Api\BroadcastingController::class, 'auth']);
    
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::post('/logout', [AuthController::class, 'logout']);

    Route::get('/activity-history', [ActivityController::class, 'getActivityHistory']);
    
    Route::post('/therapist-applications', [TherapistApplicationController::class, 'store']);

    Route::post('/user/profile', [ProfileController::class, 'update']);
    Route::put('/user/password', [ProfileController::class, 'updatePassword']);
    Route::delete('/user', [ProfileController::class, 'destroy']);
    Route::get('/appointments', [AppointmentController::class, 'index']);
    Route::delete('/appointments/{appointment}', [AppointmentController::class, 'destroy']);
    
    Route::delete('/messages/{message}', [ChatController::class, 'deleteMessage']);
    Route::post('/messages/send', [ChatController::class, 'sendMessage']);
    Route::get('/conversations', [ConversationController::class, 'index']);
    Route::get('/conversations/{user}', [ConversationController::class, 'show']);
    Route::get('/conversations/{conversation}/messages', [ConversationController::class, 'getMessages']);
    Route::delete('/conversations/{conversation}', [ConversationController::class, 'deleteConversation']);
    Route::get('/message-requests', [MessageRequestController::class, 'index']);
    Route::post('/message-requests', [MessageRequestController::class, 'store']);
    Route::put('/message-requests/{conversation}/accept', [MessageRequestController::class, 'accept']);
    Route::delete('/message-requests/{conversation}/reject', [MessageRequestController::class, 'reject']);
 
    Route::get('/users/search-clients', [UserController::class, 'searchClients']);

    Route::middleware('admin')->prefix('admin')->group(function () {
        Route::get('/therapist-applications', [TherapistManagementController::class, 'index']);
        Route::post('/therapist-applications/{user}/approve', [TherapistManagementController::class, 'approve']);
        Route::post('/therapist-applications/{user}/reject', [TherapistManagementController::class, 'reject']);
    });

    Route::prefix('psikolog')->middleware('auth:sanctum')->group(function () {
        Route::get('/availability', [AvailabilityController::class, 'get']);
        Route::put('/availability', [AvailabilityController::class, 'update']);
        Route::get('/appointments', [TherapistAppointmentController::class, 'index']);
        Route::get('/clients/{client}', [ClientController::class, 'show']);

        Route::post('/appointments/{appointment}/approve', [TherapistAppointmentController::class, 'approve']);
        Route::post('/appointments/{appointment}/reject', [TherapistAppointmentController::class, 'reject']);
    });
    
    Route::post('/appointments', [AppointmentController::class, 'store']);
    Route::post('/midtrans/create-transaction', [PaymentController::class, 'createTransaction']);
});

Route::post('/midtrans/notification', [PaymentController::class, 'handleNotification']);

Route::get('/test-auth', function () {
    return response()->json([
        'authenticated_user' => auth()->user(),
        'request_headers' => request()->headers->all(),
    ]);
})->middleware('auth:sanctum');