import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CustomImagePickerWidget extends StatefulWidget {
  @override
  _CustomImagePickerWidgetState createState() => _CustomImagePickerWidgetState();
}

class _CustomImagePickerWidgetState extends State<CustomImagePickerWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Circular Image Picker'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.grey[300],
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child: _image == null
                ? const Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 40,
            )
                : null,
          ),
        ),
      ),
    );
  }
}