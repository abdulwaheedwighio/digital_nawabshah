
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.030,),
          Image.asset(
            digitalNawabshahLogo,
            width: screenWidth * 0.60,
            height: screenHeight * 0.18,
          ),
          SizedBox(height: screenHeight * 0.010,),
          Image.asset(
            digitalIcon,
            width: screenWidth * 0.50,
            height: screenHeight * 0.050,
          ),
          SizedBox(height: screenHeight * 0.005,),
          Image.asset(
            nawabshahIcon,
            width: screenWidth * 0.70,
            height: screenHeight * 0.045,
          ),
        ],
      ),
    );
  }
}
