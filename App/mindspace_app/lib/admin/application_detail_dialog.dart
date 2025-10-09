// lib/admin/application_detail_dialog.dart
import 'package:flutter/material.dart';
import 'package:mindspace_app/models/therapist_application.dart';

class ApplicationDetailDialog extends StatelessWidget {
  final TherapistApplication application;
  const ApplicationDetailDialog({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Application Details: ${application.user.fullName}'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            _buildDetailRow(context, 'Email:', application.user.email),
            _buildDetailRow(context, 'Education:', application.profile.educationHistory),
            _buildDetailRow(context, 'Experience:', '${application.profile.experienceYears} years'),
            _buildDetailRow(context, 'Hourly Rate:', 'Rp ${application.profile.hourlyRate}'),
            _buildDetailRow(context, 'Problem Areas:', application.profile.problemAreas),
            _buildDetailRow(context, 'Specializations:', application.profile.specializations.join(', ')),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(text: title, style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' $value'),
          ],
        ),
      ),
    );
  }
}