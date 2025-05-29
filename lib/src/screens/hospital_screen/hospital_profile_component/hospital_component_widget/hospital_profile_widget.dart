import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/model/hospital_model.dart';

class HospitalProfileWidget extends StatelessWidget {
  final HospitalModel hospital;

  const HospitalProfileWidget({
    super.key, required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 50, // Keeps the container below the image
            left: 20,
            right: 20,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.18,
              padding: const EdgeInsets.all(8), // Adds spacing inside the container
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.070),
                  TextWidget(
                    text: "${hospital.name}",
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                    fontSize: screenHeight * 0.020,
                  ),
                  RatingBar.builder(
                    initialRating: 2,
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
                    text: "${hospital.sector}",
                    fontWeight: FontWeight.w200,
                    color: Colors.grey,
                    fontSize: screenHeight * 0.017,
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
                _showFullImage(context, hospital.imagePath); // Show full image on tap
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
                      image: NetworkImage(hospital.imagePath),
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
