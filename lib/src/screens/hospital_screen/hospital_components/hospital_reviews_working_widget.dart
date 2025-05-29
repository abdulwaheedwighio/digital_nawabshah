import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/hospital_model.dart';
import 'package:digital_nawabshah/src/screens/hospital_screen/hospital_profile_component/hospital_profile_screen.dart';
import 'package:flutter/material.dart';

class HospitalReviewsWorkingWidget extends StatelessWidget {
  final HospitalModel hospital;

  const HospitalReviewsWorkingWidget({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.02,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoColumn("Reviews", "10+"),
                  _verticalDivider(),
                  _infoColumn("Working Hours", "5 Years"),
                  _verticalDivider(),
                  _infoColumn("Satisfaction", "80%"),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              SizedBox(
                width: screenWidth * 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HospitalProfileScreen(hospital: hospital),
                      ),
                    );
                  },
                  child: const Text(
                    "View Profile",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoColumn(String title, String value) {
    return Column(
      children: [
        TextWidget(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
        const SizedBox(height: 4),
        TextWidget(
          text: value,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 40,
      width: 1.5,
      color: Colors.grey,
    );
  }
}
