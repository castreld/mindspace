import 'package:flutter/material.dart';
import 'package:mindspace_app/models/appointment.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/services/booking_service.dart';


import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:mindspace_app/user/dashboard/widgets/history_detail_dialog.dart';

class HistoryDashboard extends StatefulWidget {
  const HistoryDashboard({super.key});

  @override
  State<HistoryDashboard> createState() => _HistoryDashboardState();
}

class _HistoryDashboardState extends State<HistoryDashboard> {
  final TextEditingController _searchController = TextEditingController();
  List<Appointment> _appointments = [];
  List<Appointment> _filteredAppointments = [];
  bool _isLoading = true;
  String? _error;

  List<bool> _selectedFilter = [true, false, false];
  final List<String> _filterValues = ['Semua', 'Selesai', 'Dibatalkan'];

  int _totalSesi = 0;
  int _sesiSelesai = 0;
  int _sesiMendatang = 0;
  int _sesiDibatalkan = 0;


  @override
  void initState() {
    super.initState();
    _searchController.addListener(_applyFilters);
    _fetchHistory();
  }

  @override
  void dispose() {
    _searchController.removeListener(_applyFilters);
    _searchController.dispose();
    super.dispose();
  }

  
  Future<void> _fetchHistory({bool preserveFilters = true}) async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    String? statusFilter;
    String? queryFilter;

    if (preserveFilters) {
      int selectedIndex = _selectedFilter.indexWhere((isSelected) => isSelected);
      if (selectedIndex > 0) {
        statusFilter = _filterValues[selectedIndex];
      }
      queryFilter = _searchController.text;
    }


