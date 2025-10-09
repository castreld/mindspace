import 'package:flutter/material.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/routes.dart'; 
import 'navbar_admin.dart';
import 'admin_sidebar.dart';
import 'kelola_psikolog.dart';

class DashboardAdminPage extends StatefulWidget {
  const DashboardAdminPage({super.key});

  @override
  State<DashboardAdminPage> createState() => _DashboardAdminPageState();
}

class _DashboardAdminPageState extends State<DashboardAdminPage> {
  String _selectedMenu = "Dashboard Utama";

  Future<void> _logout() async {
    await AuthService().clearSession();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final User user = args['user'];

    return Scaffold(
      appBar: NavbarAdmin(user: user, onLogout: _logout),
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          SidebarAdmin(
            onMenuSelected: (menu) {
              setState(() => _selectedMenu = menu);
            },
            selectedMenu: _selectedMenu,
          ),

          Expanded(
            child: Container(
              color: const Color(0xFFF8FAFF),
              padding: const EdgeInsets.all(16),
              child: _buildPageContent(),
            ),
          ),
        ],
      ),
    );
  }

  // Menentukan halaman berdasarkan menu aktif
  Widget _buildPageContent() {
    switch (_selectedMenu) {
      case "Dashboard Utama":
        return const Center(
          child: Text(
            "Ini halaman Dashboard Utama",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );

      case "Kelola Psikolog":
        return const KelolaPsikologPage();

      case "Kelola Pengguna":
        return const Center(
          child: Text(
            "Halaman Kelola Pengguna (dalam pengembangan)",
            style: TextStyle(fontSize: 16),
          ),
        );

      case "Laporan":
        return const Center(
          child: Text(
            "Halaman Laporan (dalam pengembangan)",
            style: TextStyle(fontSize: 16),
          ),
        );

      default:
        return Center(
          child: Text(
            "Halaman: $_selectedMenu",
            style: const TextStyle(fontSize: 18),
          ),
        );
    }
  }
}
