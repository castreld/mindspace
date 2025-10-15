import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/config.dart';

class ApiException implements Exception {
  final int statusCode;
  final dynamic body;
  ApiException(this.statusCode, this.body);
  @override
  String toString() => 'ApiException($statusCode): $body';
}

class BookingService {
  final String baseUrl;
  BookingService({String? baseUrl}) : baseUrl = baseUrl ?? AppConfig.backendBaseUrl;

  Future<Map<String, dynamic>> createAppointment({
    required int therapistId,
    required int availabilityId,
    required DateTime appointmentTime,
    required int durationMinutes,
    String? clientNotes,
  }) async {
    final token = await AuthService().getToken();
    final url = Uri.parse('$baseUrl/api/appointments');
    final body = json.encode({
      'therapist_id': therapistId,
      'availability_id': availabilityId,
      'appointment_time': appointmentTime.toUtc().toIso8601String(),
      'duration_minutes': durationMinutes,
      'client_notes': clientNotes,
    });

    final resp = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    }, body: body);

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return resp.body.isNotEmpty ? json.decode(resp.body) : <String, dynamic>{};
    }
    
    dynamic parsed;
    try {
      parsed = json.decode(resp.body);
    } catch (_) {
      parsed = resp.body;
    }
    throw ApiException(resp.statusCode, parsed);
  }

  Future<Map<String, dynamic>> createTransaction({
    required String orderId,
    required int grossAmount,
    int? appointmentId,
  }) async {
    final token = await AuthService().getToken();
    final url = Uri.parse('$baseUrl/api/midtrans/create-transaction');
    final body = json.encode({
      'order_id': orderId,
      'gross_amount': grossAmount,
      if (appointmentId != null) 'appointment_id': appointmentId,
    });
    final resp = await http.post(url, headers: {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    }, body: body);

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return resp.body.isNotEmpty ? json.decode(resp.body) : <String, dynamic>{};
    }
    dynamic parsed;
    try {
      parsed = json.decode(resp.body);
    } catch (_) {
      parsed = resp.body;
    }
    throw ApiException(resp.statusCode, parsed);
  }
}
