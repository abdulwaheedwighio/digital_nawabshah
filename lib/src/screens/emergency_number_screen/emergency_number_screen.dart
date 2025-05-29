import 'package:digital_nawabshah/src/component/widgets/custom_text_form_field_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:flutter/material.dart';

class EmergencyNumberScreen extends StatefulWidget {
  const EmergencyNumberScreen({super.key});

  @override
  State<EmergencyNumberScreen> createState() => _EmergencyNumberScreenState();
}

class _EmergencyNumberScreenState extends State<EmergencyNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title:  TextWidget(
            text: "Emergency Numbers",
            color: lightColor,
            fontSize: screenWidth * 0.050,
            fontWeight: FontWeight.w400,
        ),
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
              color: lightColor,
            ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.13,
            decoration: const BoxDecoration(
              color: lightColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.030,vertical: screenHeight * 0.030),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormFieldWidget(
                      prefixIcon: Icons.search,
                      hintText: "Search",
                  ),
                ],
              ),
            )
          ),
          SizedBox(height: screenHeight * 0.020,),
          Expanded(
            child: SizedBox(
              height: screenHeight, // Ensure a fixed height
              child: ListView.builder(
                itemCount: 9,
                scrollDirection: Axis.vertical,
                shrinkWrap: true, // Ensures correct height inside SingleChildScrollView
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: screenWidth * 0.4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.020),
                      child: const EmergencyNumberWidgets(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmergencyNumberWidgets extends StatelessWidget {
  const EmergencyNumberWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.060),
      child: Column(
        children: [
          SizedBox( // Use SizedBox instead of Expanded
            width: double.infinity,
            height: screenHeight * 0.15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: primaryColor,
                    child: Image.asset(ambulanceServiceIcon, width: 45),
                  ),
                  SizedBox(width: screenWidth * 0.060),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: "Ambulance Service",
                        color: primaryColor,
                        fontSize: screenWidth * 0.050,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: screenWidth * 0.020),
                      TextWidget(
                        text: "(15)",
                        color: primaryColor,
                        fontSize: screenWidth * 0.050,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
