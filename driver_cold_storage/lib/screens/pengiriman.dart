import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'linePainter.dart';
import 'package:camera/camera.dart';
import 'camerapage.dart';
import 'package:driver_cold_storage/models/pengantaranModel.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'home.dart';

class pengirimanScreen extends StatefulWidget {
  final PengantaranModel pengantaran;
  const pengirimanScreen({super.key, required this.pengantaran});
  @override
  _pengirimanScreenState createState() => _pengirimanScreenState();
}

class _pengirimanScreenState extends State<pengirimanScreen> {
  Position? _currentLocation;
  LatLng? posisiAwal;
  // late LatLng _srcLoc = LatLng(37.422131, -122.084801);
  // late LatLng _destLoc = LatLng(37.411374, -122.071204);

  TextEditingController mytext = TextEditingController();

  List<String> nama = [];
  List<String> namaTokoPisah = [];
  List<String> namaItems = [];
  List<String> quantities = [];
  List<String> nomorTelfon = [];
  List<String> longlat = [];
  List<String> longlat2 = [];
  List<String> longLatAwal = [];
  bool cekFoto = false;
  Timer? _locationTimer;
  late SharedPreferences prefs;

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isOnTheWay', true);
    final pengantaranItemJson = json
        .encode(widget.pengantaran.toJson()); // Encode pengantaranItem to JSON
    print(" cek 1 ${widget.pengantaran.is_check}");
    print(" cek 1 ${widget.pengantaran.status_perjalanan}");
    print(pengantaranItemJson);
    prefs.setString('pengantaran_model', pengantaranItemJson);
    print("Pengantaran item json : ${pengantaranItemJson}");
  }

  Future<String> tampilkanFoto() async {
    final params = {'folder': 'Distribute', 'id': widget.pengantaran.Id};
    final apiurl = Uri.http('116.68.252.201:1945', '/getPhoto', params);
    try {
      final response = await http.get(apiurl);

      if (response.statusCode == 200) {
        print("sukses");
        return "http://116.68.252.201:1945/getPhoto?folder=Distribute&id=${widget.pengantaran.Id}";
      } else {
        print("gagal");
        return "";
      }
    } catch (e) {
      print("error $e");
      return "";
    }
  }

  Future<Uint8List> getImageBytes() async {
    String imgurl = await tampilkanFoto();
    print("url image: ${imgurl}");
    http.Response response = await http.get(Uri.parse(imgurl));
    return response.bodyBytes;
  }

  void _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Phone Number Copied"),
        //backgroundColor: Colors.green, // Use a success color
      ),
    );
  }

  Future selesaiDistribute() async {
    final apiurl =
        "http://116.68.252.201:1945/UpdateStatus_Perjalanan/${widget.pengantaran.Id}";
    try {
      if (cekFoto == true) {
        final response = await http
            .put(Uri.parse(apiurl), body: {'Status_Perjalanan': 'selesai'});
        if (response.statusCode == 200) {
          print("Berhasil");
          postToHIstory();
          _locationTimer!.cancel();
          Navigator.pop(context);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => homeScreen(userID: widget.pengantaran.),
          //   ),
          // );
        }
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Future postToHIstory() async {
    final apiurl = "http://116.68.252.201:1945/TambahHistory";
    try {
      final response = await http.post(Uri.parse(apiurl), body: {
        'Order_Id': widget.pengantaran.Order_Id,
        'Distribute_Id': widget.pengantaran.Id
      });
      if (response.statusCode == 200) {
        print("berhasil");
      }
    } catch (e) {}
  }

  Future getCurrentLocation(double latitude, double longitude) async {
    final apiurl =
        "http://116.68.252.201:1945/UpdatePosisiKendaraan/${widget.pengantaran.Order_Id}";
    try {
      final response = await http.put(Uri.parse(apiurl), body: {
        'Latitude': _currentLocation!.latitude.toString(),
        'Longitude': _currentLocation!.longitude.toString(),
      });
      if (response.statusCode == 200) {
        print("update lokasi OK");
      }
    } catch (e) {
      print("error lokasi $e");
    }
  }

  Future getCurrentLocationWithPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pengantaranItemJson = prefs.getString('pengantaran_model') ?? '';

    // Melakukan decode JSON String ke Map (jika tidak kosong)
    Map<String, dynamic> pengantaranItemMap = {};
    if (pengantaranItemJson.isNotEmpty) {
      pengantaranItemMap = json.decode(pengantaranItemJson);
    }
    PengantaranModel pengantaranItem =
        PengantaranModel.fromJson(pengantaranItemMap);

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    final apiurl =
        "http://116.68.252.201:1945/UpdatePosisiKendaraan/${pengantaranItem.Order_Id}";
    try {
      final response = await http.put(Uri.parse(apiurl), body: {
        'Latitude': position.latitude.toString(),
        'Longitude': position.longitude.toString(),
      });
      if (response.statusCode == 200) {
        print("update lokasi OK");
      }
    } catch (e) {
      print("error lokasi $e");
    }
  }

  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    const int earthRadius = 6371000;

    final double lat1Rad = startLatitude * (3.141592653589793 / 180);
    final double lon1Rad = startLongitude * (3.141592653589793 / 180);
    final double lat2Rad = endLatitude * (3.141592653589793 / 180);
    final double lon2Rad = endLongitude * (3.141592653589793 / 180);

    final double dLat = lat2Rad - lat1Rad;
    final double dLon = lon2Rad - lon1Rad;

    final double a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(lat1Rad) * math.cos(lat2Rad) * math.pow(math.sin(dLon / 2), 2);
    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    final double distance = earthRadius * c;
    return distance;
  }

  @override
  void initState() {
    super.initState();
    print("pengantaran is check: ${widget.pengantaran.is_check}");
    print(
        "pengantaran is status_perjalanan: ${widget.pengantaran.status_perjalanan}");
    initializeSharedPreferences();
    print("Test: ${widget.pengantaran}");
    print("Test: ${widget.pengantaran}");
    String namaToko = widget.pengantaran.Nama_Toko;
    if (namaToko.contains(',')) {
      namaTokoPisah = namaToko.split(',');
    } else {
      namaTokoPisah.add(namaToko);
    }
    String namaItem = widget.pengantaran.Item;
    if (namaItem.contains(',')) {
      namaItems = namaItem.split(',');
    } else {
      namaItems.add(namaItem);
    }
    String quantity = widget.pengantaran.Quantities;
    if (quantity.contains(',')) {
      quantities = quantity.split(',');
    } else {
      quantities.add(quantity);
    }
    String nomor = widget.pengantaran.Phone_Number;
    if (nomor.contains(',')) {
      nomorTelfon = nomor.split(',');
    } else {
      nomorTelfon.add(nomor);
    }
    String lokasi = widget.pengantaran.Destination;
    if (lokasi.contains(';')) {
      longlat = lokasi.split(';');
    } else {
      longlat.add(lokasi);
    }
    longLatAwal = widget.pengantaran.Titik_Awal.split(',');

    _locationTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentLocation != null) {
        getCurrentLocation(
          _currentLocation!.latitude,
          _currentLocation!.longitude,
        );
      }
    });

    _currentLocation = Position(
      longitude: double.parse(longLatAwal[1]),
      latitude: double.parse(longLatAwal[0]),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      timestamp: DateTime.now(),
      altitudeAccuracy: 0.0,
      headingAccuracy: 0.0,
    );
    posisiAwal =
        LatLng(double.parse(longLatAwal[0]), double.parse(longLatAwal[1]));
    _startLocationUpdates();
  }

  late Position _dest;

  Set<Marker> generateMarkers() {
    Set<Marker> markers = Set<Marker>();
    print("test1");

    for (int i = 0; i < longlat.length; i++) {
      longlat[i].replaceAll("(", "").replaceAll(")", "");
      longlat2 = longlat[i].split(',');

      for (int k = 0; k < longlat2.length; k++) {
        longlat2[k].replaceAll("(", "").replaceAll(")", "");
      }

      for (int j = 0; j < longlat2.length; j += 2) {
        // Remove parentheses and then split by comma
        String cleanedCoordinate =
            longlat2[j].replaceAll("(", "").replaceAll(")", "");
        String cleanedCoordinate2 =
            longlat2[j + 1].replaceAll("(", "").replaceAll(")", "");
        print(
            "latitude: ${double.parse(cleanedCoordinate)} longitude: ${double.parse(cleanedCoordinate2)}");
        double latitude = double.parse(cleanedCoordinate);
        double longitude = double.parse(cleanedCoordinate2);
        _dest = Position(
            longitude: latitude,
            latitude: longitude,
            accuracy: 0.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
            timestamp: DateTime.now(),
            altitudeAccuracy: 0.0,
            headingAccuracy: 0.0);
        markers.add(
          Marker(
            markerId: MarkerId("Pemberhentian ${i + 1}"),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: 'stops ${i + 1}'),
          ),
        );
      }
    }
    return markers;
  }

  Widget isiDetails() {
    return Column(
      children: [
        for (int i = 0; i < namaItems.length; i++)
          Row(
            children: [
              Expanded(
                child: Text(
                  namaItems[i],
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(child: Row()),
              Expanded(
                child: Text(
                  "(${quantities[i]} pcs)",
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        SizedBox(
          height: 8,
        ),
      ],
    );
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
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
        child: Column(
          children: [
            Expanded(
              child: _currentLocation == null
                  ? const Center(child: Text('Fetching location...'))
                  : GoogleMap(
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          _currentLocation!.latitude,
                          _currentLocation!.longitude,
                        ),
                        zoom: 13.5,
                      ),
                      markers: generateMarkers()
                        ..add(
                          Marker(
                            markerId: const MarkerId('source'),
                            position: posisiAwal!,
                            infoWindow: const InfoWindow(title: 'Lokasi Awal'),
                          ),
                        )
                        ..add(
                          Marker(
                            markerId: const MarkerId('current'),
                            position: LatLng(_currentLocation!.latitude,
                                _currentLocation!.longitude),
                            infoWindow: const InfoWindow(title: 'Lokasi live'),
                          ),
                        ),
                      onMapCreated: (GoogleMapController controller) {},
                    ),
            ),
            Container(
              height: 450,
              decoration: BoxDecoration(
                color: Color(0xff6ad6f9),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: namaTokoPisah.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
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
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    namaTokoPisah[index],
                                    style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
                                          child: isiDetails(),
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
                                                            BorderRadius
                                                                .circular(8),
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
                          height: 8,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(12),
                                color: Colors.white,
                                strokeCap: StrokeCap.round,
                                child: InkWell(
                                  onTap: () async => {
                                    print("tes"),
                                    await availableCameras().then(
                                      (value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => CameraPage(
                                                  cameras: value,
                                                  id: widget.pengantaran.Id))),
                                    ),
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffe0e0e0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              height: 110,
                              width: 50,
                              child: FutureBuilder<Uint8List>(
                                future: getImageBytes(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    cekFoto = true;
                                    return Image.memory(snapshot.data!);
                                  }
                                  return SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Text("NO DATA"),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 8),
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
                          height: 8,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 8),
                          child: Row(
                            children: [
                              Text(
                                "Cust Name",
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(child: Row()),
                              Text(
                                widget.pengantaran.Nama_Client,
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 8),
                          child: Row(
                            children: [
                              Text(
                                "Mobile Phone",
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(child: Row()),
                              GestureDetector(
                                onTap: () => {
                                  Clipboard.setData(
                                      ClipboardData(text: nomorTelfon[index])),
                                  _showSnackbar(),
                                },
                                child: Icon(
                                  Icons.copy_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                nomorTelfon[index],
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              onPressed: () {
                                initializeSharedPreferences();
                                double distance = calculateDistance(
                                    _currentLocation!.latitude,
                                    _currentLocation!.latitude,
                                    _dest.latitude,
                                    _dest.longitude);
                                final double desiredRange = 100;
                                if (distance <= desiredRange) {
                                  prefs.remove('isOnTheWay');
                                  prefs.remove('pengantaran_model');
                                  selesaiDistribute();
                                }
                              },
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
                        // if (index - 1 > 0)
                        //   {
                        SizedBox(
                          height: 24,
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
                        SizedBox(
                          height: 16,
                        ),
                        //},
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
