<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Midtrans Checkout</title>
  </head>
  <body>
    <h3>Processing payment...</h3>

    <script src="https://app.sandbox.midtrans.com/snap/snap.js" data-client-key="{{ $clientKey }}"></script>

    <script>
      const snapToken = '{{ $snapToken }}';
      // Call snap.pay to open the Snap payment popup or redirect
      if (snapToken) {
        window.snap.pay(snapToken, {
          onSuccess: function(result){
            window.location.href = '{{ $finishUrl }}';
          },
          onPending: function(result){
            window.location.href = '{{ $finishUrl }}';
          },
          onError: function(result){
            window.location.href = '{{ $errorUrl }}';
          },
          onClose: function(){
            window.location.href = '{{ $unfinishUrl }}';
          }
        });
      } else {
        document.body.innerText = 'Missing snap token';
      }
    </script>
  </body>
  </html>
