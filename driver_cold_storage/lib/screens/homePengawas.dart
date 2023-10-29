import 'dart:convert';

import 'package:driver_cold_storage/models/pengawasModel.dart';
import 'package:driver_cold_storage/screens/formInputPengawas.dart';

import 'package:driver_cold_storage/screens/item.dart';
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
  int? selectedIndex;
  List<String> button = ["distribute", "pickup"];
  Map<String, Map<String, List<PengawasModel>>> groupedData = {};

  Map<String, Map<String, List<PengawasModel>>> groupDistribute = {};
  Map<String, Map<String, List<PengawasModel>>> groupPickup = {};

  void toggleContainerSize() {
    setState(() {
      if (isExpanded) {
        containerHeight = 150.0;
      } else {
        containerHeight = 300.0;
      }
      isExpanded = !isExpanded;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedIndex = 0;
    fetchPengantaranData();
    super.initState();
  }

  List<Item> generateItems(int numberOfItems) {
    return List<Item>.generate(numberOfItems, (int index) {
      String idOrder = groupedData.keys.elementAt(index);
      final dataByIdOrder = groupedData[idOrder];
      print(dataByIdOrder);
      List<String> idDistributeList = dataByIdOrder!.keys.toList();

      String expandedValue = '';
      String tanggalMasuk = '';

      for (int i = 0; i < idDistributeList.length; i++) {
        String idDistribute = idDistributeList[i];
        expandedValue += '$idDistribute';

        final items = dataByIdOrder[idDistribute];
        for (var item in items!) {
          tanggalMasuk = item.Tanggal_Masuk;
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
          tanggal: '$tanggalMasuk');
    });
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
    final List<Item> _data = generateItems(groupedData.length);
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              ExpansionPanelList.radio(
                initialOpenPanelValue: 2,
                children: _data.map<ExpansionPanelRadio>((Item item) {
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
                            top: 20,
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
                          )
                        ]);
                      },
                      body: ListTile(
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FormInputPengawas(
                                    groupDistribute: groupDistribute,
                                    distributeId: item.expandedValue,
                                    userId: widget.userID,
                                  ),
                                ),
                              );
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
