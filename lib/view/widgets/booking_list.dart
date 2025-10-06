// lib/view/bookings_list.dart

import 'package:ayurveda_app/controller/patient_controller.dart';
import 'package:ayurveda_app/view/widgets/booking_card.dart';
import 'package:ayurveda_app/view/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../register_page.dart';

class BookingsList extends StatelessWidget {
  const BookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final PatientController controller = Get.put(PatientController());

    return Obx(() {
      // Loading state
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF00A86B),
          ),
        );
      }

      // Error state
      if (controller.errorMessage.isNotEmpty && controller.patients.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.red[300],
              ),
              const SizedBox(height: 16),
              Text(
                controller.errorMessage.value,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.fetchPatients(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A86B),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      // Empty state
      if (controller.patients.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people_outline,
                size: 60,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No patients found',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        );
      }

      // Success state - Display patient list with register button at bottom
      return Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              color: const Color(0xFF00A86B),
              onRefresh: () => controller.refreshPatients(),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.patients.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final patient = controller.patients[index];
                  return BookingCard(
                    number: index + 1,
                    patient: patient,
                    showRegisterButton: false, // All cards show "View Details"
                  );
                },
              ),
            ),
          ),
          // Register button at the bottom
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: MyButton(
                text: "Register Now",
                onPressed: () {
                  Get.to(() => const RegisterScreen());
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}