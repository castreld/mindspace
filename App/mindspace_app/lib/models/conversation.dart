class Conversation {
  final int id;
  final int userOneId;
  final int userTwoId;
  final int otherUserId;
  final String name;
  final String? profilePicture;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int? appointmentId;
  final String? sessionStartedAt;
  final int? sessionDurationMinutes;
  final String sessionStatus;

  Conversation({
    required this.id,
    required this.userOneId,
    required this.userTwoId,
    required this.otherUserId,
    required this.name,
    this.profilePicture,
    required this.lastMessage,
    required this.lastMessageTime,
    this.appointmentId,
    this.sessionStartedAt,
    this.sessionDurationMinutes,
    required this.sessionStatus,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    print('📦 Parsing conversation from JSON:');
    print('   id: ${json['id']}');
    print('   user_one_id: ${json['user_one_id']}');
    print('   user_two_id: ${json['user_two_id']}');
    print('   other_user_id: ${json['other_user_id']}');
    print('   full_name: ${json['full_name']}');
    
    return Conversation(
      id: json['id'],
      userOneId: json['user_one_id'],
      userTwoId: json['user_two_id'],
      otherUserId: json['other_user_id'],
      name: json['full_name'] ?? 'Unknown User',
      profilePicture: json['profile_picture'],
      lastMessage: json['last_message_text'] ?? '',
      lastMessageTime: DateTime.parse(json['last_message_time']),
      appointmentId: json['appointment_id'],
      sessionStartedAt: json['session_started_at'],
      sessionDurationMinutes: json['session_duration_minutes'],
      sessionStatus: json['session_status'] ?? json['status'] ?? 'pending',
    );
  }

  factory Conversation.fromFullJson(Map<String, dynamic> json) {
     return Conversation(
      id: json['id'],
      userOneId: json['user_one_id'],
      userTwoId: json['user_two_id'],
      otherUserId: 0, 
      name: 'Chat',  
      profilePicture: null, 
      lastMessage: '', 
      lastMessageTime: DateTime.now(), 
      appointmentId: json['appointment_id'],
      sessionStartedAt: json['session_started_at'],
      sessionDurationMinutes: json['session_duration_minutes'],
      sessionStatus: json['session_status'] ?? json['status'] ?? 'pending',
    );
  }
  
  int getOtherUserId(int currentUserId) {
    return otherUserId;
  }
}