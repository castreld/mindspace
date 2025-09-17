import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindspace',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B3F5B)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF5B3F5B),
        elevation: 0,
        title: const Text(
          'Mindspace',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // HOME LOGIC HERE
            },
            child: const Text('Home', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              // TERAPIS LOGIC HEREEEE
            },
            child: const Text('Terapis', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              // JADWAL LOGIC HERE BOSS
            },
            child: const Text('Jadwal', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              // KONTAK LOGIC HERE BOSS
            },
            child: const Text('Kontak', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          const SizedBox(width: 10),

          ElevatedButton(
            onPressed: () {
              // REGISTER LOGIC HERE BOSSSS
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC89E25),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Daftar', 
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 10),

          ElevatedButton(
            onPressed: () {
              // LOGIN LOGIC HERE BOSS
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE9B335),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Masuk',
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),

      body: CustomScrollView(
        slivers: [

          SliverToBoxAdapter(
            child: Container(
              height: screenHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 255, 247, 209), Color.fromARGB(255, 243, 229, 245)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.3]
                ),
              ),

              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(left: 180, bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      
                      children: <Widget>[
                        const Text(
                          "Selamat Datang\ndi Mindspace",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 70, 
                            color: Color.fromARGB(255, 244, 179, 51),
                            fontWeight: FontWeight.bold
                          ),
                        ),


                        const Text(
                          "“Your Safe Place To Be Heard”",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 180, bottom: 100),
                    child: Image(
                      image: AssetImage('assets/illustration1.png'),
                      width: 600,
                      height: 600,
                    ),
                  )
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 255, 247, 209), Color.fromARGB(255, 243, 229, 245)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.0, 0.9]
                ),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(left: 140),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,

                      children: <Widget>[

                        Container(
                          width: 400,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(12)
                          ),

                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            child: Image(
                            image: AssetImage('assets/stock2.jpg'),
                            fit: BoxFit.cover,
                          ),
                          ),
                        ),

                        Text(
                          "Psikolog Kesehatan Mental",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "Membantu mengatasi masalah\nemosional, perilaku, dan mental",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ), 
                  ),

                  Padding(
                    padding: EdgeInsets.only(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,

                      children: <Widget>[

                        Container(
                          width: 400,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(12)
                          ),

                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            child: Image(
                            image: AssetImage('assets/stock1.jpg'),
                            fit: BoxFit.cover,
                          ),
                          ),
                        ),

                        Text(
                          "Psikolog Rehabilitasi",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "Membantu mengatasi masalah\nemosional, perilaku, dan mental",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ), 
                  ),

                  Padding(
                    padding: EdgeInsets.only(right: 140),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,

                      children: <Widget>[

                        Container(
                          width: 400,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(12)
                          ),

                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            child: Image(
                            image: AssetImage('assets/stock2.jpg'),
                            fit: BoxFit.cover,
                          ),
                          ),
                        ),

                        Text(
                          "Psikolog Interpersonal",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "Membantu mengatasi masalah\nemosional, perilaku, dan mental",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ), 
                  )

                ],
              ),

            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 255, 247, 209), Color.fromARGB(255, 243, 229, 245)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),

              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 65),

                    child: Column(
                      children: [
                        Text(
                          "Frequently Asked Questions",
                          style: TextStyle(
                            color: Color.fromARGB(255, 244, 179, 51),
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),

                        Text(
                          "Beberapa orang mengajukan pertanyaan ini",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

            )
          ),

        ],
      ),
    );
  }
}