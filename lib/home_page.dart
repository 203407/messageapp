import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LocationData? currentLocation;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return currentLocation != null ? GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        zoom: 15,
      ),

      markers: {
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: LatLng(
            currentLocation!.latitude!, currentLocation!.longitude!
          ),
        ),
      },
    ) : const Center(
      child: CircularProgressIndicator(),
    );
  }
}
