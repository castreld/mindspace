import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mindspace_app/user/dashboard/history_dashboard.dart';
import 'package:mindspace_app/user/dashboard/message_dashboard.dart';
import 'package:mindspace_app/user/dashboard/settings_dashboard.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';
import '../models/user.dart';
import 'package:mindspace_app/animated_background_dark.dart';
import 'package:mindspace_app/routes.dart';
import 'package:mindspace_app/user/dashboard/landing_dashboard.dart';
import 'package:mindspace_app/user/dashboard/schedule_dashboard.dart';
import 'package:mindspace_app/services/auth_service.dart';

enum DashboardSection { dashboard, schedule, history, messages, settings }

class MainDashboard extends StatefulWidget {
  final User user;
  final String token;
  const MainDashboard({super.key, required this.user, required this.token});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  DashboardSection _selectedSection = DashboardSection.dashboard;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
  }

  Future<void> _logout() async {
    await AuthService().clearSession();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.home, (route) => false);
    }
  }

  Widget _getSectionWidget() {
    switch (_selectedSection) {
      case DashboardSection.dashboard:
        return LandingDashboard(user: widget.user, token: widget.token);
      case DashboardSection.schedule:
        return const ScheduleDashboard();
      case DashboardSection.history:
        return const HistoryDashboard();
      case DashboardSection.messages:
      final screenHeight = MediaQuery.of(context).size.height;
      final appBarHeight = AppBar().preferredSize.height; 
      final availableHeight = screenHeight - appBarHeight - 100;

      return SizedBox(
        height: availableHeight,
        child: const MessageDashboard(),
      );
      case DashboardSection.settings:
        return SettingsDashboard(
          user: _currentUser,
          token: widget.token,
          onProfileUpdated: (updatedUser) {
            setState(() {
              _currentUser = updatedUser;
            });
            AuthService().saveSession(updatedUser, widget.token);
          },
        );
      default:
        return LandingDashboard(user: widget.user, token: widget.token);
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
                            ProfileOverview(user: _currentUser),
                            const SizedBox(height: 24),
                            MainMenu(
                              onLogout: _logout,
                              selectedSection: _selectedSection,
                              onSectionSelected: (DashboardSection section) {
                                setState(() {
                                  _selectedSection = section;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _getSectionWidget(),
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

class MainMenu extends StatelessWidget {
  final VoidCallback onLogout;
  final DashboardSection selectedSection;
  final ValueChanged<DashboardSection> onSectionSelected;

  const MainMenu({
    super.key,
    required this.onLogout,
    required this.selectedSection,
    required this.onSectionSelected,
  });

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required DashboardSection section,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => onSectionSelected(section),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                color: const Color(0xFFF9EBC8),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFFC89E25) : Colors.grey[700]),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFFC89E25) : Colors.black,
              ),
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
          _buildMenuItem(
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            section: DashboardSection.dashboard,
            isSelected: selectedSection == DashboardSection.dashboard,
          ),
          _buildMenuItem(
            icon: Icons.calendar_today_outlined,
            title: 'Jadwal Konseling',
            section: DashboardSection.schedule,
            isSelected: selectedSection == DashboardSection.schedule,
          ),
          _buildMenuItem(
            icon: Icons.history_outlined,
            title: 'Riwayat Konseling',
            section: DashboardSection.history,
            isSelected: selectedSection == DashboardSection.history,
          ),
          _buildMenuItem(
            icon: Icons.message_outlined,
            title: 'Pesan',
            section: DashboardSection.messages,
            isSelected: selectedSection == DashboardSection.messages,
          ),
          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: 'Pengaturan',
            section: DashboardSection.settings,
            isSelected: selectedSection == DashboardSection.settings,
          ),
          const Divider(height: 1),
          InkWell(
            onTap: onLogout,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.grey[700]),
                  const SizedBox(width: 12),
                  const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}