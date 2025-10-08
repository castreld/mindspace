import 'package:flutter/material.dart';

class KelolaPsikologPage extends StatelessWidget {
  const KelolaPsikologPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> psikologList = [
      {
        "nama": "Dr. Rani Sari, M.Psi",
        "email": "rani.sari@email.com",
        "spesialisasi": "Stres & Burnout",
        "pengalaman": "15 Jan 2025",
        "rating": "4.9 (150 review)",
        "status": "Aktif",
      },
      {
        "nama": "Ahmad Pratama, S.Psi",
        "email": "ahmad.pratama@email.com",
        "spesialisasi": "Kecemasan & Depresi",
        "pengalaman": "15 Jan 2025",
        "rating": "4.9 (150 review)",
        "status": "Aktif",
      },
      {
        "nama": "Siti Mawar, M.Psi",
        "email": "siti.mawar@email.com",
        "spesialisasi": "Stres & Burnout",
        "pengalaman": "7 Tahun",
        "rating": "0 (0 review)",
        "status": "Pending",
      },
      {
        "nama": "Wisnu Epep, M.Psi",
        "email": "Wisnu.Epep@email.com",
        "spesialisasi": "Hubungan & Keluarga",
        "pengalaman": "8 Tahun",
        "rating": "0 (0 review)",
        "status": "Pending",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FE),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul
            const Text(
              "Kelola Psikolog",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Daftar Psikolog",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),

            // Baris Filter dan Tombol Tambah
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari nama terapis atau spesialisasi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: "Semua Status",
                    items: const [
                      DropdownMenuItem(
                        value: "Semua Status",
                        child: Text("Semua Status"),
                      ),
                      DropdownMenuItem(value: "Aktif", child: Text("Aktif")),
                      DropdownMenuItem(
                        value: "Pending",
                        child: Text("Pending"),
                      ),
                      DropdownMenuItem(
                        value: "Suspend",
                        child: Text("Suspend"),
                      ),
                    ],
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                  ),
                  child: const Text(
                    "+ Tambah psikolog",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Tabel Psikolog
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.separated(
                  itemCount: psikologList.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 0, color: Colors.grey),
                  itemBuilder: (context, index) {
                    final item = psikologList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          // Nama dan email
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["nama"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  item["email"],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Spesialisasi
                          Expanded(flex: 2, child: Text(item["spesialisasi"])),
                          // Pengalaman
                          Expanded(flex: 2, child: Text(item["pengalaman"])),
                          // Rating
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(item["rating"]),
                              ],
                            ),
                          ),
                          // Status
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: item["status"] == "Aktif"
                                    ? Colors.green[100]
                                    : item["status"] == "Pending"
                                    ? Colors.orange[100]
                                    : Colors.red[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  item["status"],
                                  style: TextStyle(
                                    color: item["status"] == "Aktif"
                                        ? Colors.green[800]
                                        : item["status"] == "Pending"
                                        ? Colors.orange[800]
                                        : Colors.red[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Aksi
                          Row(
                            children: [
                              if (item["status"] == "Pending") ...[
                                ElevatedButton(
                                  onPressed: () {
                                    // aksi setuju
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                  ),
                                  child: const Text(
                                    "Setuju",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    // aksi tolak
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                  ),
                                  child: const Text(
                                    "Tolak",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ] else ...[
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("Lihat"),
                                ),
                                const SizedBox(width: 6),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.orange[300],
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text("Suspend"),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
