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
        Log::info('Midtrans notification received', ['payload' => $request->all()]);

        $payload = $request->all();
        $orderId = $payload['order_id'] ?? $payload['orderId'] ?? null;
        $transactionStatus = $payload['transaction_status'] ?? null;
        $transactionId = $payload['transaction_id'] ?? $payload['transactionId'] ?? null;
        $statusCode = $payload['status_code'] ?? null;
        $grossAmount = $payload['gross_amount'] ?? $payload['grossAmount'] ?? null;

        // Verify signature if provided
        $signatureKey = $payload['signature_key'] ?? $request->header('signature_key') ?? $request->header('x-midtrans-signature') ?? null;
        if ($signatureKey && $orderId && $statusCode && $grossAmount) {
            $serverKey = env('MIDTRANS_SERVER_KEY');
            $computed = hash('sha512', $orderId . $statusCode . $grossAmount . $serverKey);
            if (!hash_equals($computed, $signatureKey)) {
                Log::warning('Midtrans signature mismatch', ['expected' => $computed, 'provided' => $signatureKey]);
                return response()->json(['status' => 'signature_mismatch'], 400);
            }
        }

        if ($orderId) {
            $transaction = Transaction::where('payment_gateway_id', $orderId)->first();
            if (!$transaction) {
                // try find by order id stored earlier
                $transaction = Transaction::where('payment_gateway_id', $orderId)->first();
            }

            if ($transaction) {
                // Idempotency: if already paid, ignore repeated settlement
                if ($transaction->status === 'paid' && in_array($transactionStatus, ['settlement', 'capture', 'success'])) {
                    return response()->json(['status' => 'ok']);
                }

                // Map Midtrans status to our transaction status
                if (in_array($transactionStatus, ['capture', 'settlement', 'success'])) {
                    $transaction->status = 'paid';
                } elseif (in_array($transactionStatus, ['deny', 'cancel', 'expire', 'failure'])) {
                    $transaction->status = 'failed';
                } else {
                    $transaction->status = 'pending';
                }
                if ($transactionId) $transaction->payment_gateway_id = $transactionId;
                $transaction->save();

                if ($transaction->appointment_id) {
                    $appt = Appointment::find($transaction->appointment_id);
                    if ($appt) {
                        if ($transaction->status === 'paid') {
                            $appt->status = 'scheduled';
                        } elseif ($transaction->status === 'failed') {
                            $appt->status = 'payment_failed';
                        }
                        $appt->save();
                    }
                }
            } else {
                Log::warning('Transaction not found for Midtrans order_id: ' . $orderId);
            }
        }

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

            // create transaction record
            $appointmentId = $request->input('appointment_id');
            $userId = $request->user()->id ?? null;

            $transaction = Transaction::create([
                'appointment_id' => $appointmentId,
                'user_id' => $userId,
                'amount' => (int) $request->input('gross_amount'),
                'status' => 'pending',
                'payment_gateway_id' => $request->input('order_id'),
            ]);

            // mark appointment as pending_payment if linked
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
