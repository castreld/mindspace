import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindspace_app/admin/report_detail_dialog.dart';
import 'package:mindspace_app/models/conversation_report.dart';
import 'package:mindspace_app/models/user_report.dart';
import 'package:mindspace_app/services/admin_service.dart';

class ReportManagementPage extends StatefulWidget {
  const ReportManagementPage({super.key});

  @override
  State<ReportManagementPage> createState() => _ReportManagementPageState();
}

class _ReportManagementPageState extends State<ReportManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Key _userReportListKey = UniqueKey();
  final Key _convoReportListKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _refreshData() {
    setState(() {
      // This will cause the active _ReportList to rebuild and refetch
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Manajemen Laporan",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
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
                  )
                ],
              ),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(icon: Icon(Icons.person_search), text: 'Laporan Pengguna'),
                      Tab(icon: Icon(Icons.chat_bubble_outline), text: 'Laporan Percakapan'),
                    ],
                    labelColor: Colors.blue.shade700,
                    unselectedLabelColor: Colors.grey.shade600,
                    indicatorColor: Colors.blue.shade700,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _ReportList<UserReport>(
                          key: _userReportListKey,
                          reportType: 'user',
                          onActionTaken: _refreshData,
                        ),
                        _ReportList<ConversationReport>(
                          key: _convoReportListKey,
                          reportType: 'conversation',
                          onActionTaken: _refreshData,
                        ),
                      ],
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

class _ReportList<T> extends StatefulWidget {
  final String reportType;
  final VoidCallback onActionTaken;

  const _ReportList({
    super.key,
    required this.reportType,
    required this.onActionTaken,
  });

  @override
  State<_ReportList<T>> createState() => _ReportListState<T>();
}

class _ReportListState<T> extends State<_ReportList<T>> {
  late Future<PaginatedResponse> _reportsFuture;
  final AdminService _adminService = AdminService();
  String _status = 'pending';

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  void _fetchReports() {
    if (widget.reportType == 'user') {
      _reportsFuture = _adminService.getUserReports(status: _status);
    } else {
      _reportsFuture = _adminService.getConversationReports(status: _status);
    }
  }

  void _refreshList() {
    setState(() {
      _fetchReports();
    });
    widget.onActionTaken();
  }

  void _changeStatusFilter(String? newStatus) {
    if (newStatus == null) return;
    setState(() {
      _status = newStatus;
      _fetchReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                items: ['pending', 'under_review', 'resolved', 'dismissed']
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
          child: FutureBuilder<PaginatedResponse>(
            future: _reportsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
                return Center(child: Text('Tidak ada laporan dengan status "$_status".'));
              }

              final reports = snapshot.data!.data;

              return ListView.separated(
                itemCount: reports.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final report = reports[index];
                  if (report is UserReport) {
                    return _buildUserReportTile(report);
                  } else if (report is ConversationReport) {
                    return _buildConversationReportTile(report);
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUserReportTile(UserReport report) {
    return ListTile(
      title: Text('Pelapor: ${report.reporter?.fullName ?? 'N/A'}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dilaporkan: ${report.reportedUser?.fullName ?? 'N/A'} (${report.reportedUser?.role})'),
          Text('Alasan: ${report.reason}', maxLines: 2, overflow: TextOverflow.ellipsis),
          Text('Dilaporkan pada: ${DateFormat('d MMM yyyy, HH:mm').format(report.createdAt.toLocal())}',
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ReportDetailDialog(
            report: report,
            onActionTaken: _refreshList,
          ),
        );
      },
    );
  }

  Widget _buildConversationReportTile(ConversationReport report) {
    return ListTile(
      title: Text('Pelapor: ${report.reporter?.fullName ?? 'N/A'}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ID Percakapan: ${report.conversationId}'),
          Text('Alasan: ${report.reason}', maxLines: 2, overflow: TextOverflow.ellipsis),
          Text('Dilaporkan pada: ${DateFormat('d MMM yyyy, HH:mm').format(report.createdAt.toLocal())}',
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ReportDetailDialog(
            report: report,
            onActionTaken: _refreshList,
          ),
        );
      },
    );
  }
}