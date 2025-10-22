import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketChannel createWebSocketChannel(String url) {
  throw UnsupportedError(
    'Cannot create WebSocket channel without dart:html or dart:io. '
    'This should never be called as the conditional import should select the correct implementation.'
  );
}