import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindspace_app/auth/appeal_dialog.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class SuspendedPage extends StatelessWidget {
  const SuspendedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final User? user = authService.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Error: Pengguna tidak ditemukan.")),
      );
    }

    final formattedDate = user.suspendedUntil != null
        ? DateFormat('d MMMM yyyy, HH:mm', 'id_ID')
            .format(user.suspendedUntil!.toLocal())
        : 'N/A';

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.gavel_rounded,
                      color: Colors.red.shade700, size: 60),
                  const SizedBox(height: 20),
                  Text(
                    'Akun Anda Disuspen',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Akun Anda telah ditangguhkan oleh administrator.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow(
                    'Ditangguhkan Hingga:',
                    formattedDate,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    'Alasan:',
                    user.suspendedReason ?? 'Tidak ada alasan yang diberikan.',
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade700,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AppealDialog(),
                      );
                    },
                    child: const Text('Ajukan Banding'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      context.read<AuthService>().clearSession();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
        ),
        const Divider(height: 16),
      ],
    );
  }
}