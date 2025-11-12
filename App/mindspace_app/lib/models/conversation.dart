import 'package:mindspace_app/models/user.dart';

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
  final User? userOne;
  final User? userTwo;

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
    this.userOne,
    this.userTwo,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
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
      userOne: json.containsKey('user_one') && json['user_one'] != null
          ? User.fromJson(json['user_one'])
          : null,
      userTwo: json.containsKey('user_two') && json['user_two'] != null
          ? User.fromJson(json['user_two'])
          : null,
    );
  }

  factory Conversation.fromFullJson(Map<String, dynamic> json) {
    String chatName = 'Chat';
    User? userOne;
    User? userTwo;

    if (json.containsKey('user_one') && json['user_one'] != null) {
      userOne = User.fromJson(json['user_one']);
    }
    if (json.containsKey('user_two') && json['user_two'] != null) {
      userTwo = User.fromJson(json['user_two']);
    }
    
    if (userOne != null && userTwo != null) {
      chatName = 'Percakapan: ${userOne.fullName} & ${userTwo.fullName}';
    }

    return Conversation(
      id: json['id'],
      userOneId: json['user_one_id'],
      userTwoId: json['user_two_id'],
      otherUserId: 0, 
      name: chatName,
      profilePicture: null, 
      lastMessage: '', 
      lastMessageTime: DateTime.now(), 
      appointmentId: json['appointment_id'],
      sessionStartedAt: json['session_started_at'],
      sessionDurationMinutes: json['session_duration_minutes'],
      sessionStatus: json['session_status'] ?? json['status'] ?? 'pending',
      userOne: userOne,
      userTwo: userTwo,
    );
  }
  
  int getOtherUserId(int currentUserId) {
    return otherUserId;
  }
}