import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindspace_app/admin/admin_chat_viewer.dart';
import 'package:mindspace_app/models/conversation.dart';
import 'package:mindspace_app/models/conversation_report.dart';
import 'package:mindspace_app/models/user_report.dart';
import 'package:mindspace_app/services/admin_service.dart';

class ReportDetailDialog extends StatefulWidget {
  final dynamic report;
  final VoidCallback onActionTaken;

  const ReportDetailDialog({
    super.key,
    required this.report,
    required this.onActionTaken,
  }) : assert(report is UserReport || report is ConversationReport);

  @override
  State<ReportDetailDialog> createState() => _ReportDetailDialogState();
}

class _ReportDetailDialogState extends State<ReportDetailDialog> {
  late String _selectedStatus;
  late final TextEditingController _notesController;
  final AdminService _adminService = AdminService();
  bool _isLoading = false;
  String? _error;

  bool get _isUserReport => widget.report is UserReport;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.report.status;
    _notesController = TextEditingController(text: widget.report.adminNotes);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitUpdate() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      if (_isUserReport) {
        await _adminService.updateUserReportStatus(
          reportId: widget.report.id,
          status: _selectedStatus,
          adminNotes: _notesController.text,
        );
      } else {
        await _adminService.updateConversationReportStatus(
          reportId: widget.report.id,
          status: _selectedStatus,
          adminNotes: _notesController.text,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Laporan berhasil diperbarui.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
        widget.onActionTaken();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString().replaceFirst("Exception: ", "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Detail Laporan #${widget.report.id}'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Tanggal Laporan:',
                  DateFormat('d MMM yyyy, HH:mm').format(widget.report.createdAt.toLocal())),
              _buildDetailRow(
                  'Pelapor:',
                  widget.report.reporter?.fullName ??
                      'ID: ${widget.report.reporterId}'),
              const Divider(height: 20),
              if (_isUserReport) ...[
                _buildDetailRow(
                    'Pengguna Dilaporkan:',
                    (widget.report as UserReport).reportedUser?.fullName ??
                        'ID: ${(widget.report as UserReport).reportedUserId}'),
                _buildDetailRow('Role:',
                    (widget.report as UserReport).reportedUser?.role ?? 'N/A'),
              ] else ...[
                _buildDetailRow('ID Percakapan:',
                    (widget.report as ConversationReport).conversationId.toString()),
                const SizedBox(height: 8),
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.chat_outlined),
                    label: const Text('Lihat Percakapan'),
                    onPressed: () {
                      final Conversation? conversation = (widget.report as ConversationReport).conversation;
                      if (conversation != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AdminChatViewer(
                              conversation: conversation,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Gagal memuat detail percakapan.')),
                        );
                      }
                    },
                  ),
                ),
              ],
              const Divider(height: 20),
              _buildDetailRow('Alasan Laporan:', widget.report.reason, isBlock: true),
              const SizedBox(height: 24),
              const Text('Tindakan Admin',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Ubah Status',
                  border: OutlineInputBorder(),
                ),
                items: ['pending', 'under_review', 'resolved', 'dismissed']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Catatan Admin',
                  hintText: 'Tambahkan catatan (opsional)...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        ElevatedButton.icon(
          onPressed: _isLoading ? null : _submitUpdate,
          icon: _isLoading
              ? Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(right: 8),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.save),
          label: const Text('Simpan'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String title, String value, {bool isBlock = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }
}