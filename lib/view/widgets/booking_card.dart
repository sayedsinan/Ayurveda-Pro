import 'package:ayurveda_app/model/patient_model.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class BookingCard extends StatelessWidget {
  final int number;
  final Patient patient;
  final bool showRegisterButton;

  const BookingCard({
    super.key,
    required this.number,
    required this.patient,
    required this.showRegisterButton,
  });

  String _formatDate(String dateTime) {
    try {
      final DateTime dt = DateTime.parse(dateTime);
      return DateFormat('dd/MM/yyyy').format(dt);
    } catch (e) {
      return dateTime;
    }
  }

  String _getTreatmentName() {
    if (patient.patientDetails.isNotEmpty) {
      final treatmentName = patient.patientDetails.first.treatmentName;
      if (treatmentName.length > 30) {
        return '${treatmentName.substring(0, 30)}...';
      }
      return treatmentName;
    }
    return 'No treatment assigned';
  }

  String _getBranchName() {
    return patient.branch?.name ?? 'Unknown Branch';
  }

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
            '$number.  ${patient.name}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            _getTreatmentName(),
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF00A86B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: Colors.red[400],
              ),
              const SizedBox(width: 6),
              Text(
                _formatDate(patient.dateTime),
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Colors.red[400],
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  patient.branch?.name ?? 'Unknown Branch',
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey[300]),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'View Booking details',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF00A86B)),
            ],
          ),
        ],
      ),
    );
  }
}
