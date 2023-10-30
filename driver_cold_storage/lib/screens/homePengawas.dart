import 'dart:convert';

import 'package:driver_cold_storage/models/pengawasModel.dart';
import 'package:driver_cold_storage/screens/formInputPengawas.dart';
import 'package:driver_cold_storage/screens/formInputPengawasPickup.dart';
import 'package:driver_cold_storage/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePengawas extends StatefulWidget {
  final String userID;
  HomePengawas({required this.userID});
  @override
  _homePengawasState createState() => _homePengawasState();
}

class _homePengawasState extends State<HomePengawas> {
  double containerHeight = 150.0; // Tinggi awal kontainer
  bool isExpanded = false;
  Map<String, Map<String, List<PengawasModel>>> groupedData = {};

  void toggleContainerSize() {
    setState(() {
      if (isExpanded) {
        containerHeight = 150.0; // Tinggi awal kontainer
      } else {
        containerHeight = 300.0; // Tinggi yang diperbesar
      }
      isExpanded = !isExpanded;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchPengantaranData();
    selectedIndex = 0;

    super.initState();
  }

  Future<void> fetchPengantaranData() async {
    final apiUrl =
        'http://116.68.252.201:1945/DetailOnGoingOrderPengawas/${widget.userID}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Successfully fetched data from the API
        final responseJson = jsonDecode(response.body);
        final List<dynamic> apiPengantaranData = responseJson['data'];

        List<PengawasModel> pengawasModel = apiPengantaranData
            .map((data) => PengawasModel.fromJson(data))
            .toList();

        for (var item in pengawasModel) {
          final id = item.Id;
          final idDistribute = item.Id_Distribute;

          if (!groupedData.containsKey(id)) {
            groupedData[id] = {};
          }

          if (!groupedData[id]!.containsKey(idDistribute)) {
            groupedData[id]![idDistribute] = [];
          }

          groupedData[id]![idDistribute]!.add(item);
        }

        print(groupedData);
        // setState(() {
        //   // After fetching the data, set the selectedIndex to 0 or 1 as needed
        //   selectedIndex = 0; // or selectedIndex = 1;
        // });

// Hasil groupedAttributes akan berisi nilai-nilai yang digabungkan sesuai dengan keys yang sama
      } else {
        // API call failed or returned an error status code
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred during API call
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        top: 16,
                      ),
                      child: Text(
                        "Home",
                        style: TextStyle(
                            color: Color(0xFF6AD6F9),
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Sora"),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Mengatur posisi ke tengah
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, right: 20),
                        child: Transform.scale(
                          scale: 1.2,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => profileScreen(
                                    id: widget.userID,
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              child: Icon(
                                Icons.alarm,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 20),
                        child: Text(
                          "History",
                          style: TextStyle(
                              color: Color(0xFF6AD6F9),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Sora"),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Mengatur posisi ke tengah
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, right: 16),
                        child: Transform.scale(
                          scale: 1.2,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => profileScreen(
                                    id: widget.userID,
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.image),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 16),
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              color: Color(0xFF6AD6F9),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Sora"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                child: Divider(
                  height: 1, // Atur tinggi garis sesuai kebutuhan
                  color: Colors.grey, // Atur warna garis sesuai kebutuhan
                ),
              ),
              ListView.builder(
                  itemCount: groupedData.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    String idOrder = groupedData.keys.elementAt(index);
                    final dataByIdOrder = groupedData[idOrder];
                    String idDistribute = dataByIdOrder!.keys.elementAt(index);

                    print(idOrder);
                    print(dataByIdOrder);
                    print(idDistribute);
                    if (selectedIndex == 0) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 24),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: 380,
                              height: containerHeight,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
              ExpansionPanelList.radio(
                initialOpenPanelValue: 2,
                children: (selectedIndex == 0 ? _data : _data2)
                    .map<ExpansionPanelRadio>((Item item) {
                  return ExpansionPanelRadio(
                      value: item.id,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Stack(children: [
                          Container(
                            width: 380,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: ListTile(
                              subtitle: Text(
                                item.tanggal.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                              child: Row(
                                children: [
                                  // Left Side Content
                                  Flexible(
                                    // <-- Tambahkan ini
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // ID Section
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 8),
                                              child: Text(
                                                "ID:",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Sora",
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8,
                                                  left: 8,
                                                ),
                                                child: Text(
                                                  idOrder,
                                                  style: TextStyle(
                                                    color: Color(0xFF6AD6F9),
                                                    fontSize: 22,
                                                    fontFamily: "Sora",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, top: 4),
                                          child: Text(
                                            "7 Juli 2023 | 10:00",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: "Sora",
                                            ),
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 1),
                                              child: Text(
                                                "Note :",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontFamily: "Sora",
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, top: 1),
                                                child: Text(
                                                  "pakai bubble wrap",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: "Sora",
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 8),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ..._buildDetailColumn(
                                                      "Items", "20"),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ..._buildDetailColumn(
                                                      "Weight", "20kg"),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ..._buildDetailColumn(
                                                      "Location", "Gedung A"),
                                                ],
                                              ),
                                              Expanded(
                                                child: Container(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5, // Posisi dari kiri
                            top: 5, // Posisi dari atas
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF6AD6F9)),
                                  child: Center(
                                    child: Text(
                                      "Distribute",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontFamily: "Sora",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimatedPositioned(
                            right: 20, // Posisi dari kiri
                            bottom: isExpanded
                                ? containerHeight - 290
                                : 10, // Posisi dari atas
                            duration: Duration(milliseconds: 300),
                            child: GestureDetector(
                              onTap:
                                  toggleContainerSize, // Panggil fungsi ketika ikon ditekan
                              child: Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 50,
                              ),
                            ),
                          ),
                          Visibility(
                            visible:
                                isExpanded, // Tampilkan widget ini hanya jika kontainer diperluas
                            child: Positioned(
                              left: 24,
                              top: 160, // Atur posisi sesuai kebutuhan Anda
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Item 1",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: "Sora",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FormInputPengawas()),
                                            );
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                  width: 2,
                                                  color: Color(0xFF6AD6F9)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Check Items",
                                                style: TextStyle(
                                                  fontFamily: 'Sora',
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF6AD6F9),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Item 2",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Sora",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 147,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FormInputPengawas()),
                                          );
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                width: 2,
                                                color: Color(0xFF6AD6F9)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Check Items",
                                              style: TextStyle(
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF6AD6F9),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ), // Gantilah dengan widget tambahan yang ingin Anda tambahkan
                            ),
                          ),
                        ],
                      );
                    } else if (selectedIndex == 1) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 24),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: 380,
                              height: containerHeight,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  // Left Side Content
                                  Flexible(
                                    // <-- Tambahkan ini
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // ID Section
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 8),
                                              child: Text(
                                                "ID:",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Sora",
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8,
                                                  left: 8,
                                                ),
                                                child: Text(
                                                  "BJE7658332BAP",
                                                  style: TextStyle(
                                                    color: Color(0xFF6AD6F9),
                                                    fontSize: 22,
                                                    fontFamily: "Sora",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, top: 4),
                                          child: Text(
                                            "8 Juli 2023 | 11:00",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: "Sora",
                                            ),
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 1),
                                              child: Text(
                                                "Note :",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontFamily: "Sora",
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, top: 1),
                                                child: Text(
                                                  "Jangan lupa dibawah 5 derajat celcius ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: "Sora",
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 8),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ..._buildDetailColumn(
                                                      "Items", "30"),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ..._buildDetailColumn(
                                                      "Weight", "30kg"),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ..._buildDetailColumn(
                                                      "Location", "Gedung B"),
                                                ],
                                              ),
                                              Expanded(
                                                child: Container(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5, // Posisi dari kiri
                            top: 5, // Posisi dari atas
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF6AD6F9)),
                                  child: Center(
                                    child: Text(
                                      "Pickup",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontFamily: "Sora",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimatedPositioned(
                            right: 20, // Posisi dari kiri
                            bottom: isExpanded
                                ? containerHeight - 290
                                : 10, // Posisi dari atas
                            duration: Duration(milliseconds: 300),
                            child: GestureDetector(
                              onTap:
                                  toggleContainerSize, // Panggil fungsi ketika ikon ditekan
                              child: Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 50,
                              ),
                            ),
                          ),
                          Visibility(
                            visible:
                                isExpanded, // Tampilkan widget ini hanya jika kontainer diperluas
                            child: Positioned(
                              left: 24,
                              top: 160, // Atur posisi sesuai kebutuhan Anda
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Item 1",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: "Sora",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FormInputPengawasPickup()),
                                            );
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                  width: 2,
                                                  color: Color(0xFF6AD6F9)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Check Items",
                                                style: TextStyle(
                                                  fontFamily: 'Sora',
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF6AD6F9),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Item 2",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Sora",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 147,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FormInputPengawasPickup()),
                                          );
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                width: 2,
                                                color: Color(0xFF6AD6F9)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Check Items",
                                              style: TextStyle(
                                                fontFamily: 'Sora',
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF6AD6F9),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ), // Gantilah dengan widget tambahan yang ingin Anda tambahkan
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
        Column(
          children: [
            Expanded(child: Container()),
            Container(
              height: 75,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                            fetchPengantaranData();
                            print(selectedIndex);
                          });
                        },
                        child: Image.asset(
                          'assets/Delivery Truck.png',
                          fit: BoxFit.cover,
                          color: 0 == selectedIndex
                              ? Color(0xFF6AD6F9)
                              : Colors.black,
                          scale: 0.8,
                        ),
                      ),
                      Text(
                        "Distribute",
                        style: TextStyle(
                          color: 0 == selectedIndex
                              ? Color(0xFF6AD6F9)
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                            fetchPengantaranData();
                            print(selectedIndex);
                          });
                        },
                        child: Image.asset(
                          'assets/Boxes.png',
                          fit: BoxFit.cover,
                          color: 1 == selectedIndex
                              ? Color(0xFF6AD6F9)
                              : Colors.black,
                          scale: 1.2,
                        ),
                      ),
                      Text("Pickup",
                          style: TextStyle(
                            color: 1 == selectedIndex
                                ? Color(0xFF6AD6F9)
                                : Colors.black,
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      ])),
    );
  }
}

List<Widget> _buildDetailColumn(String title, String value) {
  return [
    Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontFamily: "Sora",
      ),
    ),
    Text(
      value,
      style: TextStyle(
          color: Color(0xFF6AD6F9),
          fontSize: 15,
          fontFamily: "Sora",
          fontWeight: FontWeight.bold),
    ),
  ];
}
