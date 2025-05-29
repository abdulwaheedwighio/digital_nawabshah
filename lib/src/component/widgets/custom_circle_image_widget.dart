import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:digital_nawabshah/src/const/colors.dart';

class CustomCircleImagePickerWidget extends StatelessWidget {
  final File? imageFile;
  final String? networkImageUrl; // Can be URL
  final String? base64Image;     // For base64 support
  final VoidCallback function;

  const CustomCircleImagePickerWidget({
    super.key,
    required this.function,
    this.imageFile,
    this.networkImageUrl,
    this.base64Image,
  });

  @override
  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (imageFile != null) {
      imageProvider = FileImage(imageFile!);
    } else if (base64Image != null && base64Image!.isNotEmpty) {
      try {
        imageProvider = MemoryImage(base64Decode(base64Image!));
      } catch (e) {
        imageProvider = const AssetImage('assets/default_user.png');
      }
    } else if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
      // Check if it’s actually a file path being passed mistakenly
      if (networkImageUrl!.startsWith('http')) {
        imageProvider = NetworkImage(networkImageUrl!);
      } else {
        imageProvider = FileImage(File(networkImageUrl!));
      }
    } else {
      imageProvider = const AssetImage('assets/default_user.png');
    }

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.grey[300],
            backgroundImage: imageProvider,
            child: (imageFile == null && networkImageUrl == null && base64Image == null)
                ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.grey,
                ),
              )
                : null,
          ),
        ),
        Positioned(
          right: 10,
          bottom: 15,
          child: Material(
            borderRadius: BorderRadius.circular(16.0),
            color: primaryColor,
            child: InkWell(
              splashColor: primaryColor,
              borderRadius: BorderRadius.circular(16.0),
              onTap: function,
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
