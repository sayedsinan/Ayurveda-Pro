import 'package:flutter/material.dart';
class PaymentOptionSelector extends StatelessWidget {
  final String selectedOption;
  final Function(String) onOptionSelected;

  const PaymentOptionSelector({super.key, required this.selectedOption, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    final options = ['Cash', 'Card', 'UPI'];
    return Row(
      children: options.map((option) {
        return Expanded(
          child: Row(
            children: [
              Radio<String>(
                value: option,
                groupValue: selectedOption,
                onChanged: (val) => onOptionSelected(val!),
              ),
              Text(option),
            ],
          ),
        );
      }).toList(),
    );
  }
}
