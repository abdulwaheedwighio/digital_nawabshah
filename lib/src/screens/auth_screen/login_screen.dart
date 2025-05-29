import 'package:digital_nawabshah/src/component/widgets/custom_elevated_button.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_text_form_field_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/header_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/validation.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/screens/auth_screen/forget_password_screen/forget_password_screen.dart';
import 'package:digital_nawabshah/src/screens/auth_screen/registration_screen.dart';
import 'package:digital_nawabshah/src/screens/dashboard_screen/dashboard_screen.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/auth_api_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers here to prevent them from being used after disposal.
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,  // Ensures resizing when keyboard is shown
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/app_image.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const HeaderWidget(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: SingleChildScrollView(  // Makes the entire form scrollable
                              child: Column(
                                children: [
                                  CustomTabBar(
                                    emailController: emailController,
                                    passwordController: passwordController,
                                    phoneNumberController: phoneNumberController,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const TextWidget(
                                        text: "Don't have an account? ",
                                        color: lightColor,
                                        fontSize: 14,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const RegistrationScreen(),
                                            ),
                                          );
                                        },
                                        child: const TextWidget(
                                          text: "Register Now",
                                          color: lightColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTabBar extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;

  const CustomTabBar({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.phoneNumberController,
  });

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TabBar(
                      indicatorColor: Colors.transparent,
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        _tabButton("Phone Number", primaryColor),
                        _tabButton("Email Address", darkGreyColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPhoneNumberField(),
                  _buildEmailField(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          const TextFormFieldWidget(
            keyboardType: TextInputType.phone,
            hintText: "Enter Phone Number",
            prefixIcon: Icons.phone,
            fillColor: lightColor,
          ),
          SizedBox(height: screenHeight * 0.010),
          const TextFormFieldWidget(
            keyboardType: TextInputType.text,
            hintText: "Password",
            prefixIcon: Icons.lock,
            fillColor: lightColor,
            isObscure: true,
          ),
          SizedBox(height: screenHeight * 0.010),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()),
                );
              },
              child: const TextWidget(
                text: "Forget Password?",
                color: lightColor,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.010),
          CustomElevatedButton(
            text: "Login",
            width: double.infinity,
            height: 45,
            backgroundColor: primaryColor,
            onPressed: ()async {
              await Future.delayed(Duration(seconds: 2)); // Dummy delay
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) =>  DashboardScreen(userId: ,)),
              // );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {

    bool isLoading;
    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormFieldWidget(
                  controller: widget.emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter Email",
                  prefixIcon: Icons.email_outlined,
                  fillColor: lightColor,
                  validator: (value) {
                    return Validations.validateEmail(value);
                  },
                ),
                SizedBox(height: screenHeight * 0.010),
                TextFormFieldWidget(
                  controller: widget.passwordController,
                  keyboardType: TextInputType.text,
                  hintText: "Password",
                  prefixIcon: Icons.lock,
                  fillColor: lightColor,
                  isObscure: true,
                  validator: (value) {
                    return Validations.validatePassword(value);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.010),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()),
                );
              },
              child: const TextWidget(
                text: "Forget Password?",
                color: lightColor,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.010),
          CustomElevatedButton(
            text: "Login",
            width: double.infinity,
            height: 45,
            backgroundColor: primaryColor,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    // Call login API through AuthService
                    final response = await Provider.of<AuthApiServices>(context, listen: false)
                        .loginUser(context, widget.emailController.text.trim(), widget.passwordController.text.trim());

                    if (response != null && response['status'] == 'success') {
                      // After successful login, check if user data is saved in SharedPreferences
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      final userId = prefs.getString('userId');
                      final message = prefs.getString('message');

                      if (userId != null && message != null) {
                        print("🎉 Logged in. userId: $userId");

                        // Navigate to the Dashboard screen after successful login
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const DashboardScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response['message']), // Display the failure message
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      // Handle login failure due to incorrect credentials
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response?['message'] ?? 'An unknown error occurred'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } catch (e) {
                    // Handle any errors during the login process
                    print("Error during login: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("An error occurred during login."),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              }


          ),

        ],
      ),
    );
  }

  Widget _tabButton(String label, Color color) {
    return Container(
      height: 50,
      color: color,
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
