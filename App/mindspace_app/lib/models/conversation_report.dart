import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/models/conversation.dart';

class ConversationReport {
  final int id;
  final int reporterId;
  final int conversationId;
  final String reason;
  final String status;
  final String? adminNotes;
  final DateTime createdAt;
  final User? reporter;
  final Conversation? conversation;

  ConversationReport({
    required this.id,
    required this.reporterId,
    required this.conversationId,
    required this.reason,
    required this.status,
    this.adminNotes,
    required this.createdAt,
    this.reporter,
    this.conversation,
  });

  factory ConversationReport.fromJson(Map<String, dynamic> json) {
    return ConversationReport(
      id: json['id'],
      reporterId: json['reporter_id'],
      conversationId: json['conversation_id'],
      reason: json['reason'],
      status: json['status'],
      adminNotes: json['admin_notes'],
      createdAt: DateTime.parse(json['created_at']),
      reporter: json['reporter'] != null
          ? User.fromJson(json['reporter'])
          : null,
      conversation: json['conversation'] != null
          ? Conversation.fromFullJson(json['conversation']) 
          : null,
    );
  }
}