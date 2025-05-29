import 'package:digital_nawabshah/src/component/widgets/custom_elevated_button.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_text_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/pin_input_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/app_text.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpCodeController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: primaryColor,width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          text: "Verification",
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
                  text: "Verification",
                  fontSize: screenWidth * 0.068,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.13,),
              TextWidget(
                text: "Verify By Email",
                fontSize: screenWidth * 0.045,
                color: primaryColor,
                fontWeight: FontWeight.bold,
                maxLines: 3,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: TextWidget(
                  text: verifyByEmail,
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  maxLines: 2,
                ),
              ),
              Form(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.030,),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        openLockIcon,
                        width: screenWidth * 0.35,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.020,),
                    CustomPinput(
                      controller: otpCodeController,
                      onCompleted: (pin) {
                        print("Completed PIN: $pin");
                      },
                      onChanged: (value) {
                        print("Current PIN: $value");
                      },
                    ),
                    // Pinput(
                    //   defaultPinTheme: defaultPinTheme,
                    //   validator: (s) {
                    //     return s == '2222' ? null : 'Pin is incorrect';
                    //   },
                    //   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    //   showCursor: true,
                    //   onCompleted: (pin) => print(pin),
                    // ),
                    SizedBox(height: screenHeight * 0.030,),
                    CustomElevatedButton(
                        width: screenWidth * 0.55,
                        text: "Send Email",
                        backgroundColor: primaryColor,
                        onPressed: ()async{
                          await Future.delayed(Duration(seconds: 2)); // Dummy delay

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
