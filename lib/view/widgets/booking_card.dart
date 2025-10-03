import 'package:ayurveda_app/view/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../register_page.dart';

class BookingCard extends StatelessWidget {
  final int number;
  final bool showRegisterButton;

  const BookingCard({super.key, required this.number, required this.showRegisterButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(
            '$number.  Vikram Singh',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          const SizedBox(height: 8),

          
          const Text(
            'Couple Combo Package (Rejuven...',
            style: TextStyle(fontSize: 14, color: Color(0xFF00A86B), fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),

         
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 14, color: Colors.red[400]),
              const SizedBox(width: 6),
              const Text('31/01/2024', style: TextStyle(fontSize: 13, color: Colors.black54)),
              const SizedBox(width: 16),
              Icon(Icons.access_time, size: 14, color: Colors.red[400]),
              const SizedBox(width: 6),
              const Text('Jithesh', style: TextStyle(fontSize: 13, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 16),

        
          showRegisterButton
              ? MyButton(text: "Register Now", onPressed: () {
                Get.to(() => const RegisterScreen());
              })
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('View Booking details', style: TextStyle(fontSize: 14, color: Colors.black87)),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF00A86B)),
                  ],
                ),
        ],
      ),
    );
  }
}
