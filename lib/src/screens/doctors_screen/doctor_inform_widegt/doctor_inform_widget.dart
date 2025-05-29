import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/model/doctor_model.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctor_inform_widegt/doctor_reviews_experience_widget.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctor_inform_widegt/doctors_view_description.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctors_detail_screen/doctors_detail_screen.dart';
import 'package:flutter/material.dart';

class DoctorInformationWidget extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorInformationWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorsDetailScreen(doctor: doctor, userId: '',),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        // margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          color: lightColor,
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(doctor.imagePath),
              ),
              title: TextWidget(
                text: doctor.name,
                fontSize: 15,
                color: primaryColor,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.underline,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(text: doctor.specialization, fontSize: 13),
                  TextWidget(text: "|${doctor.qualification}|", fontSize: 12),
                ],
              ),
            ),
              DoctorReviewsExperience(doctor: doctor,),
              DoctorsViewDescription(doctor: doctor,),
           // DoctorsViewLocation(hospitalLat: null, hospitalLng: null,),
          ],
        ),
      ),
    );
  }
}
