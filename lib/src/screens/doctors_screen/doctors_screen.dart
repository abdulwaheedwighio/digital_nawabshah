import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_text_form_field_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/fonts.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/doctor_model.dart';
import 'package:digital_nawabshah/src/screens/doctors_screen/doctor_inform_widegt/doctor_inform_widget.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/doctors_api_services.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  late Future<List<DoctorModel>> _doctorFuture;
  List<DoctorModel> _allDoctors = [];
  List<DoctorModel> _filteredDoctors = [];
  final TextEditingController _searchController = TextEditingController();
  String _selectedSpecialization = 'All';

  @override
  void initState() {
    super.initState();
    final apiService = Provider.of<DoctorsAPIServices>(context, listen: false);
    _doctorFuture = apiService.getDoctorApi();
    _searchController.addListener(_applyFilters);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    final query = _searchController.text.trim().toLowerCase();
    final selectedSpec = _selectedSpecialization.toLowerCase();

    setState(() {
      _filteredDoctors = _allDoctors.where((doctor) {
        final matchesName = doctor.name.toLowerCase().contains(query);
        final matchesSpecialization = _selectedSpecialization == 'All' ||
            doctor.specialization.toLowerCase() == selectedSpec;
        return matchesName && matchesSpecialization;
      }).toList();
    });
  }

  void _showFilterBottomSheet() {
    final specializations = _allDoctors.map((e) => e.specialization).toSet().toList();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: lightColor,
      builder: (context) {
        String tempSelected = _selectedSpecialization;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Filter by Specialization",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    children: [
                      ChoiceChip(
                        label: const Text("All"),
                        selected: tempSelected == 'All',
                        onSelected: (_) => setModalState(() => tempSelected = 'All'),
                      ),
                      ...specializations.map((spec) => ChoiceChip(
                        label: Text(spec),
                        selected: tempSelected == spec,
                        onSelected: (_) => setModalState(() => tempSelected = spec),
                      ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              _selectedSpecialization = 'All';
                              _applyFilters();
                            });
                          },
                          child: const Text('Clear'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              _selectedSpecialization = tempSelected;
                              _applyFilters();
                            });
                          },
                          child: const Text("Apply"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        backgroundColor: lightColor,
        centerTitle: true,
        title: const TextWidget(
          text: "Doctors",
          color: primaryColor,
          fontSize: 23,
          fontFamily: poppinsBold,
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, size: 30, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: primaryColor),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: lightColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextFormFieldWidget(
              controller: _searchController,
              keyboardType: TextInputType.text,
              hintText: "Search Doctor by Name",
              prefixIcon: CupertinoIcons.search,
              fillColor: materialColor,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<DoctorModel>>(
              future: _doctorFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.asset(
                      'assets/lottie/Animation - 17455943505602.json',
                      width: 150,
                      height: 150,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final doctors = snapshot.data ?? [];
                if (_allDoctors.isEmpty) {
                  _allDoctors = doctors;
                  _filteredDoctors = doctors;
                }

                if (_filteredDoctors.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/Animation - 17455943505602.json',
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'No Doctor Found',
                          style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  // padding: const EdgeInsets.all(16),
                  itemCount: _filteredDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = _filteredDoctors[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: DoctorInformationWidget(doctor: doctor),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:digital_nawabshah/src/component/widgets/custom_text_form_field_widget.dart';
// import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
// import 'package:digital_nawabshah/src/const/colors.dart';
// import 'package:digital_nawabshah/src/const/fonts.dart';
// import 'package:digital_nawabshah/src/const/utils.dart';
// import 'package:digital_nawabshah/src/model/doctor_model.dart';
// import 'package:digital_nawabshah/src/screens/doctors_screen/doctor_inform_widegt/doctor_inform_widget.dart';
// import 'package:digital_nawabshah/src/screens/doctors_screen/filter_doctor/filter_doctor_screen.dart';
// import 'package:digital_nawabshah/src/services/auth_api_services/doctors_api_services.dart';
//
// class DoctorsScreen extends StatefulWidget {
//   const DoctorsScreen({super.key});
//
//   @override
//   State<DoctorsScreen> createState() => _DoctorsScreenState();
// }
//
// class _DoctorsScreenState extends State<DoctorsScreen> {
//   late Future<List<DoctorModel>> _doctorFuture;
//   List<DoctorModel> _allDoctors = [];
//   List<DoctorModel> _filteredDoctors = [];
//   final TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     final apiService = Provider.of<DoctorsAPIServices>(context, listen: false);
//     _doctorFuture = apiService.getDoctorApi();
//     _searchController.addListener(_filterDoctors);
//   }
//
//   void _filterDoctors() {
//     final query = _searchController.text.trim().toLowerCase();
//     setState(() {
//       _filteredDoctors = _allDoctors.where((doctor) {
//         return doctor.name.toLowerCase().contains(query);
//       }).toList();
//     });
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: lightColor,
//         centerTitle: true,
//         title: const TextWidget(
//           text: "Doctors",
//           color: primaryColor,
//           fontSize: 23,
//           fontFamily: poppinsBold,
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(
//             CupertinoIcons.back,
//             size: 30,
//             color: primaryColor,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const FilterDoctorScreen()),
//               );
//             },
//             child: const TextWidget(
//               text: "Filters",
//               fontSize: 16,
//               color: primaryColor,
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             color: lightColor,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             child: Column(
//               children: [
//                 SizedBox(height: screenHeight * 0.01),
//                 TextFormFieldWidget(
//                   controller: _searchController,
//                   keyboardType: TextInputType.text,
//                   hintText: "Search Doctor by Name",
//                   prefixIcon: CupertinoIcons.search,
//                   fillColor: materialColor,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: FutureBuilder<List<DoctorModel>>(
//               future: _doctorFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: Lottie.asset(
//                       'assets/lottie/Animation - 17455943505602.json',
//                       width: 150,
//                       height: 150,
//                       fit: BoxFit.contain,
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text(
//                       'Error: ${snapshot.error}',
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   );
//                 }
//
//                 final doctors = snapshot.data ?? [];
//                 if (_allDoctors.isEmpty) {
//                   _allDoctors = doctors;
//                   _filteredDoctors = doctors;
//                 }
//
//                 if (_filteredDoctors.isEmpty) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Lottie.asset(
//                           'assets/lottie/empty_search.json', // 👈 add empty search animation
//                           width: 150,
//                           height: 150,
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           'No Doctor Found',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//
//                 return ListView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   itemCount: _filteredDoctors.length,
//                   itemBuilder: (context, index) {
//                     final doctor = _filteredDoctors[index];
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 12),
//                       child: DoctorInformationWidget(doctor: doctor),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:digital_nawabshah/src/component/widgets/custom_text_form_field_widget.dart';
// // import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
// // import 'package:digital_nawabshah/src/const/colors.dart';
// // import 'package:digital_nawabshah/src/const/fonts.dart';
// // import 'package:digital_nawabshah/src/const/utils.dart';
// // import 'package:digital_nawabshah/src/model/doctor_model.dart';
// // import 'package:digital_nawabshah/src/screens/doctors_screen/doctor_inform_widegt/doctor_inform_widget.dart';
// // import 'package:digital_nawabshah/src/screens/doctors_screen/filter_doctor/filter_doctor_screen.dart';
// // import 'package:digital_nawabshah/src/services/auth_api_services/doctors_api_services.dart';
// //
// //
// // class DoctorsScreen extends StatefulWidget {
// //
// //
// //   const DoctorsScreen({super.key});
// //
// //   @override
// //   State<DoctorsScreen> createState() => _DoctorsScreenState();
// // }
// //
// // class _DoctorsScreenState extends State<DoctorsScreen> {
// //
// //   late Future<List<DoctorModel>> _doctorFuture;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     final apiService = Provider.of<DoctorsAPIServices>(context, listen: false);
// //     _doctorFuture = apiService.getDoctorApi();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: lightGreyColor,
// //       appBar: AppBar(
// //         backgroundColor: lightColor,
// //         centerTitle: true,
// //         title: const TextWidget(
// //           text: "Doctors",
// //           color: primaryColor,
// //           fontSize: 23,
// //           fontFamily: poppinsBold,
// //         ),
// //         leading: IconButton(
// //             onPressed: (){
// //               Navigator.pop(context);
// //             },
// //             icon: const Icon(
// //               CupertinoIcons.back,
// //               size: 30,
// //               color: primaryColor,
// //
// //             ),
// //         ),
// //         actions: [
// //           TextButton(
// //               onPressed: (){
// //                 Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context)=> const FilterDoctorScreen(),
// //                     ),
// //                 );
// //               },
// //               child: const TextWidget(text: "Filters")
// //           ),
// //         ],
// //       ),
// //       body: Column(
// //         children: [
// //           Container(
// //             width: double.infinity,
// //             height: screenHeight * 0.13,
// //             decoration: const BoxDecoration(color: lightColor),
// //             child: Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Column(
// //                 children: [
// //                   SizedBox(height: screenHeight * 0.020),
// //                   const TextFormFieldWidget(
// //                     keyboardType: TextInputType.emailAddress,
// //                     hintText: "Search Doctor by Name",
// //                     prefixIcon: CupertinoIcons.search,
// //                     fillColor: materialColor,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Expanded  (
// //             child: FutureBuilder<List<DoctorModel>>(
// //               future: _doctorFuture,  // Fetch doctors from your API here
// //               builder: (context, snapshot) {
// //                 // If the connection is still waiting, we don't show the loading indicator
// //                 if (snapshot.connectionState == ConnectionState.waiting) {
// //                   return const SizedBox();
// //                 } else if (snapshot.hasError) {
// //                   return Center(child: Text('Error: ${snapshot.error}'));
// //                 }
// //                 final doctors = snapshot.data!;
// //                 return ListView.builder(
// //                   shrinkWrap: true,
// //                   physics: const NeverScrollableScrollPhysics(),
// //                   itemCount: doctors.length,
// //                   itemBuilder: (context, index) {
// //                     final doctor = doctors[index];
// //                     return Padding(
// //                       padding: EdgeInsets.only(top: screenHeight * 0.015),
// //                       child: const DoctorInformationWidget(),
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
