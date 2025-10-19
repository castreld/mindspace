<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Models\Transaction;
use App\Models\Appointment;

class PaymentController extends Controller
{
    public function handleNotification(Request $request)
    {
        Log::info('--- Midtrans Notification Received ---', ['payload' => $request->all()]);

        $payload = $request->all();
        $orderId = $payload['order_id'] ?? null;
        $transactionStatus = $payload['transaction_status'] ?? null;
        $statusCode = $payload['status_code'] ?? null;
        $grossAmount = $payload['gross_amount'] ?? null;
        
        $serverKey = env('MIDTRANS_SERVER_KEY');
        if (!$serverKey) {
            Log::error('MIDTRANS_SERVER_KEY is not set in the .env file.');
            return response()->json(['message' => 'Server configuration error.'], 500);
        }
        
        $signatureKey = $payload['signature_key'] ?? null;
        $computedSignature = hash('sha512', $orderId . $statusCode . $grossAmount . $serverKey);
        
        if (!hash_equals($computedSignature, $signatureKey)) {
            Log::warning('Midtrans signature validation failed.', ['order_id' => $orderId]);
            return response()->json(['message' => 'Invalid signature.'], 403);
        }
        
        Log::info('Signature validation successful.', ['order_id' => $orderId]);

        $transaction = Transaction::where('payment_gateway_id', $orderId)->first();

        if (!$transaction) {
            Log::warning('Transaction not found in database.', ['order_id' => $orderId]);
            return response()->json(['message' => 'Transaction not found.'], 404);
        }
        
        Log::info('Transaction found in database.', ['transaction_id' => $transaction->id, 'current_status' => $transaction->status]);

        if ($transactionStatus == 'settlement' || $transactionStatus == 'capture') {
            if ($transaction->status == 'paid') {
                Log::info('Transaction already marked as paid. Ignoring notification.', ['order_id' => $orderId]);
                return response()->json(['message' => 'Already updated.']);
            }

            $transaction->status = 'paid';
            Log::info('Updating transaction status to PAID.');

            $appointment = Appointment::find($transaction->appointment_id);
            if ($appointment) {
                $appointment->status = 'pending_confirmation';
                $appointment->save();
                Log::info('Updated associated appointment status to PENDING_CONFIRMATION.', ['appointment_id' => $appointment->id]);
            }

        } else if (in_array($transactionStatus, ['deny', 'cancel', 'expire', 'failure'])) {
            $transaction->status = 'failed';
            Log::info('Updating transaction status to FAILED.');

            $appointment = Appointment::find($transaction->appointment_id);
            if ($appointment) {
                $appointment->status = 'payment_failed';
                $appointment->save();
                Log::info('Updated associated appointment status to PAYMENT_FAILED.', ['appointment_id' => $appointment->id]);
            }
        }
        
        $transaction->save();
        Log::info('--- Midtrans Notification Processed Successfully ---');
        
        return response()->json(['status' => 'ok']);
    }

    public function createTransaction(Request $request)
    {
        $request->validate([
            'order_id' => 'required|string',
            'gross_amount' => 'required|numeric',
            'appointment_id' => 'nullable|exists:appointments,id',
        ]);
        
        \Midtrans\Config::$serverKey = env('MIDTRANS_SERVER_KEY');
        \Midtrans\Config::$clientKey = env('MIDTRANS_CLIENT_KEY');
        \Midtrans\Config::$isProduction = env('MIDTRANS_IS_PRODUCTION', false);

        $params = [
            'transaction_details' => [
                'order_id' => $request->input('order_id'),
                'gross_amount' => (int) $request->input('gross_amount'),
            ],
            'customer_details' => [
                'first_name' => $request->user()->full_name ?? 'Guest',
                'email' => $request->user()->email ?? null,
            ],
        ];

        try {
            $snapToken = \Midtrans\Snap::getSnapToken($params);

            $appointmentId = $request->input('appointment_id');
            $userId = $request->user()->id ?? null;

            $transaction = Transaction::create([
                'appointment_id' => $appointmentId,
                'user_id' => $userId,
                'amount' => (int) $request->input('gross_amount'),
                'status' => 'pending',
                'payment_gateway_id' => $request->input('order_id'),
            ]);

            if ($appointmentId) {
                $appt = Appointment::find($appointmentId);
                if ($appt) {
                    $appt->status = 'pending_payment';
                    $appt->save();
                }
            }

            return response()->json(['snap_token' => $snapToken, 'transaction_id' => $transaction->id]);
        } catch (\Exception $e) {
            Log::error('Midtrans Snap token error: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to create Snap token'], 500);
        }
    }

    public function checkoutView(Request $request)
    {
        $snapToken = $request->query('snap_token');
        $clientKey = env('MIDTRANS_CLIENT_KEY');
        $finishUrl = env('MIDTRANS_FINISH_URL', url('/payment/finish'));
        $unfinishUrl = env('MIDTRANS_UNFINISH_URL', url('/payment/unfinish'));
        $errorUrl = env('MIDTRANS_ERROR_URL', url('/payment/error'));

        return view('midtrans.checkout', [
            'snapToken' => $snapToken,
            'clientKey' => $clientKey,
            'finishUrl' => $finishUrl,
            'unfinishUrl' => $unfinishUrl,
            'errorUrl' => $errorUrl,
        ]);
    }

    public function finish(Request $request)
    {
        return view('midtrans.finish', [
            'orderId' => $request->query('order_id'),
            'statusCode' => $request->query('status_code'),
            'transactionStatus' => $request->query('transaction_status'),
        ]);
    }
}