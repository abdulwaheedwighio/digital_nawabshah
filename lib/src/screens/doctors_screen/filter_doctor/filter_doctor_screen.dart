import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:flutter/material.dart';

class FilterDoctorScreen extends StatefulWidget {
  const FilterDoctorScreen({super.key});

  @override
  State<FilterDoctorScreen> createState() => _FilterDoctorScreenState();
}

class _FilterDoctorScreenState extends State<FilterDoctorScreen> {
  String? _selectedSpecialist;

  final List<String> _specializations = [
    'Cardiologist',
    'Neurologist',
    'Pediatrician',
    'Dermatologist',
    'Orthopedic',
  ];

  Widget? _getSpecialistWidget() {
    switch (_selectedSpecialist) {
      case 'Cardiologist':
        return CardiologistScreen();
      case 'Neurologist':
        return NeurologistScreen();
      case 'Pediatrician':
        return PediatricianScreen();
      case 'Dermatologist':
        return DermatologistScreen();
      case 'Orthopedic':
        return OrthopedicScreen();
      default:
        return null;
    }
  }

  void _showCategoryBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _categoryItem('General Medicine', Icons.local_hospital, Colors.green, () {
                  Navigator.pop(context);
                  _showSpecialistBottomSheet([
                    _specialistItem('Cardiologist', Icons.favorite, Colors.red),
                    _specialistItem('Neurologist', Icons.psychology, Colors.blue),
                  ]);
                }),
                const SizedBox(height: 10),
                _categoryItem('Surgical', Icons.local_activity, Colors.orange, () {
                  Navigator.pop(context);
                  _showSpecialistBottomSheet([
                    _specialistItem('Pediatrician', Icons.child_care, Colors.purple),
                    _specialistItem('Dermatologist', Icons.spa, Colors.green),
                  ]);
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSpecialistBottomSheet(List<Widget> specialistItems) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: specialistItems,
            ),
          ),
        );
      },
    );
  }

  Widget _categoryItem(String name, IconData icon, Color iconColor, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.2),
            child: Icon(icon, color: iconColor),
          ),
          title: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _specialistItem(String name, IconData icon, Color iconColor) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          _selectedSpecialist = name;
        });
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.2),
            child: Icon(icon, color: iconColor),
          ),
          title: Text(name, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select Doctor Category"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _showCategoryBottomSheet,
              icon: const Icon(Icons.local_hospital),
              label: const Text("Browse by Category"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 25),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: "Select Specialization",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blueGrey.shade700,
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.medical_services_outlined, color: primaryColor),
                suffixIcon: Icon(Icons.arrow_drop_down, color: primaryColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: primaryColor, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              ),
              value: _selectedSpecialist,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              iconEnabledColor: primaryColor,
              style: TextStyle(fontSize: 16, color: Colors.black87),
              items: _specializations.map((specialist) {
                return DropdownMenuItem(
                  value: specialist,
                  child: Text(specialist, style: TextStyle(fontWeight: FontWeight.w500)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedSpecialist = value);
              },
            ),
            const SizedBox(height: 30),
            if (_getSpecialistWidget() != null)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _getSpecialistWidget()!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Specialist Screens ----------------

class CardiologistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          _buildSpecialistScreen(
              'Cardiologist',
              "This is Doctor of Cardiologist",
              "https://s3-eu-west-1.amazonaws.com/intercare-web-public/wysiwyg-uploads%2F1580196666465-doctor.jpg",
          ),
        ],
    );
  }
}

class NeurologistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildSpecialistScreen(
        'Neurologist',
        "This Is a Doctor of Neurologist",
        "https://www.shutterstock.com/image-photo/medical-concept-indian-beautiful-female-600nw-1635029716.jpg",
    );
  }
}

class PediatricianScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildSpecialistScreen(
        'Pediatrician',
        "This is a Doctor of Pediatrician",
        "https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg",
    );
  }
}

class DermatologistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildSpecialistScreen(
        'Dermatologist',
        "This is a doctor of Dermatologist",
        "https://plus.unsplash.com/premium_photo-1658506671316-0b293df7c72b?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8ZG9jdG9yfGVufDB8fDB8fHww"
    );
  }
}

class OrthopedicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildSpecialistScreen(
        'Orthopedic',
        "This is a Doctor of Orthopedic",
        "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=926&fit=clip",
    );
  }
}

// --------------- Reusable Widget -----------------

Widget _buildSpecialistScreen(String title,String doctorSpecialist,String imageUrl) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(imageUrl), // Replace with your image path
          backgroundColor: Colors.grey.shade200,
        ),
      ),
      const SizedBox(height: 10),
      TextWidget(text: title,fontSize: screenWidth * 0.040,fontWeight: FontWeight.bold),
      const SizedBox(height: 10),
      TextWidget(text: doctorSpecialist,fontSize: screenWidth * 0.036,color: Colors.grey,),
      const SizedBox(height: 20),

    ],
  );
}
