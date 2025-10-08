import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mindspace_app/animated_background.dart';
import 'package:mindspace_app/models/user.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';

class TherapistForm extends StatefulWidget {
  final User user;
  final String token;
  const TherapistForm({super.key, required this.user, required this.token});

  @override
  State<TherapistForm> createState() => _TherapistFormState();
}

class _TherapistFormState extends State<TherapistForm> {
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      appBar: CustomAppBar(user: _currentUser),
      drawer: const _AppDrawer(),
      body: Stack(
        children: [
          const AnimatedGradientBackground(),
          CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: FormSection(user: _currentUser, token: widget.token),
              ),
              if (kIsWeb) const FooterSection(),
            ],
          )
        ],
      ),
    );
  }
}

class FormSection extends StatefulWidget {
  final User user;
  final String token;
  const FormSection({super.key, required this.user, required this.token});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final _formKey = GlobalKey<FormState>();

  
  final _educationalHistoryController = TextEditingController();
  final _hourlyRateController = TextEditingController();
  final _experienceController = TextEditingController();
  final _problemAreasController = TextEditingController();

  
  final Map<String, bool> _specializations = {
    'Klinis Dewasa': false,
    'Klinis Anak dan Remaja': false,
    'Klinis Pendidikan': false,
  };

  
  
  Uint8List? _imageBytes;
  String? _imageName;
  final ImagePicker _picker = ImagePicker();

  bool _isLoading = false;

  @override
  void dispose() {
    _educationalHistoryController.dispose();
    _hourlyRateController.dispose();
    _experienceController.dispose();
    _problemAreasController.dispose();
    super.dispose();
  }

  
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _imageName = pickedFile.name;
      });
    }
  }

  
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate() || _imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select a picture.')),
      );
      return;
    }

    setState(() { _isLoading = true; });

    final url = Uri.parse('http://127.0.0.1:8000/api/therapist-applications');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${widget.token}',
    });

    request.fields['education_history'] = _educationalHistoryController.text;
    request.fields['hourly_rate'] = _hourlyRateController.text;
    request.fields['experience_years'] = _experienceController.text;
    request.fields['problem_areas'] = _problemAreasController.text;

    List<String> selectedSpecializations = _specializations.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    for (int i = 0; i < selectedSpecializations.length; i++) {
      request.fields['specializations[$i]'] = selectedSpecializations[i];
    }
    
    
    request.files.add(
      http.MultipartFile.fromBytes(
        'profile_picture',
        _imageBytes!,
        filename: _imageName,
      )
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = jsonDecode(response.body);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message'] ?? 'An error occurred.'),
            backgroundColor: response.statusCode == 201 ? Colors.green : Colors.red,
          ),
        );
        if (response.statusCode == 201) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    } finally {
      if (mounted) { setState(() { _isLoading = false; }); }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 200,
      ),
      child: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Daftar Sebagai Psikolog',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _imageBytes != null ? MemoryImage(_imageBytes!) : null,
                        child: _imageBytes == null
                            ? Icon(Icons.camera_alt, size: 50, color: Colors.grey.shade800)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _pickImage,
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFF5B3F5B),
                            child: Icon(Icons.edit, size: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                TextFormField(
                  initialValue: widget.user.fullName,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap (dari profil Anda)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _educationalHistoryController,
                  decoration: const InputDecoration(
                    labelText: 'Riwayat Pendidikan (Universitas)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.school),
                  ),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _hourlyRateController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Harga per Jam (contoh: 150000)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.price_change),
                  ),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _experienceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Pengalaman Praktik (Tahun)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.work_history),
                  ),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 24),

                const Text('Spesialisasi (bisa pilih lebih dari satu)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                ..._specializations.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: _specializations[key],
                    onChanged: (bool? value) {
                      setState(() {
                        _specializations[key] = value!;
                      });
                    },
                  );
                }).toList(),
                const SizedBox(height: 16),
                
                TextFormField(
                  controller: _problemAreasController,
                  decoration: const InputDecoration(
                    labelText: 'Area Permasalahan',
                    hintText: 'Cth: Kecemasan, Depresi, Hubungan',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.psychology),
                  ),
                  validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC89E25),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Kirim Pendaftaran"),
                )
              ],
            ),
          ),
        ),
      ),
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