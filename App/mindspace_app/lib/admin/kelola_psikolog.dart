import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mindspace_app/admin/suspend_dialog.dart';
import 'package:mindspace_app/config.dart';
import 'package:mindspace_app/models/therapist_application.dart';
import 'package:mindspace_app/services/admin_service.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'application_detail_dialog.dart';

class KelolaPsikologPage extends StatefulWidget {
  const KelolaPsikologPage({super.key});

  @override
  State<KelolaPsikologPage> createState() => _KelolaPsikologPageState();
}

class _KelolaPsikologPageState extends State<KelolaPsikologPage> {
  late Future<List<TherapistApplication>> _applicationsFuture;
  late AdminService _adminService;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _adminService = context.read<AdminService>();
    _applicationsFuture = _fetchApplications();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _refreshList() {
    setState(() {
      _applicationsFuture = _fetchApplications();
    });
  }

  Future<List<TherapistApplication>> _fetchApplications() async {
    final token = await AuthService().getToken();
    
    var urlBuilder = Uri.parse('${AppConfig.backendBaseUrl}/api/admin/therapist-applications');

    if (_searchQuery.isNotEmpty) {
      urlBuilder = urlBuilder.replace(queryParameters: {'search': _searchQuery});
    }

    final response = await http.get(urlBuilder, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => TherapistApplication.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load applications');
    }
  }

  Future<void> _manageApplication(int userId, String action) async {
    final messenger = ScaffoldMessenger.of(context);
    final token = await AuthService().getToken();

    if (!mounted) return;

    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/admin/therapist-applications/$userId/$action');
    
    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    messenger.showSnackBar(
      SnackBar(content: Text(json.decode(response.body)['message'])),
    );

    if (response.statusCode == 200) {
      _refreshList();
    }
  }

  Future<void> _handleSuspend(TherapistApplication app) async {
    final bool? success = await showDialog<bool>(
      context: context,
      builder: (context) => SuspendDialog(
        userId: app.user.id,
        userName: app.user.fullName,
        userRole: 'psikolog',
      ),
    );

    if (success == true && mounted) {
      _refreshList();
    }
  }

  Future<void> _handleUnsuspend(TherapistApplication app) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aktifkan Akun?'),
        content: Text('Anda yakin ingin mengaktifkan kembali akun ${app.user.fullName}?'),
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
        await _adminService.unsuspendUser(userId: app.user.id, userRole: 'psikolog');
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
          const Text("Kelola Psikolog", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
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
              child: FutureBuilder<List<TherapistApplication>>(
                future: _applicationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Tidak ada psikolog yang ditemukan."));
                  }

                  final applications = snapshot.data!;
                  return ListView.separated(
                    itemCount: applications.length,
                    separatorBuilder: (_, __) => const Divider(height: 0, color: Colors.grey),
                    itemBuilder: (context, index) {
                      final app = applications[index];
                      final bool isSuspended = app.user.suspendedUntil != null &&
                          app.user.suspendedUntil!.isAfter(DateTime.now());
                      
                      String status;
                      Color statusColor;

                      if (isSuspended) {
                        status = 'Disuspen';
                        statusColor = Colors.red[800]!;
                      } else if (app.user.role == 'psikolog') {
                        status = 'Aktif';
                        statusColor = Colors.green[800]!;
                      } else {
                        status = 'Pending';
                        statusColor = Colors.orange[800]!;
                      }
                      
                      Color bgColor;
                      if (isSuspended) {
                        bgColor = Colors.red[100]!;
                      } else if (app.user.role == 'psikolog') {
                        bgColor = Colors.green[100]!;
                      } else {
                        bgColor = Colors.orange[100]!;
                      }


                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(app.user.fullName, style: const TextStyle(fontWeight: FontWeight.w600)),
                                Text(app.user.email, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                              ]),
                            ),
                            Expanded(flex: 2, child: Text(app.profile.specializations.join(', '))),
                            Expanded(flex: 2, child: Text('${app.profile.experienceYears} Tahun')),
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
                                if (status == "Pending") ...[
                                  TextButton(
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (_) => ApplicationDetailDialog(application: app)),
                                    child: const Text("Lihat"),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () => _manageApplication(app.user.id, 'approve'),
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                    child: const Text("Setuju", style: TextStyle(color: Colors.white)),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () => _manageApplication(app.user.id, 'reject'),
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                    child: const Text("Tolak", style: TextStyle(color: Colors.white)),
                                  ),
                                ] else ...[
                                  TextButton(
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (_) => ApplicationDetailDialog(application: app)),
                                    child: const Text("Detail")
                                  ),
                                  const SizedBox(width: 6),
                                  if (isSuspended)
                                    TextButton(
                                      onPressed: () => _handleUnsuspend(app),
                                      style: TextButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                                      child: const Text("Aktifkan"),
                                    )
                                  else
                                    TextButton(
                                      onPressed: () => _handleSuspend(app),
                                      style: TextButton.styleFrom(backgroundColor: Colors.orange[300], foregroundColor: Colors.white),
                                      child: const Text("Suspend"),
                                    ),
                                ],
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