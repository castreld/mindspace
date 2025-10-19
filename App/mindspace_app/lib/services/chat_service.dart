import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindspace_app/models/appointment.dart';
import 'package:mindspace_app/models/conversation.dart';
import 'package:mindspace_app/models/message_request.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/config.dart';

class ChatService {
  final String baseUrl;
  ChatService({String? baseUrl}) : this.baseUrl = baseUrl ?? AppConfig.backendBaseUrl;

  Future<List<Conversation>> getConversations(String token) async {
    final url = Uri.parse('$baseUrl/api/conversations');
    final resp = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (resp.statusCode == 200) {
      final List<dynamic> data = json.decode(resp.body);
      return data.map((json) => Conversation.fromJson(json)).toList();
    }
    throw Exception('Failed to load conversations');
  }

  Future<List<ChatMessage>> getMessages(String token, int otherUserId) async {
    final url = Uri.parse('$baseUrl/api/conversations/$otherUserId');
    final resp = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (resp.statusCode == 200) {
      final List<dynamic> data = json.decode(resp.body);
      return data.map((json) => ChatMessage.fromJson(json)).toList();
    }
    throw Exception('Failed to load messages');
  }

  Future<ChatMessage> sendMessage(String token, int receiverId, String messageText) async {
    
    try {
      final response = await http.post(
        Uri.parse('${AppConfig.backendBaseUrl}/api/messages/send'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'receiver_id': receiverId,
          'message': messageText,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return ChatMessage.fromJson(data);
      } else {
        throw Exception('Failed to send message: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }

  Future<List<MessageRequest>> getMessageRequests(String token) async {
    final url = Uri.parse('$baseUrl/api/message-requests');
    final resp = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (resp.statusCode == 200) {
      final List<dynamic> data = json.decode(resp.body);
      return data.map((json) => MessageRequest.fromJson(json)).toList();
    }
    throw Exception('Failed to load message requests');
  }

  Future<void> acceptRequest(String token, int conversationId) async {
    final url = Uri.parse('$baseUrl/api/message-requests/$conversationId/accept');
    final resp = await http.put(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (resp.statusCode != 200) {
      throw Exception('Failed to accept request');
    }
  }

  Future<void> rejectRequest(String token, int conversationId) async {
    final url = Uri.parse('$baseUrl/api/message-requests/$conversationId/reject');
    final resp = await http.delete(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (resp.statusCode != 200) {
      throw Exception('Failed to reject request');
    }
  }

  Future<void> sendMessageRequest(String token, int receiverId, String message) async {
    final url = Uri.parse('$baseUrl/api/message-requests');
    final resp = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'receiver_id': receiverId,
        'message': message,
      }),
    );
    if (resp.statusCode != 201) {
      final error = json.decode(resp.body)['message'] ?? 'Failed to send message request';
      throw Exception(error);
    }
  }

  Future<List<User>> searchClients(String token, String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/users/search-clients?query=$query'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => User.fromJson(item)).toList();
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else {
        throw Exception('Failed to search clients');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ChatMessage>> getMessagesByConversationId(String token, int conversationId) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConfig.backendBaseUrl}/api/conversations/$conversationId/messages'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ChatMessage.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load messages: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching messages: $e');
    }
  }

  Future<void> deleteMessage(String token, int messageId) async {
    final url = Uri.parse('$baseUrl/api/messages/$messageId');
    final response = await http.delete(
        url,
        headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
        },
    );

    if (response.statusCode != 200) {
        throw Exception('Failed to delete message: ${response.body}');
    }
  }
  
  Future<void> deleteConversation(String token, int conversationId) async {
    final url = Uri.parse('$baseUrl/api/conversations/$conversationId');
    final response = await http.delete(
        url,
        headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
        },
    );

    if (response.statusCode != 200) {
        throw Exception('Failed to delete conversation: ${response.body}');
    }
  }
}