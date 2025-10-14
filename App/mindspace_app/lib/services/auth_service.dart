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
    debugPrint('AuthService.init: starting');
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    final storedToken = prefs.getString('auth_token');

    if (userString != null && storedToken != null) {
      _currentUser = User.fromJson(json.decode(userString));
      _token = storedToken;
    }
    debugPrint('AuthService.init: done, isLoggedIn=${isLoggedIn}');
  }

  Future<void> saveSession(User user, String token) async {
    debugPrint('AuthService.saveSession: setting user ${user.username}');
    final prefs = await SharedPreferences.getInstance();
    _currentUser = user;
    _token = token;
    await prefs.setString('user', json.encode(user.toJson()));
    await prefs.setString('auth_token', token);
    debugPrint('AuthService.saveSession: notifying listeners');
    notifyListeners(); 
  }

  Future<void> updateUser(User updatedUser) async {
    debugPrint('AuthService.updateUser: updating user ${updatedUser.username}');
    final prefs = await SharedPreferences.getInstance();
    _currentUser = updatedUser;
    await prefs.setString('user', json.encode(updatedUser.toJson()));
    debugPrint('AuthService.updateUser: notifying listeners');
    notifyListeners();
  }

  void clearSession() {
    debugPrint('AuthService.clearSession: called');
    _currentUser = null;
    _token = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('AuthService.clearSession: calling notifyListeners');
      notifyListeners();
      try {
        debugPrint('AuthService.clearSession: attempting navigatorKey navigation to home');
        final navState = navigatorKey.currentState;
        debugPrint('AuthService.clearSession: navigatorKey.currentState is ${navState == null ? 'null' : 'available'}');
        if (navState != null) {
          navState.pushNamedAndRemoveUntil(AppRoutes.home, (route) => false).then((_) {
            debugPrint('AuthService.clearSession: navigatorKey navigation completed');
          }).catchError((e) {
            debugPrint('AuthService.clearSession: navigatorKey navigation error: $e');
          });
        } else {
          debugPrint('AuthService.clearSession: navigatorKey.currentState was null, skipping navigation');
        }
      } catch (e) {
        debugPrint('AuthService.clearSession: navigatorKey navigation failed: $e');
      }
    });

    SharedPreferences.getInstance().then((prefs) {
      debugPrint('AuthService.clearSession: clearing SharedPreferences');
      return prefs.clear();
    }).then((_) {
      debugPrint('AuthService.clearSession: SharedPreferences cleared');
    }).catchError((e) {
      debugPrint('AuthService.clearSession: error clearing prefs: $e');
    });
  }

  @override
  void addListener(VoidCallback listener) {
    debugPrint('AuthService.addListener called, hasListeners=${hasListeners}');
    super.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    debugPrint('AuthService.removeListener called, hasListeners=${hasListeners}');
    super.removeListener(listener);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}