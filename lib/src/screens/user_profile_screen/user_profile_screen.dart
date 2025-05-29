import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/auth_api_services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final authProvider = Provider.of<AuthApiServices>(context, listen: false);
    final userId = await authProvider.getUserId();
    if (userId != null) {
      final fetchedUser = await authProvider.fetchUserData(userId);
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthApiServices>(context).user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: TextWidget(
          text: "User Profile",
          color: darkColor,
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
            },
            child: const TextWidget(text: "Edit", fontSize: 14),
          ),
        ],
      ),
      body: isLoading || user == null
          ? Center(
        child: Lottie.asset(
          'assets/lottie/Animation - 17455943505602.json',
          width: 150,
          height: 150,
        ),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: screenHeight * 0.20,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(300),
                      bottomRight: Radius.circular(300),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.10),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: ClipOval(
                      child: user.user.image != null && user.user.image!.isNotEmpty
                          ? Image.network(
                        user.user.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Image.asset(userProfileImage, fit: BoxFit.cover),
                      )
                          : Image.asset(userProfileImage, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("Personal Information"),
                  infoTile(Icons.person, user.user.name ?? "N/A"),
                  infoTile(Icons.email, user.user.email ?? "N/A"),
                  infoTile(Icons.location_city, user.user.city ?? "N/A"),
                  infoTile(Icons.calendar_month, user.user.dateOfBirth ?? "N/A"),
                  infoTile(Icons.group, user.user.gender ?? "N/A"),
                  infoTile(Icons.now_wallpaper, user.user.religious ?? "N/A"),
                  const SizedBox(height: 20),
                  sectionTitle("Contact Details"),
                  infoTile(Icons.phone, user.user.phone ?? "N/A"),
                  infoTile(Icons.location_on, user.user.city ?? "N/A"),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: TextWidget(text: title, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget infoTile(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.indigo),
          const SizedBox(width: 12),
          Expanded(child: TextWidget(text: text, fontSize: 16)),
        ],
      ),
    );
  }
}


// import 'dart:convert';
// import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
// import 'package:digital_nawabshah/src/const/colors.dart';
// import 'package:digital_nawabshah/src/const/image_string.dart';
// import 'package:digital_nawabshah/src/model/user_model.dart'; // Adjust the path as needed
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class UserProfileScreen extends StatefulWidget {
//   @override
//   State<UserProfileScreen> createState() => _UserProfileScreenState();
// }
//
// class _UserProfileScreenState extends State<UserProfileScreen> {
//   UserModel? user;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData("USER_ID_HERE"); // Replace with actual userId or fetch from SharedPreferences
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//         ),
//         centerTitle: true,
//         title: const TextWidget(text: "Edit Profile", color: darkColor),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Stack(
//         children: [
//           // Background circle
//           Container(
//             height: screenHeight * 0.15,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.indigo.shade900,
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(350),
//                 bottomRight: Radius.circular(350),
//               ),
//             ),
//           ),
//
//           // Profile Image
//           Positioned(
//             top: screenHeight * 0.10,
//             left: MediaQuery.of(context).size.width / 2 - 60,
//             child: Container(
//               width: 124,
//               height: 124,
//               padding: const EdgeInsets.all(2),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.white, width: 3),
//               ),
//               child: ClipOval(
//                 child: Image.asset(
//                   doctorImage,
//                   width: 120,
//                   height: 120,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//
//           // Scrollable Details
//           Padding(
//             padding: EdgeInsets.only(top: screenHeight * 0.20 + 70),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     sectionTitle("Personal Information"),
//                     infoTile(Icons.person, "${user?.user.name ?? ""} ${user?.user.name ?? ""}"),
//                     infoTile(Icons.male, user?.user.name ?? ""),
//                     infoTile(Icons.book, user?.user.name ?? ""),
//                     infoTile(Icons.calendar_today, user?.user.phone ?? ""),
//                     infoTile(Icons.numbers, user?.user.name ?? ""),
//                     //infoTile(Icons.location_city, user?.province ?? ""),
//
//                     const SizedBox(height: 20),
//
//                     sectionTitle("Contact Information"),
//                     infoTile(Icons.phone, user?.user.phone ?? ""),
//                     infoTile(Icons.email, user?.user.email ?? ""),
//                     infoTile(Icons.location_on, user?.user.city ?? ""),
//
//                     const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget sectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20, bottom: 8),
//       child: TextWidget(text: title, fontWeight: FontWeight.bold, fontSize: 18),
//     );
//   }
//
//   Widget infoTile(IconData icon, String text) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 20, color: Colors.indigo),
//           const SizedBox(width: 12),
//           Expanded(child: TextWidget(text: text, fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }
