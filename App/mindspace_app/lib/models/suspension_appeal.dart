import 'package:mindspace_app/models/user.dart';

class SuspensionAppeal {
  final int id;
  final int userId;
  final String reason;
  final String status;
  final String? adminNotes;
  final DateTime createdAt;
  final User? user;

  SuspensionAppeal({
    required this.id,
    required this.userId,
    required this.reason,
    required this.status,
    this.adminNotes,
    required this.createdAt,
    this.user,
  });

  factory SuspensionAppeal.fromJson(Map<String, dynamic> json) {
    return SuspensionAppeal(
      id: json['id'],
      userId: json['user_id'],
      reason: json['reason'],
      status: json['status'],
      adminNotes: json['admin_notes'],
      createdAt: DateTime.parse(json['created_at']),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}