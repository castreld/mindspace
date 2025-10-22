import 'package:mindspace_app/config.dart';

class Client {
  final int id;
  final String fullName;
  final String? profilePicture;

  Client({
    required this.id,
    required this.fullName,
    this.profilePicture,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      fullName: json['full_name'] ?? 'Nama Klien Tidak Diketahui',
      profilePicture: json['profile_picture'] != null
          ? '${json['profile_picture']}'
          : null,
    );
  }
}

class Therapist {
  final int id;
  final String fullName;

  Therapist({required this.id, required this.fullName});

  factory Therapist.fromJson(Map<String, dynamic> json) {
    return Therapist(
      id: json['id'],
      fullName: json['full_name'] ?? 'Nama Terapis Tidak Diketahui',
    );
  }
}

class ClientDetail {
  final int id;
  final String username;
  final String fullName;
  final String email;
  final String? profilePicture;
  final String? birthDate;
  final String? phoneNumber;
  final String category;

  ClientDetail({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    this.profilePicture,
    this.birthDate,
    this.phoneNumber,
    required this.category,
  });

  factory ClientDetail.fromJson(Map<String, dynamic> json) {
    return ClientDetail(
      id: json['id'],
      username: json['username'] ?? 'N/A',
      fullName: json['full_name'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      profilePicture: json['profile_picture'] != null
          ? '${json['profile_picture']}'
          : null,
      birthDate: json['birth_date'],
      phoneNumber: json['phone_number'],
      category: json['category'] ?? 'N/A',
    );
  }
}

class Appointment {
  final int id;
  final DateTime appointmentTime;
  final int durationMinutes;
  final String status;
  final String? clientNotes;
  final String? therapistNotes;
  final Client? client;
  final Therapist? therapist;

  Appointment({
    required this.id,
    required this.appointmentTime,
    required this.durationMinutes,
    required this.status,
    this.clientNotes,
    this.therapistNotes,
    this.client,
    this.therapist,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      appointmentTime: DateTime.parse(json['appointment_time']),
      durationMinutes: json['duration_minutes'],
      status: json['status'] ?? 'unknown',
      clientNotes: json['client_notes'],
      therapistNotes: json['therapist_notes'],
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
      therapist: json['therapist'] != null
          ? Therapist.fromJson(json['therapist'])
          : null,
    );
  }
}

class ChatMessage {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      message: json['message'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}