import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mindspace_app/animated_background.dart';
import 'package:mindspace_app/routes.dart';
import 'package:mindspace_app/config.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: GlobalKey<ScaffoldState>(),
        appBar: const CustomAppBar(),
        drawer: const _AppDrawer(),
        body: Stack(
          children: [
            const AnimatedGradientBackground(),
            const CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: FormSection(),
                ),
                if (kIsWeb) SliverToBoxAdapter(child: FooterSection()),
              ],
            )
          ],
        ));
  }
}

class FormSection extends StatefulWidget {
  const FormSection({super.key});

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

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

  Future<void> _showErrorDialog(String title, String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _translateFieldName(String field) {
    switch (field) {
      case 'username':
        return 'Username';
      case 'full_name':
        return 'Nama Lengkap';
      case 'email':
        return 'Email';
      case 'password':
        return 'Password';
      case 'birth_date':
        return 'Tanggal Lahir';
      case 'gender':
        return 'Jenis Kelamin';
      case 'phone_number':
        return 'Nomor Telepon';
      case 'category':
        return 'Kategori Klien';
      case 'flyer':
        return 'Flyer';
      default:
        return field;
    }
  }

  String _translateErrorMessage(String message) {
    if (message.contains('must be a valid email address')) {
      return 'harus berupa alamat email yang valid.';
    } else if (message.contains('has already been taken')) {
      return 'sudah digunakan.';
    } else if (message.contains('must be at least 8 characters')) {
      return 'harus memiliki setidaknya 8 karakter.';
    } else if (message.contains('The selected gender is invalid')) {
      return 'Jenis kelamin yang dipilih tidak valid.';
    } else if (message.contains('The selected category is invalid')) {
      return 'Kategori yang dipilih tidak valid.';
    } else if (message.contains('The selected flyer is invalid')) {
      return 'Pilihan flyer tidak valid.';
    } else if (message.contains('The username field is required')) {
      return 'kolom username wajib diisi.';
    } else if (message.contains('The full name field is required')) {
      return 'kolom nama lengkap wajib diisi.';
    } else if (message.contains('The email field is required')) {
      return 'kolom email wajib diisi.';
    } else if (message.contains('The password field is required')) {
      return 'kolom password wajib diisi.';
    } else if (message.contains('The birth date field is required')) {
      return 'kolom tanggal lahir wajib diisi.';
    } else if (message.contains('The gender field is required')) {
      return 'kolom jenis kelamin wajib diisi.';
    } else if (message.contains('The phone number field is required')) {
      return 'kolom nomor telepon wajib diisi.';
    } else if (message.contains('The category field is required')) {
      return 'kolom kategori wajib diisi.';
    }
    return message;
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

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
        Uri.parse('${AppConfig.backendBaseUrl}/api/register'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Daftar Berhasil!'), backgroundColor: Colors.green));
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pushReplacementNamed(context, '/login');
        });
      } else {
        final errorData = jsonDecode(response.body);
        final StringBuffer errorMessage = StringBuffer();

        if (errorData is Map<String, dynamic>) {
          errorData.forEach((key, value) {
            if (value is List && value.isNotEmpty) {
              final translatedFieldName = _translateFieldName(key);
              for (String msg in value) {
                errorMessage.writeln('- $translatedFieldName ${_translateErrorMessage(msg)}');
              }
            } else if (value is String) {
              errorMessage.writeln('- ${_translateErrorMessage(value)}');
            }
          });
        } else {
          errorMessage.writeln('Terjadi kesalahan yang tidak diketahui.');
        }

        _showErrorDialog('Registrasi Gagal', errorMessage.toString());
      }
    } catch (e) {
      _showErrorDialog('Koneksi Gagal', 'Tidak dapat terhubung ke server. Mohon periksa koneksi internet Anda.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _birthDateController.text = picked.toString().split(" ")[0];
      });
    }
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 200,
      ),
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Container(
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
                            focusedBorder: OutlineInputBorder()),
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
                      const Text(
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
                                }),
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
                                }),
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
            );
          },
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