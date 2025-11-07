import 'package:mindspace_app/config.dart';
import 'package:intl/intl.dart';

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
  final int? rating;
  final String? reviewComment;

  Appointment({
    required this.id,
    required this.appointmentTime,
    required this.durationMinutes,
    required this.status,
    this.clientNotes,
    this.therapistNotes,
    this.client,
    this.therapist,
    this.rating,
    this.reviewComment,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    int? rating;
    String? reviewComment;
    if (json['review'] != null) {
      rating = json['review']['rating'];
      reviewComment = json['review']['comment'];
    }

    String displayStatus;
    switch(json['status']) {
        case 'completed':
            displayStatus = 'Selesai';
            break;
        case 'cancelled':
            displayStatus = 'Dibatalkan';
            break;
        case 'scheduled':
            displayStatus = 'Terjadwal';
            break;
        case 'pending_payment':
            displayStatus = 'Menunggu Pembayaran';
            break;
        case 'payment_failed':
            displayStatus = 'Pembayaran Gagal';
            break;
        case 'pending_confirmation':
            displayStatus = 'Menunggu Konfirmasi';
            break;
        case 'no_show':
            displayStatus = 'Tidak Hadir';
            break;
        default:
            displayStatus = 'Tidak Diketahui';
    }

    return Appointment(
      id: json['id'],
      appointmentTime: DateTime.parse(json['appointment_time']).toLocal(),
      durationMinutes: json['duration_minutes'],
      status: displayStatus,
      clientNotes: json['client_notes'],
      therapistNotes: json['therapist_notes'],
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
      therapist: json['therapist'] != null
          ? Therapist.fromJson(json['therapist'])
          : null,
      rating: rating,
      reviewComment: reviewComment,
    );
  }

  String get formattedDateTime {
    final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm', 'id_ID');
    final DateTime endTime = appointmentTime.add(Duration(minutes: durationMinutes));
    return '${formatter.format(appointmentTime)} - ${DateFormat('HH:mm').format(endTime)}';
  }
  String get topic => clientNotes ?? 'Tidak ada topik';
}

class ChatMessage {
  final int id;
  final int senderId;
  final int receiverId;
  final String? message;
  final DateTime createdAt;
  final String messageType;
  final String? filePath;
  final String? originalFileName;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.message,
    required this.createdAt,
    required this.messageType,
    this.filePath,
    this.originalFileName,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: int.parse(json['id'].toString()),
      senderId: int.parse(json['sender_id'].toString()),
      receiverId: int.parse(json['receiver_id'].toString()),
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      messageType: json['message_type'] ?? 'text',
      
      filePath: json['file_path'],
      
      originalFileName: json['original_file_name'],
    );
  }
}