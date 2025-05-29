import 'dart:convert';
import 'dart:io';
import 'package:digital_nawabshah/src/model/user_model.dart';
import 'package:digital_nawabshah/src/provider/user_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/services/api_links.dart';

class AuthApiServices extends ChangeNotifier {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<
      ScaffoldMessengerState>();

  UserModel? _user;

  UserModel? get user => _user;

  Future<void> userCreateAccount(String name, String email, String phoneNumber,
      String city, String password, String profilePic,
      BuildContext context) async {
    try {
      final url = Uri.parse(userRegisterAPIURL);
      final body = jsonEncode({
        "name": name,
        "email": email,
        "phone": phoneNumber,
        "city": city,
        "password": password,
        "profilePic": profilePic
      });

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      final jsonResponse = jsonDecode(response.body);
      final statusColor = response.statusCode == 200 ? Colors.green : Colors
          .red;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: statusColor,
          content: TextWidget(text: "${jsonResponse['message']}"),
        ),
      );
    } catch (error) {
      print("❌ Error during registration: $error");
    }
  }

  Future<Map<String, dynamic>?> loginUser(BuildContext context, String email, String password) async {
    try {
      // Make POST request to the backend
      final response = await http.post(
        Uri.parse(userLoginAPIURL),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      // Check if the response status is OK (200)
      if (response.statusCode == 200) {
        // Ensure the response body is not null or empty
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> data = json.decode(response.body);
          print("Server Response: $data"); // Debugging line

          // Check if the login was successful
          if (data['message'] == "Credential Matched!") {
            try {
              UserModel userModel = UserModel.fromJson(data);

              // Save user data in SharedPreferences
              await Provider.of<UserDetailProvider>(context, listen: false)
                  .saveUserData(userModel);

              return {
                'status': 'success',
                'message': 'Login Successful!',
              };
            } catch (e) {
              print('Error creating UserModel: $e');
              return {
                'status': 'error',
                'message': 'Error processing user data',
              };
            }
          } else {
            // If credentials are invalid, return failure message
            return {
              'status': 'failure',
              'message': 'Invalid credentials',
            };
          }
        } else {
          // If the response body is empty, handle it here
          print("Error: Empty response body");
          return {
            'status': 'error',
            'message': 'Empty response from server',
          };
        }
      } else {
        // Handle server error or failed request
        print("Failed response: ${response.statusCode} - ${response
            .body}"); // Debugging line
        return {
          'status': 'error',
          'message': 'Failed to login, try again',
        };
      }
    } catch (e) {
      // Handle any exceptions
      print('Error logging in: $e');
      return {
        'status': 'error',
        'message': 'An error occurred',
      };
    }
  }


  Future<UserModel?> fetchUserData(String userId) async {
    final url = Uri.parse(
        'https://digitalnawabshah-backend-production.up.railway.app/api/user/$userId');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userIdFromPrefs = prefs.getString('userId');

      if (token == null || userIdFromPrefs == null) {
        print('Error: No token or userId found');
        return null;
      }

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Log response to debug the issue
      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Log the raw response to verify the structure
        print('Decoded Response Data: $data');

        if (data != null) {
          if (data is Map<String, dynamic>) {
            _user = UserModel.fromJson(data);
            notifyListeners();
            return _user;
          } else {
            print('Error: Response data is not a valid map');
            return null;
          }
        } else {
          print('Error: Response body is null');
          return null;
        }
      } else {
        print('Failed to load user data. Status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId'); // Return the stored user ID
  }


  // Check if an image was picked and handle image upload
  // Your API update function
  Future<bool> updateUserProfile({
    required String userId,
    required String name,
    required String email,
    required String phone,
    required String city,
    String? gender,
    String? religious,
    String? dateOfBirth,
    File? imageFile, // This should be an actual File object
  }) async {
    final url = Uri.parse("https://digitalnawabshah-backend-production.up.railway.app/api/user/$userId");

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        print("❌ No token found.");
        return false;
      }

      final request = http.MultipartRequest('PUT', url);

      // Authorization header
      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields
      request.fields['Name'] = name;
      request.fields['Email'] = email;
      request.fields['Phone'] = phone;
      request.fields['City'] = city;
      if (gender != null) request.fields['Gender'] = gender;
      if (religious != null) request.fields['Religious'] = religious;
      if (dateOfBirth != null) request.fields['DateOfBirth'] = dateOfBirth;

      // Add image file if available
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath('profilePic', imageFile.path));
      }

      // Send request
      final response = await request.send();

      // Read response
      final responseBody = await response.stream.bytesToString();
      print('🔄 Update response code: ${response.statusCode}');
      print('📦 Response body: $responseBody');

      if (response.statusCode == 200) {
        print("✅ User updated successfully.");
        return true;
      } else {
        print("❌ Update failed.");
        return false;
      }
    } catch (e) {
      print("🚨 Error updating user: $e");
      return false;
    }
  }


  // Function to upload image to Cloudinary

// Function to handle error responses
    void _handleErrorResponse(String responseBody) {
      try {
        final errorResponse = jsonDecode(responseBody);
        if (errorResponse['message'] != null) {
          print("❌ Error: ${errorResponse['message']}");
        } else {
          print("❌ Unknown error: $responseBody");
        }
      } catch (e) {
        print("❌ Error while parsing error response: $e");
      }
    }
  }

