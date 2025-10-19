import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindspace_app/models/appointment.dart';

class ClientDetailDialog extends StatelessWidget {
  final ClientDetail client;

  const ClientDetailDialog({super.key, required this.client});

  int _calculateAge(String? birthDateString) {
    if (birthDateString == null) return 0;
    try {
      final birthDate = DateTime.parse(birthDateString);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final age = _calculateAge(client.birthDate);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Detail Klien', textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: client.profilePicture != null
                  ? NetworkImage(client.profilePicture!)
                  : null,
              child: client.profilePicture == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(client.fullName, style: Theme.of(context).textTheme.headlineSmall),
            Text('@${client.username}', style: Theme.of(context).textTheme.bodyMedium),
            const Divider(height: 32),
            _buildInfoTile(Icons.email_outlined, 'Email', client.email),
            _buildInfoTile(Icons.phone_outlined, 'Telepon', client.phoneNumber ?? 'N/A'),
            _buildInfoTile(
              Icons.cake_outlined,
              'Tanggal Lahir',
              client.birthDate != null
                ? '${DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.parse(client.birthDate!))} ($age tahun)'
                : 'N/A',
            ),
            _buildInfoTile(Icons.category_outlined, 'Kategori', client.category),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Tutup'),
        ),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade600),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 15)),
    );
  }
}