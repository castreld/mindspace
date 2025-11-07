import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindspace_app/config.dart';
import 'package:mindspace_app/models/appointment.dart';
import 'package:mindspace_app/services/booking_service.dart';
import 'package:mindspace_app/user/dashboard/widgets/client_detail_dialog.dart';
import 'package:mindspace_app/user/dashboard/widgets/rejection_dialog.dart';
import 'package:provider/provider.dart';

class TherapistDashboard extends StatefulWidget {
  const TherapistDashboard({super.key});

  @override
  State<TherapistDashboard> createState() => _TherapistDashboardState();
}

class _TherapistDashboardState extends State<TherapistDashboard> {
  late Future<List<Appointment>> _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _refreshAppointments();
  }

  void _refreshAppointments() {
    if (mounted) {
      setState(() {
        _appointmentsFuture =
            context.read<BookingService>().getTherapistAppointments();
      });
    }
  }

  String _parseApiError(Object e) {
    if (e is ApiException) {
      if (e.body is Map && e.body['message'] != null) {
        return e.body['message'];
      }
      return 'Gagal dengan status: ${e.statusCode}';
    }
    return 'Terjadi kesalahan tidak terduga.';
  }

  Future<void> _handleApprove(int appointmentId) async {
    try {
      await context.read<BookingService>().approveAppointment(appointmentId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Janji temu berhasil disetujui.'),
            backgroundColor: Colors.green),
      );
      _refreshAppointments();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Gagal menyetujui: ${_parseApiError(e)}'),
            backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _handleReject(int appointmentId) async {
    final reason = await showDialog<String>(
      context: context,
      builder: (context) => const RejectionDialog(),
    );

    if (reason != null && reason.isNotEmpty) {
      try {
        await context
            .read<BookingService>()
            .rejectAppointment(appointmentId, reason);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Janji temu berhasil ditolak.'),
              backgroundColor: Colors.blueGrey),
        );
        _refreshAppointments();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Gagal menolak: ${_parseApiError(e)}'),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Appointment>>(
      future: _appointmentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Gagal memuat janji temu: ${_parseApiError(snapshot.error!)}',
              style: TextStyle(color: Colors.red.shade700),
            ),
          );
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
                child: const Text('Tidak ada janji temu yang akan datang.'),
              ),
            ),
          );
        }

        final appointments = snapshot.data!;

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  return _buildAppointmentCard(appointments[index]);
                },
              );
            } else {
              int crossAxisCount = (constraints.maxWidth / 400).floor().clamp(1, 4);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: (constraints.maxWidth / crossAxisCount) / 320,
                ),
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  return _buildAppointmentCard(appointments[index]);
                },
              );
            }
          },
        );
      },
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    final dateFormat = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
    final timeFormat = DateFormat('HH:mm', 'id_ID');
    final clientName = appointment.client?.fullName ?? 'Klien Tidak Diketahui';
    final clientImageUrl = appointment.client?.profilePicture;

    final String displayStatus =
        appointment.status.replaceAll('_', ' ').toUpperCase();
    final bool isActionable =
        displayStatus == 'PENDING CONFIRMATION' ||
        displayStatus == 'MENUNGGU KONFIRMASI';

    return Card(
      margin: EdgeInsets.zero,
      color: const Color(0xFFFFF8F0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      onBackgroundImageError: (exception, stackTrace) {
                        if (kDebugMode) {
                          print("Failed to load client image: $exception");
                        }
                      },
                      backgroundImage: clientImageUrl != null
                          ? NetworkImage(
                              '${AppConfig.backendBaseUrl}/api/$clientImageUrl')
                          : null,
                      child: clientImageUrl == null
                          ? const Icon(Icons.person, size: 30)
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(clientName,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 4),
                          Text(
                            'Status: $displayStatus',
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                _buildInfoRow(Icons.calendar_today_outlined,
                    dateFormat.format(appointment.appointmentTime)),
                const SizedBox(height: 8),
                _buildInfoRow(
                  Icons.access_time_outlined,
                  '${timeFormat.format(appointment.appointmentTime)} - ${timeFormat.format(appointment.appointmentTime.add(Duration(minutes: appointment.durationMinutes)))} WIB',
                ),
                const SizedBox(height: 12),
                if (appointment.clientNotes != null &&
                    appointment.clientNotes!.isNotEmpty)
                  Text(
                    'Keluhan: ${appointment.clientNotes}',
                    style: TextStyle(color: Colors.grey.shade800),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    if (appointment.client == null) return;
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()));
                    try {
                      final clientDetails = await context
                          .read<BookingService>()
                          .getClientDetails(appointment.client!.id);
                      if (!mounted) return;
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (context) =>
                              ClientDetailDialog(client: clientDetails));
                    } catch (e) {
                      if (!mounted) return;
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Gagal memuat detail klien: ${_parseApiError(e)}'),
                          backgroundColor: Colors.red));
                    }
                  },
                  child: const Text('Lihat Detail'),
                ),
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  enabled: isActionable,
                  onSelected: (value) {
                    if (value == 'approve') {
                      _handleApprove(appointment.id);
                    } else if (value == 'reject') {
                      _handleReject(appointment.id);
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'approve',
                      child: ListTile(
                          leading: Icon(Icons.check, color: Colors.green),
                          title: Text('Setujui')),
                    ),
                    const PopupMenuItem<String>(
                      value: 'reject',
                      child: ListTile(
                          leading: Icon(Icons.close, color: Colors.red),
                          title: Text('Tolak')),
                    ),
                  ],
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: isActionable ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2))
                        ]),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Tindakan',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_drop_down, color: Colors.white)
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade700),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 15)),
      ],
    );
  }
}