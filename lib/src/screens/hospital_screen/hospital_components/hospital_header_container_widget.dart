import 'package:digital_nawabshah/src/model/hospital_model.dart';
import 'package:digital_nawabshah/src/screens/hospital_screen/hospital_profile_component/hospital_profile_screen.dart';
import 'package:digital_nawabshah/src/screens/hospital_screen/view_hospital_location_screen/view_hospital_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/screens/hospital_screen/hospital_components/hospital_reviews_working_widget.dart';

class HospitalHeaderContainerWidget extends StatelessWidget {
  final HospitalModel hospital;

  const HospitalHeaderContainerWidget({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HospitalProfileScreen(hospital: hospital),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        height: screenHeight * 0.60,
        decoration: const BoxDecoration(
          color: lightColor,
        ),
        child: Column(
          children: [
            // Location Row
            ViewLocationButton(
              onTab: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const  ViewHospitalLocationScreen()));
              },
            ),
            SizedBox(height: screenHeight * 0.020),

            // Hospital Image
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(hospital.imagePath),
            ),
            SizedBox(height: screenHeight * 0.015),

            // Hospital Name
            TextWidget(
              text: hospital.name,
              fontSize: screenWidth * 0.040,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
            SizedBox(height: screenHeight * 0.010),

            // Hospital Sector
            TextWidget(
              text: hospital.sector,
              fontSize: screenWidth * 0.035,
            ),

            // Working/Reviews Widget
            HospitalReviewsWorkingWidget(hospital: hospital),
          ],
        ),
      ),
    );
  }
}


class ViewLocationButton extends StatelessWidget {
  final VoidCallback onTab;
  const ViewLocationButton({
    super.key,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            width: 25,
            height: 25,
            locationIcon,
          ),
          SizedBox(width: screenWidth * 0.015),
          const TextWidget(
            text: "View Location",
            fontWeight: FontWeight.w800,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}
