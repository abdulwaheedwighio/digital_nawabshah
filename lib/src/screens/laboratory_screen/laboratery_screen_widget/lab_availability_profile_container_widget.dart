import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/laboratory_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabAvailabilityProfileContainerWidget extends StatelessWidget {


  final LaboratoryModel laboratory;

  const LabAvailabilityProfileContainerWidget({
    super.key, required this.laboratory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.25,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.circular(20),
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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                convenienceIcon,
                width: screenWidth * 0.10,
              ),
              SizedBox(width: screenWidth * 0.020,),
              TextWidget(
                text: "Availability",
                fontSize: screenWidth * 0.040,
                color: primaryColor,
                fontWeight: FontWeight.w800,
              ),
              const Spacer(),
              Image.asset(
                startIcon,
                width: 20,
                height: 20,
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.011,),
          const Divider(color: materialColor, height: 1),
          SizedBox(height: screenHeight * 0.020,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(CupertinoIcons.calendar,color: primaryColor,),
              SizedBox(width: screenHeight * 0.010,),
              TextWidget(text: "Days : ",fontSize: screenWidth * 0.035,fontWeight: FontWeight.w500,),
              Expanded(
                child: TextWidget(
                  text: "${laboratory.openingDays},",
                  maxLines: 3,
                  fontSize: screenWidth * 0.030,
                  overflow: TextOverflow.ellipsis, // Prevents overflow
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.020,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(CupertinoIcons.time,color: primaryColor,),
              SizedBox(width: screenHeight * 0.010,),
              TextWidget(text: "Timings : ",fontSize: screenWidth * 0.035,fontWeight: FontWeight.w500,),
              Expanded(
                child: TextWidget(
                  text: "${laboratory.openingTime}",
                  maxLines: 3,
                  fontSize: screenWidth * 0.030,
                  overflow: TextOverflow.ellipsis, // Prevents overflow
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
