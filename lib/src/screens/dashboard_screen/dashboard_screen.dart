import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/auth_api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:digital_nawabshah/src/component/widgets/category_button_icon_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctors_screen.dart';
import 'package:digital_nawabshah/src/screens/emergency_number_screen/emergency_number_screen.dart';
import 'package:digital_nawabshah/src/screens/hospital_screen/hospital_screen.dart';
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratory_screen.dart';
import 'package:digital_nawabshah/src/screens/user_profile_screen/user_profile_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  final List<String> backgroundImages = [
    backgroundImage1,
    backgroundImage2,
    backgroundImage3,
    backgroundImage4,
  ];

  bool isLoading = true;
  
  Future<void> getUserData()async{
    final authProvider = Provider.of<AuthApiServices>(context, listen: false);

    final userId = await authProvider.getUserId();
    print('Fetched User ID: $userId');  // Debug print

    if (userId != null) {
      final fetchedUser = await authProvider.fetchUserData(userId);

      if (fetchedUser != null) {
        print('Fetched User Data: $fetchedUser');  // Debug print
        setState(() {
          isLoading = false;
        });
      } else {
        print("Failed to load user data.");
        setState(() {
          isLoading = false;
        });
      }
    }else{
      print("User ID is null! Please make sure the user is logged in.");
      setState(() {
        isLoading = false;
      });
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final userDataProvider = Provider.of<AuthApiServices>(context).user;

    return Scaffold(
      body: isLoading? Center(child: Lottie.asset(
        'assets/lottie/Animation - 17455943505602.json', // 👈 Replace this with your Lottie link
        width: 150,
        height: 150,
        fit: BoxFit.contain,
      ),) : AdvancedDrawer(
        controller: _advancedDrawerController,
        drawer: _buildDrawer(),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title:  Column(
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: TextWidget(
                    text: "Welcome",
                    textAlign: TextAlign.right,
                    color: lightColor,
                    fontSize: 18,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextWidget(
                    text: userDataProvider?.user.name ?? 'Default Name',
                    textAlign: TextAlign.right,
                    color: lightColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
            elevation: 0,
            iconTheme: const IconThemeData(color: lightColor),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _advancedDrawerController.showDrawer(),
            ),
          ),

          body: Stack(
            children: [
              Positioned.fill(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.easeInOut,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                  ),
                  items: backgroundImages.map((image) {
                    return Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  }).toList(),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: kToolbarHeight + 20),
                    Container(
                      height: screenHeight * 0.40,
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TextWidget(
                            text: "HEALTH CARE",
                            fontWeight: FontWeight.w800,
                            color: primaryColor,
                            fontSize: 19,
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 2, color: darkGreyColor),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CategoryButtonIcon(
                                imagePath: doctorIcon,
                                label: "Doctor",
                                imageSize: 60,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DoctorsScreen()));
                                },
                              ),
                              CategoryButtonIcon(
                                imagePath: hospitalIcon,
                                label: "Hospitals",
                                imageSize: 55,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HospitalScreen()));
                                },
                              ),
                              CategoryButtonIcon(
                                imagePath: labIcon,
                                label: "City Lab",
                                imageSize: 55,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LaboratoryScreen()));
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              CategoryButtonIcon(
                                imagePath: ambulanceIcon,
                                label: "Emergency\n   Number",
                                imageSize: 55,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EmergencyNumberScreen()));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Material(
      color: lightColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(doctorImage),
                ),
                SizedBox(height: 10),
                TextWidget(
                  text: "Abdul Waheed Wighio",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: lightColor,
                ),
                TextWidget(
                  text: "abdulwaheed@email.com",
                  fontSize: 14,
                  color: lightColor,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: primaryColor),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: primaryColor),
            title: const Text("Profile"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: primaryColor),
            title: const Text("Settings"),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
              // Logout functionality
            },
          ),
        ],
      ),
    );
  }
}
