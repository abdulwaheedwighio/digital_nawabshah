import 'dart:convert';
import 'package:digital_nawabshah/src/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailProvider extends ChangeNotifier {
  String? token;
  String? message;
  String? userId;
  String? name;
  String? email;
  String? phone;
  String? city;
  bool isAdmin = false;
  User? currentUser; // ✅ Now holds User instead of UserModel

  // ✅ Save user data to SharedPreferences
  Future<void> saveUserData(UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();

    token = userModel.token;
    message = userModel.message;
    userId = userModel.user.id;
    name = userModel.user.name;
    email = userModel.user.email;
    phone = userModel.user.phone;
    city = userModel.user.city;
    isAdmin = userModel.user.isAdmin;
    currentUser = userModel.user;

    await prefs.setString('token', token!);
    await prefs.setString('message', message!);
    await prefs.setString('userId', userId!);
    await prefs.setString('name', name!);
    await prefs.setString('email', email!);
    await prefs.setString('phone', phone!);
    await prefs.setString('city', city!);
    await prefs.setBool('isAdmin', isAdmin);

    // ✅ Save the User object as JSON string
    await prefs.setString('user', jsonEncode(userModel.user.toJson()));

    print("✅ User data saved to SharedPreferences");
    notifyListeners();
  }

  // ✅ Get user data from SharedPreferences
  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
    message = prefs.getString('message');
    userId = prefs.getString('userId');
    name = prefs.getString('name');
    email = prefs.getString('email');
    phone = prefs.getString('phone');
    city = prefs.getString('city');
    isAdmin = prefs.getBool('isAdmin') ?? false;

    // ✅ Get the saved user JSON and decode it
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      currentUser = User.fromJson(jsonDecode(userJson));
    }

    print("✅ User data fetched from SharedPreferences");
    notifyListeners();
  }

  // ✅ Get current user ID
  String getCurrentUserId() {
    return userId ?? currentUser?.id ?? '';
  }

  // ✅ Clear all saved user data
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');
    await prefs.remove('message');
    await prefs.remove('userId');
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('phone');
    await prefs.remove('city');
    await prefs.remove('isAdmin');
    await prefs.remove('user');

    token = null;
    message = null;
    userId = null;
    name = null;
    email = null;
    phone = null;
    city = null;
    isAdmin = false;
    currentUser = null;

    print("✅ User data removed from SharedPreferences");
    notifyListeners();
  }
}
