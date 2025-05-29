import 'package:digital_nawabshah/src/component/widgets/custom_text_form_field_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/custom_text_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/fonts.dart';
import 'package:digital_nawabshah/src/const/utils.dart';
import 'package:digital_nawabshah/src/model/laboratory_model.dart';
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratery_screen_widget/labortory_list_widget.dart';
import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratory_filter_screen/labortory_filter_screen.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/doctors_api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LaboratoryScreen extends StatefulWidget {
  const LaboratoryScreen({super.key});

  @override
  State<LaboratoryScreen> createState() => _LaboratoryScreenState();
}

class _LaboratoryScreenState extends State<LaboratoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<LaboratoryModel> _allLabs = [];
  List<LaboratoryModel> _filteredLabs = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<DoctorsAPIServices>(context, listen: false);
      provider.fetchLaboratories().then((_) {
        setState(() {
          _allLabs = provider.laboratories;
          _filteredLabs = provider.laboratories;
        });
      });
    });
    _searchController.addListener(_filterLabs);
  }

  void _filterLabs() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredLabs = _allLabs
          .where((lab) => lab.labName.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labProvider = Provider.of<DoctorsAPIServices>(context);

    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        backgroundColor: lightColor,
        centerTitle: true,
        title: const TextWidget(
          text: "City Lab",
          color: primaryColor,
          fontSize: 23,
          fontFamily: poppinsBold,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.back, size: 30, color: primaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LaboratoryFilterScreen()),
              );
            },
            child: const TextWidget(text: "Filters"),
          ),
        ],
      ),
      body: labProvider.isLoading
          ?  Center(child:Center(child: Lottie.asset(
            'assets/lottie/Animation - 17455943505602.json', // 👈 Replace this with your Lottie link
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),))
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormFieldWidget(
              controller: _searchController,
              keyboardType: TextInputType.text,
              hintText: "Search Laboratory by Name",
              prefixIcon: CupertinoIcons.search,
              fillColor: materialColor,
            ),
          ),
          Expanded(
            child: _filteredLabs.isEmpty
                ? const Center(child: Text("No laboratories found."))
                : ListView.builder(
                itemCount: _filteredLabs.length,
                itemBuilder: (context, index) {
                  final lab = _filteredLabs[index];
                  return LaboratoryListWidget(laboratory: lab);
                },
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
// import 'package:digital_nawabshah/src/const/colors.dart';
// import 'package:digital_nawabshah/src/const/fonts.dart';
// import 'package:digital_nawabshah/src/const/utils.dart';
// import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratery_screen_widget/labortory_list_widget.dart';
// import 'package:digital_nawabshah/src/screens/laboratory_screen/laboratory_filter_screen/labortory_filter_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class LaboratoryScreen extends StatefulWidget {
//   const LaboratoryScreen({super.key});
//
//   @override
//   State<LaboratoryScreen> createState() => _LaboratoryScreenState();
// }
//
// class _LaboratoryScreenState extends State<LaboratoryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: lightColor,
//         centerTitle: true,
//         title: const TextWidget(
//           text: "City Lab",
//           color: primaryColor,
//           fontSize: 23,
//           fontFamily: poppinsBold,
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             CupertinoIcons.back,
//             size: 30,
//             color: primaryColor,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=> const LaboratoryFilterScreen()));
//             },
//             child: const TextWidget(text: "Filters"),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: screenHeight * 0.010),
//             ListView.builder(
//                 itemCount: 2,
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 physics: const  NeverScrollableScrollPhysics(),
//                 itemBuilder: (context,index){
//                   return const LaboratoryListWidget();
//                 }
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
