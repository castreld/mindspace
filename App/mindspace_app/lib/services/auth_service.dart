import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mindspace_app/config.dart';
import '../models/user.dart';
import '../navigation.dart';
import '../routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthService with ChangeNotifier{
  static final AuthService _instance = AuthService._internal();
  factory AuthService() {
    return _instance;
  }
  AuthService._internal();

  User? _currentUser;
  String? _token;
  bool _isLoading = true;

  final _secureStorage = const FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();
  static const _secureTokenKey = 'auth_token';
  static const _biometricEnabledKey = 'biometric_enabled';

  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoggedIn => _currentUser != null;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    final storedToken = prefs.getString('auth_token');

    if (userString != null && storedToken != null) {
      _currentUser = User.fromJson(json.decode(userString));
      _token = storedToken;
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveSession(User user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = user;
    _token = token;
    await prefs.setString('user', json.encode(user.toJson()));
    await prefs.setString('auth_token', token);

    if (await isBiometricsEnabled) {
      await _secureStorage.write(key: _secureTokenKey, value: token);
    }
    notifyListeners(); 
  }

  Future<void> updateUser(User updatedUser) async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = updatedUser;
    await prefs.setString('user', json.encode(updatedUser.toJson()));
    notifyListeners();
  }

  Future<void> refreshUserFromServer() async {
    if (_token == null) return; 

    try {
      final url = Uri.parse('${AppConfig.backendBaseUrl}/api/user');
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final updatedUser = User.fromJson(json.decode(response.body));
        await updateUser(updatedUser);
      } else {
        clearSession();
      }
    } catch (e) {
      debugPrint("Gagal refresh user: $e");
    }
  }

  Future<void> clearSession({bool clearBiometrics = false}) async {
    _currentUser = null;
    _token = null;
    _isLoading = false;

    
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    if (clearBiometrics) {
      
      await _secureStorage.deleteAll();
      debugPrint('Cleared all secure storage including biometrics');
    } else {
      
      final biometricsEnabled = await isBiometricsEnabled;
      
      if (!biometricsEnabled) {
        
        await _secureStorage.deleteAll();
        debugPrint('Cleared all secure storage (biometrics not enabled)');
      } else {
        
        debugPrint('Preserved biometric data in secure storage');
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
      try {
        final navState = navigatorKey.currentState;
        if (navState != null) {
          navState.pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
        }
      } catch (e) {
        debugPrint('AuthService.clearSession: navigatorKey navigation failed: $e');
      }
    });
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> submitAppeal(String reason) async {
    if (_token == null) {
      throw Exception('Not authenticated.');
    }

    try {
      final url = Uri.parse('${AppConfig.backendBaseUrl}/api/appeals');
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: json.encode({
          'reason': reason,
        }),
      );

      if (response.statusCode != 201) {
        final error = json.decode(response.body)['message'] ?? 'Failed to submit appeal';
        throw Exception(error);
      }
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }

  Future<void> loginWithGoogle() async {
    String platform = 'web';
    if (!kIsWeb) {
      if (Theme.of(navigatorKey.currentContext!).platform == TargetPlatform.android ||
          Theme.of(navigatorKey.currentContext!).platform == TargetPlatform.iOS) {
        platform = 'mobile';
      } else if (Theme.of(navigatorKey.currentContext!).platform == TargetPlatform.windows ||
                Theme.of(navigatorKey.currentContext!).platform == TargetPlatform.macOS ||
                Theme.of(navigatorKey.currentContext!).platform == TargetPlatform.linux) {
        platform = 'desktop';
      }
    }
    
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/auth/google/redirect?platform=$platform');
    
    debugPrint('Launching Google OAuth with platform: $platform');
    
    if (kIsWeb) {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, webOnlyWindowName: '_self');
      } else {
        throw Exception('Tidak dapat meluncurkan URL: $url');
      }
    } else {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw Exception('Tidak dapat meluncurkan URL: $url');
      }
    }
  }

  Future<bool> get isBiometricsEnabled async {
    final enabled = await _secureStorage.read(key: _biometricEnabledKey);
    return enabled == 'true';
  }

  Future<bool> canCheckBiometrics() async {
    try {
      
      final canCheck = await _localAuth.canCheckBiometrics;
      if (!canCheck) return false;
      
      
      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      return availableBiometrics.isNotEmpty;
    } catch (e) {
      debugPrint("Error cek biometrik: $e");
      return false;
    }
  }

  Future<bool> enableBiometrics(String token) async {
    try {
      
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Autentikasi untuk mengaktifkan login biometrik',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        
        await _secureStorage.write(key: _secureTokenKey, value: token);
        await _secureStorage.write(key: _biometricEnabledKey, value: 'true');
        debugPrint("Biometric authentication enabled successfully");
        return true;
      } else {
        debugPrint("Biometric authentication failed");
        return false;
      }
    } catch (e) {
      debugPrint("Error enabling biometrics: $e");
      return false;
    }
  }

  Future<void> disableBiometrics() async {
    await _secureStorage.delete(key: _secureTokenKey);
    await _secureStorage.write(key: _biometricEnabledKey, value: 'false');
    debugPrint("Biometric authentication disabled");
  }

  Future<bool> loginWithBiometrics() async {
    try {
      bool canCheck = await canCheckBiometrics();
      if (!canCheck) {
        debugPrint("Device doesn't support biometrics or no biometrics enrolled");
        return false;
      }
      
      
      final isEnabled = await isBiometricsEnabled;
      if (!isEnabled) {
        debugPrint("Biometrics not enabled for this app");
        return false;
      }
      
      
      final storedToken = await _secureStorage.read(key: _secureTokenKey);
      if (storedToken == null) {
        debugPrint("No token found in secure storage");
        
        await _secureStorage.write(key: _biometricEnabledKey, value: 'false');
        return false;
      }
      
      debugPrint("Token found in secure storage, prompting for biometric auth");
      
      
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Autentikasi untuk masuk ke MindSpace',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        debugPrint("Biometric authentication successful, fetching user data");
        
        _token = storedToken;
        
        
        await refreshUserFromServer();
        
        if (isLoggedIn) {
          debugPrint("User logged in successfully via biometrics");
          notifyListeners();
          return true;
        } else {
          
          debugPrint("Token is invalid, clearing biometric data");
          await disableBiometrics();
          return false;
        }
      } else {
        debugPrint("Biometric authentication failed or cancelled");
        return false;
      }
    } catch (e) {
      debugPrint("Error login biometrik: $e");
      return false;
    }
  }

  Future<void> debugBiometricStorage() async {
    final token = await _secureStorage.read(key: _secureTokenKey);
    final enabled = await _secureStorage.read(key: _biometricEnabledKey);
    debugPrint("=== BIOMETRIC DEBUG ===");
    debugPrint("Token stored: ${token != null ? 'YES (${token.substring(0, 20)}...)' : 'NO'}");
    debugPrint("Enabled flag: $enabled");
    debugPrint("======================");
  }

  Future<void> logout({bool clearBiometrics = false}) async {
    if (_token != null) {
      try {
        
        final url = Uri.parse('${AppConfig.backendBaseUrl}/api/logout');
        await http.post(
          url,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $_token',
          },
        );
        debugPrint('Logged out from server successfully');
      } catch (e) {
        debugPrint('Error logging out from server: $e');
        
      }
    }
    
    
    await clearSession(clearBiometrics: clearBiometrics);
  }
}