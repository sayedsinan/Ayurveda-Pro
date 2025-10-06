import 'dart:convert';
import 'package:ayurveda_app/model/branch_model.dart';
import 'package:ayurveda_app/model/treatment_model.dart';
import 'package:ayurveda_app/model/user_model.dart';
import 'package:ayurveda_app/services/token_services.dart';
import 'package:ayurveda_app/view/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  // Text Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  TextEditingController balanceController = TextEditingController();

  // Observable variables
  var isLoading = false.obs;
  var branches = <Branch>[].obs;
  var treatments = <Treatment>[].obs;
  var selectedBranch = Rx<Branch?>(null);
  var selectedTreatments = <int>[].obs;
  var maleTreatments = <int>[].obs;
  var femaleTreatments = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBranches();
    fetchTreatments();
  }

  // Login Function
  Future<void> login(Login user) async {
    final baseUrl = dotenv.env['BASE_URL'] ?? "";
    final url = Uri.parse("${baseUrl}Login");

    try {
      isLoading(true);
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"username": user.email, "password": user.password},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data["token"];

        await TokenService.saveToken(token);

        print("✅ Login successful, token saved");

        Get.offAll(() => HomePage());

        Get.snackbar(
          "Success",
          "Login successful!",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        print("❌ Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        Get.snackbar(
          "Error",
          "Invalid credentials",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("❌ Exception: $e");
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // Fetch Branches
  Future<void> fetchBranches() async {
    final baseUrl = dotenv.env['BASE_URL'] ?? "";
    final url = Uri.parse("${baseUrl}BranchList");
    final token = TokenService.getToken();

    if (token == null || token.isEmpty) {
      Get.snackbar("Error", "Please login first",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final branchResponse = BranchResponse.fromJson(data);
        branches.value = branchResponse.branches;
        print("✅ Fetched ${branches.length} branches");
      } else {
        print("❌ Error fetching branches: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception while fetching branches: $e");
    }
  }

  // Fetch Treatments
  Future<void> fetchTreatments() async {
    final baseUrl = dotenv.env['BASE_URL'] ?? "";
    final url = Uri.parse("${baseUrl}TreatmentList");
    final token = TokenService.getToken();

    if (token == null || token.isEmpty) {
      Get.snackbar("Error", "Please login first",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final treatmentResponse = TreatmentResponse.fromJson(data);
        treatments.value = treatmentResponse.treatments;
        print("✅ Fetched ${treatments.length} treatments");
      } else {
        print("❌ Error fetching treatments: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception while fetching treatments: $e");
    }
  }

  // Register/Update Patient
  Future<void> registerPatient({
    required String executive,
    required String payment,
    required String dateTime,
    required List<int> maleTreatmentIds,
    required List<int> femaleTreatmentIds,
  }) async {
    final baseUrl = dotenv.env['BASE_URL'] ?? "";
    final url = Uri.parse("${baseUrl}PatientUpdate");
    final token = TokenService.getToken();

    if (token == null || token.isEmpty) {
      Get.snackbar("Error", "Please login first",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Validation
    if (nameController.text.isEmpty ||
        whatsappController.text.isEmpty ||
        addressController.text.isEmpty ||
        selectedBranch.value == null) {
      Get.snackbar("Error", "Please fill all required fields",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      isLoading(true);

      // Combine all treatment IDs
      final allTreatmentIds = <int>{
        ...maleTreatmentIds,
        ...femaleTreatmentIds
      }.toList();

      final body = {
        "name": nameController.text,
        "excecutive": "Executive 1",
        "payment": payment,
        "phone": whatsappController.text,
        "address": addressController.text,
        "total_amount": totalAmountController.text.isEmpty
            ? "0"
            : totalAmountController.text,
        "discount_amount": discountController.text.isEmpty
            ? "0"
            : discountController.text,
        "advance_amount": advanceController.text.isEmpty
            ? "0"
            : advanceController.text,
        "balance_amount": balanceController.text.isEmpty
            ? "0"
            : balanceController.text,
        "date_nd_time": dateTime,
        "id": "", 
        "male": maleTreatmentIds.join(','),
        "female": femaleTreatmentIds.join(','),
        "branch": selectedBranch.value!.id.toString(),
        "treatments": allTreatmentIds.join(','),
      };

      print("📤 Sending registration data: $body");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("✅ Patient registered successfully: $data");

        Get.snackbar(
          "Success",
          "Patient registered successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );

        // Clear form
        clearForm();

        // Navigate back or to success page
        Get.back();
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
        Get.snackbar(
          "Error",
          "Failed to register patient",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("❌ Exception while registering patient: $e");
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // Clear form
  void clearForm() {
    nameController.clear();
    whatsappController.clear();
    addressController.clear();
    totalAmountController.clear();
    discountController.clear();
    advanceController.clear();
    balanceController.clear();
    selectedBranch.value = null;
    selectedTreatments.clear();
    maleTreatments.clear();
    femaleTreatments.clear();
  }

  // Logout function
  Future<void> logout() async {
    await TokenService.removeToken();
    // Navigate to login page
    // Get.offAll(() => LoginPage());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    whatsappController.dispose();
    addressController.dispose();
    totalAmountController.dispose();
    discountController.dispose();
    advanceController.dispose();
    balanceController.dispose();
    super.onClose();
  }
}