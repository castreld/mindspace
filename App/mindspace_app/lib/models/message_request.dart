class MessageRequest {
  final int conversationId;
  final String status;
  final int initiatorId;
  final String initiatorName;
  final String? initiatorProfilePicture;

  MessageRequest({
    required this.conversationId,
    required this.status,
    required this.initiatorId,
    required this.initiatorName,
    this.initiatorProfilePicture,
  });

  factory MessageRequest.fromJson(Map<String, dynamic> json) {
    return MessageRequest(
      conversationId: json['id'],
      status: json['status'],
      initiatorId: json['initiator']['id'],
      initiatorName: json['initiator']['full_name'] ?? 'Pengguna Tidak Dikenal',
      initiatorProfilePicture: json['initiator']['profile_picture'],
    );
  }
}