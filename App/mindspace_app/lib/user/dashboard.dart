import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';
import '../models/user.dart';
import 'package:mindspace_app/animated_background_dark.dart';
import 'package:mindspace_app/routes.dart';
import 'package:mindspace_app/user/dashboard/landing_dashboard.dart';
import 'package:mindspace_app/services/auth_service.dart';

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
                            // ✨ MODIFIED: We now pass the logout function to the MainMenu
                            MainMenu(onLogout: _logout),
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

class ProfileOverview extends StatelessWidget {
  final User user;
  const ProfileOverview({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // This widget remains the same...
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
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              user.username,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              user.email,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
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
              child: const Text('Edit Profil'),
            ),
          ],
        ),
      ),
    );
  }
}

// ✨ MODIFIED: MainMenu is now simpler
class MainMenu extends StatelessWidget {
  final VoidCallback onLogout;
  const MainMenu({super.key, required this.onLogout});

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
          _buildMenuItem(
              icon: Icons.logout, title: 'Logout', onTap: onLogout),
        ],
      ),
    );
  }
}