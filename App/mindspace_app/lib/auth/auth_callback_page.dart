import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/routes.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthCallbackPage extends StatefulWidget {
  const AuthCallbackPage({super.key});

  @override
  State<AuthCallbackPage> createState() => _AuthCallbackPageState();
}

class _AuthCallbackPageState extends State<AuthCallbackPage> {
  String _status = 'Memproses login...';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleCallback();
    });
  }

  void _handleCallback() async {
    try {
      final uri = Uri.base;
      debugPrint('=== AUTH CALLBACK DEBUG ===');
      debugPrint('Full URI: $uri');
      debugPrint('Query Parameters: ${uri.queryParameters}');
      
      final token = uri.queryParameters['token'];
      final userDataEncoded = uri.queryParameters['user'];

      debugPrint('Token: ${token?.substring(0, 20)}...');
      debugPrint('User Data Encoded Length: ${userDataEncoded?.length}');

      if (token != null && userDataEncoded != null) {
        setState(() {
          _status = 'Mendekode data pengguna...';
        });

        final userJsonString = utf8.decode(base64.decode(userDataEncoded));
        debugPrint('Decoded User JSON: $userJsonString');
        
        final userJson = json.decode(userJsonString);
        final user = User.fromJson(userJson);
        
        debugPrint('User parsed successfully: ${user.email}');

        setState(() {
          _status = 'Menyimpan sesi...';
        });

        await context.read<AuthService>().saveSession(user, token);
        
        debugPrint('Session saved successfully');

        setState(() {
          _status = 'Login berhasil! Mengalihkan...';
        });

        if (mounted) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      } else {
        debugPrint('ERROR: Missing token or user data');
        debugPrint('Token present: ${token != null}');
        debugPrint('User data present: ${userDataEncoded != null}');
        
        setState(() {
          _status = 'Data tidak lengkap';
        });
        
        if (mounted) {
          await Future.delayed(const Duration(seconds: 2));
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.login,
            (route) => false
          );
        }
      }
    } catch (e, stackTrace) {
      debugPrint('ERROR in auth callback: $e');
      debugPrint('Stack trace: $stackTrace');
      
      setState(() {
        _status = 'Terjadi kesalahan: ${e.toString()}';
      });
      
      if (mounted) {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.login,
          (route) => false
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                _status,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}