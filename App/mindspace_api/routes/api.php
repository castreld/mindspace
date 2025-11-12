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
use App\Http\Controllers\Api\ReviewController;
use App\Http\Controllers\Api\ReportController;
use App\Http\Controllers\Admin\ReportController as AdminReportController;
use App\Http\Controllers\Admin\UserController as AdminUserController;
use App\Http\Controllers\Api\AppealController;
use App\Http\Controllers\Admin\AppealController as AdminAppealController;
use App\Http\Controllers\Admin\DashboardController as AdminDashboardController;

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
    Route::get('/appointments/history', [AppointmentController::class, 'getHistory']);
    Route::delete('/appointments/{appointment}', [AppointmentController::class, 'destroy']);
    Route::get('/appointments/{appointment}', [AppointmentController::class, 'show']);
    Route::post('/appointments/{appointment}/reviews', [ReviewController::class, 'store']);

    Route::delete('/messages/{message}', [ChatController::class, 'deleteMessage']);
    Route::post('/messages/send', [ChatController::class, 'sendMessage']);
    Route::post('/messages/send-file', [ChatController::class, 'sendFile']);
    Route::get('/conversations', [ConversationController::class, 'index']);
    Route::get('/conversations/{user}', [ConversationController::class, 'show']);
    Route::get('/conversations/{conversation}/messages', [ConversationController::class, 'getMessages']);
    Route::delete('/conversations/{conversation}', [ConversationController::class, 'deleteConversation']);
    Route::post('/conversations/{conversation}/stop', [ConversationController::class, 'stopSession']);
    Route::get('/message-requests', [MessageRequestController::class, 'index']);
    Route::post('/message-requests', [MessageRequestController::class, 'store']);
    Route::put('/message-requests/{conversation}/accept', [MessageRequestController::class, 'accept']);
    Route::delete('/message-requests/{conversation}/reject', [MessageRequestController::class, 'reject']);

    Route::get('/users/search-clients', [UserController::class, 'searchClients']);

    Route::prefix('reports')->group(function () {
        Route::post('/user', [ReportController::class, 'storeUserReport']);
        Route::post('/conversation', [ReportController::class, 'storeConversationReport']);
    });

    Route::post('/appeals', [AppealController::class, 'store']);

    Route::middleware('admin')->prefix('admin')->group(function () {
        Route::get('/dashboard-stats', [AdminDashboardController::class, 'getStats']);

        Route::get('/therapist-applications', [TherapistManagementController::class, 'index']);
        Route::post('/therapist-applications/{user}/approve', [TherapistManagementController::class, 'approve']);
        Route::post('/therapist-applications/{user}/reject', [TherapistManagementController::class, 'reject']);
        Route::post('/therapists/{user}/suspend', [TherapistManagementController::class, 'suspend']);
        Route::post('/therapists/{user}/unsuspend', [TherapistManagementController::class, 'unsuspend']);

        Route::get('/users', [AdminUserController::class, 'index']);
        Route::post('/users/{user}/suspend', [AdminUserController::class, 'suspend']);
        Route::post('/users/{user}/unsuspend', [AdminUserController::class, 'unsuspend']);

        Route::get('/conversations/{conversation}/messages', [ConversationController::class, 'getMessagesForAdmin']);
        Route::prefix('reports')->group(function () {
            Route::get('/user', [AdminReportController::class, 'indexUserReports']);
            Route::get('/conversation', [AdminReportController::class, 'indexConversationReports']);
            Route::put('/user/{userReport}', [AdminReportController::class, 'updateUserReport']);
            Route::put('/conversation/{conversationReport}', [AdminReportController::class, 'updateConversationReport']);
        });

        Route::get('/appeals', [AdminAppealController::class, 'index']);
        Route::put('/appeals/{appeal}', [AdminAppealController::class, 'update']);
    });

    Route::prefix('psikolog')->middleware('auth:sanctum')->group(function () {
        Route::get('/availability', [AvailabilityController::class, 'get']);
        Route::put('/availability', [AvailabilityController::class, 'update']);
        Route::get('/appointments', [TherapistAppointmentController::class, 'index']);
        Route::get('/clients/{client}', [ClientController::class, 'show']);

        Route::post('/appointments/{appointment}/approve', [TherapistAppointmentController::class, 'approve']);
        Route::post('/appointments/{appointment}/reject', [TherapistAppointmentController::class, 'reject']);
        Route::post('/appointments/{appointment}/notes', [TherapistAppointmentController::class, 'addNotes']);
    });

    Route::post('/appointments', [AppointmentController::class, 'store']);
    Route::post('/midtrans/create-transaction', [PaymentController::class, 'createTransaction']);
});

Route::post('/midtrans/notification', [PaymentController::class, 'handleNotification']);