import 'package:digital_nawabshah/src/model/laboratory_model.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratery_screen_widget/lab_availability_profile_container_widget.dart';
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratery_screen_widget/lab_profile_container_widget.dart';
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratery_screen_widget/payment_method_container_widget.dart';
import 'package:flutter/material.dart';

class LabProfileScreen extends StatelessWidget {
  final LaboratoryModel labModel;

  const LabProfileScreen({super.key, required this.labModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.030,
            vertical: screenHeight * 0.010),
        child: Column(
          children: [
            LabProfileContainerWidget(isLive: true,laboratory: labModel,), // Or use labModel.isLive
            SizedBox(height: screenHeight * 0.020),
            LabAvailabilityProfileContainerWidget(laboratory: labModel,),
            SizedBox(height: screenHeight * 0.020),
            const PaymentMethodContainerWidget(),
          ],
        ),
      ),
    );
  }
}
