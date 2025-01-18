import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarLocationView extends StatelessWidget {
  const CarLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: {
          const Marker(
            markerId: MarkerId("car_location"),
            position: LatLng(9.023253588586133, 38.751833094027624),
          ),
        },
        initialCameraPosition: const CameraPosition(
          zoom: 14,
          target: LatLng(9.023253588586133, 38.751833094027624),
        ),
      ),
    );
  }
}
