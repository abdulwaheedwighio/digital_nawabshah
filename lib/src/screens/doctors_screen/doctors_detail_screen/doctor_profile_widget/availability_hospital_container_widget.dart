import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/doctor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailabilityHospitalContainerWidget extends StatelessWidget {
  final String hospitalName;
  final String days;
  final String timings;
  final bool isFree;

  const AvailabilityHospitalContainerWidget({
    super.key,
    required this.hospitalName,
    required this.days,
    required this.timings,
    required this.isFree,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.25,
      decoration: BoxDecoration(
        border: Border.all(
          color: materialColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    hospitalImage,
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: screenWidth * 0.010),
                Expanded(
                  child: TextWidget(
                    text: hospitalName,
                    fontSize: screenWidth * 0.039,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  children: [
                    Image.asset(
                      startIcon,
                      width: 20,
                      height: 20,
                    ),
                    TextWidget(
                      text: isFree ? "Free" : "Paid",
                      fontSize: 10,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.010),
            const Divider(color: materialColor, height: 1),
            SizedBox(height: screenHeight * 0.020),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(CupertinoIcons.calendar, color: primaryColor),
                SizedBox(width: screenHeight * 0.010),
                TextWidget(
                  text: "Days : ",
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(
                  child: TextWidget(
                    text: days,
                    maxLines: 3,
                    fontSize: screenWidth * 0.030,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.020),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(CupertinoIcons.time, color: primaryColor),
                SizedBox(width: screenHeight * 0.010),
                TextWidget(
                  text: "Timings : ",
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(
                  child: TextWidget(
                    text: timings,
                    maxLines: 3,
                    fontSize: screenWidth * 0.030,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}