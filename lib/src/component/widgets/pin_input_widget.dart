import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomPinput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;

  const CustomPinput({
    Key? key,
    required this.controller,
    this.onCompleted,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor,width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: primaryColor, width: 2),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(

    );

    return Pinput(
      controller: controller,
      length: 4,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      onCompleted: onCompleted,
      onChanged: onChanged,
    );
  }
}
