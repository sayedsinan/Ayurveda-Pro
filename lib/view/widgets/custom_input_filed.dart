import 'package:flutter/material.dart';

class CustomInputFiled extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType; // optional keyboard type

  const CustomInputFiled({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType, // optional
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.text, // default to text
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        controller: controller,
        validator: validator,
      ),
    );
  }
}
