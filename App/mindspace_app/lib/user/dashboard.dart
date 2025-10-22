import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mindspace_app/config.dart';
import 'package:mindspace_app/user/dashboard/history_dashboard.dart';
import 'package:mindspace_app/user/dashboard/message_dashboard.dart';
import 'package:mindspace_app/user/dashboard/settings_dashboard.dart';
import 'package:mindspace_app/user/dashboard/therapist_dashboard.dart';
import 'package:provider/provider.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/footer.dart';
import '../../models/user.dart';
import '../../routes.dart';
import 'package:mindspace_app/animated_background_dark.dart';
import 'package:mindspace_app/user/dashboard/landing_dashboard.dart';
import 'package:mindspace_app/user/dashboard/schedule_dashboard.dart';
import 'package:mindspace_app/services/auth_service.dart';

enum DashboardSection {
  dashboard,
  schedule,
  history,
  messages,
  settings,
  manageAppointments,
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  DashboardSection _selectedSection = DashboardSection.dashboard;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onSectionSelected(DashboardSection section) {
    setState(() {
      _selectedSection = section;
    });
    if (MediaQuery.of(context).size.width < 900) {
      Navigator.of(context).pop();
    }
  }

  Widget _getSectionWidget() {
    switch (_selectedSection) {
      case DashboardSection.dashboard:
        return const LandingDashboard();
      case DashboardSection.schedule:
        return const ScheduleDashboard();
      case DashboardSection.history:
        return const HistoryDashboard();
      case DashboardSection.messages:
        return const MessageDashboard();
      case DashboardSection.settings:
        return const SettingsDashboard();
      case DashboardSection.manageAppointments:
        return const TherapistDashboard();
      default:
        return const LandingDashboard();
    }
  }

  // Widget to show background - animated on desktop/web, static on mobile
  Widget _buildBackground(bool isMobile) {
    if (isMobile && !kIsWeb) {
      // Static gradient for mobile apps
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2C1A3D),
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
            ],
          ),
        ),
      );
    } else {
      // Animated background for web or desktop
      return const AnimatedGradientBackgroundDark();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final currentUser = authService.currentUser!;

    final mainMenu = MainMenu(
      user: currentUser,
      selectedSection: _selectedSection,
      onSectionSelected: _onSectionSelected,
    );

    const double mobileBreakpoint = 850;
    final bool isMobile = MediaQuery.of(context).size.width < mobileBreakpoint;
    final String currentRoute =
        ModalRoute.of(context)?.settings.name ?? AppRoutes.dashboard;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        user: currentUser,
        showNavButtonsAsActions: !isMobile,
      ),
      drawer: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 900) {
            return Drawer(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      ProfileOverview(
                        user: currentUser,
                        onEditProfilePressed: () =>
                            _onSectionSelected(DashboardSection.settings),
                      ),
                      const SizedBox(height: 24),
                      mainMenu,
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: Stack(
        children: [
          _buildBackground(isMobile),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 900) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _getSectionWidget(),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 260,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ProfileOverview(
                                      user: currentUser,
                                      onEditProfilePressed: () =>
                                          _onSectionSelected(
                                              DashboardSection.settings),
                                    ),
                                    const SizedBox(height: 24),
                                    mainMenu,
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _getSectionWidget(),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar:
          isMobile ? AppBottomNavigationBar(currentRoute: currentRoute) : null,
    );
  }
}

class ProfileOverview extends StatelessWidget {
  final User user;
  final VoidCallback onEditProfilePressed;

  const ProfileOverview({
    super.key,
    required this.user,
    required this.onEditProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = user.username ?? user.fullName;
    final firstChar = displayName.isNotEmpty 
        ? displayName.substring(0, 1).toUpperCase() 
        : '?';

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
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: user.profilePicture != null
                  ? NetworkImage(
                      '${AppConfig.backendBaseUrl}/api/${user.profilePicture!}')
                  : null,
              child: user.profilePicture == null
                  ? Icon(Icons.person, size: 50, color: Colors.grey.shade700)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              displayName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              user.email,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onEditProfilePressed,
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
  final User user;
  final DashboardSection selectedSection;
  final ValueChanged<DashboardSection> onSectionSelected;

  const MainMenu({
    super.key,
    required this.user,
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
            Icon(icon,
                color: isSelected ? const Color(0xFFC89E25) : Colors.grey[700]),
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
          if (user.role == 'psikolog')
            _buildMenuItem(
              icon: Icons.assignment_ind_outlined,
              title: 'Kelola Janji Temu',
              section: DashboardSection.manageAppointments,
              isSelected: selectedSection == DashboardSection.manageAppointments,
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
            onTap: () {
              context.read<AuthService>().clearSession();
            },
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