    try {
      final bookingService = context.read<BookingService>();
      final fetchedAppointments = await bookingService.getAppointmentHistory(
        status: statusFilter,
        searchQuery: queryFilter,
      );

      if (!mounted) return;
      setState(() {
        _appointments = fetchedAppointments;
        _calculateSummary(_appointments);
        _applyFilters();
        _isLoading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Gagal memuat riwayat: ${e.statusCode} ${e.body['message'] ?? e.body}';
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Terjadi kesalahan: $e';
        _isLoading = false;
      });
    }
  }


  void _calculateSummary(List<Appointment> appointments) {
    final userRole = context.read<AuthService>().currentUser?.role;

    _totalSesi = appointments.length;
    _sesiSelesai = appointments.where((a) => a.status == 'Selesai' || a.status == 'completed').length;
    
    if (userRole == 'psikolog') {
      _sesiMendatang = appointments.where((a) => a.status == 'Terjadwal' || a.status == 'Menunggu Konfirmasi' || a.status == 'scheduled' || a.status == 'pending_confirmation').length;
    } else {
      _sesiMendatang = appointments.where((a) => a.status == 'Terjadwal' || a.status == 'scheduled').length;
    }
    _sesiDibatalkan = appointments.where((a) => a.status == 'Dibatalkan' || a.status == 'cancelled').length;
  }

  void _applyFilters() {
    final userRole = context.read<AuthService>().currentUser?.role;
    String currentStatusFilter = '';
    int selectedIndex = _selectedFilter.indexWhere((isSelected) => isSelected);
    if (selectedIndex > 0) {
      currentStatusFilter = _filterValues[selectedIndex];
    }
    String query = _searchController.text.toLowerCase();

    
    List<Appointment> results = _appointments.where((appointment) {
      
      String normalizedStatus = appointment.status.replaceAll('_', ' ').toLowerCase();
      String filterStatus = currentStatusFilter.toLowerCase();
      
      bool statusMatch = currentStatusFilter.isEmpty || normalizedStatus == filterStatus;
      if (!statusMatch) return false;

      if (query.isNotEmpty) {
        bool nameMatch;
        if (userRole == 'psikolog') {
          nameMatch = appointment.client?.fullName.toLowerCase().contains(query) ?? false;
        } else {
          nameMatch = appointment.therapist?.fullName.toLowerCase().contains(query) ?? false;
        }
        
        bool topicMatch = appointment.clientNotes?.toLowerCase().contains(query) ?? false;

        if (!(nameMatch || topicMatch)) {
          return false;
        }
      }
      return true;
    }).toList();

    if (mounted){
      setState(() {
        _filteredAppointments = results;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 24),
          _buildHistoryListCard(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                bool isWide = constraints.maxWidth > 600;
                return Flex(
                  direction: isWide ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: isWide ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                  crossAxisAlignment: isWide ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: isWide ? 0 : 12.0),
                      child: const Text(
                        'Ringkasan Aktivitas Konseling',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ToggleButtons(
                      isSelected: _selectedFilter,
                      onPressed: (index) {
                        setState(() {
                          for (int i = 0; i < _selectedFilter.length; i++) {
                            _selectedFilter[i] = i == index;
                          }
                          _applyFilters();
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      selectedColor: Colors.white,
                      fillColor: Colors.purple.shade700,
                      color: Colors.purple.shade700,
                      constraints: const BoxConstraints(minHeight: 36.0, minWidth: 60.0),
                      children: _filterValues
                          .map((label) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(label),
                              ))
                          .toList(),
                    ),
                  ],
                );
              }
            ),
            const SizedBox(height: 20),
            _isLoading
             ? const Center(child: CircularProgressIndicator())
             : LayoutBuilder(
                builder: (context, constraints) {
                  const double spacing = 16.0;
                  int crossAxisCount = (constraints.maxWidth < 600) ? 2 : 4;
                  double boxWidth = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
                  boxWidth = boxWidth < 120 ? 120 : boxWidth;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildSummaryBox(_totalSesi.toString(), 'Total Sesi', boxWidth),
                      _buildSummaryBox(_sesiSelesai.toString(), 'Sesi Selesai', boxWidth),
                      _buildSummaryBox(_sesiMendatang.toString(), 'Sesi Mendatang', boxWidth),
                      _buildSummaryBox(_sesiDibatalkan.toString(), 'Sesi Dibatalkan', boxWidth),
                    ],
                  );
                },
              )
          ],
        ),
      ),
    );
  }

    Widget _buildSummaryBox(String count, String label, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.orange.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(count, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildHistoryListCard() {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text('Riwayat Konseling', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 250,
                  height: 40,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari sesi...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    onChanged: (_) => _applyFilters(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const Padding(padding: EdgeInsets.all(32.0), child: CircularProgressIndicator())
                : _error != null
                    ? Padding(padding: const EdgeInsets.all(32.0), child: Text(_error!, style: const TextStyle(color: Colors.red)))
                    : Column(
                        children: _filteredAppointments.isNotEmpty
                            ? _filteredAppointments.map((appointment) => _buildHistoryItem(appointment)).toList()
                            : [const Padding(padding: EdgeInsets.all(32.0), child: Text("Tidak ada riwayat yang cocok."))],
                      ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(Appointment item) {
    final userRole = context.watch<AuthService>().currentUser?.role;
    
    bool isCompleted = item.status == 'Selesai' || item.status == 'completed';
    bool isCancelled = item.status == 'Dibatalkan' || item.status == 'cancelled';
    bool isScheduled = item.status == 'Terjadwal' || item.status == 'scheduled';
    bool isPending = item.status == 'Menunggu Konfirmasi' || item.status == 'pending_confirmation';
    
    Color statusColor;
    String statusText;

    if (isCompleted) {
      statusColor = Colors.green;
      statusText = 'Selesai';
    } else if (isCancelled) {
      statusColor = Colors.red;
      statusText = 'Dibatalkan';
    } else if (isScheduled) {
      statusColor = Colors.blue;
      statusText = 'Terjadwal';
    } else if (isPending) {
      statusColor = Colors.orange;
      statusText = 'Menunggu Konfirmasi';
    } else {
      statusColor = Colors.grey;
      statusText = item.status;
    }

    String displayName = userRole == 'psikolog'
      ? item.client?.fullName ?? 'Klien Tidak Diketahui'
      : item.therapist?.fullName ?? 'Psikolog Tidak Diketahui';

    String topicText = userRole == 'psikolog'
      ? item.clientNotes ?? 'Tidak ada catatan klien'
      : 'Sesi Konseling';


    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(displayName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.calendar_today, DateFormat('EEEE, d MMM yyyy, HH:mm', 'id_ID').format(item.appointmentTime)),
                    const SizedBox(height: 6),
                    _buildInfoRow(
                      userRole == 'psikolog' ? Icons.person_outline : Icons.support_agent,
                      displayName
                    ),
                    const SizedBox(height: 6),
                    _buildInfoRow(Icons.topic_outlined, topicText),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(statusText, style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const SizedBox(height: 8),
                  if (isCompleted && item.rating != null && item.rating! > 0 && userRole == 'klien')
                    _buildRatingStars(item.rating!)
                  else
                    const SizedBox(height: 28),
                  OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          
                          return HistoryDetailDialog(
                            appointment: item,
                            currentUserRole: userRole ?? 'klien',
                            onReviewSubmitted: () {
                              
                              _fetchHistory(preserveFilters: true);
                            },
                          );
                        },
                      );
                    },
                    child: const Text('Detail')
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(color: Colors.grey[800]))),
      ],
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }
}