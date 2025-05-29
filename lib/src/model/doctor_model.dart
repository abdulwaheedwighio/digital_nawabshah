class DoctorModel {
  final String id;
  final String name;
  final String description;
  final String qualification;
  final String specialization;
  final String experience;
  final bool verified;
  final String email;
  final String imagePath;
  final String phone;
  final bool isActive;
  final List<OpdTiming> opDTimings;
  final List<DoctorFeedback> feedback;

  DoctorModel({
    required this.id,
    required this.name,
    required this.description,
    required this.qualification,
    required this.specialization,
    required this.experience,
    required this.verified,
    required this.email,
    required this.imagePath,
    required this.phone,
    required this.isActive,
    required this.opDTimings,
    required this.feedback,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['_id'] ?? '',
      name: json['Name'] ?? '',
      description: json['Description'] ?? '',
      qualification: json['Qualification'] ?? '',
      specialization: json['Specialist'] ?? '',
      experience: json['Experience'] ?? '',
      verified: json['verfiedBySindhTechSolutions'] ?? false,
      email: json['Email'] ?? '',
      imagePath: json['ImagePath'] ?? '',
      phone: json['Phone'] ?? '',
      isActive: json['is_Active'] ?? false,
      opDTimings: (json['opDTimings'] as List?)
          ?.map((e) => OpdTiming.fromJson(e))
          .toList() ??
          [],
      feedback: (json['Feedback'] as List?)
          ?.map((e) => DoctorFeedback.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class OpdTiming {
  final String day;
  final ClinicModel? clinic;
  final String from;
  final String to;

  OpdTiming({
    required this.day,
    required this.clinic,
    required this.from,
    required this.to,
  });

  factory OpdTiming.fromJson(Map<String, dynamic> json) {
    return OpdTiming(
      day: json['day'] ?? '',
      clinic: json['clinic'] != null && json['clinic'] is Map<String, dynamic>
          ? ClinicModel.fromJson(json['clinic'])
          : null,
      from: json['from'] ?? '',
      to: json['to'] ?? '',
    );
  }
}

class ClinicModel {
  final String id;
  final String name;
  final String description;
  final String address;
  final String sector;
  final String email;
  final String phone;
  final String imagePath;

  ClinicModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.sector,
    required this.email,
    required this.phone,
    required this.imagePath,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      id: json['_id'] ?? '',
      name: json['Name'] ?? '',
      description: json['Description'] ?? '',
      address: json['Address'] ?? '',
      sector: json['Sector'] ?? '',
      email: json['Email'] ?? '',
      phone: json['Phone'] ?? '',
      imagePath: json['ImagePath'] ?? '',
    );
  }
}

class DoctorFeedback {
  final String feedback;
  final int? stars; // Currently not present in API — optional
  final String userName;
  final String date;

  DoctorFeedback({
    required this.feedback,
    this.stars,
    required this.userName,
    required this.date,
  });

  factory DoctorFeedback.fromJson(Map<String, dynamic> json) {
    final dynamic user = json['User'] ?? json['user'];
    final userName = (user is Map<String, dynamic>) ? (user['Name'] ?? 'Unknown') : 'Unknown';

    return DoctorFeedback(
      feedback: json['feedback'] ?? '',
      stars: json['stars'], // will be null for now
      userName: userName,
      date: json['date'] ?? '',
    );
  }
}
