import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/model/doctor_model.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctor_inform_widegt/doctor_reviews_container_widget.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctors_detail_screen/doctor_profile_widget/doctor_contact_information.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctors_detail_screen/doctor_profile_widget/doctor_profile_widget.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctors_detail_screen/doctor_profile_widget/doctor_reviews_feedback_screen.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/doctors_api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorsDetailScreen extends StatefulWidget {
  final String userId;
  final DoctorModel doctor;

  const DoctorsDetailScreen({super.key, required this.doctor, required this.userId});

  @override
  State<DoctorsDetailScreen> createState() => _DoctorsDetailScreenState();
}

class _DoctorsDetailScreenState extends State<DoctorsDetailScreen> {
  int _selectedTab = 0; // Store selected tab index
  bool isLive = false;

  @override
  void initState() {
    super.initState();
    // Fetch doctor data if needed, or you can access it directly from the widget.
  }

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorsAPIServices>(context, listen: false);

    if (doctorProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final doctor = widget.doctor; // Access the doctor passed from previous screen

    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Doctor Details",
          style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            size: 30,
            color: Colors.black,
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
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedTab == 0 ? primaryColor : materialColor,
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
                    width: MediaQuery.of(context).size.width * 0.39,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedTab == 1 ? primaryColor : materialColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedTab = 1;
                        });
                      },
                      child: TextWidget(
                        text: "Contact Info",
                        fontSize: 14,
                        color: _selectedTab == 1 ? lightColor : primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedTab == 2 ? primaryColor : materialColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedTab = 2;
                        });
                      },
                      child: TextWidget(
                        text: "Availability",
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
                DoctorViewProfileScreen(isLive: isLive, doctor: widget.doctor,),
                DoctorContactInformation(doctor: widget.doctor,),
                DoctorReviewsContainerWidget(doctorId: widget.doctor.id,),
                // DoctorReviewsFeedbackScreen(doctorId: widget.doctor.id),

              // ListView.builder(
              //       itemCount: 3,
              //       itemBuilder: (context,index){
              //         return
              //       }
              //   ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
