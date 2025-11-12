import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindspace_app/services/admin_service.dart';
import 'package:provider/provider.dart';

class SuspendDialog extends StatefulWidget {
  final int userId;
  final String userName;
  final String userRole;

  const SuspendDialog({
    super.key,
    required this.userId,
    required this.userName,
    required this.userRole,
  });

  @override
  State<SuspendDialog> createState() => _SuspendDialogState();
}

class _SuspendDialogState extends State<SuspendDialog> {
  final _formKey = GlobalKey<FormState>();
  final _daysController = TextEditingController();
  final _reasonController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _daysController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitSuspend() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final adminService = context.read<AdminService>();
      await adminService.suspendUser(
        userId: widget.userId,
        days: int.parse(_daysController.text),
        reason: _reasonController.text,
        userRole: widget.userRole,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pengguna berhasil disuspen.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true); // Return true to indicate success
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Suspen ${widget.userName}?'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _daysController,
              decoration: const InputDecoration(
                labelText: 'Jumlah Hari',
                hintText: 'e.g., 7',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Jumlah hari tidak boleh kosong';
                }
                if (int.tryParse(value) == null || int.parse(value) <= 0) {
                  return 'Masukkan angka yang valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: 'Alasan Suspen',
                hintText: 'Alasan penangguhan...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Alasan tidak boleh kosong';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(false),
          child: const Text('Batal'),
        ),
        ElevatedButton.icon(
          onPressed: _isLoading ? null : _submitSuspend,
          icon: _isLoading
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.gavel),
          label: const Text('Suspen'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}