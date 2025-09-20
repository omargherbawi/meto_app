import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui';

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

  String _mapStyle = '''
  [
    {
      "featureType": "all",
      "elementType": "geometry.fill",
      "stylers": [
        {
          "color": "#e8e8e8"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#b3d9ff"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry.fill",
      "stylers": [
        {
          "color": "#ffffff"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry.stroke",
      "stylers": [
        {
          "color": "#d0d0d0"
        },
        {
          "weight": 1.5
        }
      ]
    },
    {
      "featureType": "road.arterial",
      "elementType": "geometry.fill",
      "stylers": [
        {
          "color": "#ffffff"
        }
      ]
    },
    {
      "featureType": "road.arterial",
      "elementType": "geometry.stroke",
      "stylers": [
        {
          "color": "#d8d8d8"
        },
        {
          "weight": 1
        }
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "geometry.fill",
      "stylers": [
        {
          "color": "#ffffff"
        }
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "geometry.stroke",
      "stylers": [
        {
          "color": "#e0e0e0"
        },
        {
          "weight": 0.8
        }
      ]
    },
    {
      "featureType": "poi",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#e0e0e0"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#d8e8d8"
        }
      ]
    },
    {
      "featureType": "transit",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#e8e8e8"
        }
      ]
    },
    {
      "featureType": "administrative",
      "elementType": "geometry.stroke",
      "stylers": [
        {
          "color": "#d0d0d0"
        },
        {
          "weight": 0.8
        }
      ]
    },
    {
      "featureType": "administrative.country",
      "elementType": "geometry.fill",
      "stylers": [
        {
          "color": "#e8e8e8"
        }
      ]
    },
    {
      "featureType": "landscape",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#e0e0e0"
        }
      ]
    }
  ]
  ''';

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
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryColor.withOpacity(0.1),
                    AppColors.countainerColor,
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryColor,
                            ),
                            strokeWidth: 3,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'جاري تحديد الموقع...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: selectedLatLng,
                zoom: 17,
              ),
              onMapCreated: (controller) {
                mapController = controller;
                // Apply custom map style
                controller.setMapStyle(_mapStyle);
                // Move camera to current location after map is created
                if (selectedLatLng != LatLng(31.9539, 35.9106)) {
                  controller.animateCamera(
                    CameraUpdate.newLatLng(selectedLatLng),
                  );
                }
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false, // We'll create custom button
              onCameraMove: (position) {
                selectedLatLng = position.target;
              },
              onCameraIdle: () async {
                await _getAddressFromPosition(selectedLatLng);
              },
            ),
          if (!isLoading) ...[
            // Custom Location Pin
            Center(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Top Bar with Back Button
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  _buildGlassButton(
                    onPressed: () => Get.back(),
                    icon: Icons.arrow_back_ios_new,
                  ),
                  Spacer(),
                  _buildGlassButton(
                    onPressed: _getCurrentLocation,
                    icon: Icons.my_location_rounded,
                    isPrimary: true,
                  ),
                ],
              ),
            ),

            // Bottom White Container with Location and Confirm Button
            if (address.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildBottomContainer(),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildGlassButton({
    required VoidCallback onPressed,
    required IconData icon,
    bool isPrimary = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isPrimary
                  ? AppColors.primaryColor.withOpacity(0.9)
                  : Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: onPressed,
                child: Icon(
                  icon,
                  color: isPrimary ? Colors.white : AppColors.primaryColor,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              'أين تريد الذهاب؟',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          // Location Card
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Location Pin Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.location_on_rounded,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                ),

                SizedBox(width: 16),

                // Address Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الموقع المحدد',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        address,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                // Heart Icon (optional - like in the photo)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.search, color: Colors.grey[600], size: 25),
                ),
              ],
            ),
          ),

          // Confirm Button
          Container(
            margin: EdgeInsets.fromLTRB(20, 8, 20, 20),
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,

              borderRadius: BorderRadius.circular(12),

              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Get.back(
                    result: {
                      'lat': selectedLatLng.latitude,
                      'lng': selectedLatLng.longitude,
                      'address': address,
                    },
                  );
                },
                child: Center(
                  child: Text(
                    'تأكيد الموقع',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
