import 'package:flutter/material.dart';
import 'package:mindspace_app/animated_background.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          AnimatedGradientBackground(),
          Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: Image(
                image: AssetImage('assets/logo.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}