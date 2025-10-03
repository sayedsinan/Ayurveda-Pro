import 'package:ayurveda_app/view/register_page.dart';
import 'package:ayurveda_app/view/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SearchBarSection(),
            SizedBox(height: 20),
            SortBySection(),
            SizedBox(height: 20),
            Expanded(child: BookingsList()),
          ],
        ),
      ),
    );
  }
}

/// ------------------- Search Bar Section -------------------
class SearchBarSection extends StatelessWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF00A86B), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for treatments',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF00A86B), size: 20),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: 45,
          child: MyButton(
            text: "Search",
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

/// ------------------- Sort By Section -------------------
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

/// ------------------- Bookings List -------------------
class BookingsList extends StatelessWidget {
  const BookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        BookingCard(number: 1, showRegisterButton: false),
        SizedBox(height: 16),
        BookingCard(number: 2, showRegisterButton: false),
        SizedBox(height: 16),
        BookingCard(number: 3, showRegisterButton: true),
      ],
    );
  }
}

/// ------------------- Booking Card -------------------
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
          /// Number + Name
          Text(
            '$number.  Vikram Singh',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          const SizedBox(height: 8),

          /// Package name
          const Text(
            'Couple Combo Package (Rejuven...',
            style: TextStyle(fontSize: 14, color: Color(0xFF00A86B), fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),

          /// Date & Location
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

          /// Register / View Details
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
