import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mindspace_app/animated_background.dart';
import 'package:mindspace_app/config.dart';
import 'package:mindspace_app/routes.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/services/booking_service.dart';
import 'package:mindspace_app/widgets/bottom_nav_bar.dart';
import 'package:mindspace_app/widgets/custom_app_bar.dart';
import 'package:mindspace_app/widgets/footer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TherapistDetailPage extends StatefulWidget {
  final int therapistId;
  const TherapistDetailPage({super.key, required this.therapistId});

  @override
  State<TherapistDetailPage> createState() => _TherapistDetailPageState();
}

class _TherapistDetailPageState extends State<TherapistDetailPage> {
  TherapistDetail? _therapist;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchDetail();
  }

  Future<void> _fetchDetail() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final url = Uri.parse(
          '${AppConfig.backendBaseUrl}/api/therapists/${widget.therapistId}');

      final resp = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      if (!mounted) return;

      if (resp.statusCode == 200) {
        final data = json.decode(resp.body);
        setState(() {
          _therapist = TherapistDetail.fromJson(data['data'] ?? data);
        });
      } else {
        setState(() {
          _error = 'Gagal memuat data terapis. Status: ${resp.statusCode}';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Gagal terhubung ke server. Periksa koneksi Anda.';
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final currentUser = authService.currentUser;
    const double mobileBreakpoint = 850;
    final bool isMobile = MediaQuery.of(context).size.width < mobileBreakpoint;
    final String currentRoute = ModalRoute.of(context)?.settings.name ?? '';

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        user: currentUser,
        showNavButtonsAsActions: !isMobile,
      ),
      drawer: isMobile ? const _AppDrawer() : null,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const AnimatedGradientBackground(),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SafeArea(
                  child: _isLoading
                      ? const Center(
                          heightFactor: 10,
                          child:
                              CircularProgressIndicator(color: Colors.white))
                      : _error != null
                          ? Center(
                              child: Text(_error!,
                                  style: const TextStyle(color: Colors.white)))
                          : _therapist == null
                              ? const Center(
                                  child: Text('Data terapis tidak ditemukan.',
                                      style: TextStyle(color: Colors.white)))
                              : LayoutBuilder(
                                  builder: (context, constraints) {
                                    if (constraints.maxWidth < 900) {
                                      return _buildMobileLayout();
                                    } else {
                                      return _buildDesktopLayout();
                                    }
                                  },
                                ),
                ),
              ),
              if (kIsWeb) SliverToBoxAdapter(child: FooterSection()),
            ],
          ),
        ],
      ),
      bottomNavigationBar:
          isMobile ? AppBottomNavigationBar(currentRoute: currentRoute) : null,
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildProfileOverviewCard(),
          const SizedBox(height: 16),
          _buildDetailsCard(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _buildProfileOverviewCard(),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: _buildDetailsCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOverviewCard() {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return Card(
      color: const Color(0xFFFFF8F0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[300],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _therapist!.profilePicture != null
                      ? Image.network(
                          _therapist!.profilePicture!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person, size: 80);
                          },
                        )
                      : const Icon(Icons.person, size: 80),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _therapist!.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _therapist!.education,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const Divider(height: 32),
            _buildInfoRow(Icons.star_rate_rounded,
                '${_therapist!.rating.toStringAsFixed(1)} Rating', Colors.amber),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.wallet_rounded,
                formatter.format(_therapist!.hourlyRate), Colors.green),
            const Divider(height: 32),
            const Text(
              'Spesialisasi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: _therapist!.specializations
                  .map((s) => Chip(
                        label: Text(s),
                        backgroundColor: Colors.deepPurple.withOpacity(0.1),
                        side: BorderSide.none,
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildDetailsCard() {
    return Card(
      color: const Color(0xFFFFF8F0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TabBar(
              labelColor: Colors.deepPurple,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.deepPurple,
              indicatorWeight: 3,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today_outlined),
                      SizedBox(width: 8),
                      Text("Ketersediaan"),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.reviews_outlined),
                      SizedBox(width: 8),
                      Text("Ulasan"),
                    ],
                  ),
                ),
              ],
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 600),
              child: TabBarView(
                children: [
                  _AvailabilityTab(
                      therapist: _therapist!,
                      availabilities: _therapist!.availabilities),
                  _ReviewsTab(reviews: _therapist!.reviews),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TherapistDetail {
  final int id;
  final String name;
  final String? profilePicture;
  final String education;
  final String problemAreas;
  final List<String> specializations;
  final int hourlyRate;
  final double rating;
  final List<Availability> availabilities;
  final List<Review> reviews;

  TherapistDetail(
      {required this.id,
      required this.name,
      this.profilePicture,
      required this.education,
      required this.problemAreas,
      required this.specializations,
      required this.hourlyRate,
      required this.rating,
      required this.availabilities,
      required this.reviews});

  factory TherapistDetail.fromJson(Map<String, dynamic> json) {
    final profile = json['therapist_profile'] ?? <String, dynamic>{};

    List<Availability> parseAvail(List<dynamic>? arr) {
      if (arr == null) return [];
      return arr.map((e) {
        final day = e['day_of_week'] ?? e['day'] ?? 1;
        final parseTime = (String s) {
          final parts = s.split(':');
          return TimeOfDay(
              hour: int.parse(parts[0]), minute: int.parse(parts[1]));
        };
        return Availability(
            id: e['id'] ?? 0,
            dayOfWeek: day,
            startTime: parseTime(e['start_time'] ?? e['start']),
            endTime: parseTime(e['end_time'] ?? e['end']));
      }).toList();
    }

    List<Review> parseReviews(List<dynamic>? arr) {
      if (arr == null) return [];
      return arr
          .map((e) => Review(
              rating: (e['rating'] ?? 0).toInt(), comment: e['comment'] ?? ''))
          .toList();
    }

    return TherapistDetail(
      id: json['id'] ?? 0,
      name: json['full_name'] ?? 'Unknown Therapist',
      profilePicture: profile['profile_picture_path'] != null
          ? '${AppConfig.backendBaseUrl}/api/${profile['profile_picture_path']}'
          : null,
      education: profile['education_history'] ?? '',
      problemAreas: profile['problem_areas'] ?? '',
      specializations: (profile['specializations'] is List)
          ? List<String>.from(profile['specializations'])
          : [],
      hourlyRate: profile['hourly_rate'] ?? 0,
      rating:
          double.tryParse(json['average_rating']?.toString() ?? '0.0') ?? 0.0,
      availabilities: parseAvail(json['availabilities']),
      reviews: parseReviews(json['reviews']),
    );
  }
}

class Availability {
  final int id;
  final int dayOfWeek;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  Availability(
      {required this.id,
      required this.dayOfWeek,
      required this.startTime,
      required this.endTime});
}

class Review {
  final int rating;
  final String comment;
  Review({required this.rating, required this.comment});
}

class _AvailabilityTab extends StatelessWidget {
  final TherapistDetail therapist;
  final List<Availability> availabilities;
  const _AvailabilityTab(
      {required this.therapist, required this.availabilities});

  @override
  Widget build(BuildContext context) {
    final Map<int, List<Availability>> groupedAvailabilities = {};
    for (var a in availabilities) {
      (groupedAvailabilities[a.dayOfWeek] ??= []).add(a);
    }

    final now = DateTime.now();
    final next7Days = List.generate(7, (i) => now.add(Duration(days: i)));

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      itemCount: next7Days.length,
      itemBuilder: (context, index) {
        final date = next7Days[index];
        final dayOfWeek = date.weekday;
        final slots = groupedAvailabilities[dayOfWeek] ?? [];

        if (slots.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: slots.map((s) {
                  final label =
                      '${s.startTime.format(context)} - ${s.endTime.format(context)}';
                  return ActionChip(
                    label: Text(label),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => BookingDialog(
                        therapist: therapist,
                        prefillDate: date,
                        prefillTime: s.startTime,
                        availability: s,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  final List<Review> reviews;
  const _ReviewsTab({required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Center(child: Text('Terapis ini belum memiliki ulasan.'));
    }
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      itemCount: reviews.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final r = reviews[i];
        return Card(
          elevation: 0,
          color: Colors.deepPurple.withOpacity(0.05),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    5,
                    (idx) => Icon(
                      idx < r.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  r.comment,
                  style: TextStyle(color: Colors.grey[800], fontSize: 15),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BookingDialog extends StatefulWidget {
  final TherapistDetail therapist;
  final DateTime? prefillDate;
  final TimeOfDay? prefillTime;
  final Availability? availability;
  const BookingDialog(
      {super.key,
      required this.therapist,
      this.prefillDate,
      this.prefillTime,
      this.availability});

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _durationMinutes = 60;
  final TextEditingController _notesController = TextEditingController();
  bool _isSubmitting = false;
  final _formKey = GlobalKey<FormState>();
  final BookingService _service = BookingService();
  Availability? _selectedAvailability;

  @override
  void initState() {
    super.initState();
    if (widget.prefillDate != null) _selectedDate = widget.prefillDate;
    if (widget.prefillTime != null) _selectedTime = widget.prefillTime;
    if (widget.availability != null) _selectedAvailability = widget.availability;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final firstSelectableDate = DateTime(now.year, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? firstSelectableDate,
      firstDate: firstSelectableDate,
      lastDate: now.add(const Duration(days: 365)),
      selectableDayPredicate: (DateTime day) {
        return widget.therapist.availabilities
            .any((a) => a.dayOfWeek == day.weekday);
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _selectedTime = null;
        _selectedAvailability = null;
        final availableTimes = widget.therapist.availabilities
            .where((a) => a.dayOfWeek == picked.weekday)
            .toList();
        if (availableTimes.isNotEmpty) {
          _selectedAvailability = availableTimes.first;
          _selectedTime = availableTimes.first.startTime;
        }
      });
    }
  }

  Future<void> _pickTime() async {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih tanggal terlebih dahulu')),
      );
      return;
    }

    final availableTimes = widget.therapist.availabilities
        .where((a) => a.dayOfWeek == _selectedDate!.weekday)
        .toList();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: availableTimes.map((availability) {
              final time = availability.startTime;
              return ListTile(
                title: Text(time.format(context)),
                onTap: () {
                  setState(() {
                    _selectedTime = time;
                    _selectedAvailability = availability;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final dt = _combined();
    if (dt == null || _selectedAvailability == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan pilih tanggal dan waktu')));
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final appt = await _service.createAppointment(
        therapistId: widget.therapist.id,
        availabilityId: _selectedAvailability!.id,
        appointmentTime: dt,
        durationMinutes: _durationMinutes,
        clientNotes: _notesController.text,
      );

      final apptId = appt['id'] is int
          ? appt['id'] as int
          : int.tryParse(appt['id']?.toString() ?? '');
      if (apptId == null) {
        throw Exception('Gagal mendapatkan ID janji temu.');
      }

      final orderId =
          'MINDSPACE-${apptId}-${DateTime.now().millisecondsSinceEpoch}';
      final gross =
          (widget.therapist.hourlyRate * (_durationMinutes / 60)).round();

      final tx = await _service.createTransaction(
        orderId: orderId,
        grossAmount: gross,
        appointmentId: apptId,
      );

      final snap =
          tx['snap_token'] ?? tx['token'] ?? tx['data']?['snap_token'];
      if (snap != null && mounted) {
        Navigator.of(context).pop();
        final checkoutUrl = Uri.parse(
            '${AppConfig.backendBaseUrl}/midtrans/checkout?snap_token=$snap');

        if (await canLaunchUrl(checkoutUrl)) {
          await launchUrl(checkoutUrl, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Gagal membuka browser. URL: $checkoutUrl')));
        }
      } else {
        throw Exception('Token transaksi tidak diterima.');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString().replaceFirst("Exception: ", ""))));
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  DateTime? _combined() {
    if (_selectedDate == null || _selectedTime == null) return null;
    return DateTime(_selectedDate!.year, _selectedDate!.month,
        _selectedDate!.day, _selectedTime!.hour, _selectedTime!.minute);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pesan sesi dengan ${widget.therapist.name}'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(_selectedDate == null
                    ? 'Pilih tanggal'
                    : DateFormat('EEEE, d MMMM yyyy', 'id_ID')
                        .format(_selectedDate!)),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              ListTile(
                title: Text(_selectedTime == null
                    ? 'Pilih Waktu'
                    : _selectedTime!.format(context)),
                trailing: const Icon(Icons.access_time),
                onTap: _pickTime,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Durasi Sesi:'),
                    DropdownButton<int>(
                        value: _durationMinutes,
                        items: [60, 90, 120]
                            .map((m) => DropdownMenuItem(
                                value: m, child: Text('$m menit')))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _durationMinutes = v ?? 60)),
                  ],
                ),
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                    labelText: 'Keluhan / Catatan (Wajib)',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Keluhan wajib diisi'
                    : null,
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal')),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          child: _isSubmitting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white))
              : const Text('Lanjut Pembayaran'),
        ),
      ],
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF5B3F5B),
            ),
            child: Text(
              'Mindspace',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _DrawerItem('Home', Icons.home, () {
            Navigator.pushNamed(context, '/');
          }),
          _DrawerItem('Terapis', Icons.people, () {}),
          _DrawerItem('Jadwal', Icons.calendar_today, () {}),
          _DrawerItem('Kontak', Icons.contact_phone, () {}),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerItem(this.title, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      onTap: onTap,
    );
  }
}