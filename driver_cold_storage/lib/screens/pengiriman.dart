import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class pengirimanScreen extends StatefulWidget {
  @override
  _pengirimanScreenState createState() => _pengirimanScreenState();
}

class _pengirimanScreenState extends State<pengirimanScreen> {
  Position? _currentLocation;
  late LatLng _srcLoc = LatLng(37.422131, -122.084801);
  late LatLng _destLoc = LatLng(37.411374, -122.071204);

  @override
  void initState() {
    super.initState();
    _currentLocation = Position(
      longitude: _srcLoc.longitude,
      latitude: _srcLoc.latitude,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      timestamp: DateTime.now(),
    );
    _startLocationUpdates();
  }

  void _startLocationUpdates() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Geolocator.getPositionStream().listen((Position newPosition) {
      setState(() {
        _currentLocation = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: _currentLocation == null
              ? const Center(child: Text('Fetching location...'))
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentLocation!.latitude,
                      _currentLocation!.longitude,
                    ),
                    zoom: 13.5,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('currentLocation'),
                      position: LatLng(
                        _currentLocation!.latitude,
                        _currentLocation!.longitude,
                      ),
                      infoWindow: const InfoWindow(title: 'Current Location'),
                    ),
                    Marker(
                      markerId: const MarkerId('source'),
                      position: _srcLoc,
                      infoWindow: const InfoWindow(title: 'Source Location'),
                    ),
                    Marker(
                      markerId: const MarkerId('destination'),
                      position: _destLoc,
                      infoWindow:
                          const InfoWindow(title: 'Destination Location'),
                    ),
                  },
                  onMapCreated: (GoogleMapController controller) {
                    // Remove the setState call from this method
                    // as it is not required
                  },
                ),
        ),
      ]),
    );
  }
}
