import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:flutter/material.dart';

class PaymentMethodContainerWidget extends StatelessWidget {
  const PaymentMethodContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.23,
      padding: const EdgeInsets.all(15.0),
      decoration:  BoxDecoration(
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
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: "Payment Method",
            color: primaryColor,
            fontSize: screenWidth * 0.042,
            fontWeight: FontWeight.w800,
          ),
          SizedBox(height: screenHeight * 0.015,),
          const Divider(color: materialColor, height: 1),
          SizedBox(height: screenHeight * 0.015,),
          const TextWidget(text: "1). Cash"),
          SizedBox(height: screenHeight * 0.010,),
          const TextWidget(text: "2). Online"),
          SizedBox(height: screenHeight * 0.010,),
          const TextWidget(text: "3). Debit Credit Card"),

        ],
      ),
    );
  }
}
