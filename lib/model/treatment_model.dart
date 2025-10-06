class TreatmentResponse {
  final bool status;
  final String message;
  final List<Treatment> treatments;

  TreatmentResponse({
    required this.status,
    required this.message,
    required this.treatments,
  });

  factory TreatmentResponse.fromJson(Map<String, dynamic> json) {
    return TreatmentResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      treatments: (json['treatments'] as List?)
              ?.map((t) => Treatment.fromJson(t))
              .toList() ??
          [],
    );
  }
}

class Treatment {
  final int id;
  final String name;
  final String duration;
  final String price;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final List<int> branches;

  Treatment({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.branches,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      duration: json['duration'] ?? '',
      price: json['price'] ?? '',
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      branches: (json['branches'] as List?)?.map((e) => e as int).toList() ?? [],
    );
  }
}