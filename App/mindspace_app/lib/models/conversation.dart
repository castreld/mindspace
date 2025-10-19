class Conversation {
  final int id;
  final int userOneId;
  final int userTwoId;
  final int otherUserId;  // Add this for convenience
  final String name;
  final String? profilePicture;
  final String lastMessage;
  final DateTime lastMessageTime;

  Conversation({
    required this.id,
    required this.userOneId,
    required this.userTwoId,
    required this.otherUserId,
    required this.name,
    this.profilePicture,
    required this.lastMessage,
    required this.lastMessageTime,
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
    );
  }
  
  // Helper method to get the other user's ID
  int getOtherUserId(int currentUserId) {
    // Use the convenient field from backend
    return otherUserId;
  }
}