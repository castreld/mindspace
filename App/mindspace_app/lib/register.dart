import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  TextEditingController _dateController = TextEditingController();
  static const List<String> flyer = ['yes', 'no'];
  String flyerOption = flyer[0];
  String? _sexDropdownValue, _categoryDropdownController;
  bool _obscurePassword = true;

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
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.alternate_email),
                ),
              ),
              const SizedBox(height: 15),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_4_outlined),
                ),
              ),
              const SizedBox(height: 15),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-Mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 15),
              
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                  filled: true,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                  focusedBorder: OutlineInputBorder()
                ),
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
              ),
              const SizedBox(height: 15),

              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone_android_outlined),
                ),
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
              ),
              const SizedBox(height: 15),

              TextFormField(
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC89E25),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Daftar!"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (_picked != null){
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
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
}