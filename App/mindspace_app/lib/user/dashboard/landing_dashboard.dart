import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindspace_app/models/user.dart';


class LandingDashboard extends StatefulWidget {
  final User user;
  final String token;
  const LandingDashboard({super.key, required this.user, required this.token});

  @override
  State<LandingDashboard> createState() => LandingDashboardState();
}

class LandingDashboardState extends State<LandingDashboard> {
  String _activityTitle = 'Loading Activity...';
  String _activityDescription = '';
  bool _isLoadingActivity = true;

  @override
  void initState() {
    super.initState();
    _fetchRecentActivity();
  }

  Future<void> _fetchRecentActivity() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/activity-history');

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (mounted) {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final latestActivity = (data['data'] as List).firstOrNull;
          if (latestActivity != null) {
             setState(() {
                _activityTitle = 'Recent ${latestActivity['activity_type']}';
                _activityDescription = 'From IP: ${latestActivity['ip_address']}';
                _isLoadingActivity = false;
             });
          } else {
             setState(() {
                _activityTitle = 'Welcome!';
                _activityDescription = 'No recent activity found.';
                _isLoadingActivity = false;
             });
          }
        } else {
          setState(() {
            _activityTitle = 'Error';
            _activityDescription = 'Could not load recent activity.';
            _isLoadingActivity = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _activityTitle = 'Error';
          _activityDescription = 'Could not connect to the server.';
          _isLoadingActivity = false;
        });
      }
    }
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
    required String buttonText,
  }) {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: Colors.black87),
            const SizedBox(height: 12),
            Text(title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9A825),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: const Color(0xFFFFF8F0),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang, ${widget.user.username}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ini adalah dashboard layanan konsaling MINDSPACE. Didalam halaman ini anda bisa menggunakan beberapa fitur yang disediakan oleh kami',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildSummaryCard(
                icon: Icons.calendar_month,
                title: 'Jadwal Konseling',
                subtitle: '0 Jadwal Aktif',
                buttonText: 'Buat Jadwal',
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildSummaryCard(
                icon: Icons.message,
                title: 'Pesan',
                subtitle: '0 Pesan Baru',
                buttonText: 'Lihat Pesan',
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildSummaryCard(
                icon: Icons.article,
                title: 'Materi',
                subtitle: '5 Materi Tersedia',
                buttonText: 'Lihat Materi',
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Card(
          color: const Color(0xFFFFF8F0),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: _isLoadingActivity
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListTile(
                  title: Text(_activityTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(_activityDescription),
                  isThreeLine: true,
                ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}