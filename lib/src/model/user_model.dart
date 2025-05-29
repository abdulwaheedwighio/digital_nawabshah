class UserModel {
  final String message;
  final User user;
  final String token;

  UserModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      // Safely extract the 'User' data from the response JSON
      final userJson = json['User'];
      final user = userJson != null ? User.fromJson(userJson) : User.defaultUser();

      return UserModel(
        message: json['message'] ?? 'No message available',
        user: user,
        token: json['Token'] ?? '',
      );
    } catch (e) {
      print('❌ Error creating UserModel from JSON: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'User': user,
      'Token': token,
    };
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String city;
  final bool isAdmin;

  // Optional Fields
  final String? gender;
  final String? religious;
  final String? dateOfBirth;
  final String? image;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
    required this.isAdmin,
    this.gender,
    this.religious,
    this.dateOfBirth,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: json['_id'] ?? 'Unknown ID', // Default value for missing or null ID
        name: json['Name'] ?? 'Unknown', // Default value for missing name
        email: json['Email'] ?? 'Unknown', // Default value for missing email
        phone: json['Phone'] ?? 'Unknown', // Default value for missing phone
        city: json['City'] ?? 'Unknown', // Default value for missing city
        isAdmin: json['is_Admin'] ?? false, // Default value for missing isAdmin
        gender: json['Gender'] ?? 'Not provided', // Default value for missing gender
        religious: json['Religious'] ?? 'Not provided', // Default value for missing religious
        dateOfBirth: json['DateOfBirth'] ?? 'Not provided', // Default value for missing dateOfBirth
        image: json['profilePic'] ?? 'Not provided', // Default value for missing image
      );
    } catch (e) {
      print('❌ Error creating User from JSON: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Name': name,
      'Email': email,
      'Phone': phone,
      'City': city,
      'is_Admin': isAdmin,
      'Gender': gender ?? '', // Optional field
      'Religious': religious ?? '', // Optional field
      'DateOfBirth': dateOfBirth ?? '', // Optional field
      'profilePic': image ?? '', // Optional field
    };
  }

  factory User.defaultUser() {
    return User(
      id: 'Unknown ID',
      name: 'Unknown',
      email: 'Unknown',
      phone: 'Unknown',
      city: 'Unknown',
      isAdmin: false,
      gender: 'Not provided',
      religious: 'Not provided',
      dateOfBirth: 'Not provided',
      image: 'Not provided',
    );
  }
}
