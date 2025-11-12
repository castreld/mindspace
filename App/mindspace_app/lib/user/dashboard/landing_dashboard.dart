import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mindspace_app/auth/appeal_dialog.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:mindspace_app/config.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/user/dashboard.dart';
import 'package:mindspace_app/user/activity_history_screen.dart';

class LandingDashboard extends StatefulWidget {
  final ValueChanged<DashboardSection> onNavigate;

  const LandingDashboard({super.key, required this.onNavigate});

  @override
  State<LandingDashboard> createState() => LandingDashboardState();
}

class LandingDashboardState extends State<LandingDashboard> {
  String _activityTitle = 'Memuat Aktivitas...';
  String _activityDescription = '';
  bool _isLoadingActivity = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _fetchRecentActivity();
      }
    });
  }

  Future<void> _fetchRecentActivity() async {
    final token = context.read<AuthService>().token;
    if (token == null) {
      if (mounted) {
        setState(() {
          _activityTitle = 'Error';
          _activityDescription = 'Token otentikasi tidak ditemukan.';
          _isLoadingActivity = false;
        });
      }
      return;
    }

    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/activity-history');

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (mounted) {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final latestActivity = (data['data'] as List).firstOrNull;
          if (latestActivity != null) {
            setState(() {
              _activityTitle =
                  'Login Terakhir: ${latestActivity['activity_type']}';
              _activityDescription = 'Dari IP: ${latestActivity['ip_address']}';
              _isLoadingActivity = false;
            });
          } else {
            setState(() {
              _activityTitle = 'Selamat Datang!';
              _activityDescription = 'Ini adalah login pertama Anda.';
              _isLoadingActivity = false;
            });
          }
        } else {
          setState(() {
            _activityTitle = 'Error';
            _activityDescription = 'Tidak dapat memuat aktivitas terbaru.';
            _isLoadingActivity = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _activityTitle = 'Error';
          _activityDescription = 'Tidak dapat terhubung ke server.';
          _isLoadingActivity = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthService>().currentUser;
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSuspensionWarning(context, user),
          _buildWelcomeCard(user),
          const SizedBox(height: 24),
          _buildRoleSpecificSummary(user),
          const SizedBox(height: 24),
          _buildRecentActivityCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSuspensionWarning(BuildContext context, User user) {
    if (user.role != 'psikolog' ||
        user.suspendedUntil == null ||
        !user.suspendedUntil!.isAfter(DateTime.now())) {
      return const SizedBox.shrink();
    }

    final formattedDate = DateFormat('d MMMM yyyy, HH:mm', 'id_ID')
        .format(user.suspendedUntil!.toLocal());

    return Card(
      color: Colors.red.shade100,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.red.shade700, width: 1),
      ),
      margin: const EdgeInsets.only(bottom: 24.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: Colors.red.shade700, size: 30),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Akun Anda Disuspen',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Akun Anda tidak akan muncul di hasil pencarian dan tidak dapat menerima janji temu baru hingga:\n$formattedDate',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red.shade800,
                          height: 1.4,
                        ),
                      ),
                      if (user.suspendedReason != null &&
                          user.suspendedReason!.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Text(
                          'Alasan: ${user.suspendedReason}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.red.shade800,
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AppealDialog(),
                  );
                },
                child: const Text('Ajukan Banding'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(User user) {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang, ${user.username}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ini adalah dashboard layanan konseling MINDSPACE. Di dalam halaman ini Anda bisa menggunakan beberapa fitur yang disediakan oleh kami.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleSpecificSummary(User user) {
    List<Widget> summaryCards = (user.role == 'psikolog')
        ? _buildPsikologSummaryCards()
        : _buildKlienSummaryCards();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          // Mobile View (Stacked)
          return Column(
            children: [
              summaryCards[0],
              const SizedBox(height: 20),
              summaryCards[1],
              const SizedBox(height: 20),
              summaryCards[2],
            ],
          );
        } else {
          // Desktop View (Row)
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: summaryCards[0]),
              const SizedBox(width: 20),
              Expanded(child: summaryCards[1]),
              const SizedBox(width: 20),
              Expanded(child: summaryCards[2]),
            ],
          );
        }
      },
    );
  }

  void _safeNavigate(DashboardSection section) {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        widget.onNavigate(section);
      }
    });
  }

  List<Widget> _buildKlienSummaryCards() {
    return [
      _buildSummaryCard(
        icon: Icons.calendar_month,
        title: 'Jadwal Konseling',
        subtitle: 'Lihat jadwal sesi Anda yang akan datang.',
        buttonText: 'Lihat Jadwal',
        onPressed: () => _safeNavigate(DashboardSection.schedule),
      ),
      _buildSummaryCard(
        icon: Icons.message,
        title: 'Pesan',
        subtitle: 'Lihat percakapan dengan psikolog atau klien.',
        buttonText: 'Lihat Pesan',
        onPressed: () => _safeNavigate(DashboardSection.messages),
      ),
      _buildSummaryCard(
        icon: Icons.history,
        title: 'Riwayat Sesi',
        subtitle: 'Lihat sesi konseling yang telah selesai.',
        buttonText: 'Lihat Riwayat',
        onPressed: () => _safeNavigate(DashboardSection.history),
      ),
    ];
  }

  List<Widget> _buildPsikologSummaryCards() {
    return [
      _buildSummaryCard(
        icon: Icons.assignment_ind_outlined,
        title: 'Kelola Janji Temu',
        subtitle: 'Setujui atau tolak permintaan sesi klien.',
        buttonText: 'Kelola Janji Temu',
        onPressed: () => _safeNavigate(DashboardSection.manageAppointments),
      ),
      _buildSummaryCard(
        icon: Icons.message,
        title: 'Pesan',
        subtitle: 'Lihat percakapan dengan klien.',
        buttonText: 'Lihat Pesan',
        onPressed: () => _safeNavigate(DashboardSection.messages),
      ),
      _buildSummaryCard(
        icon: Icons.settings_outlined,
        title: 'Pengaturan',
        subtitle: 'Atur profil dan ketersediaan Anda.',
        buttonText: 'Atur Profil',
        onPressed: () => _safeNavigate(DashboardSection.settings),
      ),
    ];
  }

  Widget _buildRecentActivityCard() {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _isLoadingActivity
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  leading: const Icon(Icons.security_outlined, color: Colors.blue, size: 30),
                  title: Text(_activityTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(_activityDescription),
                  isThreeLine: true,
                ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Lihat Semua Aktivitas', style: TextStyle(color: Colors.blue)),
            trailing: const Icon(Icons.arrow_forward, color: Colors.blue),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ActivityHistoryScreen())
              );
            },
          )
        ],
      ),
    );
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
                style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.4)),
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
}