class BranchResponse {
  final bool status;
  final String message;
  final List<Branch> branches;

  BranchResponse({
    required this.status,
    required this.message,
    required this.branches,
  });

  factory BranchResponse.fromJson(Map<String, dynamic> json) {
    return BranchResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      branches: (json['branches'] as List?)
              ?.map((b) => Branch.fromJson(b))
              .toList() ??
          [],
    );
  }
}

class Branch {
  final int id;
  final String name;
  final int patientsCount;
  final String location;
  final String phone;
  final String mail;
  final String address;
  final String gst;
  final bool isActive;

  Branch({
    required this.id,
    required this.name,
    required this.patientsCount,
    required this.location,
    required this.phone,
    required this.mail,
    required this.address,
    required this.gst,
    required this.isActive,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      patientsCount: json['patients_count'] ?? 0,
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
      mail: json['mail'] ?? '',
      address: json['address'] ?? '',
      gst: json['gst'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }
}