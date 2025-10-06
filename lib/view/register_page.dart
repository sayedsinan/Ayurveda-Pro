import 'package:ayurveda_app/view/bill_screen.dart';
import 'package:ayurveda_app/view/widgets/custom_dropdown.dart';
import 'package:ayurveda_app/view/widgets/custom_input_filed.dart';
import 'package:ayurveda_app/view/widgets/date_picker_field.dart';
import 'package:ayurveda_app/view/widgets/my_button.dart';
import 'package:ayurveda_app/view/widgets/payment_option.dart';
import 'package:ayurveda_app/view/widgets/treatment_card.dart';
import 'package:ayurveda_app/view/widgets/treatment_edit_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _selectedLocation = 'Choose your location';
  String _selectedBranch = 'Select the branch';
  String _selectedPaymentOption = 'Cash';
  String _selectedTreatmentDate = 'Choose Date';
  String _selectedHour = 'Hours';
  String _selectedMinute = 'Minutes';

  List<String> locations = ['Choose your location', 'Location 1', 'Location 2'];
  List<String> branches = ['Select the branch', 'Branch 1', 'Branch 2'];
  List<String> hours = [
    'Hours',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];
  List<String> minutes = ['Minutes', '00', '15', '30', '45'];

  List<Map<String, dynamic>> treatments = [
    {'name': 'Couple Combo package i...', 'male': 2, 'female': 3},
  ];

  @override
  void initState() {
    super.initState();
    final controller = Get.find<AuthController>();
    
    // Load branches and treatments
    if (controller.branches.isEmpty) {
      controller.fetchBranches();
    }
    if (controller.treatments.isEmpty) {
      controller.fetchTreatments();
    }
    
    // Populate branches dropdown from API
    controller.branches.listen((branchList) {
      if (branchList.isNotEmpty) {
        setState(() {
          branches = ['Select the branch', ...branchList.map((b) => b.name).toList()];
        });
      }
    });
  }

  Future<void> _generateBill() async {
    final controller = Get.find<AuthController>();

    if (controller.nameController.text.isEmpty ||
        controller.whatsappController.text.isEmpty ||
        controller.addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    // First save the registration to API
    await _saveToAPI();

    // Then generate the bill
    await BillGenerator.generateBill(
      patientName: controller.nameController.text,
      address: controller.addressController.text,
      whatsappNumber: controller.whatsappController.text,
      location: _selectedLocation,
      branch: _selectedBranch,
      treatments: treatments,
      totalAmount: controller.totalAmountController.text,
      discountAmount: controller.discountController.text,
      advanceAmount: controller.advanceController.text,
      balanceAmount: controller.balanceController.text,
      treatmentDate: _selectedTreatmentDate,
      treatmentTime: '$_selectedHour:$_selectedMinute',
      paymentOption: _selectedPaymentOption,
    );
  }

  Future<void> _saveToAPI() async {
    final controller = Get.find<AuthController>();

    // Validation
    if (_selectedBranch == 'Select the branch') {
      Get.snackbar("Error", "Please select a branch",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (_selectedTreatmentDate == 'Choose Date') {
      Get.snackbar("Error", "Please select treatment date",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (_selectedHour == 'Hours' || _selectedMinute == 'Minutes') {
      Get.snackbar("Error", "Please select treatment time",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Set selected branch in controller
    final selectedBranchObj = controller.branches.firstWhere(
      (b) => b.name == _selectedBranch,
      orElse: () => controller.branches.first,
    );
    controller.selectedBranch.value = selectedBranchObj;

    // Extract male and female treatment IDs from treatments list
    List<int> maleTreatmentIds = [];
    List<int> femaleTreatmentIds = [];

    for (var treatment in treatments) {
      // Find treatment ID from controller.treatments by name
      final treatmentObj = controller.treatments.firstWhereOrNull(
        (t) => t.name.contains(treatment['name'].toString().substring(0, 10)),
      );
      
      if (treatmentObj != null) {
        // Add male count
        for (int i = 0; i < treatment['male']; i++) {
          maleTreatmentIds.add(treatmentObj.id);
        }
        // Add female count
        for (int i = 0; i < treatment['female']; i++) {
          femaleTreatmentIds.add(treatmentObj.id);
        }
      }
    }

    // Format date and time
    final dateTime = '$_selectedTreatmentDate $_selectedHour:$_selectedMinute';

    // Call register API
    await controller.registerPatient(
      executive: _selectedLocation, // Using location as executive for now
      payment: _selectedPaymentOption,
      dateTime: dateTime,
      maleTreatmentIds: maleTreatmentIds,
      femaleTreatmentIds: femaleTreatmentIds,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Register",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Name",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 8),
              CustomInputFiled(
                hintText: "Enter your name",
                controller: controller.nameController,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              Text(
                "Whatsapp number",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),
              CustomInputFiled(
                hintText: "Enter your Whatsapp Number",
                controller: controller.whatsappController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              Text(
                "Address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 8),
              CustomInputFiled(
                hintText: "Enter your full address",
                controller: controller.addressController,
                keyboardType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 20),
              Text(
                "Location",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 8),
              CustomDropdownField(
                hintText: 'Location',
                value: _selectedLocation,
                items: locations,
                onChanged: (val) {
                  setState(() => _selectedLocation = val!);
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Branch",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8),
              Obx(() => CustomDropdownField(
                    hintText: 'Branch',
                    value: _selectedBranch,
                    items: controller.branches.isEmpty
                        ? branches
                        : [
                            'Select the branch',
                            ...controller.branches.map((b) => b.name).toList()
                          ],
                    onChanged: (val) {
                      setState(() => _selectedBranch = val!);
                    },
                  )),
              const SizedBox(height: 20),

              const Text(
                'Treatments',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 12),
              ...treatments.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> t = entry.value;
                return TreatmentCard(
                  treatment: t,
                  onEdit: () {
                    showDialog(
                      context: context,
                      builder: (_) => TreatmentEditDialog(
                        treatment: t,
                        onSave: (updatedTreatment) {
                          setState(() {
                            treatments[index] = updatedTreatment;
                          });
                        },
                      ),
                    );
                  },
                );
              }).toList(),
              const SizedBox(height: 12),

              Opacity(
                opacity: 0.4,
                child: MyButton(text: "+ Add Treatment", onPressed: () {}),
              ),
              const SizedBox(height: 20),
              Text(
                "Total amount",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8),
              CustomInputFiled(
                hintText: "",
                controller: controller.totalAmountController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Text(
                "Discount Amount",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8),

              CustomInputFiled(
                hintText: "",
                controller: controller.discountController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              const Text(
                'Payment Option',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 12),
              PaymentOptionSelector(
                selectedOption: _selectedPaymentOption,
                onOptionSelected: (val) {
                  setState(() => _selectedPaymentOption = val);
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Advance Amount",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 8),
              CustomInputFiled(
                hintText: "",
                controller: controller.advanceController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Text(
                "Balance Amount",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 8),
              CustomInputFiled(
                hintText: "",
                controller: controller.balanceController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              DatePickerField(
                label: 'Treatment Date',
                selectedDate: _selectedTreatmentDate,
                onDateSelected: (val) {
                  setState(() => _selectedTreatmentDate = val);
                },
              ),
              const SizedBox(height: 20),

              const Text(
                "Treatment Time",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdownField(
                      hintText: 'Hour',
                      value: _selectedHour,
                      items: hours,
                      onChanged: (val) {
                        setState(() => _selectedHour = val!);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomDropdownField(
                      hintText: 'Minutes',
                      value: _selectedMinute,
                      items: minutes,
                      onChanged: (val) {
                        setState(() => _selectedMinute = val!);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              MyButton(text: "Save", onPressed: () => _generateBill()),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}