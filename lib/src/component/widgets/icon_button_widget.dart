import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {

  final VoidCallback onTab;
  final IconData icon;

  const IconButtonWidget({
    super.key,
    required this.onTab,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryColor, // Background color
        shape: BoxShape.circle, // Circular shape for better UI
      ),
      child: IconButton(
        onPressed: onTab,
        icon: Icon(
          icon, // Send icon
          size: screenWidth * 0.06,
          color: Colors.white, // White icon for better contrast
        ),
      ),
    );
  }
}
