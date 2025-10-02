import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/user.dart';
import '../../routes.dart';
import '../../services/auth_service.dart';

class SettingsDashboard extends StatefulWidget {
  final User user;
  final String token;
  final Function(User) onProfileUpdated;

  const SettingsDashboard({
    super.key, 
    required this.user, 
    required this.token,
    required this.onProfileUpdated,
  });

  @override
  State<SettingsDashboard> createState() => _SettingsDashboardState();
}

class _SettingsDashboardState extends State<SettingsDashboard> {
  bool _isEditing = false;
  bool _isLoading = false;

  late TextEditingController _fullNameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _birthDateController;

  late String _genderValue;
  late bool _flyerPreference;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.user.fullName);
    _usernameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: "081234567890"); 
    _birthDateController = TextEditingController(text: "1995-05-20");
    _genderValue = "pria";
    _flyerPreference = true; 
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

  Future<void> _saveProfile() async {
    setState(() { _isLoading = true; });

    final url = Uri.parse('http://127.0.0.1:8000/api/user/profile');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json', 'Accept': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
        body: jsonEncode({
          'username': _usernameController.text,
          'full_name': _fullNameController.text,
          'email': _emailController.text,
          'phone_number': _phoneController.text,
          'birth_date': _birthDateController.text,
          'gender': _genderValue,
          'flyer': _flyerPreference ? 'yes' : 'no',
        }),
      );
      if (mounted) {
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final updatedUser = User.fromJson(responseData['user']);

          widget.onProfileUpdated(updatedUser);

          setState(() { _isEditing = false; });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profil berhasil diperbarui!')),
          );
        } else {
          final error = jsonDecode(response.body)['message'];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) { setState(() { _isLoading = false; }); }
    }
  }

  Future<void> _updatePasswordApiCall(String current, String newPass, String confirm) async {
    setState(() { _isLoading = true; });
    final url = Uri.parse('http://127.0.0.1:8000/api/user/password');
    
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${widget.token}'},
        body: jsonEncode({'current_password': current, 'new_password': newPass, 'new_password_confirmation': confirm}),
      );

      if (mounted) {
        final message = jsonDecode(response.body)['message'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: response.statusCode == 200 ? Colors.green : Colors.red,));
      }
    } catch(e) {
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'))); }
    } finally {
      if (mounted) { setState(() { _isLoading = false; }); }
    }
  }
  
  Future<void> _deleteAccountApiCall(String password) async {
    setState(() { _isLoading = true; });
    final url = Uri.parse('http://127.0.0.1:8000/api/user');
    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer ${widget.token}'},
        body: jsonEncode({'current_password': password}),
      );
      
      if (mounted) {
        final message = jsonDecode(response.body)['message'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

        if (response.statusCode == 200) {
          await AuthService().clearSession();
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
        }
      }
    } catch(e) {
       if (mounted) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'))); }
    } finally {
       if (mounted) { setState(() { _isLoading = false; }); }
    }
  }
  
  void _showChangePasswordDialog() {
    final formKey = GlobalKey<FormState>();
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah Password'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(controller: currentPasswordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password Saat Ini'), validator: (v) => v!.isEmpty ? 'Wajib diisi' : null),
              const SizedBox(height: 8),
              TextFormField(controller: newPasswordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password Baru'), validator: (v) => v!.length < 8 ? 'Minimal 8 karakter' : null),
              const SizedBox(height: 8),
              TextFormField(controller: confirmPasswordController, obscureText: true, decoration: const InputDecoration(labelText: 'Konfirmasi Password Baru'), validator: (v) => v != newPasswordController.text ? 'Password tidak cocok' : null),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context);
                _updatePasswordApiCall(currentPasswordController.text, newPasswordController.text, confirmPasswordController.text);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
  
  void _showDeleteAccountDialog() {
    final formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Akun'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Tindakan ini permanen dan tidak dapat diurungkan. Masukkan password Anda untuk konfirmasi.'),
              const SizedBox(height: 16),
              TextFormField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password Saat Ini'), validator: (v) => v!.isEmpty ? 'Wajib diisi' : null),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context);
                _deleteAccountApiCall(passwordController.text);
              }
            },
            child: const Text('Hapus Akun Saya'),
          ),
        ],
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProfileSection(),
          const SizedBox(height: 24),
          _buildSecuritySection(),
          const SizedBox(height: 24),
          _buildPreferencesSection(),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Profil Pengguna', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  icon: _isLoading
                      ? Container(width: 16, height: 16, child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Icon(_isEditing ? Icons.save : Icons.edit, size: 16),
                  label: Text(_isEditing ? 'Simpan' : 'Edit Profil'),
                  onPressed: _isLoading ? null : () {
                    if (_isEditing) {
                      _saveProfile();
                    } else {
                      setState(() { _isEditing = true; });
                    }
                  },
                ),
              ],
            ),
            const Divider(height: 32),
            _buildTextField(label: 'Nama Lengkap', controller: _fullNameController, icon: Icons.person_outline),
            const SizedBox(height: 16),
            _buildTextField(label: 'Username', controller: _usernameController, icon: Icons.alternate_email, enabled: true),
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
              items: const [ DropdownMenuItem(value: 'pria', child: Text("Pria")), DropdownMenuItem(value: 'wanita', child: Text("Wanita")) ],
              onChanged: _isEditing ? (value) { setState(() { _genderValue = value!; }); } : null,
            ),
          ],
        ),
      ),
    );
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
              title: const Text('Ubah Password'),
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
              title: const Text('Terima Flyer Edukasi'),
              subtitle: const Text('Dapatkan info psikologi sebulan sekali via email.'),
              secondary: const Icon(Icons.article_outlined),
              value: _flyerPreference,
              onChanged: _isEditing ? (value) {
                setState(() { _flyerPreference = value; });
              } : null,
            ),
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
      enabled: _isEditing && enabled,
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
}