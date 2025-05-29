import 'dart:async';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String text;
  final Future<void> Function() onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;
  final EdgeInsets padding;
  final double? width;
  final double? height;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = primaryColor,
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
    this.borderRadius = 2.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressed();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.backgroundColor),
          foregroundColor: MaterialStateProperty.all(widget.textColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ),
          padding: MaterialStateProperty.all(widget.padding),
          elevation: MaterialStateProperty.all(2),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: _isLoading ? null : _handlePress,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
          child: _isLoading
              ? const SizedBox(
            key: ValueKey('loader'),
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            ),
          )
              : TextWidget(
            key: const ValueKey('text'),
            text: widget.text,
            color: widget.textColor,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
          ),
        ),
      ),
    );
  }
}
