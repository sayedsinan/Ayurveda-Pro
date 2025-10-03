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

Future<void> _generateBill() async {
  final controller = Get.find<AuthController>();
  
  // Validate that required fields are filled
  if (controller.nameController.text.isEmpty || 
      controller.whatsappController.text.isEmpty ||
      controller.addressController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill all required fields')),
    );
    return;
  }

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
  @override
  Widget build(BuildContext context) {
 final controller=Get.find<AuthController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Register",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
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
              CustomInputFiled(hintText: "Name", controller: controller.nameController),
              const SizedBox(height: 20),
              CustomInputFiled(
                hintText: "Whatsapp Number",
                controller: controller.whatsappController,
              ),
              const SizedBox(height: 20),
              CustomInputFiled(
                hintText: "Address",
                controller: controller.addressController,
              ),
              const SizedBox(height: 20),

              CustomDropdownField(
                hintText: 'Location',
                value: _selectedLocation,
                items: locations,
                onChanged: (val) {
                  setState(() => _selectedLocation = val!);
                },
              ),
              const SizedBox(height: 20),

              CustomDropdownField(
                hintText: 'Branch',
                value: _selectedBranch,
                items: branches,
                onChanged: (val) {
                  setState(() => _selectedBranch = val!);
                },
              ),
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

              CustomInputFiled(
                hintText: "Total Amount",
                controller: controller.totalAmountController,
              ),
              const SizedBox(height: 20),
              CustomInputFiled(
                hintText: "Discount Amount",
                controller: controller.discountController,
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

              CustomInputFiled(
                hintText: "Advance Amount",
                controller: controller.advanceController,
              ),
              const SizedBox(height: 20),
              CustomInputFiled(
                hintText: "Balance Amount",
                controller: controller.balanceController,
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

              MyButton(text: "Save", onPressed:()=>_generateBill()),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
