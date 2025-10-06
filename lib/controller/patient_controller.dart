import 'dart:convert';
import 'package:ayurveda_app/model/patient_model.dart';

import 'package:ayurveda_app/services/token_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PatientController extends GetxController {
  var patients = <Patient>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    final baseUrl = dotenv.env['BASE_URL'] ?? "";
    final url = Uri.parse("${baseUrl}PatientList");
    
  
    final token = TokenService.getToken();

    
    if (token == null || token.isEmpty) {
      Get.snackbar(
        "Error",
        "Please login first",
        snackPosition: SnackPosition.BOTTOM,
      );
      errorMessage('Authentication required');
      return;
    }

    try {
      isLoading(true);
      errorMessage('');
      
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Add token to header
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final patientList = (data['patient'] as List)
            .map((json) => Patient.fromJson(json))
            .toList();

        patients.assignAll(patientList);
        print("✅ Fetched ${patientList.length} patients");
      } else if (response.statusCode == 401) {
        // Token expired or invalid
        print("❌ Unauthorized - Token may be invalid");
        errorMessage('Session expired. Please login again');
        
        // Remove invalid token and redirect to login
        await TokenService.removeToken();
        
        Get.snackbar(
          "Session Expired",
          "Please login again",
          snackPosition: SnackPosition.BOTTOM,
        );
        
        // Navigate to login
        // Get.offAll(() => LoginPage());
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
        errorMessage('Failed to load patients');
        
        Get.snackbar(
          "Error",
          "Failed to load patients",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("❌ Exception while fetching patients: $e");
      errorMessage('Something went wrong');
      
      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

 
  Future<void> refreshPatients() async {
    await fetchPatients();
  }
  
}