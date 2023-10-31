import 'dart:convert';

import 'package:driver_cold_storage/models/pengawasModel.dart';
import 'package:driver_cold_storage/screens/detailHistoryDistribute.dart';
import 'package:driver_cold_storage/screens/detailHistoryPickupPengawas.dart';

import 'package:driver_cold_storage/screens/formInputPengawasPickup.dart';
import 'package:driver_cold_storage/screens/item.dart';
import 'package:driver_cold_storage/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoryPengawas extends StatefulWidget {
  final String userID;
  HistoryPengawas({required this.userID});
  @override
  _HistoryPengawasState createState() => _HistoryPengawasState();
}

class _HistoryPengawasState extends State<HistoryPengawas> {
  double containerHeight = 150.0; // Tinggi awal kontainer
  bool isExpanded = false;
  int? selectedIndex;
  List<String> button = ["distribute", "pickup"];
  Map<String, Map<String, List<PengawasModel>>> groupedData = {};

  Map<String, Map<String, List<PengawasModel>>> groupDistribute = {};
  Map<String, Map<String, List<PengawasModel>>> groupPickup = {};

  @override
  void initState() {
    // TODO: implement initState
    selectedIndex = 0;
    fetchPengantaranData();
    super.initState();
  }

  List<Item> generateItems(int numberOfItems) {
    return List<Item>.generate(numberOfItems, (int index) {
      String idOrder = groupDistribute.keys.elementAt(index);
      final dataByIdOrder = groupDistribute[idOrder];
      print(dataByIdOrder);
      List<String> idDistributeList = dataByIdOrder!.keys.toList();

      String expandedValue = '';
      String tanggalMasuk = '';
      String isCheck = '';
      bool canSubmit = true;

      for (int i = 0; i < idDistributeList.length; i++) {
        String idDistribute = idDistributeList[i];
        expandedValue += '$idDistribute';

        final items = dataByIdOrder[idDistribute];
        for (var item in items!) {
          tanggalMasuk = item.Tanggal_Masuk;
          isCheck = item.isCheck;
          if (item.isCheck != 'true') {
            canSubmit =
                false; // Jika ada isCheck yang bukan true, canSubmit menjadi false
          }
        }

        if (i < idDistributeList.length - 1) {
          expandedValue += ', ';
        }
      }
      print(tanggalMasuk);
      return Item(
          id: index,
          headerValue: '$idOrder',
          expandedValue: '$expandedValue',
          tanggal: '$tanggalMasuk',
          isCheck: '$isCheck',
          canSubmit: canSubmit);
    });
  }

  List<Item> generateItems2(int numberOfItems) {
    return List<Item>.generate(numberOfItems, (int index) {
      String idOrder = groupPickup.keys.elementAt(index);
      final dataByIdOrder = groupPickup[idOrder];
      print(dataByIdOrder);
      List<String> idDistributeList = dataByIdOrder!.keys.toList();

      String expandedValue = '';
      String tanggalMasuk = '';
      String isCheck = '';
      bool canSubmit = true;

      for (int i = 0; i < idDistributeList.length; i++) {
        String idDistribute = idDistributeList[i];
        expandedValue += '$idDistribute';

        final items = dataByIdOrder[idDistribute];
        for (var item in items!) {
          tanggalMasuk = item.Tanggal_Masuk;
          isCheck = item.isCheck;
          if (item.isCheck != 'true') {
            canSubmit =
                false; // Jika ada isCheck yang bukan true, canSubmit menjadi false
          }
        }

        if (i < idDistributeList.length - 1) {
          expandedValue += ', ';
        }
      }
      print(tanggalMasuk);
      return Item(
        id: index,
        headerValue: '$idOrder',
        expandedValue: '$expandedValue',
        tanggal: '$tanggalMasuk',
        isCheck: '$isCheck',
        canSubmit: canSubmit,
      );
    });
  }

  Future<void> putStatus(String idOrder) async {
    final apiUrl = 'http://116.68.252.201:1945/UpdateStatusSelesai/${idOrder}';

    final response =
        await http.put(Uri.parse(apiUrl), body: {'Status_Selesai': "selesai"});

    if (response.statusCode == 200) {
      print('Data statusSelesai berhasil dipost ke API');
    } else {
      print('Gagal melakukan put data statusSelesai ke API');
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
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
        setState(() {
          selectedIndex = 0;
        });

        print(groupedData);

        groupedData.forEach((idOrder, dataByIdOrder) {
          dataByIdOrder.forEach((idDistribute, items) {
            for (var item in items) {
              if (item.Status_Selesai == 'selesai') {
                if (item.Status_Distribute == 'Distribute') {
                  if (!groupDistribute.containsKey(idOrder)) {
                    groupDistribute[idOrder] = {};
                  }
                  if (!groupDistribute[idOrder]!.containsKey(idDistribute)) {
                    groupDistribute[idOrder]![idDistribute] = [];
                  }
                  groupDistribute[idOrder]![idDistribute]!.add(item);
                } else if (item.Status_Distribute == 'Pick-Up') {
                  if (!groupPickup.containsKey(idOrder)) {
                    groupPickup[idOrder] = {};
                  }
                  if (!groupPickup[idOrder]!.containsKey(idDistribute)) {
                    groupPickup[idOrder]![idDistribute] = [];
                  }
                  groupPickup[idOrder]![idDistribute]!.add(item);
                }
              }
            }
          });
        });
      } else {
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Item> _data = generateItems(groupDistribute.length);
    final List<Item> _data2 = generateItems2(groupPickup.length);
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
                        "History Pengawas",
                        style: TextStyle(
                            color: Color(0xFF6AD6F9),
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Sora"),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
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
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: ListTile(
                              subtitle: Text(
                                item.tanggal.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    "ID Order: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Sora",
                                    ),
                                  ),
                                  Text(
                                    item.headerValue,
                                    style: TextStyle(
                                      color: Color(0xFF6AD6F9),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Sora",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5,
                            top: 25,
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
                          Positioned(
                            right: 150,
                            top: 65,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 30,
                                ),
                              ],
                            ),
                          )
                        ]);
                      },
                      body: ListTile(
                          subtitle: item.isCheck == 'true'
                              ? Text(
                                  "checked",
                                  style: TextStyle(
                                    color: Colors
                                        .green, // Atur warna sesuai preferensi Anda
                                    fontSize: 16,
                                  ),
                                )
                              : null,
                          title: Text(
                            item.expandedValue,
                            style: TextStyle(
                              color: Color(0xFF6AD6F9),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Sora",
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            setState(() {
                              if (selectedIndex == 0) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailHistoryDistributePengawas(
                                      groupDistribute: groupDistribute,
                                      distributeId: item.expandedValue,
                                      userId: widget.userID,
                                    ),
                                  ),
                                );
                              } else if (selectedIndex == 1) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailHistoryPickupPengawas(
                                      groupPickup: groupPickup,
                                      distributeId: item.expandedValue,
                                      userId: widget.userID,
                                    ),
                                  ),
                                );
                              }
                            });
                          }));
                }).toList(),
              ),
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
                            print(selectedIndex);
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => HomePengawas(
                            //       userID: widget.userID,
                            //     ),
                            //   ),
                            // );
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
                            print(selectedIndex);
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => HomePengawas2(
                            //       userID: widget.userID,
                            //     ),
                            //   ),
                            // );
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
