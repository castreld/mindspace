import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mindspace_app/animated_background.dart';
import 'package:mindspace_app/auth/login.dart';
import 'package:mindspace_app/auth/splash_screen.dart';
import 'package:mindspace_app/auth/suspended_page.dart';
import 'package:mindspace_app/kontak_page.dart';
import 'package:mindspace_app/models/user.dart';
import 'package:mindspace_app/routes.dart';
import 'package:mindspace_app/services/admin_service.dart';
import 'package:mindspace_app/services/auth_service.dart';
import 'package:mindspace_app/services/booking_service.dart';
import 'package:mindspace_app/services/chat_service.dart';
import 'package:mindspace_app/therapist/therapist.dart';
import 'package:mindspace_app/therapist/therapist_detail.dart';
import 'package:mindspace_app/therapist_dashboard/register.dart';
import 'package:mindspace_app/widgets/bottom_nav_bar.dart';
import 'package:mindspace_app/admin/dashboard_adminn.dart';
import 'package:mindspace_app/admin/admin_mobile_block.dart';
import 'package:mindspace_app/user/dashboard.dart';
import 'package:provider/provider.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/footer.dart';
import 'navigation.dart';
import 'auth/register.dart';


Future<void> main() async {
  await initializeDateFormatting('id_ID');
  Intl.defaultLocale = 'id_ID';

  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
    };

    AuthService().init();

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthService()),
          Provider(create: (context) => BookingService()),
          Provider(create: (context) => ChatService()),
          Provider(create: (context) => AdminService()),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
  debugPrint('==== runZonedGuarded caught error ====', wrapWidth: 120);
  debugPrint(error.toString(), wrapWidth: 120);
  debugPrint(stack.toString(), wrapWidth: 120);
  });
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Mindspace',
      home: const AuthGate(),
      onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.home:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case AppRoutes.register:
              return MaterialPageRoute(builder: (_) => const RegisterForm());
            case AppRoutes.login:
              return MaterialPageRoute(builder: (_) => const LoginForm());
            case AppRoutes.dashboard:
              return MaterialPageRoute(builder: (_) => const MainDashboard());
            case AppRoutes.therapistPage:
              if (AuthService().isLoggedIn) {
                return MaterialPageRoute(builder: (_) => const TherapistPage());
              } else {
                return MaterialPageRoute(builder: (_) => const LoginForm());
              }
            case AppRoutes.adminDashboard:
              return MaterialPageRoute(
                  builder: (_) => const DashboardAdminPage());
            case AppRoutes.suspended:
              return MaterialPageRoute(builder: (_) => const SuspendedPage());
            case AppRoutes.kontak:
              return MaterialPageRoute(builder: (_) => const KontakPage());
            case AppRoutes.therapistDetail:
              final therapistId = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TherapistDetailPage(therapistId: therapistId),
              );
            default:
              return MaterialPageRoute(builder: (_) => const HomePage());
          }
      },
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color(0xFF5B3F5B)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final AuthService _auth;
  late final VoidCallback _authExternalListener;

  @override
  void initState() {
    super.initState();
    _auth = context.read<AuthService>();
    _authExternalListener = () {
      final isLoggedIn = _auth.isLoggedIn;
      debugPrint('AuthGate(external): received auth change, isLoggedIn=$isLoggedIn');
      if (!isLoggedIn) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
      }
    };
    _auth.addListener(_authExternalListener);
  }

  @override
  void dispose() {
    try {
      _auth.removeListener(_authExternalListener);
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    debugPrint(
        'AuthGate.build: building, isLoading=${authService.isLoading}, isLoggedIn=${authService.isLoggedIn}, currentUser=${authService.currentUser?.username}');

    // 1. Show splash screen while Auth-Service is initializing
    if (authService.isLoading) {
      return const SplashScreen();
    }

    // 2. Auth-Service is done, check if user is logged in
    if (authService.isLoggedIn) {
      final user = authService.currentUser;
      
      // This 'else' (user == null) should rarely happen, but SplashScreen is safer
      if (user == null) { 
         return const SplashScreen(); 
      }

      // 3. Check for suspension
      if (user.suspendedUntil != null && 
          user.suspendedUntil!.isAfter(DateTime.now())) {
        
        if (ModalRoute.of(context)?.settings.name == AppRoutes.suspended) {
          return const SuspendedPage();
        }
        
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppRoutes.suspended, 
            (route) => false
          );
        });
        
        return const SplashScreen(); // Show splash while redirecting
      }
  
      // 4. Check for Admin role and platform
      if (user.role == 'admin') {
        // Check if on a mobile device (not web)
        final bool isMobile = !kIsWeb && (Theme.of(context).platform == TargetPlatform.android || Theme.of(context).platform == TargetPlatform.iOS);
        
        if (isMobile) {
          return const AdminMobileBlockPage();
        } else {
          return const DashboardAdminPage();
        }
      } 
      
      // 5. Normal user
      else {
        return const MainDashboard();
      }
    } 
    
    // 6. Not logged in
    else {
      return const HomePage();
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentRoute = AppRoutes.home;
  bool _isRouteInitialized = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isRouteInitialized) {
      _currentRoute = ModalRoute.of(context)?.settings.name ?? AppRoutes.home;
      _isRouteInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<AuthService>().currentUser;
    const double mobileBreakpoint = 850;
    final bool isMobile = MediaQuery.of(context).size.width < mobileBreakpoint;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        user: currentUser,
        showNavButtonsAsActions: !isMobile,
      ),
      drawer: const _AppDrawer(),
      body: Stack(
        children: [
          const AnimatedGradientBackground(),
          const CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              HeroSection(),
              ServicesSection(),
              FaqSection(),
              if (kIsWeb) SliverToBoxAdapter(child: FooterSection()),
            ],
          ),
        ],
      ),
      bottomNavigationBar: isMobile 
      ? AppBottomNavigationBar(currentRoute: _currentRoute)
      : null,
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

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 1200;

    final children = [
      Expanded(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: isSmallScreen
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Selamat Datang\ndi Mindspace",
                textAlign: isSmallScreen ? TextAlign.center : TextAlign.left,
                style: TextStyle(
                  fontSize: isSmallScreen ? 48 : 70,
                  color: const Color.fromARGB(255, 244, 179, 51),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "\u201cYour Safe Place To Be Heard\u201d",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset('assets/illustration1.png', fit: BoxFit.contain),
        ),
      ),
    ];

    return SliverToBoxAdapter(
      child: Container(
        height: screenSize.height,
        width: screenSize.width,
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        child: isSmallScreen
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
      ),
    );
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: const Wrap(
          spacing: 40,
          runSpacing: 40,
          alignment: WrapAlignment.center,
          children: [
            ServiceCard(
              imagePath: 'assets/stock2.jpg',
              title: "Psikolog Kesehatan Mental",
              description:
                  "Membantu mengatasi masalah\nemosional, perilaku, dan mental",
            ),
            ServiceCard(
              imagePath: 'assets/stock1.jpg',
              title: "Psikolog Rehabilitasi",
              description: "Membantu proses pemulihan\ndan adaptasi kembali",
            ),
            ServiceCard(
              imagePath: 'assets/stock2.jpg',
              title: "Psikolog Interpersonal",
              description:
                  "Membantu meningkatkan kualitas\nhubungan dengan orang lain",
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const ServiceCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 23, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: Column(
          children: [
            const Text(
              "Frequently Asked Questions",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 244, 179, 51),
                fontSize: 33,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Beberapa orang mengajukan pertanyaan ini",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 27),
            ),
            const SizedBox(height: 100),
            const Wrap(
              spacing: 60,
              runSpacing: 40,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                FaqItem(
                  question: "Aman ga sih?",
                  answer:
                      "Mindspace tentunya aman, karena semua terapis sudah kami uji terlebih dahulu.",
                ),
                FaqItem(
                  question: "Apa Manfaatnya?",
                  answer:
                      "Mindspace memberikan wadah untuk pengguna kami merasa lebih baik, tentunya dengan terapis kami yang profesional.",
                ),
                FaqItem(
                  question: "Buka 24 Jam gak?",
                  answer:
                      "Tentunya Mindspace buka selama 24 jam tergantung jadwal dari Psikolog ya.",
                ),
                FaqItem(
                  question: "Jadwal bisa dibatalkan?",
                  answer:
                      "Tentunya bisa dong, maksimal dalam kurun waktu kurang dari 24 Jam.",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const FaqItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.black, size: 35),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}