<!DOCTYPE html>
<html>
<head>
    <title>Payment Finished</title>
    <style>
        body { font-family: sans-serif; text-align: center; padding-top: 50px; }
        .container { max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Payment Successful!</h1>
        <p>Your payment has been processed.</p>
        <p><strong>Order ID:</strong> {{ $orderId ?? 'N/A' }}</p>
        <p><strong>Status:</strong> {{ $transactionStatus ?? 'N/A' }}</p>
        <hr>
        <p>You can now close this window and return to the Mindspace application.</p>
    </div>
</body>
</html>