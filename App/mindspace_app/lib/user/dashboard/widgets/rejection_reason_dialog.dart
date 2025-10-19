import 'package:flutter/material.dart';

class RejectionReasonDialog extends StatelessWidget {
  final String reason;
  final String therapistName;

  const RejectionReasonDialog({
    super.key,
    required this.reason,
    required this.therapistName,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Column(
        children: [
          const Icon(Icons.info_outline, color: Colors.blue, size: 40),
          const SizedBox(height: 16),
          Text('Alasan Penolakan dari $therapistName', textAlign: TextAlign.center),
        ],
      ),
      content: SingleChildScrollView(
        child: Text(
          reason,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Mengerti'),
        ),
      ],
    );
  }
}