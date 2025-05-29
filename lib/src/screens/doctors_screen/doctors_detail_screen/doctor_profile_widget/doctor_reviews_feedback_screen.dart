import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class DoctorReviewsFeedbackScreen extends StatelessWidget {

  final String doctorId;

  const DoctorReviewsFeedbackScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/images/myImage.jpg'), // Replace with your asset
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Allison Dorwart',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        Icon(Icons.star_half, size: 16, color: Colors.amber),
                        SizedBox(width: 4),
                        Text('4.5', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                DateFormat('dd MMM yyyy').format(DateTime(2024, 5, 19)),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Dr. Stanton was thorough, attentive, and took the time to answer all my questions in detail. I left feeling confident in my health and the care I received. Highly recommend!',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
