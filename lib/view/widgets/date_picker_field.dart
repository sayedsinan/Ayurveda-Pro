import 'package:flutter/material.dart';
class DatePickerField extends StatelessWidget {
  final String label;
  final String selectedDate;
  final Function(String) onDateSelected;

  const DatePickerField({super.key, required this.label, required this.selectedDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              onDateSelected("${pickedDate.day}/${pickedDate.month}/${pickedDate.year}");
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedDate, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                const Icon(Icons.calendar_today_outlined, color: Colors.black54, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
