import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindspace_app/admin/appeal_detail_dialog.dart';
import 'package:mindspace_app/models/suspension_appeal.dart';
import 'package:mindspace_app/services/admin_service.dart';
import 'package:provider/provider.dart';

class KelolaBandingPage extends StatefulWidget {
  const KelolaBandingPage({super.key});

  @override
  State<KelolaBandingPage> createState() => _KelolaBandingPageState();
}

class _KelolaBandingPageState extends State<KelolaBandingPage> {
  late Future<PaginatedResponse<SuspensionAppeal>> _appealsFuture;
  late AdminService _adminService;
  String _status = 'pending';

  @override
  void initState() {
    super.initState();
    _adminService = context.read<AdminService>();
    _refreshList();
  }

  void _refreshList() {
    setState(() {
      _appealsFuture = _adminService.getAppeals(status: _status);
    });
  }

  void _changeStatusFilter(String? newStatus) {
    if (newStatus == null) return;
    setState(() {
      _status = newStatus;
      _refreshList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Kelola Banding", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3))]),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Filter Status: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: _status,
                          onChanged: _changeStatusFilter,
                          items: ['pending', 'approved', 'rejected']
                              .map((status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: _refreshList,
                          tooltip: 'Refresh List',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<PaginatedResponse<SuspensionAppeal>>(
                      future: _appealsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
                          return Center(child: Text('Tidak ada banding dengan status "$_status".'));
                        }

                        final appeals = snapshot.data!.data;

                        return ListView.separated(
                          itemCount: appeals.length,
                          separatorBuilder: (context, index) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final appeal = appeals[index];
                            return ListTile(
                              title: Text(appeal.user?.fullName ?? 'Pengguna Tidak Dikenal'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Role: ${appeal.user?.role ?? 'N/A'}'),
                                  Text('Alasan: ${appeal.reason}', maxLines: 2, overflow: TextOverflow.ellipsis),
                                  Text('Diajukan: ${DateFormat('d MMM yyyy, HH:mm').format(appeal.createdAt.toLocal())}',
                                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AppealDetailDialog(
                                    appeal: appeal,
                                    onActionTaken: _refreshList,
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}