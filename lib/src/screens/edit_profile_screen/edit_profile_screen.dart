import 'dart:io';
import 'package:digital_nawabshah/src/component/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_circle_image_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_elevated_button.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_text_dropdown_button_field.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_text_form_field_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/app_method.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/fonts.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/user_model.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/auth_api_services.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final picker = ImagePicker();
  File? _pickedImage;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final dobController = TextEditingController();

  String gender = "Male";
  String religion = "Islam";

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthApiServices>(context, listen: false).user!.user;

    nameController.text = user.name;
    emailController.text = user.email;
    phoneController.text = user.phone;
    cityController.text = user.city;
    dobController.text = user.dateOfBirth ?? '';
    gender = user.gender ?? "Male";
    religion = user.religious ?? "Islam";
  }

  void setImage(File? image) {
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  Future<void> getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setImage(File(pickedFile.path));
  }

  Future<void> getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) setImage(File(pickedFile.path));
  }

  void removeFunction() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthApiServices>(context);
    final userModel = authService.user!;
    final user = userModel.user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: TextWidget(
          text: "Edit Profile",
          color: lightColor,
          fontSize: screenWidth * 0.050,
          fontFamily: poppinsRegular,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(CupertinoIcons.back, color: lightColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.040),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: TextWidget(
                text: "PERSONAL INFORMATION",
                color: primaryColor,
                fontSize: screenWidth * 0.060,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenHeight * 0.020),
            Form(
              child: Column(
                children: [
                  Center(
                    child: CustomCircleImagePickerWidget(
                      imageFile: _pickedImage,
                      networkImageUrl: user.image,
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
                  SizedBox(height: screenHeight * 0.020),
                  _buildTextField("NAME", nameController),
                  _buildTextField("EMAIL", emailController),
                  _buildTextField("Phone Number", phoneController),
                  _buildTextField("City", cityController),
                  _buildTextField("Date of Birth", dobController, isDatePicker: true),
                  _buildDropdownField("Gender", gender, ['Male', 'Female', 'Other'], (value) {
                    setState(() => gender = value!);
                  }),
                  _buildDropdownField("Religion", religion, ['Islam', 'Christianity', 'Hinduism', 'Other'], (value) {
                    setState(() => religion = value!);
                  }),
                  SizedBox(height: screenHeight * 0.030),
                  CustomElevatedButton(
                    text: "UPDATE",
                    width: double.infinity,
                    height: 45,
                    backgroundColor: primaryColor,
                      onPressed: () async {
                        // Optional: Show loading dialog
                        // Utils.showLoadingDialog(context, "Updating profile...");

                        try {
                          final isUpdated = await Provider.of<AuthApiServices>(context, listen: false).updateUserProfile(
                            userId: user.id,
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            phone: phoneController.text.trim(),
                            city: cityController.text.trim(),
                            gender: gender,
                            religious: religion,
                            dateOfBirth: dobController.text.trim(),
                            imageFile: _pickedImage, // ✅ Pass picked File or null
                          );

                          // Navigator.pop(context); // Close loading dialog

                          if (isUpdated) {
                            print("✅ Profile updated successfully");
                            // Optional: Show snackbar
                            // Utils.showSnackBar(context, "✅ Profile updated successfully", isSuccess: true);
                            Navigator.pop(context); // Navigate back
                          } else {
                            print("❌ Failed to update profile");
                            // Utils.showSnackBar(context, "❌ Failed to update profile", isSuccess: false);
                          }
                        } catch (e) {
                          // Navigator.pop(context); // Close loading dialog
                          print("🚨 Error: ${e.toString()}");
                          // Utils.showSnackBar(context, "🚨 Error: ${e.toString()}", isSuccess: false);
                        }
                      }

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isDatePicker = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: label,
          color: primaryColor,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        CustomTextFormFieldWidget(
          hintText: "Enter $label",
          controller: controller,
          isDatePicker: isDatePicker,
        ),
        SizedBox(height: screenHeight * 0.030),
      ],
    );
  }

  Widget _buildDropdownField(String label, String selectedValue, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: label,
          color: primaryColor,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        CustomTextDropdownButtonWidget(
          selectedValue: selectedValue,
          hintText: label,
          dropdownItems: items,
          onChanged: onChanged,
        ),
        SizedBox(height: screenHeight * 0.030),
      ],
    );
  }
}
