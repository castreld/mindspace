import 'package:flutter/material.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class AdminMobileBlockPage extends StatelessWidget {
  const AdminMobileBlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Akses Ditolak'),
        backgroundColor: const Color(0xFF1E88E5), // Admin app bar color
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.desktop_windows,
                size: 80,
                color: Colors.grey[600],
              ),
              const SizedBox(height: 24),
              const Text(
                'Akses Admin Ditolak',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Halaman Dasbor Admin dirancang untuk tampilan desktop dan tidak dapat diakses di perangkat seluler.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () {
                  context.read<AuthService>().clearSession();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}