import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctors_view_location_screen/doctors_view_location_screen.dart';
import 'package:flutter/material.dart';

class DoctorsViewLocation extends StatelessWidget {
  final double? hospitalLat;
  final double? hospitalLng;

  const DoctorsViewLocation({
    super.key,
    required this.hospitalLat,
    required this.hospitalLng,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.1,
        vertical: screenHeight * 0.025,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const DoctorsViewLocationScreen(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 45,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                locationIcon,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              const TextWidget(
                text: "View Location",
                fontSize: 14,
                color: lightColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
