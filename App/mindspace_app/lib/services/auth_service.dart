import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
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

  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoggedIn => _currentUser != null;

  Future<void> init() async {
    
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    final storedToken = prefs.getString('auth_token');

    if (userString != null && storedToken != null) {
      _currentUser = User.fromJson(json.decode(userString));
      _token = storedToken;
    }
    
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

  void clearSession() {
    
    _currentUser = null;
    _token = null;
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
}