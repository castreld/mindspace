import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindspace_app/therapist/register.dart';
import '../../models/user.dart';
import '../../routes.dart';
import '../../services/auth_service.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

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
  // Loading and editing states
  bool _isEditing = false;
  bool _isLoading = false;
  bool _isAvailabilityLoading = false;

  // Profile controllers
  late TextEditingController _fullNameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _birthDateController;
  late String _genderValue;
  late bool _flyerPreference;

  // Image picking
  Uint8List? _imageBytes;
  String? _imageName;
  final ImagePicker _picker = ImagePicker();

  // Availability state
  final Map<String, List<Map<String, TimeOfDay>>> _availabilities = {
    'Monday': [], 'Tuesday': [], 'Wednesday': [], 'Thursday': [],
    'Friday': [], 'Saturday': [], 'Sunday': [],
  };

  @override
  void initState() {
    super.initState();
    _initializeProfileControllers();
    // Fetch availability only if the user is a psychologist
    if (widget.user.role == 'psikolog') {
      _fetchAvailability();
    }
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

  void _initializeProfileControllers() {
    _fullNameController = TextEditingController(text: widget.user.fullName);
    _usernameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber ?? "");
    _birthDateController = TextEditingController(text: widget.user.birthDate ?? "");
    _genderValue = widget.user.gender ?? "pria";
    _flyerPreference = widget.user.flyer == 'yes';
  }

  Future<void> _fetchAvailability() async {
    setState(() => _isAvailabilityLoading = true);
    final url = Uri.parse('http://127.0.0.1:8000/api/psikolog/availability');
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${widget.token}',
      });

      if (response.statusCode == 200 && mounted) {
        List<dynamic> data = json.decode(response.body);
        final dayMapping = {1: 'Monday', 2: 'Tuesday', 3: 'Wednesday', 4: 'Thursday', 5: 'Friday', 6: 'Saturday', 7: 'Sunday'};
        
        _availabilities.forEach((key, value) => value.clear());

        for (var slot in data) {
          final day = dayMapping[slot['day_of_week']];
          if (day != null) {
            final startTime = TimeOfDay(hour: int.parse(slot['start_time'].split(':')[0]), minute: int.parse(slot['start_time'].split(':')[1]));
            final endTime = TimeOfDay(hour: int.parse(slot['end_time'].split(':')[0]), minute: int.parse(slot['end_time'].split(':')[1]));
            _availabilities[day]!.add({'start': startTime, 'end': endTime});
          }
        }
      }
    } catch (e) {
      // Handle error if needed
    } finally {
      if (mounted) setState(() => _isAvailabilityLoading = false);
    }
  }

  Future<void> _updateAvailability() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/psikolog/availability');
    final messenger = ScaffoldMessenger.of(context);
    
    List<Map<String, dynamic>> payload = [];
    final dayMapping = {'Monday': 1, 'Tuesday': 2, 'Wednesday': 3, 'Thursday': 4, 'Friday': 5, 'Saturday': 6, 'Sunday': 7};
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
          'Authorization': 'Bearer ${widget.token}',
        },
        body: json.encode({'availabilities': payload}),
      );

      messenger.showSnackBar(
        SnackBar(content: Text(json.decode(response.body)['message'] ?? 'Availability update status.'),
        backgroundColor: response.statusCode == 200 ? Colors.green : Colors.red,
      ));
    } catch(e) {
      messenger.showSnackBar(SnackBar(content: Text('Error updating availability: $e')));
    }
  }
  
  Future<void> _updateProfile() async {
    final url = Uri.parse('http://127.0.0.1:8000/api/user/profile');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${widget.token}',
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
          widget.onProfileUpdated(updatedUser);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
        } else {
          final error = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${error['message'] ?? error}')));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _onSaveChanges() async {
    setState(() => _isLoading = true);
    
    List<Future> updateFutures = [_updateProfile()]; 
    if (widget.user.role == 'psikolog') {
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('End time must be after start time.'), backgroundColor: Colors.red));
      }
      return;
    }
    setState(() => _availabilities[day]!.add({'start': startTime, 'end': endTime}));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProfileSection(),
          const SizedBox(height: 24),
          if (widget.user.role == 'psikolog') ...[
            _buildAvailabilitySection(),
            const SizedBox(height: 24),
          ],
          _buildSecuritySection(),
          const SizedBox(height: 24),
          _buildPreferencesSection(),
          const SizedBox(height: 24),
          if (widget.user.role != 'psikolog') ...[
            _buildPsychologistCard(),
            const SizedBox(height: 24),
          ],
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
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _imageBytes != null
                        ? MemoryImage(_imageBytes!)
                        : (widget.user.profilePicture != null
                            ? NetworkImage('http://127.0.0.1:8000/api/${widget.user.profilePicture!}')
                            : null) as ImageProvider?,
                    child: _imageBytes == null && widget.user.profilePicture == null
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
                const Text('User Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  icon: _isLoading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Icon(_isEditing ? Icons.save : Icons.edit, size: 16),
                  label: Text(_isEditing ? 'Save All Changes' : 'Edit'),
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
            _buildTextField(label: 'Full Name', controller: _fullNameController, icon: Icons.person_outline),
            const SizedBox(height: 16),
            _buildTextField(label: 'Username', controller: _usernameController, icon: Icons.alternate_email),
            const SizedBox(height: 16),
            _buildTextField(label: 'Email', controller: _emailController, icon: Icons.email_outlined),
            const SizedBox(height: 16),
            _buildTextField(label: 'Phone Number', controller: _phoneController, icon: Icons.phone_outlined),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Birth Date',
              controller: _birthDateController,
              icon: Icons.calendar_today_outlined,
              readOnly: true,
              onTap: _isEditing ? _selectDate : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _genderValue,
              decoration: const InputDecoration(labelText: 'Gender', prefixIcon: Icon(Icons.wc_outlined), border: OutlineInputBorder()),
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
            const Text('Manage Your Availability', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            if (_isAvailabilityLoading)
              const Center(child: CircularProgressIndicator())
            else
              ..._availabilities.keys.map((day) {
                return ExpansionTile(
                  key: PageStorageKey(day), // Helps maintain state on rebuild
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
                        title: const Text('Add Time Slot', style: TextStyle(color: Colors.blue)),
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
            const Text('Account Security', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.chevron_right),
              onTap: _showChangePasswordDialog,
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.delete_forever_outlined, color: Colors.red.shade700),
              title: Text('Delete Account', style: TextStyle(color: Colors.red.shade700)),
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
            const Text('Preferences', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            SwitchListTile(
              title: const Text('Receive Educational Flyers'),
              subtitle: const Text('Get psychology info once a month via email.'),
              secondary: const Icon(Icons.article_outlined),
              value: _flyerPreference,
              onChanged: _isEditing ? (value) => setState(() => _flyerPreference = value) : null,
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
            const Text('Interested in becoming a psychologist?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text(
              'Join our team of professionals and help more people find their inner peace.',
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
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TherapistForm(user: widget.user, token: widget.token)),
                ),
                child: const Text('Apply Here!'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog() {
    final _formKey = GlobalKey<FormState>();
    final _currentPasswordController = TextEditingController();
    final _newPasswordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    bool _isLoading = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Change Password'),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _currentPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Current Password'),
                      validator: (value) => value!.isEmpty ? 'This field is required' : null,
                    ),
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'New Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'This field is required';
                        if (value.length < 8) return 'Password must be at least 8 characters';
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Confirm New Password'),
                      validator: (value) {
                        if (value != _newPasswordController.text) return 'Passwords do not match';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: _isLoading ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isLoading = true);
                      await _updatePasswordApiCall(
                        _currentPasswordController.text,
                        _newPasswordController.text,
                        _confirmPasswordController.text
                      );
                      setState(() => _isLoading = false);
                    }
                  },
                  child: _isLoading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Change'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    final _passwordController = TextEditingController();
    final messenger = ScaffoldMessenger.of(context);
    bool _isLoading = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Delete Account'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('This action is irreversible. Please enter your password to confirm.'),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: _isLoading ? null : () async {
                    if (_passwordController.text.isEmpty) {
                      messenger.showSnackBar(const SnackBar(content: Text('Password is required'), backgroundColor: Colors.orange));
                      return;
                    }
                    setState(() => _isLoading = true);
                    await _deleteAccountApiCall(_passwordController.text);
                    setState(() => _isLoading = false);
                  },
                  child: _isLoading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Delete'),
                ),
              ],
            );
          },
        );
      },
    );
  }
  Future<void> _updatePasswordApiCall(String current, String newP, String confirm) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/user/password');
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      final response = await http.put(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
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
      messenger.showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }
  
  Future<void> _deleteAccountApiCall(String password) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/user');
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      final response = await http.delete(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
          'Content-Type': 'application/json',
        },
        body: json.encode({'current_password': password}),
      );
      
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        messenger.showSnackBar(SnackBar(content: Text(responseData['message']), backgroundColor: Colors.green));

        await AuthService().clearSession();
        navigator.pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);

      } else {
        messenger.showSnackBar(SnackBar(content: Text(responseData['message']), backgroundColor: Colors.red));
      }

    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }
}