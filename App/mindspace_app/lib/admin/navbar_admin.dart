import 'package:flutter/material.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/routes.dart'; 

class NavbarAdmin extends StatelessWidget implements PreferredSizeWidget {
  final User user;
  final VoidCallback onLogout;

  const NavbarAdmin({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1E88E5),
      elevation: 1,
      title: const Text(
        "Dasbor Admin",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {},
        ),
        
        Builder(
          builder: (menuContext) {
            return PopupMenuButton<String>(
              onSelected: (value) {
                
                if (value == 'home') {
                  Navigator.pushNamed(menuContext, AppRoutes.home);
                } else if (value == 'dashboard') {
                } else if (value == 'logout') {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    onLogout();
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: user.profilePicture != null
                          ? NetworkImage('http://127.0.0.1:8000/api/${user.profilePicture!}')
                          : null,
                      child: user.profilePicture == null
                          ? Text(user.username.substring(0, 1).toUpperCase())
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(user.username, style: const TextStyle(color: Colors.white)),
                    const Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ),
              // These are the dropdown items
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'home',
                  child: ListTile(
                    leading: Icon(Icons.home_outlined),
                    title: Text('Beranda'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'dashboard',
                  child: ListTile(
                    leading: Icon(Icons.dashboard_outlined),
                    title: Text('Dasbor'),
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.red.shade700),
                    title: Text('Keluar', style: TextStyle(color: Colors.red.shade700)),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}