import 'dart:io';
import 'package:digital_nawabshah/src/component/widgets/custom_circle_image_widget.dart';
import 'package:digital_nawabshah/src/const/app_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_elevated_button.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_text_dropdown_button_field.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_text_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/validation.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/auth_api_services.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController selectCityController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = false;
  bool obscureText1 = false;
  

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    selectCityController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose(); // Always call this at the end
  }

  Future<String> _uploadImage(File imageFile) async {
    // Simulate upload delay
    await Future.delayed(const Duration(seconds: 2));

    // Return a fake image URL (you can change to Firebase/Supabase later)
    return "https://your-server.com/images/${imageFile.path.split('/').last}";
  }


  Future<void> userRegister() async {
    if (_formKey.currentState!.validate()) {
      String imageUrl = "";

      if (_pickedImage != null) {
        imageUrl = await _uploadImage(_pickedImage!);
      }

      await Provider.of<AuthApiServices>(context, listen: false).userCreateAccount(
        userNameController.text.trim(),
        emailController.text.trim(),
        phoneNumberController.text.trim(),
        selectCityController.text.trim(),
        passwordController.text.trim(),
        imageUrl, // Profile pic URL
        context,
      );
    }
  }



  final picker = ImagePicker();
  File? _pickedImage;

  Future<void> getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void removeFunction() {
    setState(() {
      _pickedImage = null;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
            text: "SIGN UP",
            color: lightColor,
            fontSize: screenWidth * 0.050,
            fontWeight: FontWeight.bold,
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:  Icon(CupertinoIcons.back,color: lightColor,size: screenWidth * 0.080,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.040,vertical: screenHeight * 0.040),
          child:  Column(
            children: [
              const RegistrationHeader(),
              Column(
                children: [
                  Form(
                    key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.020,),
                          Center(
                            child: CustomCircleImagePickerWidget(
                              imageFile: _pickedImage,
                              function: () {
                                AppMethod.imagePickerDialogue(
                                  context: context,
                                  getGalleryImage: getGalleryImage,
                                  getCameraImage: getCameraImage,
                                  removeFunction: removeFunction,
                                );
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.040,),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                                text: "NAME",
                                color: primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.0017,),
                           CustomTextFormFieldWidget(
                              controller: userNameController,
                              hintText: "Enter Your Name",
                              validator: (value){
                                return Validations.validateName(value);
                              },
                          ),
                          SizedBox(height: screenHeight * 0.0017,),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                              text: "EMAIL",
                              color: primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.0017,),
                          CustomTextFormFieldWidget(
                            controller: emailController,
                            hintText: "Enter Email",
                            validator: (value){
                              return Validations.validateEmail(value);
                            },
                          ),
                          SizedBox(height: screenHeight * 0.0017,),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                              text: "Phone Number",
                              color: primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.0017,),
                           CustomTextFormFieldWidget(
                              controller: phoneNumberController,
                              hintText: "Enter Phone Number",
                              validator: (value){
                                return Validations.validateNumber(value);
                              },
                          ),
                          SizedBox(height: screenHeight * 0.030,),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                              text: "Select City",
                              color: primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.0017,),
                          SizedBox(
                            height: 50,
                            child: CustomTextDropdownButtonWidget(
                              controller: selectCityController,
                              hintText: "Select a City",
                              isDropdown: true,
                              dropdownItems: const [
                                "Nawabshah",
                                "Qazi Ahmed",
                                "Sakrand",
                                "Hyderabad",
                                "Nushoro Feroz"
                              ],
                              selectedValue: "Nawabshah",
                              onDropdownChanged: (value) {
                                selectCityController.text = value!; // ✅ Set the value
                                print("Selected city: ${selectCityController.text}");
                              },
                              validator: (value){
                                return Validations.validateCity(value);
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.030,),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                              text: "Create Password",
                              color: primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.0017,),
                           CustomTextFormFieldWidget(
                              obscureText: obscureText,
                              controller: passwordController,
                              hintText: "Enter Password",
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      obscureText =! obscureText;
                                    });
                                  },
                                  icon: Icon(obscureText ?  CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_solid ),
                              ),
                              validator: (value){
                                return Validations.validatePassword(value);
                              },
                          ),
                          SizedBox(height: screenHeight * 0.030,),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                              text: "Confirm Password",
                              color: primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.0017,),
                           CustomTextFormFieldWidget(
                              controller: confirmPasswordController,
                              hintText: "Confirm Password",
                             suffixIcon: IconButton(
                               onPressed: (){
                                 setState(() {
                                   obscureText1 =! obscureText1;
                                 });
                               },
                               icon: Icon(obscureText1 ?  CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_solid ),
                             ),
                              validator: (value){
                                return Validations.validateConfirmPassword(
                                    passwordController.text,
                                    value,
                                );
                              },
                          ),
                          SizedBox(height: screenHeight * 0.025,),
                          CustomElevatedButton(
                              text: "SIGN UP",
                              width: double.infinity,
                              height: 40,
                              backgroundColor: primaryColor,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await userRegister();
                                }
                              }
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                          ),
                          SizedBox(height: screenHeight * 0.020,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TextWidget(
                                text: "Already have an account? ",
                                color: darkColor,
                                fontSize: 14,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: const TextWidget(
                                  text: " Login",
                                  color: darkColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          registrationLogo,
          width: screenWidth * 0.25,
          height: screenHeight * 0.090,
        ),
        FittedBox(
          child: TextWidget(
              text: "REGISTER NOW",
              color: primaryColor,
              fontSize: screenWidth * 0.080,
              fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
