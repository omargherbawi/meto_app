import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng selectedLatLng = LatLng(31.9539, 35.9106); // موقع افتراضي: عمان
  String address = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        selectedLatLng = LatLng(position.latitude, position.longitude);
        isLoading = false;
      });

      await _getAddressFromPosition(selectedLatLng);

      if (mapController != null) {
        mapController!.animateCamera(CameraUpdate.newLatLng(selectedLatLng));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _getAddressFromPosition(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          address = "${place.street}, ${place.locality}, ${place.country}";
        });
      }
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (isLoading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            )
          else
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: selectedLatLng,
                zoom: 16,
              ),
              onMapCreated: (controller) {
                mapController = controller;
                // Move camera to current location after map is created
                if (selectedLatLng != LatLng(31.9539, 35.9106)) {
                  controller.animateCamera(
                    CameraUpdate.newLatLng(selectedLatLng),
                  );
                }
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onCameraMove: (position) {
                selectedLatLng = position.target;
              },
              onCameraIdle: () async {
                await _getAddressFromPosition(selectedLatLng);
              },
            ),
          if (!isLoading) ...[
            Center(
              child: Icon(
                Icons.location_on,
                size: 50,
                color: AppColors.primaryColor,
              ),
            ),
            // Back Button
            Positioned(
              top: 20,
              left: 20,
              child: FloatingActionButton(
                mini: true,
                onPressed: () => Get.back(),
                child: Icon(Icons.arrow_back),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
            // My Location Button
            Positioned(
              top: 20,
              right: 20,
              child: FloatingActionButton(
                mini: true,
                onPressed: _getCurrentLocation,
                child: Icon(Icons.my_location),
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryColor,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ElevatedButton(
                child: Text('تأكيد الموقع'),
                onPressed: () {
                  Get.back(
                    result: {
                      'lat': selectedLatLng.latitude,
                      'lng': selectedLatLng.longitude,
                      'address': address,
                    },
                  );
                },
              ),
            ),
            if (address.isNotEmpty)
              Positioned(
                bottom: 80,
                left: 20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(address, textAlign: TextAlign.center),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
