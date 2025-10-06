// lib/model/patient_model.dart

class Patient {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String payment;
  final int totalAmount;
  final int discountAmount;
  final int advanceAmount;
  final int balanceAmount;
  final String dateTime;
  final Branch? branch; // Make nullable
  final List<PatientDetail> patientDetails;

  Patient({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.payment,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateTime,
    this.branch, // Optional
    required this.patientDetails,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      payment: json['payment'] ?? '',
      totalAmount: json['total_amount'] ?? 0,
      discountAmount: json['discount_amount'] ?? 0,
      advanceAmount: json['advance_amount'] ?? 0,
      balanceAmount: json['balance_amount'] ?? 0,
      dateTime: json['date_nd_time'] ?? '',
      branch: json['branch'] != null ? Branch.fromJson(json['branch']) : null,
      patientDetails: json['patientdetails_set'] != null
          ? (json['patientdetails_set'] as List<dynamic>)
              .map((e) => PatientDetail.fromJson(e))
              .toList()
          : [],
    );
  }
}

class Branch {
  final int id;
  final String name;
  final String location;
  final String phone;

  Branch({
    required this.id,
    required this.name,
    required this.location,
    required this.phone,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}

class PatientDetail {
  final int id;
  final String treatmentName;

  PatientDetail({
    required this.id,
    required this.treatmentName,
  });

  factory PatientDetail.fromJson(Map<String, dynamic> json) {
    return PatientDetail(
      id: json['id'] ?? 0,
      treatmentName: json['treatment_name'] ?? '',
    );
  }
}