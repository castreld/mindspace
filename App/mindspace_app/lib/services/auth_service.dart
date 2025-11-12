import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mindspace_app/config.dart';
import '../models/user.dart';
import '../navigation.dart';
import '../routes.dart';

class AuthService with ChangeNotifier{
  static final AuthService _instance = AuthService._internal();
  factory AuthService() {
    return _instance;
  }
  AuthService._internal();

  User? _currentUser;
  String? _token;
  bool _isLoading = true;

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

  void clearSession() {
    
    _currentUser = null;
    _token = null;
    _isLoading = false;
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

    SharedPreferences.getInstance().then((prefs) {
      
      return prefs.clear();
    }).then((_) {
      
    }).catchError((e) {
      
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
}