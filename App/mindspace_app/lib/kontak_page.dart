import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mindspace_app/animated_background.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/routes.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/widgets/bottom_nav_bar.dart';
import 'package:mindspace_app/widgets/custom_app_bar.dart';
import 'package:mindspace_app/widgets/footer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class KontakPage extends StatefulWidget {
  const KontakPage({super.key});

  @override
  State<KontakPage> createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {
  String _currentRoute = AppRoutes.kontak;
  bool _isRouteInitialized = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isRouteInitialized) {
      _currentRoute = ModalRoute.of(context)?.settings.name ?? AppRoutes.kontak;
      _isRouteInitialized = true;
    }
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuka link: $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final currentUser = authService.currentUser;
    const double mobileBreakpoint = 850;
    final bool isMobile = MediaQuery.of(context).size.width < mobileBreakpoint;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        user: currentUser,
        showNavButtonsAsActions: !isMobile,
      ),
      drawer: isMobile ? const _AppDrawer() : null, 
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const AnimatedGradientBackground(),
          CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildContactContent(context),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar:
          isMobile ? AppBottomNavigationBar(currentRoute: _currentRoute) : null,
    );
  }

  Widget _buildContactContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: const Color(0xFFFFF8F0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Butuh Bantuan?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Tim kami siap membantu Anda dengan pertanyaan atau masalah apa pun yang Anda hadapi. Silakan hubungi kami melalui salah satu saluran di bawah ini.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildContactCard(
          context: context,
          icon: FontAwesomeIcons.whatsapp,
          title: 'WhatsApp',
          subtitle: '+62 821-3030-4142',
          color: Colors.green.shade700,
          onTap: () {
            _launchUrl(context, 'https://wa.me/6282130304142');
          },
        ),
        const SizedBox(height: 16),
        _buildContactCard(
          context: context,
          icon: Icons.email_outlined,
          title: 'Email',
          subtitle: 'support@mindspace.org',
          color: Colors.blue.shade700,
          onTap: () {
            _launchUrl(
              context,
              'mailto:support@mindspace.org?subject=Bantuan%20Aplikasi%20Mindspace',
            );
          },
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      color: const Color(0xFFFFF8F0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap.call,
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF5B3F5B)),
            child: Text(
              'Mindspace',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _DrawerItem('Beranda', Icons.home, () {
            Navigator.pushNamed(context, AppRoutes.home);
          }),
          _DrawerItem('Terapis', Icons.people, () {
            Navigator.pushNamed(context, AppRoutes.therapistPage);
          }),
          _DrawerItem('Jadwal', Icons.calendar_today, () {
             Navigator.pushNamed(context, AppRoutes.dashboard);
          }),
          _DrawerItem('Kontak', Icons.contact_phone, () {
            Navigator.pushNamed(context, AppRoutes.kontak);
          }),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerItem(this.title, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      onTap: onTap,
    );
  }
}