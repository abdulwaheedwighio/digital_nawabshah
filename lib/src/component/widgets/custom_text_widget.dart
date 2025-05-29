import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon; // ✅ Changed from IconData? to Widget?
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final bool isDatePicker;

  const CustomTextFormFieldWidget({
    Key? key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon, // ✅ Now accepts Widget (IconButton, etc.)
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.minLines,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.isDatePicker = false,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isDatePicker ? TextInputType.none : keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
      readOnly: isDatePicker,
      onTap: isDatePicker
          ? () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
          helpText: 'Select Date',
          fieldLabelText: 'Day/Month/Year',
          fieldHintText: 'DD-MM-YYYY',
          initialEntryMode: DatePickerEntryMode.calendar,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                dialogBackgroundColor: Colors.white,
                colorScheme: const ColorScheme.light(
                  primary: primaryColor,
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null && controller != null) {
          controller!.text =
          "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
        }
      }
          : null,

      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 1, color: primaryColor),
        ),
      ),
    );
  }

}
