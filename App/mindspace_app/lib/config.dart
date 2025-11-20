class AppConfig {
  static String backendBaseUrl = 'https://api.mindspace.asia';
  static const String webSocketHost = 'api.mindspace.asia'; 
  static const String webSocketPusherAppKey = 'l1kxgzsfajfdudiywfit';
  static String reverbHost = 'api.mindspace.asia';
  static int reverbPort = 443;
  static String reverbScheme = 'https';

  static String getWebSocketUrl() {
    String host = AppConfig.reverbHost;
    String key = AppConfig.webSocketPusherAppKey;

    if (AppConfig.reverbScheme == 'https') {
      return 'wss://$host/app/$key';
    } 

    String port = AppConfig.reverbPort.toString();
    return 'ws://$host:$port/app/$key';
  }
}