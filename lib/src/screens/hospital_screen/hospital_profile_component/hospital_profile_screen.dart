import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/fonts.dart';
import 'package:digital_nawabshah/src/model/hospital_model.dart';
import 'package:digital_nawabshah/src/screens/hospital_screen/hospital_profile_component/hospital_component_widget/hospital_about_container_widget.dart';
import 'package:digital_nawabshah/src/screens/hospital_screen/hospital_profile_component/hospital_component_widget/hospital_profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HospitalProfileScreen extends StatefulWidget {
  final HospitalModel hospital;

  const HospitalProfileScreen({super.key, required this.hospital});

  @override
  State<HospitalProfileScreen> createState() => _HospitalProfileScreenState();
}

class _HospitalProfileScreenState extends State<HospitalProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hospital = widget.hospital;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        centerTitle: true,
        title: TextWidget(
          text: hospital.name,
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            HospitalProfileWidget(hospital: hospital,), // Removed 'const'
            TabBar(
              controller: _tabController,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: primaryColor,
              tabs: const [
                Tab(text: "About"),
                Tab(text: "Doctor Available"),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: HospitalAboutContainerWidget(hospital: hospital), // Removed 'const'
                    ),
                    const SingleChildScrollView(
                      child: Center(
                        child: Text("Reviews Section"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
