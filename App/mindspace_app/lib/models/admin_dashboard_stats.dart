import 'package:mindspace_app/models/user.dart';

class AdminDashboardStats {
  final SummaryStats summary;
  final List<ActivityLogItem> recentLogins;

  AdminDashboardStats({
    required this.summary,
    required this.recentLogins,
  });

  factory AdminDashboardStats.fromJson(Map<String, dynamic> json) {
    var loginsList = json['recent_logins'] as List;
    List<ActivityLogItem> logins = loginsList
        .map((i) => ActivityLogItem.fromJson(i))
        .toList();

    return AdminDashboardStats(
      summary: SummaryStats.fromJson(json['summary']),
      recentLogins: logins,
    );
  }
}

class SummaryStats {
  final int totalClients;
  final int totalTherapists;
  final int pendingApplications;
  final int totalPendingReports;
  final int pendingAppeals;

  SummaryStats({
    required this.totalClients,
    required this.totalTherapists,
    required this.pendingApplications,
    required this.totalPendingReports,
    required this.pendingAppeals,
  });

  factory SummaryStats.fromJson(Map<String, dynamic> json) {
    return SummaryStats(
      totalClients: json['total_clients'] ?? 0,
      totalTherapists: json['total_therapists'] ?? 0,
      pendingApplications: json['pending_applications'] ?? 0,
      totalPendingReports: json['total_pending_reports'] ?? 0,
      pendingAppeals: json['pending_appeals'] ?? 0,
    );
  }
}

class ActivityLogItem {
  final int id;
  final int userId;
  final String activityType;
  final String? ipAddress;
  final String? userAgent;
  final DateTime createdAt;
  final User? user;

  ActivityLogItem({
    required this.id,
    required this.userId,
    required this.activityType,
    this.ipAddress,
    this.userAgent,
    required this.createdAt,
    this.user,
  });

  factory ActivityLogItem.fromJson(Map<String, dynamic> json) {
    return ActivityLogItem(
      id: json['id'],
      userId: json['user_id'],
      activityType: json['activity_type'],
      ipAddress: json['ip_address'],
      userAgent: json['user_agent'],
      createdAt: DateTime.parse(json['created_at']),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}