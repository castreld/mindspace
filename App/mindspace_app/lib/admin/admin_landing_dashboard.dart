import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindspace_app/models/admin_dashboard_stats.dart';
import 'package:mindspace_app/services/admin_service.dart';
import 'package:provider/provider.dart';

class AdminLandingDashboard extends StatefulWidget {
  final Function(String) onMenuSelected;
  const AdminLandingDashboard({super.key, required this.onMenuSelected});

  @override
  State<AdminLandingDashboard> createState() => _AdminLandingDashboardState();
}

class _AdminLandingDashboardState extends State<AdminLandingDashboard> {
  late Future<AdminDashboardStats> _statsFuture;

  @override
  void initState() {
    super.initState();
    _refreshStats();
  }

  void _refreshStats() {
    setState(() {
      _statsFuture = context.read<AdminService>().getDashboardStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AdminDashboardStats>(
      future: _statsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Gagal memuat data: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('Tidak ada data.'));
        }

        final stats = snapshot.data!;
        return _buildDashboardContent(stats);
      },
    );
  }

  Widget _buildDashboardContent(AdminDashboardStats stats) {
    return RefreshIndicator(
      onRefresh: () async => _refreshStats(),
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSummaryCards(stats.summary),
          const SizedBox(height: 24),
          _buildNotificationSection(stats.summary),
          const SizedBox(height: 24),
          _buildRecentLogins(stats.recentLogins),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(SummaryStats summary) {
    const blueMaterial = Colors.blue;
    const greenMaterial = Colors.green;
    const redMaterial = Colors.red;

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 3 : 1;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _SummaryCard(
              title: 'Total Klien',
              count: summary.totalClients.toString(),
              icon: Icons.person,
              color: blueMaterial,
            ),
            _SummaryCard(
              title: 'Total Psikolog',
              count: summary.totalTherapists.toString(),
              icon: Icons.psychology,
              color: greenMaterial,
            ),
            _SummaryCard(
              title: 'Laporan Pending',
              count: summary.totalPendingReports.toString(),
              icon: Icons.flag,
              color: redMaterial,
            ),
          ],
        );
      },
    );
  }

  Widget _buildNotificationSection(SummaryStats summary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tindakan Diperlukan",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _NotificationCard(
          title: '${summary.pendingApplications} Aplikasi Psikolog Baru',
          subtitle: 'Tinjau dan setujui pendaftar baru.',
          icon: Icons.person_add,
          color: Colors.orange,
          onTap: () => widget.onMenuSelected('Kelola Psikolog'),
        ),
        const SizedBox(height: 12),
        _NotificationCard(
          title: '${summary.totalPendingReports} Laporan Baru',
          subtitle: 'Lihat laporan dari pengguna dan percakapan.',
          icon: Icons.report_problem,
          color: Colors.red,
          onTap: () => widget.onMenuSelected('Laporan'),
        ),
        const SizedBox(height: 12),
        _NotificationCard(
          title: '${summary.pendingAppeals} Banding Suspensi',
          subtitle: 'Tinjau banding dari akun yang disuspen.',
          icon: Icons.gavel,
          color: Colors.purple,
          onTap: () => widget.onMenuSelected('Kelola Banding'),
        ),
      ],
    );
  }

  Widget _buildRecentLogins(List<ActivityLogItem> logins) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Aktivitas Login Terakhir",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Column(
            children: logins.map((log) {
              final formattedDate =
                  DateFormat('d MMM yyyy, HH:mm').format(log.createdAt.toLocal());
              return ListTile(
                leading: const Icon(Icons.login, color: Colors.green),
                title: Text(
                  '${log.user?.fullName ?? 'N/A'} (${log.ipAddress ?? 'Unknown IP'})',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Device: ${log.userAgent ?? 'Unknown'}\nTime: $formattedDate',
                  style: const TextStyle(fontSize: 12),
                ),
                isThreeLine: true,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final MaterialColor color; 

  const _SummaryCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1), 
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color.shade900), 
              ),
              Icon(icon, color: color, size: 24),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            count,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color.shade900, 
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}