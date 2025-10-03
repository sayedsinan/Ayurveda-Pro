import 'package:ayurveda_app/view/widgets/booking_card.dart';
import 'package:flutter/material.dart';

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
