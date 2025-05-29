import 'package:digital_nawabshah/src/component/widgets/custom_text_form_field_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/icon_button_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/doctors_api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DoctorReviewsContainerWidget extends StatefulWidget {
  final String doctorId;

  const DoctorReviewsContainerWidget({super.key, required this.doctorId});

  @override
  State<DoctorReviewsContainerWidget> createState() => _DoctorReviewsContainerWidgetState();
}

class _DoctorReviewsContainerWidgetState extends State<DoctorReviewsContainerWidget> {
  List<bool> isClicked = List.generate(5, (_) => false);
  final TextEditingController _commentController = TextEditingController();

  int getRating() => isClicked.where((clicked) => clicked).length;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoctorsAPIServices>(context, listen: false)
          .fetchDoctorFeedback(widget.doctorId);
    });
  }

  void _handleSubmit() async {
    final comment = _commentController.text.trim();
    final rating = getRating();
    final provider = Provider.of<DoctorsAPIServices>(context, listen: false);

    if (comment.isNotEmpty && rating > 0) {
      await provider.submitDoctorFeedback(
        doctorId: widget.doctorId,
        rating: rating,
        review: comment,
      );

      if (provider.errorMessage == null) {
        setState(() {
          _commentController.clear();
          isClicked = List.generate(5, (_) => false);
        });

        // ✅ Fetch new feedback after successful submission
        await provider.fetchDoctorFeedback(widget.doctorId);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Feedback submitted successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(provider.errorMessage!)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Please enter a comment and rating")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DoctorsAPIServices>(context);
    final feedbackList = provider.feedbackList;
    final isSubmitting = provider.isSubmitting;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Center(
            child: TextWidget(
              text: "Doctor Reviews",
              fontSize: screenWidth * 0.055,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 20),

          // Rating Title
          TextWidget(
            text: "Rate this Doctor",
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w700,
            color: primaryColor,
          ),
          const SizedBox(height: 4),
          TextWidget(
            text: "Tell others what you think",
            fontSize: screenWidth * 0.035,
            color: Colors.black54,
          ),
          const SizedBox(height: 12),

          // Star Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < 5; i++) {
                      isClicked[i] = i <= index;
                    }
                  });
                },
                icon: Icon(
                  isClicked[index]
                      ? CupertinoIcons.star_fill
                      : CupertinoIcons.star,
                  size: screenWidth * 0.10,
                  color: isClicked[index] ? primaryColor : Colors.grey,
                ),
              );
            }),
          ),
          const SizedBox(height: 10),

          // Comment Input
          TextWidget(
            text: "Write a comment",
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormFieldWidget(
                  controller: _commentController,
                  hintText: "Enter your feedback",
                ),
              ),
              const SizedBox(width: 8),
              IconButtonWidget(
                icon: isSubmitting
                    ? CupertinoIcons.time
                    : CupertinoIcons.paperplane,
                onTab: () {
                  if (!isSubmitting) _handleSubmit();
                },
              ),
            ],
          ),
          const SizedBox(height: 25),

          // Recent Reviews
          TextWidget(
            text: "Recent Reviews",
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          const SizedBox(height: 10),

          if (feedbackList.isEmpty)
            Center(
              child: TextWidget(
                text: "No reviews yet.",
                color: Colors.black54,
                fontSize: screenWidth * 0.035,
              ),
            )
          else
            ListView.builder(
              itemCount: feedbackList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final review = feedbackList[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage('assets/images/myImage.jpg'), // Replace with dynamic image
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: review.userName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.040,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: List.generate(5, (i) {
                                    final filled = (review.stars ?? 0) > i;
                                    return Icon(
                                      filled
                                          ? CupertinoIcons.star_fill
                                          : CupertinoIcons.star,
                                      size: 16,
                                      color: filled ? primaryColor : Colors.grey,
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          TextWidget(
                            text: DateFormat('dd MMM yyyy').format(DateTime.parse(review.date)),
                            fontSize: screenWidth * 0.032,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Review Content
                      TextWidget(
                        text: review.feedback,
                        fontSize: screenWidth * 0.035,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}


// import 'package:digital_nawabshah/src/component/widgets/custom_text_form_field_widget.dart';
// import 'package:digital_nawabshah/src/component/widgets/icon_button_widget.dart';
// import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
// import 'package:digital_nawabshah/src/const/colors.dart';
// import 'package:digital_nawabshah/src/const/utils.dart';
// import 'package:digital_nawabshah/src/services/auth_api_services/doctors_api_services.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart'; // For date formatting
//
// class DoctorReviewsContainerWidget extends StatefulWidget {
//   final String doctorId;
//
//   const DoctorReviewsContainerWidget({
//     super.key,
//     required this.doctorId,
//   });
//
//   @override
//   State<DoctorReviewsContainerWidget> createState() => _DoctorReviewsContainerWidgetState();
// }
//
// class _DoctorReviewsContainerWidgetState extends State<DoctorReviewsContainerWidget> {
//
//   List<bool> isClicked = List.generate(5, (index) => false);
//   final TextEditingController _commentController = TextEditingController();
//
//   int getRating() => isClicked.where((clicked) => clicked).length;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<DoctorsAPIServices>(context, listen: false)
//           .fetchDoctorFeedback(widget.doctorId); // Fetch feedback data
//     });
//   }
//
//
//   void _handleSubmit() async {
//       final comment = _commentController.text.trim();
//       final rating = getRating();
//       final provider = Provider.of<DoctorsAPIServices>(context, listen: false);
//
//       if (comment.isNotEmpty && rating > 0) {
//         await provider.submitDoctorFeedback(
//           doctorId: widget.doctorId,
//           rating: rating,
//           review: comment,
//         );
//
//         if (provider.errorMessage == null) {
//           setState(() {
//             _commentController.clear();
//             isClicked = List.generate(5, (_) => false);
//           });
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("✅ Feedback submitted successfully!")),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(provider.errorMessage!)),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("❌ Please enter a comment and rating")),
//         );
//       }
//     }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DoctorsAPIServices>(context);
//     final isSubmitting = provider.isSubmitting;
//     final feedbackList = provider.feedbackList;
//
//     return SingleChildScrollView( // Wrap with SingleChildScrollView
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(10.0),
//         decoration: const BoxDecoration(color: lightColor),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title and Header
//             SizedBox(height: screenHeight * 0.015),
//             Align(
//               alignment: Alignment.center,
//               child: TextWidget(
//                 text: "Reviews",
//                 color: primaryColor,
//                 fontSize: screenWidth * 0.050,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.015),
//             TextWidget(
//               text: "Rate this Doctor",
//               fontSize: screenWidth * 0.040,
//               color: primaryColor,
//               fontWeight: FontWeight.w800,
//             ),
//             TextWidget(
//               text: "Tell others what you think",
//               fontSize: screenWidth * 0.035,
//               color: Colors.black45,
//               fontWeight: FontWeight.w500,
//             ),
//             SizedBox(height: screenHeight * 0.015),
//
//             // Rating Stars
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(5, (index) {
//                 return IconButton(
//                   onPressed: () {
//                     setState(() {
//                       for (int i = 0; i < 5; i++) {
//                         isClicked[i] = i <= index;
//                       }
//                     });
//                   },
//                   icon: Icon(
//                     isClicked[index]
//                         ? CupertinoIcons.star_fill
//                         : CupertinoIcons.star,
//                     size: screenWidth * 0.10,
//                     color: isClicked[index] ? primaryColor : Colors.grey,
//                   ),
//                 );
//               }),
//             ),
//             SizedBox(height: screenHeight * 0.010),
//             TextWidget(
//               text: "Write a comment",
//               fontSize: screenWidth * 0.032,
//             ),
//             SizedBox(height: screenHeight * 0.013),
//
//             // Comment Input
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormFieldWidget(
//                     controller: _commentController,
//                     hintText: "Write Comment",
//                   ),
//                 ),
//                 SizedBox(width: screenWidth * 0.020),
//                 IconButtonWidget(
//                   icon: isSubmitting
//                       ? CupertinoIcons.time
//                       : CupertinoIcons.paperplane,
//                   onTab: () {
//                     if (!isSubmitting) _handleSubmit();
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: screenHeight * 0.020),
//
//             // Recent Reviews Section
//             TextWidget(
//               text: "Recent Reviews",
//               fontSize: screenWidth * 0.042,
//               fontWeight: FontWeight.bold,
//               color: primaryColor,
//             ),
//             SizedBox(height: screenHeight * 0.010),
//
//             // Feedback Display
//             if (feedbackList.isEmpty)
//               Center(
//                 child: TextWidget(
//                   text: "No reviews yet.",
//                   color: Colors.black54,
//                   fontSize: screenWidth * 0.035,
//                 ),
//               )
//             else
//               Column(
//                 children: feedbackList.map((review) {
//                   return Container(
//                     margin: const EdgeInsets.symmetric(vertical: 5),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 4,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             const CircleAvatar(
//                               radius: 22,
//                               backgroundImage: AssetImage('assets/images/myImage.jpg'), // Use dynamic profile image here
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   TextWidget(
//                                     text: review.userName,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: screenWidth * 0.040,
//                                   ),
//                                   Row(
//                                     children: List.generate(5, (index) {
//                                       final starValue = review.stars ?? 0;
//                                       print('Review by ${review.userName}: Stars = $starValue');
//                                       final isFilled = starValue > index;
//                                       return Icon(
//                                         isFilled ? CupertinoIcons.star_fill : CupertinoIcons.star,
//                                         color: isFilled ? primaryColor : Colors.grey,
//                                         size: 16,
//                                       );
//                                     }),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             TextWidget(
//                               text: DateFormat('dd MMM yyyy').format(DateTime.parse(review.date),),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 5),
//                         TextWidget(
//                           text: review.feedback,
//                           fontSize: screenWidth * 0.035,
//                           color: Colors.black87,
//                           maxLines: 4,
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
