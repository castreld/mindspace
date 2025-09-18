import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const double mobileBreakpoint = 850;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < mobileBreakpoint;
        return isMobile
            ? _buildMobileAppBar(context)
            : _buildDesktopAppBar(context);
      },
    );
  }

  PreferredSizeWidget _buildMobileAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: const Color(0xFF5B3F5B),
      elevation: 0,
      title: const Text(
        'Mindspace',
        style: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 30),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC89E25),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text('Daftar', style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            // LOGIN LOGIC DI SINI BOSSSSS
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE9B335),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text('Masuk', style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(width: 15),
      ],
    );
  }

  PreferredSizeWidget _buildDesktopAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: const Color(0xFF5B3F5B),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text(
        'Mindspace',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        _AppBarTextButton('Home', () {
          Navigator.pushNamed(context, '/');
        }),
        _AppBarTextButton('Psikolog', () {
          // TERAPIS DI SINI
        }),
        _AppBarTextButton('Jadwal', () {
          // JADWAL DI SINI
        }),
        _AppBarTextButton('Kontak', () {
          // KONTAK DI SINIIIIII
        }),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC89E25),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text('Daftar', style: TextStyle(fontSize: 20)),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            // ANOTHER LOGIN LOGIC HERE
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE9B335),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text('Masuk', style: TextStyle(fontSize: 20)),
        ),
        const SizedBox(width: 20),
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
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}