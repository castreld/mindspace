import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mindspace_app/animated_background.dart';
import 'package:mindspace_app/routes.dart';
import 'package:http/http.dart' as http;
import 'package:mindspace_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:mindspace_app/config.dart';
import '../models/user.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _canCheckBiometrics = false;
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthService>().debugBiometricStorage();
    _checkBiometrics();
    _checkForAuthCallback();
  }

  Future<void> _checkForAuthCallback() async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    if (!mounted) return;
    
    final uri = Uri.base;
    debugPrint('Current URL: $uri');
    debugPrint('Path: ${uri.path}');
    debugPrint('Query params: ${uri.queryParameters}');

    if (uri.path.contains('/auth/callback')) {
      final token = uri.queryParameters['token'];
      final userDataEncoded = uri.queryParameters['user'];
      
      debugPrint('Detected auth callback!');
      debugPrint('Token present: ${token != null}');
      debugPrint('User data present: ${userDataEncoded != null}');
      
      if (token != null && userDataEncoded != null) {
        try {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );

          final userJsonString = utf8.decode(base64.decode(userDataEncoded));
          final userJson = json.decode(userJsonString);
          final user = User.fromJson(userJson);
          
          debugPrint('User decoded: ${user.email}');

          await context.read<AuthService>().saveSession(user, token);
          
          debugPrint('Session saved, navigating to dashboard');

          if (mounted) {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.dashboard,
              (route) => false,
            );
          }
        } catch (e) {
          debugPrint('Error processing callback: $e');
          if (mounted) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login gagal: ${e.toString()}')),
            );
          }
        }
      }
    }
  }

  Future<void> _checkBiometrics() async {
    final authService = context.read<AuthService>();
    final isEnabled = await authService.isBiometricsEnabled;
    final canCheck = await authService.canCheckBiometrics();

    setState(() {
      _isBiometricAvailable = canCheck;
    });

    if (isEnabled && canCheck && mounted) {
       final success = await authService.loginWithBiometrics();
       if (success && mounted) {
         Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboard, (route) => false);
       }
    }
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

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('${AppConfig.backendBaseUrl}/api/login');
    final authService = context.read<AuthService>();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({
          'username': _usernameController.text,
          'password': _passwordController.text,
          'remember': _rememberMe,
        }),
      );

      if (!mounted) return;

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        final user = User.fromJson(responseData['user']);
        final token = responseData['access_token'];

        await authService.saveSession(user, token);

        if (_isBiometricAvailable && mounted) {
          final isAlreadyEnabled = await authService.isBiometricsEnabled;
          if (!isAlreadyEnabled) {
            await _showEnableBiometricsDialog(token);
          }
        }

        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.dashboard, (route) => false);
        }
      } else {
        _showErrorDialog('Login Gagal', 'Username atau password salah. Mohon periksa kembali detail Anda.');
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

  Future<void> _showEnableBiometricsDialog(String token) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aktifkan Login Biometrik?'),
          content: const Text(
            'Gunakan sidik jari atau wajah Anda untuk login lebih cepat di kemudian hari. '
            'Anda akan diminta untuk memverifikasi biometrik Anda sekarang.'
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Lain Kali'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Aktifkan'),
              onPressed: () async {
                Navigator.of(context).pop();

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                final success = await context.read<AuthService>().enableBiometrics(token);
                
                if (mounted) {
                  Navigator.of(context).pop();
                  
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login Biometrik berhasil diaktifkan!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Gagal mengaktifkan login biometrik. Pastikan Anda telah mengatur biometrik di perangkat Anda.'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 200,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
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
                    'Masuk',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username tidak boleh kosong';
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
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
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
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Ingat saya"),
                    value: _rememberMe,
                    onChanged: (newValue) {
                      setState(() {
                        _rememberMe = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      child: const Text(
                        "Belum punya akun? Daftar",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC89E25),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Masuk"),
                  ),
                  const SizedBox(height: 20),
                  Row(children: [
                     Expanded(child: Divider(color: Colors.grey.shade300)),
                     Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text("ATAU", style: TextStyle(color: Colors.grey.shade600))),
                     Expanded(child: Divider(color: Colors.grey.shade300)),
                  ]),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       InkWell(
                        onTap: () => context.read<AuthService>().loginWithGoogle(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset('assets/google_logo.png', width: 40, height: 40),
                        ),
                       ),
                       if (_isBiometricAvailable) ...[
                         const SizedBox(width: 20),
                         InkWell(
                           onTap: () async {
                             final success = await context.read<AuthService>().loginWithBiometrics();
                             if (success && mounted) {
                                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.dashboard, (route) => false);
                             } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Verifikasi Biometrik Gagal"))
                                );
                             }
                           },
                           child: Container(
                             padding: const EdgeInsets.all(8),
                             decoration: BoxDecoration(
                               border: Border.all(color: Colors.grey.shade300),
                               borderRadius: BorderRadius.circular(50),
                             ),
                             child: const Icon(Icons.fingerprint, size: 40, color: Color(0xFFC89E25)),
                           ),
                         ),
                       ],
                    ],
                  )
                ],
              ),
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