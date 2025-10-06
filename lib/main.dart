import 'package:ayurveda_app/controller/auth_controller.dart';
import 'package:ayurveda_app/controller/patient_controller.dart';
import 'package:ayurveda_app/services/token_services.dart';
import 'package:ayurveda_app/view/home_page.dart';
import 'package:ayurveda_app/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  Get.put(AuthController());
  Get.put(PatientController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: TokenService.isLoggedIn() ? HomePage() : SplashScreen(),
    );
  }
}
