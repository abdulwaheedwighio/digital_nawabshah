import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/doctor_model.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctor_inform_widegt/doctor_about_container_widget.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctor_inform_widegt/doctor_reviews_container_widget.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctor_inform_widegt/verify_doctor_container_widget.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctors_detail_screen/doctor_profile_widget/availability_hospital_container_widget.dart';
import 'package:flutter/material.dart';

class DoctorViewProfileScreen extends StatefulWidget {
  const DoctorViewProfileScreen({
    super.key,
    required this.isLive,
    required this.doctor,
  });

  final bool isLive;
  final DoctorModel doctor;

  @override
  State<DoctorViewProfileScreen> createState() => _DoctorViewProfileScreenState();
}

class _DoctorViewProfileScreenState extends State<DoctorViewProfileScreen> {
  bool isClick = false;

  String _formatDays(List<OpdTiming>? opdTimings) {
    if (opdTimings == null || opdTimings.isEmpty) return "Not available";
    return opdTimings.map((e) => e.day).join(', ');
  }

  String _formatTimings(List<OpdTiming>? opdTimings) {
    if (opdTimings == null || opdTimings.isEmpty) return "Not available";
    return opdTimings.map((e) {
      final clinicName = e.clinic?.name ?? 'Unknown Clinic';
      return '${e.day}: ${e.from} - ${e.to} at $clinicName';
    }).join('\n');
  }

  String _calculateSatisfaction() {
    if (widget.doctor.feedback.isEmpty) return "0";

    // Treat all feedbacks as positive if no stars field exists
    final positive = widget.doctor.feedback.where((f) => (f.stars ?? 5) >= 4).length;
    final total = widget.doctor.feedback.length;

    return ((positive / total) * 100).toStringAsFixed(0);
  }


  String _calculateAverageRating() {
    if (widget.doctor.feedback.isEmpty) return "0";
    final totalStars = widget.doctor.feedback.fold<int>(0, (sum, f) => sum + (f.stars ?? 5)); // default to 5
    final avg = totalStars / widget.doctor.feedback.length;
    return avg.toStringAsFixed(1);
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.030, vertical: screenHeight * 0.010),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.15,
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => _showFullImage(context, widget.doctor.imagePath),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: ClipOval(
                              child: Image.network(
                                widget.doctor.imagePath,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(Icons.person, size: 80),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.isLive ? Colors.green : Colors.red,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(
                              widget.isLive ? Icons.check : Icons.close,
                              color: Colors.white,
                              size: 14,
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
                        TextWidget(
                          text: widget.doctor.name,
                          color: primaryColor,
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w800,
                        ),
                        TextWidget(
                          text: widget.doctor.specialization,
                          color: primaryColor,
                          fontSize: screenWidth * 0.037,
                        ),
                        TextWidget(
                          text: widget.doctor.qualification,
                          color: primaryColor,
                          fontSize: screenWidth * 0.037,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenWidth * 0.020),
              TextWidget(
                text: "${_calculateAverageRating()}+",
                fontSize: screenWidth * 0.070,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
              TextWidget(
                text: "Positive Patient Reviews",
                fontSize: screenWidth * 0.045,
                color: primaryColor,
                fontWeight: FontWeight.w700,
              ),
              TextWidget(
                text: "View All",
                fontSize: screenWidth * 0.040,
                color: primaryColor,
                fontWeight: FontWeight.w400,
              ),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _containerDetail("Experience", widget.doctor.experience),
                    _containerDetail("Satisfaction", "${_calculateSatisfaction()}%"),
                    _containerDetail("Ratings", "${_calculateAverageRating()} ★"),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.020),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                        text: "Availability",
                        fontWeight: FontWeight.w800,
                        color: darkColor,
                      ),
                      SizedBox(height: screenHeight * 0.030),
                      AvailabilityHospitalContainerWidget(
                        hospitalName: widget.doctor.opDTimings.isNotEmpty
                            ? widget.doctor.opDTimings.first.clinic?.name ?? 'City Hospital'
                            : 'City Hospital',
                        days: _formatDays(widget.doctor.opDTimings),
                        isFree: widget.doctor.verified,
                        timings: _formatTimings(widget.doctor.opDTimings),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
              DoctorAboutContainerWidget(doctor: widget.doctor),
              SizedBox(height: screenHeight * 0.025),
              const VerifiedDoctorContainerWidget(),
              SizedBox(height: screenHeight * 0.025),
              DoctorReviewsContainerWidget(doctorId: widget.doctor.id),
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: screenWidth * 0.28,
        height: screenHeight * 0.090,
        decoration: BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                text: title,
                fontSize: screenWidth * 0.038,
                fontWeight: FontWeight.bold,
              ),
              TextWidget(
                text: value,
                fontSize: screenWidth * 0.032,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Icon(Icons.broken_image),
        ),
      ),
    );
  }
}


