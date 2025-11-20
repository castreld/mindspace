import 'package:flutter/material.dart';
import 'package:mindspace_app/config.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/routes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:mindspace_app/services/auth_service.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final User? user;
  final bool showNavButtonsAsActions;

  const CustomAppBar({
    super.key,
    this.user,
    this.showNavButtonsAsActions = true,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  AuthService? _authService;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuka link: $url')),
        );
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_authService == null) {
      _authService = context.read<AuthService>();
    }
  }

  void _handleLogout() {
    final authService = _authService;
    if (authService != null) {
      Navigator.of(context).popUntil((route) => route is! PopupRoute);
      Future.delayed(const Duration(milliseconds: 100), () {
        authService.clearSession();
      });
    }
  }

  Widget _buildDownloadButton() {
    if (!kIsWeb) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton<String>(
      icon: const Icon(Icons.download_for_offline, color: Colors.white),
      tooltip: 'Download Aplikasi',
      offset: const Offset(0, 50),
      onSelected: (value) {
        if (value == 'android') {
          _launchURL('https://mindspace.asia/downloads/mindspace.apk');
        } else if (value == 'windows') {
          _launchURL('https://mindspace.asia/downloads/mindspace_installer.exe');
        }
      },
      itemBuilder: (BuildContext popupContext) {
        return [
          const PopupMenuItem<String>(
            value: 'android',
            child: ListTile(
              leading: Icon(Icons.android),
              title: Text('Download .apk (Android)'),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'windows',
            child: ListTile(
              leading: Icon(Icons.window),
              title: Text('Download .exe (Windows)'),
            ),
          ),
        ];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 850) {
          return _buildMobileAppBar(context);
        } else {
          return _buildDesktopAppBar(context);
        }
      },
    );
  }

  Widget _buildUserProfileDropdown(BuildContext context, {bool isMobile = false}) {
    if (widget.user == null) {
      return const SizedBox.shrink();
    }

    final displayName = widget.user!.username ?? widget.user!.fullName;
    final firstChar = displayName.isNotEmpty 
        ? displayName.substring(0, 1).toUpperCase() 
        : '?';

    final Widget avatarWidget = CircleAvatar(
      backgroundColor: Colors.white.withOpacity(0.8),
      backgroundImage: widget.user!.profilePicture != null
          ? NetworkImage('${AppConfig.backendBaseUrl}/api/${widget.user!.profilePicture!}')
          : null,
      child: widget.user!.profilePicture == null
          ? Text(
              firstChar,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          : null,
    );

    final Widget dropdownChild = isMobile
        ? Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: avatarWidget,
          )
        : Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                avatarWidget,
                const SizedBox(width: 10),
                Text(
                  displayName,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          );

    return PopupMenuButton<String>(
      offset: const Offset(0, 50),
      onSelected: (value) {
        if (value == 'dashboard') {
          Navigator.pushNamed(context, AppRoutes.dashboard);
        } else if (value == 'admin_dashboard') {
          Navigator.pushNamed(context, AppRoutes.adminDashboard);
        } else if (value == 'logout') {
          _handleLogout();
        }
      },
      itemBuilder: (BuildContext popupContext) {
        List<PopupMenuEntry<String>> menuItems = [
          const PopupMenuItem<String>(
            value: 'dashboard',
            child: ListTile(
              leading: Icon(Icons.dashboard_outlined),
              title: Text('Dashboard'),
            ),
          ),
        ];
        if (widget.user != null && widget.user!.role == 'admin') {
          menuItems.add(const PopupMenuItem<String>(
            value: 'admin_dashboard',
            child: ListTile(
              leading: Icon(Icons.admin_panel_settings_outlined),
              title: Text('Admin Dashboard'),
            ),
          ));
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
      child: dropdownChild,
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
      leading: widget.user != null
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,
      actions: <Widget>[
        _buildDownloadButton(),
        widget.user != null
            ? _buildUserProfileDropdown(context, isMobile: true)
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
        if (widget.showNavButtonsAsActions) ...[
          _AppBarTextButton(
              'Home', () => Navigator.pushNamed(context, AppRoutes.home)),
          _AppBarTextButton('Psikolog',
              () => Navigator.pushNamed(context, AppRoutes.therapistPage)),
          _AppBarTextButton('Kontak', 
          () => Navigator.pushNamed(context, AppRoutes.kontak)),
          const SizedBox(width: 20),
        ],
        _buildDownloadButton(),
        widget.user != null
            ? _buildUserProfileDropdown(context)
            : _buildAuthButtons(context),
      ],
    );
  }
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