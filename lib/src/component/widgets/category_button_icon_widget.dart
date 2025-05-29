import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:flutter/material.dart';

class CategoryButtonIcon extends StatelessWidget {
  final String imagePath; // Image asset path
  final String label;
  final VoidCallback onPressed;
  final Color textColor;
  final double imageSize;

  const CategoryButtonIcon({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onPressed,
    this.textColor = Colors.black,
    this.imageSize = 20, // Default image size
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.cover,
          ),
           SizedBox(height: screenHeight * 0.002),
          TextWidget(
            text: label,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}
