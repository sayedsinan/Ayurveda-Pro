import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final String label;
  final int count;

  const Counter({super.key, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFD4E7D7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(label),
          const SizedBox(width: 8),
          Text(count.toString(), style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
