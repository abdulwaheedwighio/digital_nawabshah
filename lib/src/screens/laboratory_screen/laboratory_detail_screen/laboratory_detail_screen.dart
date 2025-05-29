import 'package:digital_nawabshah/src/model/laboratory_model.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratory_detail_screen/lab_profile_screens/available_test_screen.dart';
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratory_detail_screen/lab_profile_screens/lab_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LaboratoryDetailScreen extends StatefulWidget {
  final LaboratoryModel labModel;

  const LaboratoryDetailScreen({super.key, required this.labModel});

  @override
  State<LaboratoryDetailScreen> createState() =>
      _LaboratoryDetailScreenState();
}

class _LaboratoryDetailScreenState extends State<LaboratoryDetailScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        centerTitle: true,
        title: TextWidget(
          text: widget.labModel.labName,
          color: primaryColor,
          fontSize: screenWidth * 0.050,
          fontWeight: FontWeight.w800,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: screenWidth * 0.30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        _selectedTab == 0 ? primaryColor : materialColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedTab = 0;
                        });
                      },
                      child: TextWidget(
                        text: "Profile",
                        fontSize: 14,
                        color: _selectedTab == 0 ? lightColor : primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: screenWidth * 0.39,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        _selectedTab == 1 ? primaryColor : materialColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedTab = 1;
                        });
                      },
                      child: TextWidget(
                        text: "Available Tests",
                        fontSize: 14,
                        color: _selectedTab == 1 ? lightColor : primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: screenWidth * 0.35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        _selectedTab == 2 ? primaryColor : materialColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedTab = 2;
                        });
                      },
                      child: TextWidget(
                        text: "About Us",
                        fontSize: 14,
                        color: _selectedTab == 2 ? lightColor : primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedTab,
              children: [
                LabProfileScreen(labModel: widget.labModel),
                 AvailableTestScreen(laboratoryModel: widget.labModel,),
                Container(
                  color: Colors.green,
                  child: Center(
                    child: TextWidget(
                      text: "About Us Section",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
