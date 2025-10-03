import 'package:ayurveda_app/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/splash_background.png', fit: BoxFit.cover),

          Container(color: Colors.black.withOpacity(0.3)),

          Center(
            child: Image.asset('assets/logo.png', width: 120, height: 120),
          ),
        ],
      ),
    );
  }
}
