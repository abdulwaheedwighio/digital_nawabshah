import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/doctor_model.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/doctors_api_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorReviewsExperience extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorReviewsExperience({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorsAPIServices>(context, listen: false);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.020,
        vertical: screenHeight * 0.010,
      ),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: const BoxDecoration(
          color: lightColor,
        ),
        child: Row(
          children: [
            _infoColumn("Reviews", "10+"),
            _verticalDivider(),
            _infoColumn("Experience", doctor.experience),
            _verticalDivider(),
            SizedBox(width: screenWidth * 0.015,),
            _infoColumn("Satisfaction", doctor.specialization),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String title, String value) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            text: title,
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
          Flexible(
            child: TextWidget(
              text: value,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return const SizedBox(
      height: 40,
      child: VerticalDivider(
        color: Colors.black,
        thickness: 1,
        width: 1,
      ),
    );
  }
}
