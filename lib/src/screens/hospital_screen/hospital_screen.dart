import 'package:digital_nawabshah/src/component/widgets/custom_text_form_field_widget.dart';
import 'package:digital_nawabshah/src/component/widgets/text_widget.dart';
import 'package:digital_nawabshah/src/const/colors.dart';
import 'package:digital_nawabshah/src/const/fonts.dart';
import 'package:digital_nawabshah/src/model/hospital_model.dart';
import 'package:digital_nawabshah/src/screens/hospital_screen/hospital_components/hospital_header_container_widget.dart';
import 'package:digital_nawabshah/src/services/auth_api_services/doctors_api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({super.key});

  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  List<HospitalModel> _allHospitals = [];
  List<HospitalModel> _filteredHospitals = [];
  final TextEditingController _searchController = TextEditingController();

  String _selectedCity = 'All';
  String _selectedSector = 'All';
  List<String> _cityList = ['All', 'Nawabshah', 'Karachi', 'Hyderabad', 'Sukkur'];
  List<String> _sectorList = ['All'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DoctorsAPIServices>(context, listen: false);
      provider.fetchHospitals().then((_) {
        setState(() {
          _allHospitals = provider.hospitals;
          _filteredHospitals = provider.hospitals;
          _extractSectors(); // populate sector list dynamically
        });
      });
    });
    _searchController.addListener(_filterHospitals);
  }

  void _extractSectors() {
    final sectors = _allHospitals.map((e) => e.sector).whereType<String>().toSet().toList();
    setState(() {
      _sectorList = ['All', ...sectors];
    });
  }

  void _filterHospitals() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredHospitals = _allHospitals.where((hospital) {
        final matchesName = hospital.name.toLowerCase().contains(query);
        final matchesCity = _selectedCity == 'All' || hospital.address.toLowerCase().contains(_selectedCity.toLowerCase());
        final matchesSector = _selectedSector == 'All' || hospital.sector == _selectedSector;
        return matchesName && matchesCity && matchesSector;
      }).toList();
    });
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Filter by City", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: _cityList.map((city) {
                  return ChoiceChip(
                    label: Text(city),
                    selected: _selectedCity == city,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCity = city;
                        _filterHospitals();
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text("Filter by Sector", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: _sectorList.map((sector) {
                  return ChoiceChip(
                    label: Text(sector),
                    selected: _selectedSector == sector,
                    onSelected: (selected) {
                      setState(() {
                        _selectedSector = sector;
                        _filterHospitals();
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Apply", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        backgroundColor: lightColor,
        centerTitle: true,
        title: const TextWidget(
          text: "Hospitals",
          color: primaryColor,
          fontSize: 23,
          fontFamily: poppinsBold,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.back, size: 30, color: primaryColor),
        ),
        actions: [
          IconButton(
            onPressed: () => _showFilterBottomSheet(context),
            icon: const Icon(Icons.filter_list, color: primaryColor),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: lightColor),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextFormFieldWidget(
              controller: _searchController,
              keyboardType: TextInputType.text,
              hintText: "Search Hospital by Name",
              prefixIcon: CupertinoIcons.search,
              fillColor: materialColor,
            ),
          ),
          Expanded(
            child: _filteredHospitals.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/Animation - 17455943505602.json',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'No Hospital Found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _filteredHospitals.length,
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: HospitalHeaderContainerWidget(
                    hospital: _filteredHospitals[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}







