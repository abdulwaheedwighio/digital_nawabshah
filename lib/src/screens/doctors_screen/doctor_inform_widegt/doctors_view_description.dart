
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/app_text.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/doctor_model.dart';
import 'package:flutter/material.dart';

class DoctorsViewDescription extends StatelessWidget {

  final DoctorModel doctor;

  const DoctorsViewDescription({
    super.key, required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.070,
        padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 5),
        decoration: BoxDecoration(
            color: containerColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8.0)
        ),
        child: TextWidget(
          text: "${doctor.description} ReadMore",
          fontSize: 12,
          maxLines: 2,
        ),
      ),
    );
  }
}
