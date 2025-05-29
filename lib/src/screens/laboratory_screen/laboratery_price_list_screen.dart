import 'package:digital_nawabshah/src/component/widgets/custom_text_form_field_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/fonts.dart';
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratery_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LaboratoryPriceListScreen extends StatefulWidget {
  const LaboratoryPriceListScreen({super.key});

  @override
  State<LaboratoryPriceListScreen> createState() => _LaboratoryPriceListScreenState();
}

class _LaboratoryPriceListScreenState extends State<LaboratoryPriceListScreen> {

  final TextEditingController labSearchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        centerTitle: true,
        title: const TextWidget(
          text: "Lab Tests",
          color: primaryColor,
          fontSize: 23,
          fontFamily: poppinsBold,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            size: 30,
            color: primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          /// **Search Bar**
           Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormFieldWidget(
                controller: labSearchController,
                hintText: "Search Lab Tests",
                prefixIcon: CupertinoIcons.search,
            ),
          ),

          /// **Lab List**
          Expanded(child: LabList()), // Expands to fill remaining space
        ],
      ),
    );
  }
}
