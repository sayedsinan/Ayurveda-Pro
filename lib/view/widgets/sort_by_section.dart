import 'package:flutter/material.dart';

class SortBySection extends StatelessWidget {
  const SortBySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Sort by :',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Text('Date', style: TextStyle(fontSize: 14, color: Colors.black87)),
              SizedBox(width: 8),
              Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black87),
            ],
          ),
        ),
      ],
    );
  }
}