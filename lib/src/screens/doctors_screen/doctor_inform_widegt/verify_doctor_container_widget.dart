import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/app_text.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:flutter/material.dart';

class VerifiedDoctorContainerWidget extends StatelessWidget {
  const VerifiedDoctorContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.30,
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: lightColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              width: screenWidth * 0.25,
              thumbIcon,
            ),
            Image.asset(
              width: screenWidth * 0.31,
              verifiedIcon,
            ),
            TextWidget(
              text: verifyDoctorBySTS,
              fontSize: screenWidth * 0.030,
              color: Colors.black45,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
