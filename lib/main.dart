import 'package:digital_nawabshah/src/const/fonts.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/provider/user_detail_provider.dart';
import 'package:digital_nawabshah/src/screens/auth_screen/login_screen.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/auth_api_services.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/doctors_api_services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AuthApiServices(),
        ),
        ChangeNotifierProvider(
            create: (context) => DoctorsAPIServices(),
        ),
        ChangeNotifierProvider(
            create: (context) => UserDetailProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Digital Nawabshah',
        theme: ThemeData(
          fontFamily: poppinsRegular,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}

class LottieScreen extends StatefulWidget {
  const LottieScreen({super.key});

  @override
  State<LottieScreen> createState() => _LottieScreenState();
}

class _LottieScreenState extends State<LottieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/Animation - 1745664923739.json",width: 200,height: 200),
          ],
        ),
      ),
    );
  }
}
