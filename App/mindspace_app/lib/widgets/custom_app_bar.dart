import 'package:flutter/material.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User? user;
  final VoidCallback? onLogout;

  const CustomAppBar({super.key, this.user, this.onLogout});

  @override
  Widget build(BuildContext context) {
    const double mobileBreakpoint = 850;
    final bool isMobile = MediaQuery.of(context).size.width < mobileBreakpoint;
    return isMobile ? _buildMobileAppBar(context) : _buildDesktopAppBar(context);
  }

  Widget _buildUserProfileDropdown(BuildContext context) {
    return Builder(
      builder: (menuContext) {
        return PopupMenuButton<String>(
          onSelected: (value) {
          
            if (value == 'dashboard') {
              Navigator.pushNamed(menuContext, AppRoutes.dashboard);
            } else if (value == 'admin_dashboard') {
              Navigator.pushNamed(menuContext, AppRoutes.adminDashboard);
            } else if (value == 'logout') {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                onLogout?.call();
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  backgroundImage: user!.profilePicture != null
                      ? NetworkImage('http://127.0.0.1:8000/api/${user!.profilePicture!}')
                      : null,
                  child: user!.profilePicture == null
                      ? Text(
                          user!.username.substring(0, 1).toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : null,
                ),
                const SizedBox(width: 10),
                Text(
                  user!.username,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
          itemBuilder: (BuildContext context) {
            List<PopupMenuEntry<String>> menuItems = [
              const PopupMenuItem<String>(
                value: 'dashboard',
                child: ListTile(
                  leading: Icon(Icons.dashboard_outlined),
                  title: Text('Dashboard'),
                ),
              ),
            ];

            if (user != null && user!.role == 'admin') {
              menuItems.add(
                const PopupMenuItem<String>(
                  value: 'admin_dashboard',
                  child: ListTile(
                    leading: Icon(Icons.admin_panel_settings_outlined),
                    title: Text('Admin Dashboard'),
                  ),
                ),
              );
            }

            menuItems.addAll([
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Log out', style: TextStyle(color: Colors.red)),
                ),
              ),
            ]);

            return menuItems;
          },
        );
      },
    );
  }

  Widget _buildAuthButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC89E25),
                foregroundColor: Colors.black),
            child: const Text('Daftar'),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE9B335),
                foregroundColor: Colors.black),
            child: const Text('Masuk'),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildMobileAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: const Color(0xFF5B3F5B),
  title: const Text('Mindspace',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 30),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: <Widget>[
        _AppBarTextButton(
            'Home', () => Navigator.pushNamed(context, AppRoutes.home)),
        _AppBarTextButton(
            'Psikolog', () => Navigator.pushNamed(context, AppRoutes.therapistPage)),
        _AppBarTextButton('Kontak', () {}),
        const SizedBox(width: 20),
        user != null
            ? _buildUserProfileDropdown(context)
            : _buildAuthButtons(context),
      ],
    );
  }

  PreferredSizeWidget _buildDesktopAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: const Color(0xFF5B3F5B),
      automaticallyImplyLeading: false,
      title: const Text('Mindspace',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
      actions: <Widget>[
        _AppBarTextButton(
            'Home', () => Navigator.pushNamed(context, AppRoutes.home)),
        _AppBarTextButton('Psikolog', () => Navigator.pushNamed(context, AppRoutes.therapistPage)),
        _AppBarTextButton('Kontak', () {}),
        const SizedBox(width: 20),
        user != null
            ? _buildUserProfileDropdown(context)
            : _buildAuthButtons(context),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

class _AppBarTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const _AppBarTextButton(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}