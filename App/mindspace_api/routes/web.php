<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Http\Controllers\Api\PaymentController;
use App\Http\Controllers\AdminController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/midtrans/health', function () {
    return response('ok', 200);
});

Route::get('/midtrans/checkout', [PaymentController::class, 'checkoutView']);

Route::get('/payment/finish', [App\Http\Controllers\Api\PaymentController::class, 'finish']);

Route::prefix('admin')->group(function () {
    Route::get('/dashboard', function () {
        return view('admin.dashboard');
    })->name('admin.dashboard');

    Route::get('/psikolog', function () {
        return view('admin.psikolog');
    })->name('admin.psikolog');

    Route::get('/laporan', function () {
        return view('admin.laporan');
    })->name('admin.laporan');
});
