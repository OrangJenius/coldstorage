import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dotted_border/dotted_border.dart';
import 'linePainter.dart';

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
      body: Column(
        children: [
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
          Container(
            height: 350,
            decoration: BoxDecoration(
              color: Color(0xff6ad6f9),
              borderRadius: BorderRadius.circular(24),
            ),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 16, right: 16),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, right: 40),
                              child: Text(
                                "Start",
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset("assets/Line 75.png"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    for (int i = 0; i < 5; i++)
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "Store A",
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 90,
                          height: 25,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // border radius sebesar 30
                                ),
                              ),
                              elevation: MaterialStateProperty.all(5),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      scrollable: true,
                                      title: Text(
                                        "Details",
                                        style: TextStyle(
                                          fontFamily: 'Sora',
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff6ad6f9),
                                        ),
                                      ),
                                      content: Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Ayam goyeng",
                                                  style: TextStyle(
                                                    fontFamily: 'Sora',
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Expanded(child: Row()),
                                                Text(
                                                  "(5 pcs)",
                                                  style: TextStyle(
                                                    fontFamily: 'Sora',
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Es Batu",
                                                  style: TextStyle(
                                                    fontFamily: 'Sora',
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Expanded(child: Row()),
                                                Text(
                                                  "(5 pcs)",
                                                  style: TextStyle(
                                                    fontFamily: 'Sora',
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        Center(
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      side: BorderSide(
                                                          color: Color(
                                                              0xff6AD6F9))),
                                                ),
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        5),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Go back",
                                                style: TextStyle(
                                                  fontFamily: 'Sora',
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff6AD6F9),
                                                ),
                                              )),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              "Details",
                              style: TextStyle(
                                fontFamily: 'Sora',
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff6ad6f9),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12),
                          color: Colors.white,
                          strokeCap: StrokeCap.round,
                          child: InkWell(
                            onTap: () => {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffe0e0e0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "+",
                                    style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontSize: 48,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Add photos",
                                    style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontSize: 13,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Text(
                              "Reciever",
                              style: TextStyle(
                                fontFamily: 'Sora',
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(child: Row()),
                            Image.asset("assets/Line 96.png")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Container(
                          width: 200,
                          height: 40,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // border radius sebesar 30
                                ),
                              ),
                              elevation: MaterialStateProperty.all(5),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Finish",
                              style: TextStyle(
                                fontFamily: 'Sora',
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff6ad6f9),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomPaint(
                              painter: DrawDottedhorizontalline(
                                  color: Colors.white, strokeWidth: 2.0),
                              child: Container(
                                height: 2,
                              ), // Adjust the width as needed
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
