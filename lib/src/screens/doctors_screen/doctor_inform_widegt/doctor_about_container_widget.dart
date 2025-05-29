import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/app_text.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/doctor_model.dart';
import 'package:flutter/material.dart';

class DoctorAboutContainerWidget extends StatelessWidget {

  final DoctorModel doctor;

  const DoctorAboutContainerWidget({
    super.key, required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: lightColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Take only required space
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextWidget(
                  text: "About",
                  fontWeight: FontWeight.w800,
                  color: darkColor,
                ),
                Image.asset(
                  startIcon,
                  width: 20,
                  height: 20,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.010),
            const Divider(color: materialColor, height: 1),
            SizedBox(height: screenHeight * 0.010),
            TextWidget(
              text: doctor.description,
              maxLines: 21,
              fontSize: screenWidth * 0.031,
              color: Colors.black45,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
