import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindspace_app/models/suspension_appeal.dart';
import 'package:mindspace_app/services/admin_service.dart';
import 'package:provider/provider.dart';

class AppealDetailDialog extends StatefulWidget {
  final SuspensionAppeal appeal;
  final VoidCallback onActionTaken;

  const AppealDetailDialog({
    super.key,
    required this.appeal,
    required this.onActionTaken,
  });

  @override
  State<AppealDetailDialog> createState() => _AppealDetailDialogState();
}

class _AppealDetailDialogState extends State<AppealDetailDialog> {
  late String _selectedStatus;
  late final TextEditingController _notesController;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.appeal.status;
    _notesController = TextEditingController(text: widget.appeal.adminNotes);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitUpdate(String newStatus) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _selectedStatus = newStatus;
    });

    try {
      final adminService = context.read<AdminService>();
      await adminService.updateAppeal(
        appealId: widget.appeal.id,
        status: _selectedStatus,
        adminNotes: _notesController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Banding telah di-$newStatus.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
        widget.onActionTaken();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = e.toString().replaceFirst("Exception: ", "");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Detail Banding #${widget.appeal.id}'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Pengguna:',
                  '${widget.appeal.user?.fullName ?? 'N/A'} (${widget.appeal.user?.role})'),
              _buildDetailRow('Email:', widget.appeal.user?.email ?? 'N/A'),
              _buildDetailRow('Tanggal Diajukan:',
                  DateFormat('d MMM yyyy, HH:mm').format(widget.appeal.createdAt.toLocal())),
              const Divider(height: 20),
              _buildDetailRow('Alasan Banding:', widget.appeal.reason, isBlock: true),
              const SizedBox(height: 24),
              const Text('Tindakan Admin',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Catatan Admin',
                  hintText: 'Tambahkan catatan (opsional)...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
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
        ElevatedButton(
          onPressed: _isLoading ? null : () => _submitUpdate('rejected'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: _isLoading && _selectedStatus == 'rejected'
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Tolak'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : () => _submitUpdate('approved'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: _isLoading && _selectedStatus == 'approved'
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Setujui'),
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