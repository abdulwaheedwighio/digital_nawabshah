import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class DoctorsViewLocationScreen extends StatefulWidget {
  const DoctorsViewLocationScreen({super.key});

  @override
  State<DoctorsViewLocationScreen> createState() => _DoctorsViewLocationScreenState();
}

class _DoctorsViewLocationScreenState extends State<DoctorsViewLocationScreen> {
  static const LatLng hospitalLatLng = LatLng(25.3960, 68.3578);
  LatLng? currentLocation;
  late GoogleMapController mapController;

  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      _addPolyline();
    });
  }

  void _addPolyline() {
    if (currentLocation != null) {
      _polylines.add(Polyline(
        polylineId: const PolylineId("route"),
        points: [currentLocation!, hospitalLatLng],
        color: Colors.blue,
        width: 5,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Location"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation!,
                zoom: 14,
              ),
              mapType: MapType.normal,
              markers: {
                const Marker(
                  markerId: const MarkerId('hospital'),
                  position: hospitalLatLng,
                  infoWindow: const InfoWindow(title: 'Liaquat University Hospital'),
                ),
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: currentLocation!,
                  infoWindow: const InfoWindow(title: 'Your Location'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                ),
              },
              polylines: _polylines,
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: _showRideConfirmationDialog,
                  icon: const Icon(Icons.local_taxi, color: Colors.white),
                  label: const Text("Request Ride"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
      ),
    );
  }

  void _showRideConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Ride"),
        content: const Text("Do you want to request a ride to the hospital?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Ride requested successfully! 🚕"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
//
// class DoctorsViewLocationScreen extends StatefulWidget {
//   final double hospitalLat;
//   final double hospitalLng;
//
//   const DoctorsViewLocationScreen({
//     super.key,
//     required this.hospitalLat,
//     required this.hospitalLng,
//   });
//
//   @override
//   State<DoctorsViewLocationScreen> createState() => _DoctorsViewLocationScreenState();
// }
//
// class _DoctorsViewLocationScreenState extends State<DoctorsViewLocationScreen> {
//   LatLng? userLocation;
//   double? distanceInKm;
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocationAndDistance();
//   }
//
//   Future<void> _getCurrentLocationAndDistance() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location service is enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//
//     // Request location permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     // Get current position
//     Position position = await Geolocator.getCurrentPosition();
//
//     setState(() {
//       userLocation = LatLng(position.latitude, position.longitude);
//       distanceInKm = Geolocator.distanceBetween(
//         position.latitude,
//         position.longitude,
//         widget.hospitalLat,
//         widget.hospitalLng,
//       ) / 1000; // convert to KM
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     CameraPosition initialCameraPosition = CameraPosition(
//       target: LatLng(widget.hospitalLat, widget.hospitalLng),
//       zoom: 14.0,
//     );
//
//     Set<Marker> markers = {
//       Marker(
//         markerId: const MarkerId("hospital"),
//         position: LatLng(widget.hospitalLat, widget.hospitalLng),
//         infoWindow: const InfoWindow(title: "Hospital Location"),
//       ),
//     };
//
//     if (userLocation != null) {
//       markers.add(
//         Marker(
//           markerId: const MarkerId("user"),
//           position: userLocation!,
//           infoWindow: const InfoWindow(title: "Your Location"),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//         ),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Hospital Location")),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: initialCameraPosition,
//             markers: markers,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//           ),
//           if (distanceInKm != null)
//             Positioned(
//               bottom: 20,
//               left: 20,
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 color: Colors.white,
//                 child: Text(
//                   "Distance: ${distanceInKm!.toStringAsFixed(2)} km",
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