// import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
// import 'package:digital_nawabshah/src/const/colors.dart';
// import 'package:digital_nawabshah/src/const/utils.dart';
// import 'package:digital_nawabshah/src/model/doctor_model.dart';
// import 'package:digital_nawabshah/src/screens/doctors_screen/doctor_inform_widegt/doctor_about_container_widget.dart';
// import 'package:digital_nawabshah/src/screens/doctors_screen/doctor_inform_widegt/doctor_reviews_container_widget.dart';
// import 'package:digital_nawabshah/src/screens/doctors_screen/doctor_inform_widegt/verify_doctor_container_widget.dart';
// import 'package:digital_nawabshah/src/screens/doctors_screen/doctors_detail_screen/doctor_profile_widget/availability_hospital_container_widget.dart';
// import 'package:flutter/material.dart';
//
// class DoctorViewProfileScreen extends StatefulWidget {
//   const DoctorViewProfileScreen({
//     super.key,
//     required this.isLive, required this.doctor,
//   });
//
//   final bool isLive;
//   final DoctorModel doctor;
//
//   @override
//   State<DoctorViewProfileScreen> createState() => _DoctorViewProfileScreenState();
// }
//
// class _DoctorViewProfileScreenState extends State<DoctorViewProfileScreen> {
//
//   String _formatDays(List<dynamic>? opdTimings) {
//     if (opdTimings == null || opdTimings.isEmpty) return "Not available";
//     return opdTimings.map((e) => (e as OpdTiming).day).join(', ');
//   }
//
//   String _formatTimings(List<dynamic>? opdTimings) {
//     if (opdTimings == null || opdTimings.isEmpty) return "Not available";
//     return opdTimings.map((e) {
//       final timing = e as OpdTiming;
//       return '${timing.from} - ${timing.to}';
//     }).join('\n');
//   }
//
//
//   bool isClick = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.030, vertical: screenHeight * 0.010),
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: screenHeight * 0.15,
//                 decoration: BoxDecoration(
//                   color: lightColor,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//                     Stack(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             // Navigate to a new screen or show a dialog with the full image
//                             _showFullImage(context, widget.doctor.imagePath);
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.only(left: 10),
//                             decoration: const BoxDecoration(
//                               color: lightColor,
//                             ),
//                             child: ClipOval(
//                               child: Image.network(
//                                 widget.doctor.imagePath,  // Use doctor's image from the passed data
//                                 width: 80,
//                                 height: 80,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 5, // Position at bottom-right
//                           right: 5,
//                           child: Container(
//                             width: 20, // Adjusted size
//                             height: 20,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: widget.isLive ? Colors.green : Colors.red, // Green for online, red for offline
//                               border: Border.all(color: Colors.white, width: 2), // White border
//                             ),
//                             child: Align(
//                               alignment: Alignment.centerRight, // Align icon to the right
//                               child: Icon(
//                                 widget.isLive ? Icons.check : Icons.close, // Check icon if online, Close icon if offline
//                                 color: Colors.white, // White icon
//                                 size: 14, // Adjusted size for better visibility
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(width: screenWidth * 0.020),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         TextWidget(
//                           text: widget.doctor.name,  // Use the doctor's name
//                           color: primaryColor,
//                           fontSize: screenWidth * 0.045,
//                           fontWeight: FontWeight.w800,
//                         ),
//                         TextWidget(
//                           text: widget.doctor.specialization,  // Use the doctor's specialization
//                           color: primaryColor,
//                           fontSize: screenWidth * 0.037,
//                         ),
//                         TextWidget(
//                           text: widget.doctor.qualification,  // Use the doctor's qualifications
//                           color: primaryColor,
//                           fontSize: screenWidth * 0.037,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: screenWidth * 0.010),
//               TextWidget(
//                 text: "10+",
//                 fontSize: screenWidth * 0.070,
//                 color: primaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//               SizedBox(height: screenWidth * 0.010),
//               TextWidget(
//                 text: "Positive Patient Reviews",
//                 fontSize: screenWidth * 0.045,
//                 color: primaryColor,
//                 fontWeight: FontWeight.w700,
//               ),
//               SizedBox(height: screenWidth * 0.010),
//               TextWidget(
//                 text: "View All",
//                 fontSize: screenWidth * 0.040,
//                 color: primaryColor,
//                 fontWeight: FontWeight.w400,
//               ),
//               SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     FittedBox(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _containerDetail("Experience", widget.doctor.experience),  // Display dynamic experience
//                           _containerDetail("Satisfaction", widget.doctor.specialization),  // Display dynamic satisfaction
//                           _containerDetail("Ratings", widget.doctor.specialization),  // Display dynamic ratings
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: screenHeight * 0.020),
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: lightColor,
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const TextWidget(
//                               text: "Availability",
//                               fontWeight: FontWeight.w800,
//                               color: darkColor,
//                             ),
//                             SizedBox(height: screenHeight * 0.030),
//                             AvailabilityHospitalContainerWidget(
//                               hospitalName: "City Hospital", // or from doctor.hospitalName if available
//                               days: _formatDays(widget.doctor.opDTimings),
//                               isFree: widget.doctor.verified,
//                               timings: _formatTimings(widget.doctor.opDTimings),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: screenHeight * 0.030),
//                     // AvailabilityHospitalContainerWidget(
//                     //   hospitalName: "City Hospital", // or from doctor.hospitalName if available
//                     //   days: _formatDays(widget.doctor.opDTimings),
//                     //   isFree: widget.doctor.verified,
//                     //   timings: _formatTimings(widget.doctor.opDTimings),
//                     // ),
//                     SizedBox(height: screenHeight * 0.025),
//                     DoctorAboutContainerWidget(doctor: widget.doctor,),
//                     SizedBox(height: screenHeight * 0.025),
//                     const VerifiedDoctorContainerWidget(),
//                     SizedBox(height: screenHeight * 0.025),
//                     DoctorReviewsContainerWidget(doctorId: widget.doctor.id, ),
//
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _containerDetail(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Container(
//         width: screenWidth * 0.28, // Reduce width
//         height: screenHeight * 0.090,
//         decoration: BoxDecoration(
//           color: lightColor,
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextWidget(
//                 text: title,
//                 fontSize: screenWidth * 0.038,
//                 fontWeight: FontWeight.bold,
//               ),
//               TextWidget(
//                 text: value,  // Display dynamic value (Experience, Satisfaction, etc.)
//                 fontSize: screenWidth * 0.032,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   // Function to show the full image
//   void _showFullImage(BuildContext context, String imageUrl) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           child: Image.network(
//             imageUrl,
//             fit: BoxFit.contain,  // Make the image fit within the dialog
//           ),
//         );
//       },
//     );
//   }
// }
//
//
//
