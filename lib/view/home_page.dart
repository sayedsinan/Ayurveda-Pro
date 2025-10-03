import 'package:ayurveda_app/view/widgets/booking_list.dart';

import 'package:ayurveda_app/view/widgets/search_bar_section.dart' show SearchBarSection;
import 'package:ayurveda_app/view/widgets/sort_by_section.dart';
import 'package:flutter/material.dart';


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
            SearchBarSection(),
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

