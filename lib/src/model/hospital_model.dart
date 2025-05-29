import 'dart:convert';

class HospitalModel {
  final String id;
  final String name;
  final String? description;
  final String address;
  final String sector;
  final String? email;
  final String? phone;
  final String imagePath;
  final String cloudinaryId;
  final LocationModel location;

  HospitalModel({
    required this.id,
    required this.name,
    this.description,
    required this.address,
    required this.sector,
    this.email,
    this.phone,
    required this.imagePath,
    required this.cloudinaryId,
    required this.location,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      id: json['_id'] ?? '',
      name: json['Name'] ?? '',
      description: json['Description'],
      address: json['Address'] ?? '',
      sector: json['Sector'] ?? '',
      email: json['Email'],
      phone: json['Phone'],
      imagePath: json['ImagePath'] ?? '',
      cloudinaryId: json['CloudinaryID'] ?? '',
      location: json['Location'] != null
          ? LocationModel.fromJson(json['Location'])
          : LocationModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Name': name,
      'Description': description,
      'Address': address,
      'Sector': sector,
      'Email': email,
      'Phone': phone,
      'ImagePath': imagePath,
      'CloudinaryID': cloudinaryId,
      'Location': location.toJson(),
    };
  }
}

class LocationModel {
  final String type;
  final List<double?> coordinates;

  LocationModel({
    required this.type,
    required this.coordinates,
  });

  /// Factory handles both stringified JSON and Map
  factory LocationModel.fromJson(dynamic json) {
    if (json is String) {
      try {
        json = jsonDecode(json);
      } catch (e) {
        return LocationModel.empty();
      }
    }

    if (json == null || json['coordinates'] == null) {
      return LocationModel.empty();
    }

    return LocationModel(
      type: json['type'] ?? 'Point',
      coordinates: (json['coordinates'] as List)
          .map((e) => e == null ? null : (e as num).toDouble())
          .toList(),
    );
  }

  /// Empty model in case of invalid or missing data
  factory LocationModel.empty() {
    return LocationModel(type: 'Point', coordinates: [null, null]);
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}
