import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindspace_app/models/appointment.dart';
import 'package:mindspace_app/services/booking_service.dart';
import 'package:provider/provider.dart';
import 'widgets/rejection_reason_dialog.dart';

class ScheduleDashboard extends StatefulWidget {
  const ScheduleDashboard({super.key});

  @override
  State<ScheduleDashboard> createState() => _ScheduleDashboardState();
}

class _ScheduleDashboardState extends State<ScheduleDashboard> {
  late Future<List<Appointment>> _schedulesFuture;

  @override
  void initState() {
    super.initState();
    _refreshSchedules();
  }

  void _refreshSchedules() {
    if (mounted) {
      setState(() {
        _schedulesFuture = context.read<BookingService>().getClientAppointments();
      });
    }
  }

  void _showRejectionReason(BuildContext context, Appointment schedule) {
    final reason = schedule.therapistNotes;
    final therapistName = schedule.therapist?.fullName ?? 'Terapis';
    if (reason == null || reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak ada alasan yang diberikan.')),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (_) => RejectionReasonDialog(reason: reason, therapistName: therapistName),
    );
  }

  Future<void> _handleDelete(int appointmentId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin membatalkan jadwal ini?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Tidak')),
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Ya, Batalkan', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await context.read<BookingService>().deleteClientAppointment(appointmentId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Jadwal berhasil dibatalkan.'),
              backgroundColor: Colors.green),
        );
        _refreshSchedules();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Gagal membatalkan: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Map<String, dynamic> _getStatusInfo(String dbStatus) {
    switch (dbStatus) {
      case 'pending_payment':
        return {'text': 'Menunggu Bayar', 'color': const Color(0xFFFFA000), 'action': 'pending_payment'};
      case 'pending_confirmation':
        return {'text': 'Menunggu Konfirmasi', 'color': const Color(0xFFFFA000), 'action': 'pending_confirmation'};
      case 'scheduled':
        return {'text': 'Disetujui', 'color': const Color(0xFF4CAF50), 'action': 'approved'};
      case 'completed':
        return {'text': 'Selesai', 'color': const Color(0xFFBDBDBD), 'action': 'done'};
      case 'cancelled':
        return {'text': 'Dibatalkan', 'color': const Color(0xFFF44336), 'action': 'rejected'};
      case 'payment_failed':
        return {'text': 'Gagal Bayar', 'color': const Color(0xFFD32F2F), 'action': 'rejected'};
      default:
        return {'text': 'Menunggu', 'color': const Color(0xFFFFC107), 'action': 'pending'};
    }
  }

  Widget _statusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Text(text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          textAlign: TextAlign.center),
    );
  }

  Widget _actionButtons(String action, Appointment schedule) {
    switch (action) {
      case 'pending_payment':
        return Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              icon: const Icon(Icons.payment, color: Color(0xFF2196F3)),
              tooltip: 'Bayar',
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.delete_outline, color: Color(0xFFF44336)),
              tooltip: 'Batalkan',
              onPressed: () => _handleDelete(schedule.id)),
        ]);
      case 'pending_confirmation':
        return Row(mainAxisSize: MainAxisSize.min, children: [
           IconButton(
              icon: const Icon(Icons.visibility, color: Color(0xFF2196F3)),
              tooltip: 'Lihat Detail',
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.delete_outline, color: Color(0xFFF44336)),
              tooltip: 'Batalkan',
              onPressed: () => _handleDelete(schedule.id)),
        ]);
      case 'approved':
        return Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              icon: const Icon(Icons.visibility, color: Color(0xFF2196F3)),
              tooltip: 'Lihat Detail',
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.forum, color: Color(0xFF8E24AA)),
              tooltip: 'Pesan',
              onPressed: () {}),
        ]);
      case 'done':
        return Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              icon: const Icon(Icons.visibility, color: Color(0xFF2196F3)),
              tooltip: 'Lihat Detail',
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.star, color: Color(0xFF43A047)),
              tooltip: 'Beri Rating',
              onPressed: () {}),
        ]);
      case 'rejected':
        return Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              icon: const Icon(Icons.visibility, color: Color(0xFF2196F3)),
              tooltip: 'Lihat Alasan',
              onPressed: () => _showRejectionReason(context, schedule)),
          IconButton(
              icon: const Icon(Icons.delete_outline, color: Color(0xFFF44336)),
              tooltip: 'Hapus',
              onPressed: () => _handleDelete(schedule.id)),
        ]);
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Appointment>>(
      future: _schedulesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Gagal memuat jadwal: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: const Text('Anda belum memiliki jadwal konseling.'),
              ),
            ),
          );
        }

        final schedules = snapshot.data!;
        
        final completedCount = schedules.where((s) => s.status == 'completed').length;
        final approvedCount = schedules.where((s) => s.status == 'scheduled').length;
        final pendingCount = schedules.where((s) => s.status == 'pending_payment' || s.status == 'pending_confirmation').length;
        final rejectedCount = schedules.where((s) => s.status == 'cancelled' || s.status == 'payment_failed').length;

        final summaryWidgets = [
          _buildSummaryCard(title: 'Sesi Selesai', count: completedCount, icon: Icons.check_circle_outline, color: const Color(0xFF8D8D8D)),
          _buildSummaryCard(title: 'Jadwal Disetujui', count: approvedCount, icon: Icons.event_available_outlined, color: const Color(0xFF4CAF50)),
          _buildSummaryCard(title: 'Menunggu Konfirmasi', count: pendingCount, icon: Icons.hourglass_empty_outlined, color: const Color(0xFFFFC107)),
          _buildSummaryCard(title: 'Jadwal Ditolak', count: rejectedCount, icon: Icons.cancel_outlined, color: const Color(0xFFF44336)),
        ];

        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth < 900) {
            return _buildMobileLayout(schedules, summaryWidgets);
          } else {
            return _buildDesktopLayout(schedules, summaryWidgets);
          }
        });
      },
    );
  }

  Widget _buildDesktopLayout(List<Appointment> schedules, List<Widget> summaryWidgets) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 7,
          child: _buildDataTableCard(schedules),
        ),
        const SizedBox(width: 24),
        Flexible(
          flex: 3,
          child: Column(
            children: [
              ...summaryWidgets.expand((w) => [w, const SizedBox(height: 12)]),
              const SizedBox(height: 12),
              const AdPlaceholderImage(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(List<Appointment> schedules, List<Widget> summaryWidgets) {
    return Column(
      children: [
        ...summaryWidgets.expand((w) => [w, const SizedBox(height: 12)]),
        const SizedBox(height: 12),
        _buildDataTableCard(schedules),
        const SizedBox(height: 24),
        const AdPlaceholderImage(),
      ],
    );
  }

  Widget _buildDataTableCard(List<Appointment> schedules) {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jadwal Konseling Anda', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Lihat dan kelola semua jadwal konseling yang telah Anda ajukan.', style: TextStyle(fontSize: 16, height: 1.5)),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 24,
              dataRowMinHeight: 60.0,
              dataRowMaxHeight: 80.0,
              headingRowColor: MaterialStateProperty.all(const Color(0xFFF9EBC8)),
              headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3A3A3A), fontSize: 14),
              columns: const [
                DataColumn(label: Text('NO')),
                DataColumn(label: Text('TANGGAL PENGAJUAN')),
                DataColumn(label: Text('KONSELOR')),
                DataColumn(label: Text('JADWAL')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('AKSI')),
              ],
              rows: schedules.asMap().entries.map((entry) {
                int index = entry.key;
                Appointment schedule = entry.value;
                final statusInfo = _getStatusInfo(schedule.status);
                final dateFormat = DateFormat('d MMM yyyy');
                final timeFormat = DateFormat('HH:mm');
                return DataRow(cells: [
                  DataCell(Text((index + 1).toString())),
                  DataCell(Text(dateFormat.format(schedule.appointmentTime))),
                  DataCell(Text(schedule.therapist?.fullName ?? 'N/A')),
                  DataCell(Text('${dateFormat.format(schedule.appointmentTime)}, ${timeFormat.format(schedule.appointmentTime)}')),
                  DataCell(_statusBadge(statusInfo['text'], statusInfo['color'])),
                  DataCell(_actionButtons(statusInfo['action'], schedule)),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class AdPlaceholderImage extends StatelessWidget {
  const AdPlaceholderImage({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset('assets/placeholder.png', fit: BoxFit.cover),
    );
  }
}

class _buildSummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;

  const _buildSummaryCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
                radius: 20,
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, color: color, size: 22)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$count Sesi',
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(title,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}