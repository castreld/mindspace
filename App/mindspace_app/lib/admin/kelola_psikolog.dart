import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mindspace_app/models/therapist_application.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'application_detail_dialog.dart';

class KelolaPsikologPage extends StatefulWidget {
  const KelolaPsikologPage({super.key});

  @override
  State<KelolaPsikologPage> createState() => _KelolaPsikologPageState();
}

class _KelolaPsikologPageState extends State<KelolaPsikologPage> {
  late Future<List<TherapistApplication>> _applicationsFuture;

  @override
  void initState() {
    super.initState();
    _applicationsFuture = _fetchApplications();
  }

  Future<List<TherapistApplication>> _fetchApplications() async {
    final token = await AuthService().getToken();
    final url = Uri.parse('http://127.0.0.1:8000/api/admin/therapist-applications');

    final response = await http.get(url, headers: {
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

    final url = Uri.parse('http://127.0.0.1:8000/api/admin/therapist-applications/$userId/$action');
    
    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    messenger.showSnackBar(
      SnackBar(content: Text(json.decode(response.body)['message'])),
    );

    if (response.statusCode == 200) {
      setState(() {
        _applicationsFuture = _fetchApplications();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0FE),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header and filters... (remains the same)
            const Text("Kelola Psikolog", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            // Table
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
                      return const Center(child: Text("No applications found."));
                    }

                    final applications = snapshot.data!;
                    return ListView.separated(
                      itemCount: applications.length,
                      separatorBuilder: (_, __) => const Divider(height: 0, color: Colors.grey),
                      itemBuilder: (context, index) {
                        final app = applications[index];
                        final status = app.user.role == 'psikolog' ? 'Aktif' : 'Pending';

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              // Name and email
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
                                    color: status == "Aktif" ? Colors.green[100] : Colors.orange[100],
                                    borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(status, style: TextStyle(
                                        color: status == "Aktif" ? Colors.green[800] : Colors.orange[800],
                                        fontWeight: FontWeight.bold))),
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
                                    TextButton(onPressed: () {}, child: const Text("Detail")),
                                    const SizedBox(width: 6),
                                    TextButton(
                                      onPressed: () {},
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
      ),
    );
  }
}