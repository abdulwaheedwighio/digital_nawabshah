import 'package:digital_nawabshah/src/component/widgets/custom_elevated_button.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/app_text.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/laboratory_model.dart';
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratery_list_screen.dart';
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratery_price_list_screen.dart';
import 'package:flutter/material.dart';

class LabAvailabilityContainerWidget extends StatelessWidget {

  final LaboratoryModel laboratory;

  const LabAvailabilityContainerWidget({
    super.key, required this.laboratory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.70,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: lightColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow color
            spreadRadius: 2, // Spread of shadow
            blurRadius: 5, // Blur effect
            offset: const Offset(0, 3), // Shadow position (x, y)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: "Available Test",
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w800,
            color: primaryColor,
          ),
          SizedBox(height: screenHeight * 0.010,),
          const Divider(color: materialColor, height: 1),
          SizedBox(height: screenHeight * 0.010,),
          Align(
            alignment: Alignment.center,
            child: CustomElevatedButton(
              text: "Available Test",
                onPressed: () async {
                  await Future.delayed(Duration(seconds: 2)); // Dummy delay
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LaboratoryPriceListScreen()),
                  );
                  print("Click Object");
                }

            ),
          ),
          SizedBox(height: screenHeight * 0.010,),
          Container(
            width: double.infinity,
            height: screenHeight * 0.45,
            decoration: BoxDecoration(
              color: lightColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Light shadow color
                  spreadRadius: 2, // Spread of shadow
                  blurRadius: 5, // Blur effect
                  offset: const Offset(0, 3), // Shadow position (x, y)
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: "About",
                        fontSize: screenWidth * 0.050,
                        color: darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                      Image.asset(
                        startIcon,
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.010,),
                  const Divider(color: materialColor, height: 1),
                  SizedBox(height: screenHeight * 0.010,),
                  TextWidget(
                    text: aboutDoctorText,
                    maxLines: 21,
                    fontSize: screenWidth * 0.031,
                    color: Colors.black45,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
