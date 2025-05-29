import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/app_text.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/hospital_model.dart';
import 'package:digital_nawabshah/src/screens/hospital_screen/hospital_profile_component/hospital_component_widget/hospital_contact_container_widget.dart';
import 'package:digital_nawabshah/src/screens/hospital_screen/hospital_profile_component/hospital_component_widget/hospital_reviews_container_widget.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/doctors_api_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalAboutContainerWidget extends StatelessWidget {

  final HospitalModel hospital;

  const HospitalAboutContainerWidget({
    super.key, required this.hospital,
  });

  @override
  Widget build(BuildContext context) {

    final hospitalProvider = Provider.of<DoctorsAPIServices>(context,listen: false);

    return Column(
      children: [
        Container(
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
                  text: hospital.description ?? "null",
                  maxLines: 21,
                  fontSize: screenWidth * 0.031,
                  color: Colors.black45,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.020),
        HospitalContactContainerWidget(hospital: hospital),
        SizedBox(height: screenHeight * 0.020),
        const HospitalReviewsContainerWidget(),
      ],
    );
  }
}
