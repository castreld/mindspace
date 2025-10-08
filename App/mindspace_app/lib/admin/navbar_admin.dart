import 'package:flutter/material.dart';

class NavbarAdmin extends StatelessWidget implements PreferredSizeWidget {
  const NavbarAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 1,
      title: const Text(
        "Admin Dashboard",
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black54),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.black54),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
