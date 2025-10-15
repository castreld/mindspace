<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Http\Controllers\Api\PaymentController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/midtrans/health', function () {
    return response('ok', 200);
});

Route::get('/midtrans/checkout', [PaymentController::class, 'checkoutView']);

Route::get('/payment/finish', [App\Http\Controllers\Api\PaymentController::class, 'finish']);
