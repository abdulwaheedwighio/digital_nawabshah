
class LaboratoryModel {
  final String id;
  final String labName;
  final String? description;
  final String address;
  final String? email;
  final String? phoneNumber;
  final String imagePath;
  final String cloudinaryId;
  final String labContacts;
  final String discounts;
  final List<String> openingDays;
  final List<String> openingTime;
  final List<TestOffered> testsOffered;

  LaboratoryModel({
    required this.id,
    required this.labName,
    this.description,
    required this.address,
    this.email,
    this.phoneNumber,
    required this.imagePath,
    required this.cloudinaryId,
    required this.labContacts,
    required this.discounts,
    required this.openingDays,
    required this.openingTime,
    required this.testsOffered,
  });

  factory LaboratoryModel.fromJson(Map<String, dynamic> json) {
    var testList = json['testsOffered'] as List;
    List<TestOffered> tests = testList.map((e) => TestOffered.fromJson(e)).toList();

    return LaboratoryModel(
      id: json['_id'] ?? '',
      labName: json['labName'] ?? '',
      description: json['description'],
      address: json['address'] ?? '',
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      imagePath: json['ImagePath'] ?? '',
      cloudinaryId: json['CloudinaryID'] ?? '',
      labContacts: json['labContacts'] ?? '',
      discounts: json['discounts'] ?? '',
      openingDays: List<String>.from(json['openingDays'] ?? []),
      openingTime: List<String>.from(json['openingTime'] ?? []),
      testsOffered: tests,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'labName': labName,
      'description': description,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
      'ImagePath': imagePath,
      'CloudinaryID': cloudinaryId,
      'labContacts': labContacts,
      'discounts': discounts,
      'openingDays': openingDays,
      'openingTime': openingTime,
      'testsOffered': testsOffered.map((test) => test.toJson()).toList(),
    };
  }
}

class TestOffered {
  final String id;
  final String testName;
  final String price;

  TestOffered({
    required this.id,
    required this.testName,
    required this.price,
  });

  factory TestOffered.fromJson(Map<String, dynamic> json) {
    return TestOffered(
      id: json['_id'] ?? '',
      testName: json['testName'] ?? '',
      price: json['price'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'testName': testName,
      'price': price,
    };
  }
}
