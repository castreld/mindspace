

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  
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
  }

  
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = null;
    _token = null;
    await prefs.clear();
  }
}