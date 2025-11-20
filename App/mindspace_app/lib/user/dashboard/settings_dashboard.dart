import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindspace_app/config.dart';
import 'package:mindspace_app/therapist_dashboard/register.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../routes.dart';
import '../../services/auth_service.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb; 
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class SettingsDashboard extends StatefulWidget {
  const SettingsDashboard({super.key});

  @override
  State<SettingsDashboard> createState() => _SettingsDashboardState();
}

class _SettingsDashboardState extends State<SettingsDashboard> {
  bool _isEditing = false;
  bool _isLoading = false;
  bool _isAvailabilityLoading = false;
  
  bool _biometricsEnabled = false;
  bool _isBiometricAvailable = false;

  late TextEditingController _fullNameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _birthDateController;
  late String _genderValue;
  late bool _flyerPreference;

  Uint8List? _imageBytes;
  String? _imageName;
  final ImagePicker _picker = ImagePicker();

  final Map<String, List<Map<String, TimeOfDay>>> _availabilities = {
    'Senin': [], 'Selasa': [], 'Rabu': [], 'Kamis': [],
    'Jumat': [], 'Sabtu': [], 'Minggu': [],
  };

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _birthDateController = TextEditingController();
    
    context.read<AuthService>().refreshUserFromServer();
    _loadBiometricSettings();
  }

  Future<void> _loadBiometricSettings() async {
    final authService = context.read<AuthService>();
    final canCheck = await authService.canCheckBiometrics();
    final isEnabled = await authService.isBiometricsEnabled;
    
    if (mounted) {
      setState(() {
        _isBiometricAvailable = canCheck;
        _biometricsEnabled = isEnabled;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeProfileData();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _initializeProfileData() {
    final user = context.read<AuthService>().currentUser;
    if (user != null) {
      _fullNameController.text = user.fullName;
      _usernameController.text = user.username ?? '';
      _emailController.text = user.email;
      _phoneController.text = user.phoneNumber ?? '';
      _birthDateController.text = user.birthDate ?? '';
      _genderValue = user.gender ?? 'pria';
      _flyerPreference = user.flyer == 'yes';

      if (user.role == 'psikolog') {
        _fetchAvailability();
      }
    }
  }

  Future<void> _fetchAvailability() async {
    setState(() => _isAvailabilityLoading = true);
    final token = context.read<AuthService>().token;
    if (token == null) {
      setState(() => _isAvailabilityLoading = false);
      return;
    }
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/psikolog/availability');
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200 && mounted) {
        List<dynamic> data = json.decode(response.body);
        final dayMapping = {
          1: 'Senin', 2: 'Selasa', 3: 'Rabu', 4: 'Kamis',
          5: 'Jumat', 6: 'Sabtu', 7: 'Minggu'
        };
        _availabilities.forEach((key, value) => value.clear());

        for (var slot in data) {
          final day = dayMapping[slot['day_of_week']];
          if (day != null) {
            final startTime = TimeOfDay(
                hour: int.parse(slot['start_time'].split(':')[0]),
                minute: int.parse(slot['start_time'].split(':')[1]));
            final endTime = TimeOfDay(
                hour: int.parse(slot['end_time'].split(':')[0]),
                minute: int.parse(slot['end_time'].split(':')[1]));
            _availabilities[day]!.add({'start': startTime, 'end': endTime});
          }
        }
      }
    } catch (e) {
      // Hehe
    } finally {
      if (mounted) setState(() => _isAvailabilityLoading = false);
    }
  }
  
  Future<void> _updateAvailability() async {
    final token = context.read<AuthService>().token;
    if (token == null) return;
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/psikolog/availability');
    final messenger = ScaffoldMessenger.of(context);
    
    List<Map<String, dynamic>> payload = [];
    final dayMapping = {'Senin': 1, 'Selasa': 2, 'Rabu': 3, 'Kamis': 4, 'Jumat': 5, 'Sabtu': 6, 'Minggu': 7};
    _availabilities.forEach((day, slots) {
      for (var slot in slots) {
        payload.add({
          'day_of_week': dayMapping[day],
          'start_time': '${slot['start']!.hour.toString().padLeft(2, '0')}:${slot['start']!.minute.toString().padLeft(2, '0')}',
          'end_time': '${slot['end']!.hour.toString().padLeft(2, '0')}:${slot['end']!.minute.toString().padLeft(2, '0')}',
        });
      }
    });

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'availabilities': payload}),
      );

      messenger.showSnackBar(
        SnackBar(content: Text(json.decode(response.body)['message'] ?? 'Status pembaruan ketersediaan.'),
        backgroundColor: response.statusCode == 200 ? Colors.green : Colors.red,
      ));
    } catch(e) {
      messenger.showSnackBar(SnackBar(content: Text('Error memperbarui ketersediaan: $e')));
    }
  }

  Future<void> _updateProfile() async {
    final authService = context.read<AuthService>();
    final token = authService.token;
    if (token == null) return;

    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/user/profile');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    
    request.fields['username'] = _usernameController.text;
    request.fields['full_name'] = _fullNameController.text;
    request.fields['email'] = _emailController.text;
    request.fields['phone_number'] = _phoneController.text;
    request.fields['birth_date'] = _birthDateController.text;
    request.fields['gender'] = _genderValue;
    request.fields['flyer'] = _flyerPreference ? 'yes' : 'no';

    if (_imageBytes != null && _imageName != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'profile_picture',
        _imageBytes!,
        filename: _imageName,
      ));
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (mounted) {
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final updatedUser = User.fromJson(responseData['user']);
          await authService.updateUser(updatedUser);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profil berhasil diperbarui!')),
          );
        } else {
          final error = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Kesalahan: ${error['message'] ?? error}')));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Kesalahan: $e')));
      }
    }
  }

  Future<void> _onSaveChanges() async {
    setState(() => _isLoading = true);
    final user = context.read<AuthService>().currentUser;
    
    List<Future> updateFutures = [_updateProfile()]; 
    if (user?.role == 'psikolog') {
      updateFutures.add(_updateAvailability());
    }

    await Future.wait(updateFutures);

    if (mounted) {
      setState(() {
        _isLoading = false;
        _isEditing = false;
        _imageBytes = null;
        _imageName = null;
      });
    }
  }

  Future<void> _pickImage() async {
    if (!_isEditing) return;
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _imageName = pickedFile.name;
      });
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_birthDateController.text) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _addOrEditTimeSlot(String day) async {
    final TimeOfDay? startTime = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 9, minute: 0));
    if (startTime == null || !mounted) return;
    final TimeOfDay? endTime = await showTimePicker(context: context, initialTime: TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute));
    if (endTime == null) return;
    
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;

    if (startMinutes >= endMinutes) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Waktu selesai harus setelah waktu mulai.'), backgroundColor: Colors.red));
      }
      return;
    }
    setState(() => _availabilities[day]!.add({'start': startTime, 'end': endTime}));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthService>().currentUser;
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProfileSection(user),
          const SizedBox(height: 24),
          if (user.role == 'psikolog') ...[
            _buildAvailabilitySection(),
            const SizedBox(height: 24),
          ],
          _buildSecuritySection(),
          const SizedBox(height: 24),
          _buildPreferencesSection(),
          const SizedBox(height: 24),
          if (user.role != 'psikolog') ...[
            _buildPsychologistCard(),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  Widget _buildProfileSection(User user) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _imageBytes != null
                        ? MemoryImage(_imageBytes!)
                        : (user.profilePicture != null
                            ? NetworkImage('${AppConfig.backendBaseUrl}/api/${user.profilePicture!}')
                            : null) as ImageProvider?,
                    child: _imageBytes == null && user.profilePicture == null
                        ? Icon(Icons.person, size: 60, color: Colors.grey.shade800)
                        : null,
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.white)),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Profil Pengguna', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                if (isMobile)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                    onPressed: _isLoading ? null : () {
                      if (_isEditing) {
                        _onSaveChanges();
                      } else {
                        setState(() => _isEditing = true);
                      }
                    },
                    child: _isLoading
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : Icon(_isEditing ? Icons.save : Icons.edit, size: 20),
                  )
                else
                  ElevatedButton.icon(
                    icon: _isLoading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : Icon(_isEditing ? Icons.save : Icons.edit, size: 16),
                    label: Text(_isEditing ? 'Simpan Perubahan' : 'Ubah'),
                    onPressed: _isLoading ? null : () {
                      if (_isEditing) {
                        _onSaveChanges();
                      } else {
                        setState(() => _isEditing = true);
                      }
                    },
                  ),
              ],
            ),
            const Divider(height: 32),
            _buildTextField(label: 'Nama Lengkap', controller: _fullNameController, icon: Icons.person_outline),
            const SizedBox(height: 16),
            _buildTextField(label: 'Nama Pengguna', controller: _usernameController, icon: Icons.alternate_email),
            const SizedBox(height: 16),
            _buildTextField(label: 'Email', controller: _emailController, icon: Icons.email_outlined),
            const SizedBox(height: 16),
            _buildTextField(label: 'Nomor Telepon', controller: _phoneController, icon: Icons.phone_outlined),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Tanggal Lahir',
              controller: _birthDateController,
              icon: Icons.calendar_today_outlined,
              readOnly: true,
              onTap: _isEditing ? _selectDate : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _genderValue,
              decoration: const InputDecoration(labelText: 'Jenis Kelamin', prefixIcon: Icon(Icons.wc_outlined), border: OutlineInputBorder()),
              items: const [DropdownMenuItem(value: 'pria', child: Text("Pria")), DropdownMenuItem(value: 'wanita', child: Text("Wanita"))],
              onChanged: _isEditing ? (value) => setState(() => _genderValue = value!) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilitySection() {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Atur Ketersediaan Anda', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            if (_isAvailabilityLoading)
              const Center(child: CircularProgressIndicator())
            else
              ..._availabilities.keys.map((day) {
                return ExpansionTile(
                  key: PageStorageKey(day),
                  title: Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    ..._availabilities[day]!.asMap().entries.map((entry) {
                      int idx = entry.key;
                      Map<String, TimeOfDay> slot = entry.value;
                      return ListTile(
                        title: Text('${slot['start']!.format(context)} - ${slot['end']!.format(context)}'),
                        trailing: _isEditing ? IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                          onPressed: () => setState(() => _availabilities[day]!.removeAt(idx)),
                        ) : null,
                      );
                    }),
                    if (_isEditing)
                      ListTile(
                        title: const Text('Tambah Jadwal', style: TextStyle(color: Colors.blue)),
                        leading: const Icon(Icons.add, color: Colors.blue),
                        onTap: () => _addOrEditTimeSlot(day),
                      )
                  ],
                );
              }),
          ],
        ),
      ),
    );
  }

  Future<void> _handleBiometricToggle(bool newValue) async {
    final authService = context.read<AuthService>();
    final token = authService.token; 
    final messenger = ScaffoldMessenger.of(context);

    if (newValue == true) {
      
      if (token == null) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Error: Token tidak ditemukan, silakan login ulang.'), backgroundColor: Colors.red),
        );
        return;
      }
      try {
        await authService.enableBiometrics(token);
        if (mounted) {
          setState(() {
            _biometricsEnabled = true;
          });
          messenger.showSnackBar(
            const SnackBar(content: Text('Login Biometrik Diaktifkan!'), backgroundColor: Colors.green),
          );
        }
      } catch (e) {
        if (mounted) {
          messenger.showSnackBar(
            SnackBar(content: Text('Gagal mengaktifkan: $e'), backgroundColor: Colors.red),
          );
        }
      }
    } else {
      try {
        await authService.disableBiometrics();
        if (mounted) {
          setState(() {
            _biometricsEnabled = false;
          });
          messenger.showSnackBar(
            const SnackBar(content: Text('Login Biometrik Dinonaktifkan.'), backgroundColor: Colors.grey),
          );
        }
      } catch (e) {
        if (mounted) {
          messenger.showSnackBar(
            SnackBar(content: Text('Gagal menonaktifkan: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  Widget _buildSecuritySection() {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Keamanan Akun', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text('Ubah Kata Sandi'),
              trailing: const Icon(Icons.chevron_right),
              onTap: _showChangePasswordDialog,
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.delete_forever_outlined, color: Colors.red.shade700),
              title: Text('Hapus Akun', style: TextStyle(color: Colors.red.shade700)),
              trailing: Icon(Icons.chevron_right, color: Colors.red.shade700),
              onTap: _showDeleteAccountDialog,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesSection() {
    bool showBiometricSwitch = !kIsWeb && _isBiometricAvailable;

    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Preferensi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            SwitchListTile(
              title: const Text('Terima Info Edukasi'),
              subtitle: const Text('Dapatkan info psikologi sebulan sekali via email.'),
              secondary: const Icon(Icons.article_outlined),
              value: _flyerPreference,
              onChanged: _isEditing ? (value) => setState(() => _flyerPreference = value) : null,
            ),

            if (showBiometricSwitch) ...[
              const Divider(),
              SwitchListTile(
                title: const Text('Login Biometrik'),
                subtitle: Text(
                  _biometricsEnabled 
                    ? 'Login cepat menggunakan biometrik diaktifkan' 
                    : 'Gunakan sidik jari/wajah untuk login cepat'
                ),
                secondary: const Icon(Icons.fingerprint),
                value: _biometricsEnabled,
                onChanged: (val) => _handleBiometricToggle(val),
              ),
            ],
            
            if (!kIsWeb && !_isBiometricAvailable) ...[
              const Divider(),
              ListTile(
                leading: Icon(Icons.fingerprint, color: Colors.grey.shade400),
                title: Text(
                  'Login Biometrik Tidak Tersedia',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                subtitle: Text(
                  'Perangkat Anda tidak mendukung atau belum mengatur biometrik',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool enabled = true,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      enabled: _isEditing,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }

  Widget _buildPsychologistCard() {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tertarik menjadi psikolog?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text(
              'Bergabunglah dengan tim profesional kami dan bantu lebih banyak orang menemukan kedamaian batin mereka.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF653A50)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TherapistForm(),
                    ),
                  );
                },
                child: const Text('Daftar di Sini!'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog() {
    final formKey = GlobalKey<FormState>();
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool isLoadingDialog = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Ubah Kata Sandi'),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: currentPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Kata Sandi Saat Ini'),
                      validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Kata Sandi Baru'),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Wajib diisi';
                        if (value.length < 8) return 'Kata sandi minimal 8 karakter';
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Konfirmasi Kata Sandi Baru'),
                      validator: (value) {
                        if (value != newPasswordController.text) return 'Kata sandi tidak cocok';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
                ElevatedButton(
                  onPressed: isLoadingDialog ? null : () async {
                    if (formKey.currentState!.validate()) {
                      setStateDialog(() => isLoadingDialog = true);
                      await _updatePasswordApiCall(
                        currentPasswordController.text,
                        newPasswordController.text,
                        confirmPasswordController.text
                      );
                      setStateDialog(() => isLoadingDialog = false);
                    }
                  },
                  child: isLoadingDialog ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Ubah'),
                ),
              ],
            );
          },
        );
      },
    );
  }
  
  void _showDeleteAccountDialog() {
    final passwordController = TextEditingController();
    final messenger = ScaffoldMessenger.of(context);
    bool isLoadingDialog = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Hapus Akun'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Tindakan ini tidak dapat diurungkan. Silakan masukkan kata sandi Anda untuk mengonfirmasi.'),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Kata Sandi'),
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: isLoadingDialog ? null : () async {
                    if (passwordController.text.isEmpty) {
                      messenger.showSnackBar(const SnackBar(content: Text('Kata sandi diperlukan'), backgroundColor: Colors.orange));
                      return;
                    }
                    setStateDialog(() => isLoadingDialog = true);
                    await _deleteAccountApiCall(passwordController.text);
                    setStateDialog(() => isLoadingDialog = false);
                  },
                  child: isLoadingDialog ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Hapus'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _updatePasswordApiCall(String current, String newP, String confirm) async {
    final token = context.read<AuthService>().token;
    if (token == null) return;
    
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/user/password');
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      final response = await http.put(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'current_password': current,
          'new_password': newP,
          'new_password_confirmation': confirm,
        }),
      );
      
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        messenger.showSnackBar(SnackBar(content: Text(responseData['message']), backgroundColor: Colors.green));
        navigator.pop();
      } else {
        messenger.showSnackBar(SnackBar(content: Text(responseData['message']), backgroundColor: Colors.red));
      }

    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    }
  }
  
  Future<void> _deleteAccountApiCall(String password) async {
    final authService = context.read<AuthService>();
    final token = authService.token;
    if (token == null) return;
    
    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/user');
    final messenger = ScaffoldMessenger.of(context);

    try {
      final response = await http.delete(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'current_password': password}),
      );
      
      if (!mounted) return;
      
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        messenger.showSnackBar(SnackBar(content: Text(responseData['message']), backgroundColor: Colors.green));
        authService.clearSession();
      } else {
        messenger.showSnackBar(SnackBar(content: Text(responseData['message']), backgroundColor: Colors.red));
      }
    } catch (e) {
      if (mounted) {
        messenger.showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e'
        )));
      }
    }
  }
}