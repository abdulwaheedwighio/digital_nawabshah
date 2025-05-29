
import 'package:digital_nawabshah/src/model/laboratory_model.dart';
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratery_screen_widget/lab_availability_container_widget.dart';
import 'package:flutter/material.dart';

class AvailableTestScreen extends StatefulWidget {
  final LaboratoryModel laboratoryModel;
  const AvailableTestScreen({super.key, required this.laboratoryModel});

  @override
  State<AvailableTestScreen> createState() => _AvailableTestScreenState();
}

class _AvailableTestScreenState extends State<AvailableTestScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LabAvailabilityContainerWidget(laboratory: widget.laboratoryModel,),
        ],
      ),
    );
  }
}

// class LabAvailabilityContainerWidget extends StatelessWidget {
//   const LabAvailabilityContainerWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: screenHeight * 0.70,
//       padding: const EdgeInsets.all(12.0),
//       decoration: BoxDecoration(
//         color: lightColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1), // Light shadow color
//             spreadRadius: 2, // Spread of shadow
//             blurRadius: 5, // Blur effect
//             offset: const Offset(0, 3), // Shadow position (x, y)
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextWidget(
//             text: "Available Test",
//             fontSize: screenWidth * 0.045,
//             fontWeight: FontWeight.w800,
//             color: primaryColor,
//           ),
//           SizedBox(height: screenHeight * 0.010,),
//           const Divider(color: materialColor, height: 1),
//           SizedBox(height: screenHeight * 0.010,),
//           Align(
//             alignment: Alignment.center,
//             child: CustomElevatedButton(
//                 text: "Available Test",
//                 onPressed: (){},
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.010,),
//           Container(
//             width: double.infinity,
//             height: screenHeight * 0.45,
//             decoration: BoxDecoration(
//               color: lightColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3), // Light shadow color
//                   spreadRadius: 2, // Spread of shadow
//                   blurRadius: 5, // Blur effect
//                   offset: const Offset(0, 3), // Shadow position (x, y)
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(13.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextWidget(
//                         text: "About",
//                         fontSize: screenWidth * 0.050,
//                         color: darkColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       Image.asset(
//                         startIcon,
//                         width: 20,
//                         height: 20,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: screenHeight * 0.010,),
//                   const Divider(color: materialColor, height: 1),
//                   SizedBox(height: screenHeight * 0.010,),
//                   TextWidget(
//                     text: aboutDoctorText,
//                     maxLines: 21,
//                     fontSize: screenWidth * 0.031,
//                     color: Colors.black45,
//                     textAlign: TextAlign.justify,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
