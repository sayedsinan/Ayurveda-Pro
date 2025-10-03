import 'dart:ui';

import 'package:ayurveda_app/controller/auth_controller.dart';
import 'package:ayurveda_app/model/user_model.dart';
import 'package:ayurveda_app/view/home_page.dart';
import 'package:ayurveda_app/view/widgets/custom_input_filed.dart';
import 'package:ayurveda_app/view/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/splash_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(color: Colors.transparent),
                  ),
                ),

                Center(
                  child: Image.asset('assets/logo.png', width: 80, height: 80),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32),

                    Text(
                      'Login Or Register To Book\nYour Appointments',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),

                    SizedBox(height: 32),

                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 8),

                    CustomInputFiled(
                      hintText: 'Enter your email',
                      controller: controller.emailController,
                    ),
                    SizedBox(height: 20),

                    // Password label
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 8),

                    CustomInputFiled(
                      hintText: 'Enter your password',
                      controller: controller.passwordController,
                    ),
                    SizedBox(height: 32),
                    MyButton(
                      text: "Login",
                      onPressed: () {
                        final email = controller.emailController.text.trim();
                        final password = controller.passwordController.text
                            .trim();
                        if (email.isEmpty || password.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Please enter email and password',
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                          );
                          return;
                        }
                        Get.offAll(()=>HomePage());
                      },
                    ),

                    Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0, left: 24),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  'By creating or logging into an account you are agreeing\nwith our ',
                            ),
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
