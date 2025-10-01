import 'package:flutter/material.dart';

class ScheduleDashboard extends StatefulWidget {
  const ScheduleDashboard({super.key});

  @override
  State<ScheduleDashboard> createState() => _ScheduleDashboardState();
}

class _ScheduleDashboardState extends State<ScheduleDashboard> {
  final List<Map<String, dynamic>> _schedules = [
     {
      'tanggal': '10 Mei 2025',
      'konselor': 'Dr. Rani Sari, M.Psi',
      'jadwal': '15 Mei 2025, 10:10',
      'kategori': 'Akademik',
      'status': 'Menunggu',
      'aksi': 'pending',
    },
    {
      'tanggal': '11 Mei 2025',
      'konselor': 'Dr. Rani Sari, M.Psi',
      'jadwal': '16 Mei 2025, 11:00',
      'kategori': 'Akademik',
      'status': 'Disetujui',
      'aksi': 'approved',
    },
    {
      'tanggal': '12 Mei 2025',
      'konselor': 'Dr. Budi Santoso, S.Psi',
      'jadwal': '18 Mei 2025, 14:00',
      'kategori': 'Karier',
      'status': 'Selesai',
      'aksi': 'done',
    },
    {
      'tanggal': '13 Mei 2025',
      'konselor': 'Dr. Rani Sari, M.Psi',
      'jadwal': '20 Mei 2025, 09:30',
      'kategori': 'Pribadi',
      'status': 'Ditolak',
      'aksi': 'rejected',
    },
  ];

  Widget _statusBadge(String status) {
    Color color;
    switch (status) {
      case 'Menunggu':
        color = const Color(0xFFFFC107);
        break;
      case 'Disetujui':
        color = const Color(0xFF4CAF50);
        break;
      case 'Selesai':
        color = const Color(0xFFBDBDBD);
        break;
      case 'Ditolak':
        color = const Color(0xFFF44336);
        break;
      default:
        color = Colors.blueGrey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _actionButtons(String aksi) {
    switch (aksi) {
      case 'pending':
        return Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              icon: const Icon(Icons.visibility, color: Color(0xFF2196F3)),
              tooltip: 'Lihat',
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.close, color: Color(0xFFF44336)),
              tooltip: 'Batalkan',
              onPressed: () {}),
        ]);
      case 'approved':
        return Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              icon: const Icon(Icons.visibility, color: Color(0xFF2196F3)),
              tooltip: 'Lihat',
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
              tooltip: 'Lihat',
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
              tooltip: 'Lihat',
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.refresh, color: Color(0xFF8E24AA)),
              tooltip: 'Ajukan Ulang',
              onPressed: () {}),
        ]);
      default:
        return const SizedBox();
    }
  }

  Widget _buildSummaryCard({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
  }) {
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
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$count Sesi',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCount =
        _schedules.where((s) => s['status'] == 'Selesai').length;
    final approvedCount =
        _schedules.where((s) => s['status'] == 'Disetujui').length;
    final pendingCount =
        _schedules.where((s) => s['status'] == 'Menunggu').length;
    final rejectedCount =
        _schedules.where((s) => s['status'] == 'Ditolak').length;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT SECTION (TABLE)
        Flexible(
          flex: 7,
          child: Card(
            color: const Color(0xFFFFF8F0),
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jadwal Konseling Anda',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(
                          'Lihat dan kelola semua jadwal konseling yang telah Anda ajukan.',
                          style: TextStyle(fontSize: 16, height: 1.5)),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 24,
                    dataRowMinHeight: 60.0,
                    dataRowMaxHeight: 80.0,
                    headingRowColor:
                        MaterialStateProperty.all(const Color(0xFFF9EBC8)),
                    headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3A3A3A),
                        fontSize: 14),
                    columns: const [
                      DataColumn(label: Text('NO')),
                      DataColumn(label: Text('TANGGAL PENGAJUAN')),
                      DataColumn(label: Text('KONSELOR')),
                      DataColumn(label: Text('JADWAL')),
                      DataColumn(label: Text('KATEGORI')),
                      DataColumn(label: Text('STATUS')),
                      DataColumn(label: Text('AKSI')),
                    ],
                    rows: _schedules.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> schedule = entry.value;
                      return DataRow(cells: [
                        DataCell(Text((index + 1).toString())),
                        DataCell(Text(schedule['tanggal'])),
                        DataCell(Text(schedule['konselor'])),
                        DataCell(Text(schedule['jadwal'])),
                        DataCell(Text(schedule['kategori'])),
                        DataCell(_statusBadge(schedule['status'])),
                        DataCell(_actionButtons(schedule['aksi'])),
                      ]);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        // RIGHT SECTION (SUMMARY & AD)
        Flexible(
          flex: 3,
          child: Column(
            children: [
              _buildSummaryCard(
                title: 'Sesi Selesai',
                count: completedCount,
                icon: Icons.check_circle_outline,
                color: const Color(0xFF8D8D8D),
              ),
              const SizedBox(height: 12),
              _buildSummaryCard(
                title: 'Jadwal Disetujui',
                count: approvedCount,
                icon: Icons.event_available_outlined,
                color: const Color(0xFF4CAF50),
              ),
              const SizedBox(height: 12),
              _buildSummaryCard(
                title: 'Menunggu Konfirmasi',
                count: pendingCount,
                icon: Icons.hourglass_empty_outlined,
                color: const Color(0xFFFFC107),
              ),
              const SizedBox(height: 12),
              _buildSummaryCard(
                title: 'Jadwal Ditolak',
                count: rejectedCount,
                icon: Icons.cancel_outlined,
                color: const Color(0xFFF44336),
              ),
              const SizedBox(height: 24),
              // ## Replaced carousel with a simple placeholder
              const AdPlaceholderImage(),
            ],
          ),
        ),
      ],
    );
  }
}

// ## New widget for the static ad image
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
      child: Image.network(
        'https://placehold.co/600x320/E8D5C4/604970?text=Your+Ad+Here',
        fit: BoxFit.cover,
      ),
    );
  }
}