import 'package:ayurveda_app/view/widgets/counter.dart';
import 'package:flutter/material.dart';
class TreatmentCard extends StatelessWidget {
  final Map<String, dynamic> treatment;
  final VoidCallback? onEdit; // Add this

  const TreatmentCard({super.key, required this.treatment, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. ${treatment['name']}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Counter(label: 'Male', count: treatment['male']),
                    const SizedBox(width: 16),
                    Counter(label: 'Female', count: treatment['female']),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Color(0xFF006837)),
                onPressed: onEdit, // Call the callback
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
