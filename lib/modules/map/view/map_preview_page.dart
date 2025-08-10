import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../global/global.dart';

class MapPreviewPage extends StatelessWidget {
  const MapPreviewPage({super.key, required this.lon, required this.lat});

  final String lat, lon;

  @override
  Widget build(BuildContext context) {
    final LatLng position = LatLng(double.parse(lat), double.parse(lon));
    return Scaffold(
      appBar: AppBars.appBar(title: 'Gulf Car Auction - Map'),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("location_marker"),
            position: position,
            infoWindow: const InfoWindow(title: 'Gulf Car Auction'),
          ),
        },
      ),
    );
  }
}
