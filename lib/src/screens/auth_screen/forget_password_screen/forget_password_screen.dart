import 'package:digital_nawabshah/src/component/widgets/custom_elevated_button.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_text_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/app_text.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/screens/auth_screen/forget_password_screen/otp_verification/otp_verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          text: "Forget Password",
          color: lightColor,
          fontSize: screenWidth * 0.050,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: (){},
          icon:  Icon(CupertinoIcons.back,color: lightColor,size: screenWidth * 0.080,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.055,vertical: screenHeight * 0.055),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: TextWidget(
                  text: "Forget Password",
                  fontSize: screenWidth * 0.068,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.010,),
              Align(
                alignment: Alignment.topCenter,
                child: TextWidget(
                  text: forgetPasswordText,
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  maxLines: 2,
                  textAlign: TextAlign.center, // Yeh line add karo
                ),
              ),
              SizedBox(height: screenHeight * 0.12,),
              TextWidget(
                text: sendEmailText,
                fontSize: screenWidth * 0.040,
                color: primaryColor,
                maxLines: 3,
              ),
              Form(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.030,),
                      const CustomTextFormFieldWidget(
                          hintText: "Enter Email",
                      ),
                      SizedBox(height: screenHeight * 0.030,),
                      CustomElevatedButton(
                          width: screenWidth * 0.55,
                          text: "Send Email",
                          backgroundColor: primaryColor,
                          onPressed: ()async{
                            await Future.delayed(const Duration(seconds: 2)); // Dummy delay
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const OtpVerificationScreen()));
                          }
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
}
