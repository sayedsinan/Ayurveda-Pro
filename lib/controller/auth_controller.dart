import 'dart:convert';

import 'package:ayurveda_app/model/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> login(Login user) async {
    final baseUrl = dotenv.env['BASE_URL'] ?? "";
    final url = Uri.parse("${baseUrl}Login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": user.email, "password": user.password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final token = data["token"];
        print("Login successful, token: $token");

        // Get.offAll(() => const HomeScreen());
      } else {
        print(response.statusCode);
        Get.snackbar(
          "Error",
          "Invalid credentials",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
