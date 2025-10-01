import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mindspace_app/routes.dart';

import 'widgets/custom_app_bar.dart';
import 'widgets/footer.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: FormSection(),
          ),
          if (kIsWeb) const FooterSection(),
        ],
      ),
    );
  }
}

class FormSection extends StatefulWidget {
  const FormSection({super.key});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {

  final _formKey = GlobalKey<FormState>();

  final _usernameController   = TextEditingController();
  final _fullNameController   = TextEditingController();
  final _birthDateController  = TextEditingController();
  final _emailController      = TextEditingController();
  final _phoneController      = TextEditingController();
  final _passwordController   = TextEditingController();
  
  String? _sexDropdownValue; 
  String? _categoryDropdownController;
  static const List<String> flyer = ['yes', 'no'];
  String flyerOption = 'yes';
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }

    final Map<String, dynamic> data = {
      'username': _usernameController.text,
      'full_name': _fullNameController.text,
      'email': _emailController.text,
      'phone_number': _phoneController.text,
      'password': _passwordController.text,
      'birth_date': _birthDateController.text,
      'gender': _sexDropdownValue,
      'category': _categoryDropdownController,
      'flyer': flyerOption,
    };

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/register'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Daftar Berhasil!'))
        );
      } else {
        print('Validation Errors: ${response.body}');
        
        final errorData = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${errorData['message'] ?? 'Unknown error'}')),
          );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to connect to the server: $e')),
        );
    } finally {
      setState(() {
          _isLoading = false;
        });
    }
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    setState(() {
      _birthDateController.text = _picked.toString().split(" ")[0];
    });
    }

  void sexDropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _sexDropdownValue = selectedValue;
      });
    }
  }

  void categoryDropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _categoryDropdownController = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 247, 209),
            Color.fromARGB(255, 243, 229, 245),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.6]
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 200,
      ),
      child: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(20.0),
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
                'Buat Akun',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong masukan username anda!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_4_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong masukan nama lengkap anda!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-Mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong masukan e-mail anda!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              
              TextFormField(
                controller: _birthDateController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                  filled: true,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                  focusedBorder: OutlineInputBorder()
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong masukan tanggal lahir anda!';
                  }
                  return null;
                },
                readOnly: true,
                onTap: _selectDate,
              ),
              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                value: _sexDropdownValue,
                decoration: const InputDecoration(
                  labelText: 'Jenis Kelamin',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.wc_outlined),
                ),
                hint: const Text('Pilih Jenis Kelamin'),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: 'pria', child: Text("Pria")),
                  DropdownMenuItem(value: 'wanita', child: Text("Wanita")),
                ],
                onChanged: sexDropdownCallback,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong pilih jenis kelamin anda!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone_android_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong masukan nomor telepon anda!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                value: _categoryDropdownController,
                decoration: const InputDecoration(
                  labelText: 'Kategori Klien',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.wc_outlined),
                ),
                hint: const Text('Pilih Kategori Klien'),
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: 'Umum', child: Text("Umum")),
                  DropdownMenuItem(value: 'Mahasiswa Aktif Unpad', child: Text("Mahasiswa Aktif Unpad")),
                  DropdownMenuItem(value: 'Dosen / Tenaga Kependidikan Unpad', child: Text("Dosen / Tenaga Kependidikan Unpad")),
                ],
                onChanged: categoryDropdownCallback,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong pilih kategori anda!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.key_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong masukan password anda!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              Text(
                "Apakah anda bersedia menerima flyer edukasi seputar psikologi satu kali setiap bulan?",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: const Text('Iya'),
                    leading: Radio(
                      value: flyer[0], 
                      groupValue: flyerOption, 
                      onChanged: (value) {
                        setState(() {
                          flyerOption = value.toString();
                        });
                      }
                    ),
                  ),
                  ListTile(
                    title: const Text('Tidak'),
                    leading: Radio(
                      value: flyer[1], 
                      groupValue: flyerOption, 
                      onChanged: (value) {
                        setState(() {
                          flyerOption = value.toString();
                        });
                      }
                      
                    ),
                  ),
                ],
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: const Text(
                    "Sudah punya akun? Masuk",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC89E25),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: _isLoading ? const CircularProgressIndicator(color: Colors.white,) : const Text("Daftar!"),
              )
            ],
          ),
          ),

        ),
      ),
    );
  }
}