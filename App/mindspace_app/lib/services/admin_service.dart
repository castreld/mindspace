import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindspace_app/config.dart';
import 'package:mindspace_app/models/admin_dashboard_stats.dart';
import 'package:mindspace_app/models/conversation_report.dart';
import 'package:mindspace_app/models/suspension_appeal.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/models/user_report.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/services/chat_service.dart';

class PaginatedResponse<T> {
  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int total;

  PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });
}

class AdminService {
  final String _baseUrl = AppConfig.backendBaseUrl;
  final AuthService _authService = AuthService();

  Future<String?> _getToken() async {
    return await _authService.getToken();
  }

  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await _getToken();
    if (token == null) throw Exception('Auth token not found.');
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<AdminDashboardStats> getDashboardStats() async {
    try {
      final headers = await _getAuthHeaders();
      final url = Uri.parse('$_baseUrl/api/admin/dashboard-stats');
      
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return AdminDashboardStats.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load dashboard stats: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching dashboard stats: $e');
    }
  }

  Future<List<User>> getClientUsers({String? search}) async {
    try {
      final headers = await _getAuthHeaders();
      var url = Uri.parse('$_baseUrl/api/admin/users');

      if (search != null && search.isNotEmpty) {
        url = url.replace(queryParameters: {'search': search});
      }
      
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        return body.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load client users: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching client users: $e');
    }
  }

  Future<PaginatedResponse<UserReport>> getUserReports({
    String status = 'pending',
    int page = 1,
  }) async {
    try {
      final headers = await _getAuthHeaders();
      final url = Uri.parse('$_baseUrl/api/admin/reports/user?status=$status&page=$page');
      
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final List<dynamic> data = body['data'];
        
        return PaginatedResponse<UserReport>(
          data: data.map((json) => UserReport.fromJson(json)).toList(),
          currentPage: body['current_page'],
          lastPage: body['last_page'],
          total: body['total'],
        );
      } else {
        throw Exception('Failed to load user reports: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching user reports: $e');
    }
  }

  Future<PaginatedResponse<ConversationReport>> getConversationReports({
    String status = 'pending',
    int page = 1,
  }) async {
    try {
      final headers = await _getAuthHeaders();
      final url = Uri.parse('$_baseUrl/api/admin/reports/conversation?status=$status&page=$page');
      
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final List<dynamic> data = body['data'];
        
        return PaginatedResponse<ConversationReport>(
          data: data.map((json) => ConversationReport.fromJson(json)).toList(),
          currentPage: body['current_page'],
          lastPage: body['last_page'],
          total: body['total'],
        );
      } else {
        throw Exception('Failed to load conversation reports: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching conversation reports: $e');
    }
  }

  Future<void> updateUserReportStatus({
    required int reportId,
    required String status,
    String? adminNotes,
  }) async {
    try {
      final headers = await _getAuthHeaders();
      final url = Uri.parse('$_baseUrl/api/admin/reports/user/$reportId');
      
      final body = json.encode({
        'status': status,
        'admin_notes': adminNotes ?? '',
      });

      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode != 200) {
        throw Exception('Failed to update user report: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating user report: $e');
    }
  }

  Future<void> updateConversationReportStatus({
    required int reportId,
    required String status,
    String? adminNotes,
  }) async {
    try {
      final headers = await _getAuthHeaders();
      final url = Uri.parse('$_baseUrl/api/admin/reports/conversation/$reportId');
      
      final body = json.encode({
        'status': status,
        'admin_notes': adminNotes ?? '',
      });

      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode != 200) {
        throw Exception('Failed to update conversation report: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating conversation report: $e');
    }
  }

  Future<void> suspendUser({
    required int userId,
    required int days,
    required String reason,
    required String userRole,
  }) async {
    try {
      final headers = await _getAuthHeaders();
      final endpoint = userRole == 'psikolog' ? 'therapists' : 'users';
      final url = Uri.parse('$_baseUrl/api/admin/$endpoint/$userId/suspend');
      
      final body = json.encode({
        'days': days,
        'reason': reason,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode != 200) {
        throw Exception('Failed to suspend user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error suspending user: $e');
    }
  }

  Future<ChatSessionDetails> getConversationMessages(int conversationId) async {
    try {
      final headers = await _getAuthHeaders();
      final url = Uri.parse('$_baseUrl/api/admin/conversations/$conversationId/messages');
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return ChatSessionDetails.fromJson(data);
      } else {
        throw Exception('Failed to load messages: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching admin messages: $e');
    }
  }

  Future<void> unsuspendUser({required int userId, required String userRole}) async {
    try {
      final headers = await _getAuthHeaders();
      final endpoint = userRole == 'psikolog' ? 'therapists' : 'users';
      final url = Uri.parse('$_baseUrl/api/admin/$endpoint/$userId/unsuspend');
      
      final response = await http.post(url, headers: headers);

      if (response.statusCode != 200) {
        throw Exception('Failed to unsuspend user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error lifting suspension: $e');
    }
  }

  Future<PaginatedResponse<SuspensionAppeal>> getAppeals({
    String status = 'pending',
    int page = 1,
  }) async {
    try {
      final headers = await _getAuthHeaders();
      final url = Uri.parse('$_baseUrl/api/admin/appeals?status=$status&page=$page');
      
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        final List<dynamic> data = body['data'];
        
        return PaginatedResponse<SuspensionAppeal>(
          data: data.map((json) => SuspensionAppeal.fromJson(json)).toList(),
          currentPage: body['current_page'],
          lastPage: body['last_page'],
          total: body['total'],
        );
      } else {
        throw Exception('Failed to load appeals: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching appeals: $e');
    }
  }

  Future<void> updateAppeal({
    required int appealId,
    required String status,
    String? adminNotes,
  }) async {
    try {
      final headers = await _getAuthHeaders();
      final url = Uri.parse('$_baseUrl/api/admin/appeals/$appealId');
      
      final body = json.encode({
        'status': status,
        'admin_notes': adminNotes ?? '',
      });

      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode != 200) {
        throw Exception('Failed to update appeal: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating appeal: $e');
    }
  }
}