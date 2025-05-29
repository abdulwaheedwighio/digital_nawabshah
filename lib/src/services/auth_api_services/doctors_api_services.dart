import 'dart:convert';
import 'package:digital_nawabshah/src/model/doctor_model.dart';
import 'package:digital_nawabshah/src/model/hospital_model.dart';
import 'package:digital_nawabshah/src/model/laboratory_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DoctorsAPIServices extends ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<DoctorModel> _doctors = []; // ✅ This must be defined
  List<DoctorModel> get doctors => _doctors;

  // ✅ Your fetch function
  Future<void> fetchDoctors() async {
    try {
      _isLoading = true;
      notifyListeners();

      // 1. Get token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("⚠️ No authorization token found.");
      }

      print("🔐 Token used: $token");

      // 2. Make authorized API request
      final response = await http.get(
        Uri.parse("https://digitalnawabshah-backend-production.up.railway.app/api/doctors4app"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("📡 Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        Set<String> seenIds = {};
        _doctors = (data as List)
            .map((item) => DoctorModel.fromJson(item))
            .where((doctor) => seenIds.add(doctor.id))
            .toList();

        print("✅ Doctors fetched: ${_doctors.length}");
      } else if (response.statusCode == 403) {
        print("🚫 Forbidden: Token might be invalid or missing permissions.");
      } else {
        print("❌ Server error (${response.statusCode}): ${response.body}");
      }

      notifyListeners();
    } catch (e) {
      print("🚨 Exception: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  DoctorModel getDoctorById(String id) {
    return _doctors.firstWhere(
          (doc) => doc.id == id,
      orElse: () => DoctorModel(
        id: '',
        name: 'Not Found',
        specialization: '',
        qualification: '',
        imagePath: '',
        description: '',
        experience: '',
        verified: false,
        email: '',
        phone: '',
        isActive: false,
        opDTimings: [],
        feedback: [],
      ),
    );
  }

// ✅ One-time fetch version (Optional)
  Future<List<DoctorModel>> getDoctorApi() async {
    List<DoctorModel> doctorList = [];
    Set<String> seenIds = {};

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("No token found in SharedPreferences.");
      }

      final response = await http.get(
        Uri.parse("https://digitalnawabshah-backend-production.up.railway.app/api/doctors4app"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("📡 Doctor API Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded is List) {
          doctorList = decoded
              .map((item) => DoctorModel.fromJson(item))
              .where((doctor) => seenIds.add(doctor.id))
              .toList();
        } else {
          throw Exception("Unexpected response format. Expected a list of doctors.");
        }

        return doctorList;
      } else if (response.statusCode == 403) {
        throw Exception('Access Denied: Invalid token');
      } else {
        throw Exception('Failed to fetch doctors. Status code: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('⚠️ Error fetching doctors: $e');
      print(stackTrace);
      return [];
    }
  }



  List<HospitalModel> _hospitals = []; // Initialize _hospitals here

  // Public getters
  List<HospitalModel> get hospitals => _hospitals;

  // Fetch hospitals from API using token
  Future<void> fetchHospitals() async {
    try {
      _isLoading = true;
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("❌ No token found in SharedPreferences.");
      }

      final response = await http.get(
        Uri.parse("https://digitalnawabshah-backend-production.up.railway.app/api/hospitals4app"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("📡 Hospital API status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        Set<String> seenIds = {};

        _hospitals = data.map<HospitalModel?>((item) {
          final hospital = HospitalModel.fromJson(item);
          if (!seenIds.contains(hospital.id)) {
            seenIds.add(hospital.id);
            return hospital;
          }
          return null;
        }).whereType<HospitalModel>().toList();

        print("🏥 Hospitals fetched: ${_hospitals.length}");
      } else if (response.statusCode == 403) {
        print("🚫 Unauthorized - Token might be expired or invalid.");
      } else {
        print("❌ Server error: ${response.statusCode} - ${response.body}");
      }

    } catch (e) {
      print("🚨 Error fetching hospitals: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<LaboratoryModel> _laboratories = [];

  // Public getters
  List<LaboratoryModel> get laboratories => _laboratories;

  // Fetch laboratories from API using token
  Future<void> fetchLaboratories() async {
    try {
      _isLoading = true;
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("❌ No token found in SharedPreferences.");
      }

      final response = await http.get(
        Uri.parse("https://digitalnawabshah-backend-production.up.railway.app/api/labs4app"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("📡 Laboratory API status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        Set<String> seenIds = {};

        _laboratories = data.map<LaboratoryModel?>((item) {
          final laboratory = LaboratoryModel.fromJson(item);
          if (!seenIds.contains(laboratory.id)) {
            seenIds.add(laboratory.id);
            return laboratory;
          }
          return null;
        }).whereType<LaboratoryModel>().toList();

        print("🏥 Laboratories fetched: ${_laboratories.length}");
      } else if (response.statusCode == 403) {
        print("🚫 Unauthorized - Token might be expired or invalid.");
      } else {
        print("❌ Server error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("🚨 Error fetching laboratories: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  bool _isSubmitting = false;
  String? _errorMessage;

  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;

  Future<void> submitDoctorFeedback({
    required String doctorId,
    required int rating,
    required String review,
  }) async {
    final url = Uri.parse(
      "https://digitalnawabshah-backend-production.up.railway.app/api/doctors/feedback/$doctorId",
    );

    try {
      _isSubmitting = true;
      _errorMessage = null;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userData = prefs.getString('user');

      if (token == null || token.isEmpty) {
        throw Exception("❌ No token found in SharedPreferences.");
      }

      if (userData == null) {
        throw Exception("❌ No user data found in SharedPreferences.");
      }

      final userJson = jsonDecode(userData);
      final String userId = userJson['_id'] ?? '';

      if (!isValidObjectId(userId)) {
        throw Exception("❌ Invalid User ID format.");
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'doctorId': doctorId, // Doctor's ID you are submitting feedback for
          '_id': userId, // The ID of the user submitting the feedback
          'stars': rating,
          'feedback': review,
        }),
      );

      if (response.statusCode == 201) {
        print("✅ Feedback submitted successfully!");
      } else {
        _errorMessage = 'Failed: ${response.body}';
        print(_errorMessage);
      }
    } catch (e) {
      _errorMessage = '❌ Error: $e';
      print(_errorMessage);
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }


  bool isValidObjectId(String id) {
    final objectIdPattern = RegExp(r'^[0-9a-fA-F]{24}$');
    return objectIdPattern.hasMatch(id);
  }
  List<DoctorFeedback> _feedbackList = [];
  List<DoctorFeedback> get feedbackList => _feedbackList;


  Future<void> fetchDoctorFeedback(String userId) async {
    try {
      _isSubmitting = true;
      notifyListeners();

      // Fetch the token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("❌ No token found in SharedPreferences.");
      }

      // Include the token in the headers for authentication
      final response = await http.get(
        Uri.parse('https://digitalnawabshah-backend-production.up.railway.app/api/doctors4app'),
        headers: {
          'Authorization': 'Bearer $token', // Pass the token here
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // DEBUG: Print all doctor IDs to see if they match
        print("Fetched ${data.length} doctors.");

        final doctorData = data.firstWhere(
              (doc) => doc['_id'] == userId,
          orElse: () => null,
        );

        if (doctorData != null && doctorData['Feedback'] != null) {
          final List<dynamic> feedbackJson = doctorData['Feedback'];
          _feedbackList = feedbackJson
              .map((json) => DoctorFeedback.fromJson(json))
              .toList();
        } else {
          print("Doctor not found or no Feedback.");
          _feedbackList = [];
        }
      } else {
        print("Failed with status: ${response.statusCode}");
        _feedbackList = [];
      }
    } catch (e) {
      print('Error fetching feedback: $e');
      _feedbackList = [];
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

}
