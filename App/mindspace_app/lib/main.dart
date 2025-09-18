import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_app_bar.dart';
import 'widgets/footer.dart';
import 'register.dart';

void main() {
  runApp(const MyApp());
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
      title: 'Mindspace',
      routes: {
        '/': (context) => const HomePage(),
        '/register': (context) => const RegisterForm()
      },
      initialRoute: '/',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B3F5B)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The drawer requires a key on mobile to be opened programmatically.
      key: GlobalKey<ScaffoldState>(),
      // Here is our clean, reusable AppBar
      appBar: const CustomAppBar(),
      drawer: const _AppDrawer(),
      body: const CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          HeroSection(),
          ServicesSection(),
          FaqSection(),
          // Here is our clean, reusable Footer
          if (kIsWeb) FooterSection(),
        ],
      ),
    );
  }
}

// Widgets specific to the HomePage can remain here.
class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF5B3F5B),
            ),
            child: Text(
              'Mindspace',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _DrawerItem('Home', Icons.home, () {}),
          _DrawerItem('Terapis', Icons.people, () {}),
          _DrawerItem('Jadwal', Icons.calendar_today, () {}),
          _DrawerItem('Kontak', Icons.contact_phone, () {}),
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

// Other sections used only by the HomePage
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
                textAlign:
                    isSmallScreen ? TextAlign.center : TextAlign.left,
                style: TextStyle(
                  fontSize: isSmallScreen ? 48 : 70,
                  color: const Color.fromARGB(255, 244, 179, 51),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "“Your Safe Place To Be Heard”",
                textAlign:
                    isSmallScreen ? TextAlign.center : TextAlign.left,
                style: TextStyle(
                  fontSize: isSmallScreen ? 24 : 32,
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
          child: Image.asset(
            'assets/illustration1.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    ];

    return SliverToBoxAdapter(
      child: Container(
        height: screenSize.height,
        width: screenSize.width,
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 247, 209),
              Color.fromARGB(255, 243, 229, 245)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.3],
          ),
        ),
        child: isSmallScreen
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center, children: children)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center, children: children),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 247, 209),
              Color.fromARGB(255, 243, 229, 245)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.9],
          ),
        ),
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
              description:
                  "Membantu proses pemulihan\ndan adaptasi kembali",
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 247, 209),
              Color.fromARGB(255, 243, 229, 245),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
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
            const SizedBox(height: 70),
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

  const FaqItem({
    super.key,
    required this.question,
    required this.answer,
  });

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
                    fontSize: 25,
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
              style: const TextStyle(fontSize: 23, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}