import 'package:digital_nawabshah/src/component/widgets/custom_checkbox_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_elevated_button.dart';
import 'package:digital_nawabshah/src/component/widgets/dropdown_button_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:flutter/material.dart';

class LaboratoryFilterScreen extends StatefulWidget {
  const LaboratoryFilterScreen({super.key});

  @override
  State<LaboratoryFilterScreen> createState() => _LaboratoryFilterScreenState();
}

class _LaboratoryFilterScreenState extends State<LaboratoryFilterScreen> {

  bool nearMeCheckBox = false;
  bool privateCheckBox = false;
  bool governmentCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          text: "Filter Result",
          fontSize: screenWidth * 0.060,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: primaryColor,
            size: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.030,),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: lightColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextWidget(
                      text: "Select Area",
                    ),
                    SizedBox(height: screenHeight * 0.010,),
                    SizedBox(
                      width: screenWidth * 0.65,
                      height: screenHeight * 0.055,
                      child: DropdownButtonWidget(
                        items: const ['Item 1', 'Item 2', 'Item 3'],
                        onChanged: (value) {
                          print('Selected: $value');
                        },
                      ),
                    ),

                    CustomCheckBox(
                      value: nearMeCheckBox,
                      activeColor: primaryColor,
                      checkColor: lightColor,
                      onChanged: (value){
                        setState(() {
                          nearMeCheckBox = value!;
                        });
                      },
                      label: "Near Me",
                    ),
                    SizedBox(height: screenHeight * 0.060,),
                    const TextWidget(
                      text: "Select Hospital Type",
                    ),

                    CustomCheckBox(
                      value: privateCheckBox,
                      checkColor: lightColor,
                      activeColor: primaryColor,
                      onChanged: (value){
                        setState(() {
                          privateCheckBox = value!;
                        });
                      },
                      label: "Private",
                    ),
                    CustomCheckBox(
                      value: governmentCheckBox,
                      checkColor: lightColor,
                      activeColor: primaryColor,
                      onChanged: (value){
                        setState(() {
                          governmentCheckBox = value!;
                        });
                      },
                      label: "Government",
                    ),
                    SizedBox(height: screenHeight * 0.020,),
                    Align(
                      alignment: Alignment.topCenter,
                      child: CustomElevatedButton(
                          text: "Clear Setting",
                          fontSize: 14,
                          backgroundColor: materialColor1,
                          textColor: lightColor,
                          onPressed: ()async{
                            await Future.delayed(Duration(seconds: 2)); // Dummy delay
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
