import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; 

class ActivityHistoryScreen extends StatefulWidget {
  const ActivityHistoryScreen({super.key});

  @override
  State<ActivityHistoryScreen> createState() => _ActivityHistoryScreenState();
}

class _ActivityHistoryScreenState extends State<ActivityHistoryScreen> {
  late Future<List<dynamic>> _activityFuture;

  @override
  void initState() {
    super.initState();
    _activityFuture = _fetchActivityHistory();
  }

  Future<List<dynamic>> _fetchActivityHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/activity-history'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']; 
    } else {
      throw Exception('Failed to load activity history');
    }
  }

  String _formatDate(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('E, d MMM yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text('Riwayat Aktivitas'),
        backgroundColor: const Color(0xFF5B3F5B),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _activityFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Riwayat aktivitas tidak ditemukan.'));
          }

          final activities = snapshot.data!;

          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              final isLogin = activity['activity_type'] == 'login';
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Icon(
                    isLogin ? Icons.login : Icons.logout,
                    color: isLogin ? Colors.green : Colors.red,
                  ),
                  title: Text(
                    '${activity['activity_type'].toString().toUpperCase()} from ${activity['ip_address']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${_formatDate(activity['created_at'])}\nDevice: ${activity['user_agent'] ?? 'Unknown'}',
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}