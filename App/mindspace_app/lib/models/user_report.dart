import 'package:mindspace_app/models/user.dart';

class UserReport {
  final int id;
  final int reporterId;
  final int reportedUserId;
  final String reason;
  final String status;
  final String? adminNotes;
  final DateTime createdAt;
  final User? reporter;
  final User? reportedUser;

  UserReport({
    required this.id,
    required this.reporterId,
    required this.reportedUserId,
    required this.reason,
    required this.status,
    this.adminNotes,
    required this.createdAt,
    this.reporter,
    this.reportedUser,
  });

  factory UserReport.fromJson(Map<String, dynamic> json) {
    return UserReport(
      id: json['id'],
      reporterId: json['reporter_id'],
      reportedUserId: json['reported_user_id'],
      reason: json['reason'],
      status: json['status'],
      adminNotes: json['admin_notes'],
      createdAt: DateTime.parse(json['created_at']),
      reporter: json['reporter'] != null
          ? User.fromJson(json['reporter'])
          : null,
      reportedUser: json['reported_user'] != null
          ? User.fromJson(json['reported_user'])
          : null,
    );
  }
}