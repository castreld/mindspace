import 'package:flutter/material.dart';
import 'package:mindspace_app/routes.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final String currentRoute;

  const AppBottomNavigationBar({super.key, required this.currentRoute});

  int _calculateSelectedIndex(String routeName) {
    if (routeName == AppRoutes.home) {
      return 0;
    } else if (routeName == AppRoutes.therapistPage) {
      return 1;
    }
    // Add other routes here if needed
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.therapistPage, (route) => false);
        break;
      case 2:
        // Handle Kontak navigation
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          activeIcon: Icon(Icons.people),
          label: 'Psikolog',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_phone_outlined),
          activeIcon: Icon(Icons.contact_phone),
          label: 'Kontak',
        ),
      ],
      currentIndex: _calculateSelectedIndex(currentRoute),
      selectedItemColor: const Color(0xFFC89E25),
      onTap: (index) => _onItemTapped(index, context),
    );
  }
}