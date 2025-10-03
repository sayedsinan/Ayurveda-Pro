import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
      
          Image.asset(
            'assets/splash_background.png',
            fit: BoxFit.cover,
          ),
          
          Container(
            color: Colors.black.withOpacity(0.3),
          ),

          Center(
            child: Image.asset(
              'assets/logo.png',
              width: 120,
              height: 120,
            ),
          ),
        ],
      ),
    );
  }
}