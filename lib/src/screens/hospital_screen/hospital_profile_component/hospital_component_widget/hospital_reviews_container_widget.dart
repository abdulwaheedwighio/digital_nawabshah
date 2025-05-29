import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HospitalReviewsContainerWidget extends StatefulWidget {
  const HospitalReviewsContainerWidget({super.key});

  @override
  State<HospitalReviewsContainerWidget> createState() => _HospitalReviewsContainerWidgetState();
}

class _HospitalReviewsContainerWidgetState extends State<HospitalReviewsContainerWidget> {
  List<bool> isClicked = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: screenHeight * 0.25,
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: lightColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.015),
          Align(
            alignment: Alignment.center,
            child: TextWidget(
              text: "Reviews",
              color: primaryColor,
              fontSize: screenWidth * 0.050,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextWidget(
            text: "Rate This Hospital",
            fontSize: screenWidth * 0.040,
            color: primaryColor,
            fontWeight: FontWeight.w800,
          ),
          TextWidget(
            text: "Tell others what you think",
            fontSize: screenWidth * 0.035,
            color: Colors.black45,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: screenHeight * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    isClicked[index] = !isClicked[index]; // Toggle specific star
                  });
                },
                icon: Icon(
                  isClicked[index] ? CupertinoIcons.star_fill : CupertinoIcons.star,
                  size: screenWidth * 0.12,
                  color: isClicked[index] ? primaryColor : Colors.grey,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}