import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/image_string.dart';
import 'package:flutter/material.dart';

class LabList extends StatefulWidget {
  @override
  State<LabList> createState() => _LabListState();
}

class _LabListState extends State<LabList> {
  final List<Map<String, String>> labs = [
    {'name': 'Khan Lab', 'address': 'Hospital Road C.S.32 A', 'timing': '9 AM - 5 PM'},
    {'name': 'XYZ Lab', 'address': 'Street 2, City', 'timing': '10 AM - 6 PM'},
    {'name': 'Health Care Lab', 'address': 'Street 3, City', 'timing': '8 AM - 4 PM'},
    {'name': 'Medico Plus', 'address': 'Street 4, City', 'timing': '11 AM - 7 PM'},
    {'name': 'Lab Tech', 'address': 'Street 5, City', 'timing': '7 AM - 3 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: labs.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print('${labs[index]['name']} clicked');
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const TextWidget(
                    text: "Lab Detail"
                ),
                content: Text('You selected ${labs[index]['name']}'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            shadowColor: Colors.grey.withOpacity(0.5),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue[50]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 30,
                    child: ClipOval(  // Ensures the image is circular
                      child: Image.asset(
                        khanLabImage,
                        width: 60, // Ensure it covers the CircleAvatar
                        height: 60,
                        fit: BoxFit.cover, // Ensures the image fills the space
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          labs[index]['name']!,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          labs[index]['address']!,
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        Text(
                          'Timing: ${labs[index]['timing']}',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.blue[800]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}