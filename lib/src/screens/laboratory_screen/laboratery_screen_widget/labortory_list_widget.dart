import 'package:digital_nawabshah/src/model/laboratory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart'; // Your color constants
import 'package:digital_nawabshah/src/const/utils.dart'; // Your utils (screen height, etc.)
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratory_detail_screen/laboratory_detail_screen.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_elevated_button.dart';
import 'package:digital_nawabshah/src/const/image_string.dart'; // Your location icon path

class LaboratoryListWidget extends StatelessWidget {
  final LaboratoryModel laboratory;

  const LaboratoryListWidget({
    super.key, required this.laboratory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.38,  // Adjust height to fit content properly
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 50, // Keeps the container below the image
            left: 20,
            right: 20,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.25,  // Adjust the height for content inside
              padding: const EdgeInsets.all(8), // Adds spacing inside the container
              decoration: BoxDecoration(
                color: lightColor,
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.070),
                  TextWidget(
                    text: "${laboratory.labName}",
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                    fontSize: screenHeight * 0.020,
                  ),
                  RatingBar.builder(
                    initialRating: 5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20, // Adjust the size of the stars (Default is 40)
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0), // Reduce spacing between stars
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  TextWidget(
                    text: "${laboratory.labName}",
                    fontWeight: FontWeight.w200,
                    color: Colors.grey,
                    fontSize: screenHeight * 0.017,
                  ),
                  // **Buttons (View Location and View Profile) added below the lab name**
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: materialColor1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          onPressed: () {
                            // Logic to show live location of laboratory
                            print("Live Location button pressed");
                          },
                          child: Row(
                            children: [
                              Image.asset(locationIcon, width: 15),
                              const SizedBox(width: 5),
                              const TextWidget(
                                text: "Live Location",
                                fontSize: 14,
                                color: lightColor,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        CustomElevatedButton(
                          backgroundColor: lightColor,
                          text: "View Profile",
                          textColor: materialColor1,
                          fontSize: 14,
                          onPressed: () async {
                            await Future.delayed(Duration(seconds: 2)); // Dummy delay
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LaboratoryDetailScreen(labModel: laboratory),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// **Circle Image (Remains Centered)**
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () {
                _showFullImage(context, laboratory.imagePath); // Show full image on tap
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 55,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(laboratory.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the full image in a dialog
  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,  // Make the image fit within the dialog
          ),
        );
      },
    );
  }
}
