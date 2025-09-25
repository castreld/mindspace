import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mindspace_app/animated_background.dart';
import 'package:mindspace_app/animated_background_dark.dart';
import 'package:mindspace_app/auth/login.dart';
import 'package:mindspace_app/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';
import '../models/user.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainDashboard extends StatefulWidget {
  final User user;
  final String token;
  const MainDashboard({super.key, required this.user, required this.token});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  Future<void> _logout() async {

    await AuthService().clearSession();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.home, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(user: widget.user, onLogout: _logout),
      body: Stack(
        children: [
          const AnimatedGradientBackgroundDark(),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 260,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ProfileOverview(user: widget.user),
                            const SizedBox(height: 24),
                            const MainMenu(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: LandingDashboard(
                            user: widget.user, token: widget.token),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverFillRemaining(hasScrollBody: false),
              if (kIsWeb) const FooterSection(),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileOverview extends StatefulWidget {
  final User user;
  const ProfileOverview({super.key, required this.user});

  @override
  State<ProfileOverview> createState() => _ProfileOverviewState();
}

class _ProfileOverviewState extends State<ProfileOverview> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.user.username,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.user.email,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE0E0E0),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Edit Profil',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}


class _MainMenuState extends State<MainMenu> {
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final url = Uri.parse('http://127.0.0.1:8000/api/activity-history');

    try {
      await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    } catch (e) {
      print("Error during API logout: $e");
    } finally {
      await prefs.clear();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginForm()),
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  Widget _buildMenuItem(
      {required IconData icon, required String title, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12), bottom: Radius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700]),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildMenuItem(icon: Icons.dashboard_outlined, title: 'Dashboard'),
          _buildMenuItem(
              icon: Icons.calendar_today_outlined, title: 'Jadwal Konseling'),
          _buildMenuItem(
              icon: Icons.history_outlined, title: 'Riwayat Konseling'),
          _buildMenuItem(icon: Icons.message_outlined, title: 'Pesan'),
          _buildMenuItem(icon: Icons.settings_outlined, title: 'Pengaturan'),
          const Divider(height: 1),
          _buildMenuItem(icon: Icons.logout, title: 'Logout', onTap: _logout),
        ],
      ),
    );
  }
}


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