import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIconButton;
  final TextInputType keyboardType;
  final bool isObscure;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Color borderColor;
  final Color? fillColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;

  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.suffixIconButton,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
    this.validator,
    this.onChanged,
    this.borderColor = Colors.transparent,
    this.focusedBorderColor = Colors.transparent,
    this.errorBorderColor = Colors.transparent, this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isObscure,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIconButton,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          filled: true, // ✅ Enable background color
          fillColor: fillColor, // ✅ Set background color to white
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(color: borderColor, width: 1),

          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(color: focusedBorderColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(color: errorBorderColor, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(color: errorBorderColor, width: 2),
          ),
        ),
      ),
    );
  }
}
