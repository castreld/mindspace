import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mindspace_app/animated_background.dart';
import 'package:mindspace_app/auth/login.dart';
import 'package:mindspace_app/routes.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';
import '../models/user.dart';

class MainDashboard extends StatefulWidget {
  final User user;
  const MainDashboard({super.key, required this.user});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          const AnimatedGradientBackground(),
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
                          children: [
                            ProfileOverview(user: widget.user),
                            const SizedBox(height: 24),
                            const MainMenu(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: LandingDashboard(user: widget.user),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverFillRemaining(hasScrollBody: false),
              if (kIsWeb) FooterSection(),
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
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white,),
            ),
            const SizedBox(height: 16,),
            Text(
              widget.user.username,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4,),
            Text(
              widget.user.email,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () {
                
              },
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

  Widget _buildMenuItem({required IconData icon, required String title}) {
    return InkWell(
      onTap: () {},
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(12),
        bottom: Radius.circular(12)
      ),
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
      elevation: 2,
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
        ],
      ),
    );
  }
}

class LandingDashboard extends StatefulWidget {
  final User user;
  const LandingDashboard({super.key, required this.user});

  @override
  State<LandingDashboard> createState() => LandingDashboardState();
}

class LandingDashboardState extends State<LandingDashboard> {

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
    required String buttonText,
  }) {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: Colors.black87),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
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
  
  Widget _buildPsychologistCard({
    required String name,
    required String specialty,
  }) {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundColor: Color(0xFFF9A825),
              child: Text('RS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(specialty, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            )
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
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Text(
              'Selamat Datang, ${widget.user.username}\nIni adalah dashboard layanan konsaling MINDSPACE. Didalam halaman ini anda bisa menggunakan beberapa fitur yang disediakan oleh kami',
              style: const TextStyle(fontSize: 16, height: 1.5),
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
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: const ListTile(
            title: Text('Aktivitas Terbaru', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Pendaftaran Akun\nAnda telah berhasil mendaftar dan membuat akun'),
            isThreeLine: true,
          ),
        ),
        const SizedBox(height: 24),
        
      ],
    );
  }
}

class ScheduleDashboard extends StatefulWidget {
  const ScheduleDashboard({super.key});

  @override
  State<ScheduleDashboard> createState() => _ScheduleDashboardState();
}

class _ScheduleDashboardState extends State<ScheduleDashboard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HistoryDashboard extends StatefulWidget {
  const HistoryDashboard({super.key});

  @override
  State<HistoryDashboard> createState() => _HistoryDashboardState();
}

class _HistoryDashboardState extends State<HistoryDashboard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MessageDashboard extends StatefulWidget {
  const MessageDashboard({super.key});

  @override
  State<MessageDashboard> createState() => _MessageDashboardState();
}

class _MessageDashboardState extends State<MessageDashboard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SettingsDashboard extends StatefulWidget {
  const SettingsDashboard({super.key});

  @override
  State<SettingsDashboard> createState() => _SettingsDashboardState();
}

class _SettingsDashboardState extends State<SettingsDashboard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}