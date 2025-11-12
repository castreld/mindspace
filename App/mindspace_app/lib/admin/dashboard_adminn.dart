import 'package:flutter/material.dart';
import 'package:mindspace_app/admin/admin_landing_dashboard.dart';
import 'package:mindspace_app/admin/kelola_banding.dart';
import 'package:mindspace_app/admin/kelola_pengguna.dart';
import 'package:mindspace_app/admin/report_management_page.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/routes.dart'; 
import 'navbar_admin.dart';
import '../navigation.dart';
import 'admin_sidebar.dart';
import 'kelola_psikolog.dart';

class DashboardAdminPage extends StatefulWidget {
  const DashboardAdminPage({super.key});

  @override
  State<DashboardAdminPage> createState() => _DashboardAdminPageState();
}

class _DashboardAdminPageState extends State<DashboardAdminPage> {
  String _selectedMenu = "Dashboard Utama";
  final User user = AuthService().currentUser!;

  Future<void> _logout() async {
    
    AuthService().clearSession();
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
         
         navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
      });
    }
  }
  
  void _onMenuSelected(String menu) {
    setState(() {
      _selectedMenu = menu;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: NavbarAdmin(user: user, onLogout: _logout),
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          SidebarAdmin(
            onMenuSelected: _onMenuSelected,
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

  Widget _buildPageContent() {
    switch (_selectedMenu) {
      case "Dashboard Utama":
        return AdminLandingDashboard(onMenuSelected: _onMenuSelected);

      case "Kelola Psikolog":
        return const KelolaPsikologPage();

      case "Kelola Pengguna":
        return const KelolaPenggunaPage();

      case "Laporan":
        return const ReportManagementPage();
      
      case "Kelola Banding":
        return const KelolaBandingPage();

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