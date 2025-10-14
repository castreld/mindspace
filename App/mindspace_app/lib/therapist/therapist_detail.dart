

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:mindspace_app/animated_background.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/widgets/custom_app_bar.dart';
import 'package:mindspace_app/widgets/footer.dart';



class Review {
  final int rating;
  final String comment;
  
  Review({required this.rating, required this.comment});
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? 'No comment provided.',
    );
  }
}

class Availability {
  final int dayOfWeek; 
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  Availability({required this.dayOfWeek, required this.startTime, required this.endTime});
  factory Availability.fromJson(Map<String, dynamic> json) {
    TimeOfDay parseTime(String time) {
      final parts = time.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }
    return Availability(
      dayOfWeek: json['day_of_week'],
      startTime: parseTime(json['start_time']),
      endTime: parseTime(json['end_time']),
    );
  }
}

class TherapistDetail {
  final String name;
  final String? imageUrl;
  final double rating;
  final int experienceYears;
  final int hourlyRate;
  final String education;
  final String problemAreas;
  final List<String> specializations;
  final List<Availability> availabilities;
  final List<Review> reviews;

  TherapistDetail({
    required this.name, this.imageUrl, required this.rating,
    required this.experienceYears, required this.hourlyRate,
    required this.education, required this.problemAreas,
    required this.specializations, required this.availabilities, required this.reviews,
  });

  factory TherapistDetail.fromJson(Map<String, dynamic> json) {
    final profile = json['therapist_profile'];
    return TherapistDetail(
      name: json['full_name'] ?? 'N/A',
      imageUrl: profile?['profile_picture_path'] != null
          ? 'http://127.0.0.1:8000/api/${profile['profile_picture_path']}'
          : null,
      rating: double.tryParse(json['average_rating']?.toString() ?? '0.0') ?? 0.0,
      experienceYears: profile?['experience_years'] ?? 0,
      hourlyRate: profile?['hourly_rate'] ?? 0,
      education: profile?['education_history'] ?? 'No education history provided.',
      problemAreas: profile?['problem_areas'] ?? 'No problem areas specified.',
      specializations: List<String>.from(profile?['specializations'] ?? []),
      availabilities: (json['availabilities'] as List? ?? [])
          .map((a) => Availability.fromJson(a))
          .toList(),
      reviews: (json['reviews'] as List? ?? [])
          .map((r) => Review.fromJson(r))
          .toList(),
    );
  }
}

class TherapistDetailPage extends StatefulWidget {
  final int therapistId;
  const TherapistDetailPage({super.key, required this.therapistId});

  @override
  State<TherapistDetailPage> createState() => _TherapistDetailPageState();
}

class _TherapistDetailPageState extends State<TherapistDetailPage> {
  Future<TherapistDetail>? _therapistFuture;

  @override
  void initState() {
    super.initState();
    _therapistFuture = _fetchTherapistDetails();
  }

  Future<TherapistDetail> _fetchTherapistDetails() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/therapists/${widget.therapistId}');
    try {
      final response = await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        return TherapistDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load therapist details.');
      }
    } catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser = context.watch<AuthService>().currentUser;
    return Scaffold(
      appBar: CustomAppBar(
        user: currentUser,
        onLogout: () {
          context.read<AuthService>().clearSession();
        },
      ),
      body: Stack(
        children: [
          const AnimatedGradientBackground(),
          FutureBuilder<TherapistDetail>(
            future: _therapistFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return const Center(child: Text('Therapist not found.'));
              }

              final therapist = snapshot.data!;
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(32.0),
                    sliver: SliverToBoxAdapter(
                      child: LayoutBuilder(builder: (context, constraints) {
                        bool isSmallScreen = constraints.maxWidth < 900;
                        return isSmallScreen
                            ? Column(children: _buildLayout(therapist))
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildLayout(therapist),
                              );
                      }),
                    ),
                  ),
                  const FooterSection(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLayout(TherapistDetail therapist) {
    return [
      Flexible(
        flex: 3,
        child: _ProfileSummaryCard(therapist: therapist),
      ),
      const SizedBox(width: 32, height: 32),
      Flexible(
        flex: 7,
        child: _DetailsTabs(therapist: therapist),
      ),
    ];
  }
}

class _ProfileSummaryCard extends StatelessWidget {
  final TherapistDetail therapist;
  const _ProfileSummaryCard({required this.therapist});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: therapist.imageUrl != null ? NetworkImage(therapist.imageUrl!) : null,
              child: therapist.imageUrl == null
                  ? Icon(Icons.person, size: 80, color: Colors.grey.shade400)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(therapist.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Chip(
              avatar: const Icon(Icons.star, color: Colors.amber),
              label: Text('${therapist.rating.toStringAsFixed(1)} Rating'),
            ),
            const Divider(height: 32),
            _InfoRow(icon: Icons.work_outline, title: 'Experience', value: '${therapist.experienceYears} Years'),
            _InfoRow(icon: Icons.school_outlined, title: 'Specializations', value: therapist.specializations.join(', ')),
            _InfoRow(icon: Icons.attach_money_outlined, title: 'Rate', value: 'Rp ${NumberFormat.decimalPattern('id').format(therapist.hourlyRate)} / hour'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_today_outlined),
              label: const Text('Book a Session'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () { },
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _InfoRow({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 16),
          Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }
}

class _DetailsTabs extends StatelessWidget {
  final TherapistDetail therapist;
  const _DetailsTabs({required this.therapist});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'About'),
              Tab(text: 'Availability'),
              Tab(text: 'Reviews'),
            ],
          ),
          SizedBox(
            
            height: 600,
            child: TabBarView(
              children: [
                _AboutTab(therapist: therapist),
                _AvailabilityTab(availabilities: therapist.availabilities),
                _ReviewsTab(reviews: therapist.reviews),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutTab extends StatelessWidget {
  final TherapistDetail therapist;
  const _AboutTab({required this.therapist});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Education', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(therapist.education, style: Theme.of(context).textTheme.bodyLarge),
          const Divider(height: 32),
          Text('Specializations', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: therapist.specializations.map((spec) => Chip(label: Text(spec))).toList(),
          ),
          const Divider(height: 32),
          Text('Commonly Addressed Problems', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(therapist.problemAreas, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _AvailabilityTab extends StatelessWidget {
  final List<Availability> availabilities;
  const _AvailabilityTab({required this.availabilities});

  @override
  Widget build(BuildContext context) {
    
    final Map<int, List<Availability>> slotsByDay = {};
    for (var avail in availabilities) {
      (slotsByDay[avail.dayOfWeek] ??= []).add(avail);
    }
    
    
    final now = DateTime.now();
    final List<DateTime> nextSevenDays = List.generate(7, (i) => now.add(Duration(days: i)));

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: nextSevenDays.map((date) {
          final dayOfWeek = date.weekday;
          final slots = slotsByDay[dayOfWeek] ?? [];
          if (slots.isEmpty) return const SizedBox.shrink(); 

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat('EEEE, d MMMM').format(date), style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: slots.map((slot) {
                  return ActionChip(
                    label: Text('${slot.startTime.format(context)} - ${slot.endTime.format(context)}'),
                    onPressed: () { },
                  );
                }).toList(),
              ),
              const Divider(height: 32),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  final List<Review> reviews;
  const _ReviewsTab({required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Center(child: Text('This therapist has no reviews yet.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(5, (i) => Icon(
                    i < review.rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  )),
                ),
                const SizedBox(height: 8),
                Text(review.comment, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        );
      },
    );
  }
}