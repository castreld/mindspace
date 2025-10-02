import 'package:flutter/material.dart';

class HistoryDashboard extends StatefulWidget {
  const HistoryDashboard({super.key});

  @override
  State<HistoryDashboard> createState() => _HistoryDashboardState();
}

class _HistoryDashboardState extends State<HistoryDashboard> {
  
  final TextEditingController _searchController = TextEditingController();
  
  
  List<bool> _selectedFilter = [true, false, false];

  
  final List<Map<String, dynamic>> _allHistory = [
    {
      'kategori': 'Konseling Akademik',
      'tanggal': '15 Mei 2025, 10:00 - 11:00',
      'konselor': 'Guru konseling 1',
      'topik': 'Strategi belajar efektif untuk persiapan Ujian Akhir',
      'status': 'Selesai',
      'rating': 4,
    },
    {
      'kategori': 'Konseling Karier',
      'tanggal': '20 Mei 2025, 09:30 - 10:30',
      'konselor': 'Guru konseling 1',
      'topik': 'Diskusi pemilihan jurusan kuliah',
      'status': 'Dibatalkan',
      'rating': 0,
    },
    {
      'kategori': 'Konseling Pribadi',
      'tanggal': '05 April 2025, 11:00 - 12:00',
      'konselor': 'Dr. Rani Sari, M.Psi',
      'topik': 'Manajemen stres dan kecemasan',
      'status': 'Selesai',
      'rating': 5,
    },
  ];

  
  late List<Map<String, dynamic>> _filteredHistory;

  @override
  void initState() {
    super.initState();
    
    _filteredHistory = _allHistory;
    
    _searchController.addListener(_filterHistory);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  
  void _filterHistory() {
    List<Map<String, dynamic>> results = [];
    String currentStatusFilter = '';
    if (_selectedFilter[1]) currentStatusFilter = 'Selesai';
    if (_selectedFilter[2]) currentStatusFilter = 'Dibatalkan';

    
    if (currentStatusFilter.isEmpty) {
      results = _allHistory; 
    } else {
      results = _allHistory
          .where((item) => item['status'] == currentStatusFilter)
          .toList();
    }

    
    String query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      results = results.where((item) {
        return item['kategori'].toLowerCase().contains(query) ||
               item['topik'].toLowerCase().contains(query) ||
               item['konselor'].toLowerCase().contains(query);
      }).toList();
    }

    setState(() {
      _filteredHistory = results;
    });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ringkasan Aktivitas Konseling',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ToggleButtons(
                  isSelected: _selectedFilter,
                  onPressed: (index) {
                    setState(() {
                      for (int i = 0; i < _selectedFilter.length; i++) {
                        _selectedFilter[i] = i == index;
                      }
                      _filterHistory(); 
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  selectedColor: Colors.white,
                  fillColor: Colors.purple.shade700,
                  color: Colors.purple.shade700,
                  constraints: const BoxConstraints(minHeight: 36.0),
                  children: const [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Text('Semua')),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Text('Selesai')),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Text('Dibatalkan')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildSummaryBox('12', 'Total Sesi'),
                const SizedBox(width: 16),
                _buildSummaryBox('7', 'Sesi Selesai'),
                const SizedBox(width: 16),
                _buildSummaryBox('2', 'Sesi Mendatang'),
                const SizedBox(width: 16),
                _buildSummaryBox('3', 'Sesi Dibatalkan'),
              ],
            )
          ],
        ),
      ),
    );
  }

  
  Widget _buildSummaryBox(String count, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.orange.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(count, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ],
        ),
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
                const Text('Riwayat Konseling', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Column(
              children: _filteredHistory.isNotEmpty
                  ? _filteredHistory.map((item) => _buildHistoryItem(item)).toList()
                  : [const Padding(padding: EdgeInsets.all(32.0), child: Text("Tidak ada riwayat yang cocok."))],
            ),
          ],
        ),
      ),
    );
  }
  
  
  Widget _buildHistoryItem(Map<String, dynamic> item) {
    bool isCompleted = item['status'] == 'Selesai';
    Color statusColor = isCompleted ? Colors.green : Colors.red;

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['kategori'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.calendar_today, item['tanggal']),
                  const SizedBox(height: 6),
                  _buildInfoRow(Icons.person, item['konselor']),
                  const SizedBox(height: 6),
                  _buildInfoRow(Icons.topic_outlined, item['topik']),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(item['status'], style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const SizedBox(height: 8),
                  if (isCompleted) _buildRatingStars(item['rating']),
                  const SizedBox(height: 8),
                  OutlinedButton(onPressed: () {}, child: const Text('Detail')),
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
      children: [
        Icon(icon, size: 16, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: Colors.grey[800])),
      ],
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
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