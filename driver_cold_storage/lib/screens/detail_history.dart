import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:driver_cold_storage/models/historyModel.dart';

class DetailHistory extends StatefulWidget {
  @override
  _DetailHistoryState createState() => _DetailHistoryState();
  final List<HistoryModel> historyModel;
  final List<HistoryModel2> historyModel2;
  DetailHistory({
    required this.historyModel,
    required this.historyModel2,
  });
}

class _DetailHistoryState extends State<DetailHistory> {
  void test() {
    print("historymodel1: ${widget.historyModel}");
    print("historymodel2: ${widget.historyModel2}");
  }

  late LatLng _destLoc = LatLng(37.411374, -122.071204);
  final List<String> image = [
    'assets/gambar.jpg',
    'assets/gambar.jpg',
    'assets/gambar.jpg',
    'assets/gambar.jpg',
    'assets/gambar.jpg',
    'assets/gambar.jpg',
  ];

  @override
  void initState() {
    super.initState();

    test();
  }

  List<Widget> displayItems = [];

  @override
  Widget build(BuildContext context) {
    displayItems.clear();

    for (int i = 0; i < widget.historyModel2.length; i++) {
      List<List<String>> locations = [];
      for (int j = 0; j < widget.historyModel.length; j++) {
        List<String> temp = (widget.historyModel[j].destination.contains(';')
            ? widget.historyModel[j].destination.split(';')
            : [widget.historyModel[j].destination]);

        for (int k = 0; k < temp.length; k++) {
          temp[k] = temp[k].replaceAll("(", "").replaceAll(")", "");
        }

        locations.add(temp);
        print("Lokasi: ${locations[0][j]}");
      }
      List<String> lokasi = locations[0][i].split(',');

      lokasi[0] = lokasi[0].replaceAll("(", "").replaceAll(")", "");
      lokasi[1] = lokasi[1].replaceAll("(", "").replaceAll(")", "");

      print("Lokasi ${lokasi[0]}");
      print("Lokasi ${lokasi[1]}");
      _destLoc = LatLng(double.parse(lokasi[0]), double.parse(lokasi[1]));

      displayItems.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                  ),
                  child: Text(
                    "ID :",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Sora"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 4),
                  child: Text(
                    "BJE66565612KLOP",
                    style: TextStyle(
                        color: Color(0xFF6AD6F9),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Sora"),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              height: 200,
              child: GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  zoom: 13.5,
                  target: _destLoc,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('destination'),
                    position: _destLoc,
                    infoWindow: const InfoWindow(title: 'Destination Location'),
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  // Remove the setState call from this method
                  // as it is not required
                },
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Customer",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text(
                    widget.historyModel2[i].namaClient,
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Service",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text(
                    widget.historyModel2[i].serviceType,
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Receiver",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text(
                    widget.historyModel2[i].namaClient,
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF505050),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                width: 125,
                height: 25,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // border radius sebesar 30
                      ),
                    ),
                    elevation: MaterialStateProperty.all(5),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            scrollable: true,
                            title: Text(
                              "Details items",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Quantities",
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
                                        widget.historyModel2[i].jumlah
                                            .toString(),
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
                                        "Weights",
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
                                        "${widget.historyModel2[i].berat.toString()} Kg",
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
                                    height: 32,
                                  ),
                                  Text(
                                    widget.historyModel[0].status,
                                    style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff6ad6f9),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.historyModel2[i].namaItem,
                                        style: TextStyle(
                                          fontFamily: 'Sora',
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text(
                                        widget.historyModel2[i].jumlah
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Sora',
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              Center(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            side: BorderSide(
                                                color: Color(0xff6AD6F9))),
                                      ),
                                      elevation: MaterialStateProperty.all(5),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
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
                    "Details items",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
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
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Bukti Foto",
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF505050),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                child: ListView.builder(
                  itemCount: image.length,
                  scrollDirection: Axis.horizontal,
                  itemExtent: 100,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          image[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
          child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  top: 16,
                ),
                child: Text(
                  "Detail History",
                  style: TextStyle(
                      color: Color(0xFF6AD6F9),
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Sora"),
                ),
              ),
              Column(
                children: displayItems,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24), // Padding horizontal 32 dan vertikal 24
                child: Container(
                  width: double
                      .infinity, // Ini akan membuat Container mengambil lebar maksimal yang tersedia.
                  height:
                      50, // Anda bisa mengatur tinggi tombol sesuai kebutuhan Anda.
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30), // border radius sebesar 30
                        ),
                      ),
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF6AD6F9)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Sora",
                        )), // Anda juga bisa mengatur style dari teks jika diperlukan.
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
