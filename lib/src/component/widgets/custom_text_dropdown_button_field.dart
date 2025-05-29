import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextDropdownButtonWidget extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final void Function()? onSuffixIconTap;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final String? selectedValue;
  final void Function(String?)? onDropdownChanged;

  const CustomTextDropdownButtonWidget({
    Key? key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.minLines,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.onSuffixIconTap,
    this.isDropdown = false,
    this.dropdownItems,
    this.selectedValue,
    this.onDropdownChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isDropdown
        ? DropdownButtonFormField<String>(
      value: selectedValue,
      items: dropdownItems?.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: TextWidget(text: item,fontSize: 15,),
        );
      }).toList(),
      onChanged: onDropdownChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: errorColor,
          ),
        ),
      ),
    )
        : TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines,
        minLines: minLines,
        autofocus: autofocus,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? GestureDetector(
                onTap: onSuffixIconTap,
                child: Icon(suffixIcon),
              )
            : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: primaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: errorColor,
            ),
          ),

      ),
    );
  }
}
