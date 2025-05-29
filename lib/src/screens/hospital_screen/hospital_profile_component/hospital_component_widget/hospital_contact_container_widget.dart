import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/hospital_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HospitalContactContainerWidget extends StatelessWidget {

  final HospitalModel hospital;

  const HospitalContactContainerWidget({
    super.key, required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.35,
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
                  text: "Contact Information",
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(CupertinoIcons.phone_fill,color: primaryColor,),
                SizedBox(width: screenWidth * 0.010,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "Phone Number",
                      maxLines: 21,
                      fontSize: screenWidth * 0.037,
                      textAlign: TextAlign.justify,
                    ),
                    TextWidget(
                      text: "${hospital.phone}",
                      maxLines: 1,
                      fontSize: screenWidth * 0.030,
                      textAlign: TextAlign.justify,
                      color: Colors.black54,
                    ),
                    TextWidget(
                      text: "${hospital.phone}",
                      maxLines: 1,
                      fontSize: screenWidth * 0.030,
                      textAlign: TextAlign.justify,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.030,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(CupertinoIcons.mail_solid,color: primaryColor,),
                SizedBox(width: screenWidth * 0.010,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "Email",
                      maxLines: 21,
                      fontSize: screenWidth * 0.037,
                      textAlign: TextAlign.justify,
                    ),
                    TextWidget(
                      text: "${hospital.email}",
                      maxLines: 1,
                      fontSize: screenWidth * 0.030,
                      textAlign: TextAlign.justify,
                      color: Colors.black54,
                    ),
                    TextWidget(
                      text: "${hospital.email}",
                      maxLines: 1,
                      fontSize: screenWidth * 0.030,
                      textAlign: TextAlign.justify,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.030,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(CupertinoIcons.location_solid,color: primaryColor,),
                SizedBox(width: screenWidth * 0.010,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "Address",
                      maxLines: 21,
                      fontSize: screenWidth * 0.037,
                      textAlign: TextAlign.justify,
                    ),
                    TextWidget(
                      text: "Hospital Road Nawabshah",
                      maxLines: 1,
                      fontSize: screenWidth * 0.030,
                      textAlign: TextAlign.justify,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
