import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindspace_app/admin/suspend_dialog.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/services/admin_service.dart';
import 'package:provider/provider.dart';

class KelolaPenggunaPage extends StatefulWidget {
  const KelolaPenggunaPage({super.key});

  @override
  State<KelolaPenggunaPage> createState() => _KelolaPenggunaPageState();
}

class _KelolaPenggunaPageState extends State<KelolaPenggunaPage> {
  late Future<List<User>> _usersFuture;
  late AdminService _adminService;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _adminService = context.read<AdminService>();
    _usersFuture = _fetchUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _refreshList() {
    setState(() {
      _usersFuture = _fetchUsers();
    });
  }

  Future<List<User>> _fetchUsers() async {
    return _adminService.getClientUsers(search: _searchQuery);
  }

  Future<void> _handleSuspend(User user) async {
    final bool? success = await showDialog<bool>(
      context: context,
      builder: (context) => SuspendDialog(
        userId: user.id,
        userName: user.fullName,
        userRole: 'klien',
      ),
    );

    if (success == true && mounted) {
      _refreshList();
    }
  }

  Future<void> _handleUnsuspend(User user) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aktifkan Akun?'),
        content: Text('Anda yakin ingin mengaktifkan kembali akun ${user.fullName}?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Batal')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Ya, Aktifkan', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _adminService.unsuspendUser(userId: user.id, userRole: 'klien');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Suspensi dicabut.'), backgroundColor: Colors.green),
          );
        }
        _refreshList();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Kelola Pengguna (Klien)", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Cari berdasarkan nama atau email...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                        _refreshList();
                      },
                    )
                  : null,
            ),
            onSubmitted: (value) {
              setState(() {
                _searchQuery = value;
              });
              _refreshList();
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3))]),
              child: FutureBuilder<List<User>>(
                future: _usersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Tidak ada pengguna yang ditemukan."));
                  }

                  final users = snapshot.data!;
                  return ListView.separated(
                    itemCount: users.length,
                    separatorBuilder: (_, __) => const Divider(height: 0, color: Colors.grey),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      final bool isSuspended = user.suspendedUntil != null &&
                          user.suspendedUntil!.isAfter(DateTime.now());
                      
                      String status;
                      Color statusColor;
                      Color bgColor;

                      if (isSuspended) {
                        status = 'Disuspen';
                        statusColor = Colors.red[800]!;
                        bgColor = Colors.red[100]!;
                      } else {
                        status = 'Aktif';
                        statusColor = Colors.green[800]!;
                        bgColor = Colors.green[100]!;
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.w600)),
                                Text(user.email, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                              ]),
                            ),
                            Expanded(flex: 2, child: Text(user.phoneNumber ?? '-')),
                            Expanded(flex: 2, child: Text(user.gender ?? '-')),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                      color: statusColor,
                                      fontWeight: FontWeight.bold
                                    )
                                  )
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                if (isSuspended)
                                  TextButton(
                                    onPressed: () => _handleUnsuspend(user),
                                    style: TextButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                                    child: const Text("Aktifkan"),
                                  )
                                else
                                  TextButton(
                                    onPressed: () => _handleSuspend(user),
                                    style: TextButton.styleFrom(backgroundColor: Colors.orange[300], foregroundColor: Colors.white),
                                    child: const Text("Suspend"),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}