import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/laboratory_model.dart';
import 'package:flutter/material.dart';

class LabProfileContainerWidget extends StatelessWidget {

  final LaboratoryModel laboratory;

  const LabProfileContainerWidget({
    super.key,
    required this.isLive, required this.laboratory,
  });

  final bool isLive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.15,
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
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  color: lightColor,
                ),
                child: ClipOval(
                  child: Image.network(
                    laboratory.imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),

                ),
              ),
              Positioned(
                bottom: 5, // Position at bottom-right
                right: 5,
                child: Container(
                  width: 20, // Adjusted size
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isLive ? Colors.green : Colors.red, // Green for online, red for offline
                    border: Border.all(color: Colors.white, width: 2), // White border
                  ),
                  child: Align(
                    alignment: Alignment.centerRight, // Align icon to the right
                    child: Icon(
                      isLive ? Icons.check : Icons.close, // Check icon if online, Close icon if offline
                      color: Colors.white, // White icon
                      size: 14, // Adjusted size for better visibility
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: screenWidth * 0.020),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(text: "${laboratory.labName}", color: primaryColor,fontSize: screenWidth * 0.045,fontWeight: FontWeight.w800,),
              TextWidget(text: "${laboratory.discounts}", color: primaryColor, fontSize: screenWidth * 0.037),
              TextWidget(text: "${laboratory.openingDays}", color: primaryColor, fontSize: screenWidth * 0.037),
            ],
          ),
        ],
      ),
    );
  }
}
