import 'package:flutter/material.dart';

class SidebarAdmin extends StatelessWidget {
  final Function(String) onMenuSelected;
  final String selectedMenu;

  const SidebarAdmin({
    super.key,
    required this.onMenuSelected,
    required this.selectedMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: const Color(0xFFF4F6FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const DrawerHeader(
          //   decoration: BoxDecoration(color: Color(0xFF1E88E5)),
          //   child: Center(
          //     child: Text(
          //       "Mind Space Admin",
          //       style: TextStyle(color: Colors.white, fontSize: 18),
          //     ),
          //   ),
          // ),
          buildMenuItem("Dashboard Utama", Icons.dashboard),
          buildMenuItem("Kelola Psikolog", Icons.people),
          buildMenuItem("Laporan", Icons.insert_chart),
        ],
      ),
    );
  }

  Widget buildMenuItem(String title, IconData icon) {
    final bool active = selectedMenu == title;
    return ListTile(
      leading: Icon(icon, color: active ? Colors.blue : Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          color: active ? Colors.blue : Colors.black,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () => onMenuSelected(title),
    );
  }
}
