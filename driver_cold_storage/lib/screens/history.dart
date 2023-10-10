import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'customStepper.dart';
import 'customStep.dart';
import 'package:driver_cold_storage/models/historyModel.dart';
import 'package:http/http.dart' as http;

class historyScreen extends StatefulWidget {
  final String id;

  const historyScreen({super.key, required this.id});
  @override
  _historyScreenState createState() => _historyScreenState();
}

class _historyScreenState extends State<historyScreen> {
  DateTime? pickedDate;

  late List<HistoryModel> historyData;
  late List<HistoryModel2> historyData2;
  List<Widget> steps = [];

  // Future<void> getHistory() async {
  //   steps.clear();
  //   final apiurl =
  //       "http://116.68.252.201:1945/DataHistoryANDDistributeWithUSERID/${widget.id}";

  //   final apiurl2 = "http://116.68.252.201:1945/HistoryDriver/${widget.id}";
  //   try {
  //     final response = await http.get(Uri.parse(apiurl));
  //     final response2 = await http.get(Uri.parse(apiurl2));

  //     if (response.statusCode == 200 && response2.statusCode == 200) {
  //       final responseJson = jsonDecode(response.body);
  //       final List<dynamic> apihistoryData = responseJson['data']['History'];

  //       final responseJson2 = jsonDecode(response2.body);
  //       final List<dynamic> apihistoryData2 = responseJson2['data']['History'];

  //       // Merge data from both API responses
  //       final mergedData = [...apihistoryData, ...apihistoryData2];

  //       // Filter out duplicates based on the 'Id' field
  //       final uniqueHistoryData = <String, dynamic>{};
  //       mergedData.forEach((data) {
  //         final id = data['Id'] as String;
  //         if (!uniqueHistoryData.containsKey(id)) {
  //           uniqueHistoryData[id] = data;
  //         }
  //       });

  //       List<HistoryModel> historyModel = uniqueHistoryData.values
  //           .map((data) => HistoryModel.fromJson(data))
  //           .toList();

  //       setState(() {
  //         historyData = historyModel;
  //         print('test');
  //         print('historydata: ${historyData[0].userId}');
  //         steps.add(
  //           CustomStep(
  //             historyModel: historyData,
  //             selectedDate: pickedDate,
  //           ),
  //         );
  //       });
  //       for (var historyModelItem in historyData) {
  //         print('Id: ${historyModelItem.Id}');
  //         print('DistributeId: ${historyModelItem.distibuteId}');
  //         print('NamaToko: ${historyModelItem.namaToko}');
  //         print('Alamat: ${historyModelItem.alamat}');
  //         print('Time: ${historyModelItem.time}');
  //         print('TanggalPickup: ${historyModelItem.tanggalPickup}');
  //         print('Status: ${historyModelItem.status}');
  //         print('TitikAwal: ${historyModelItem.titikAwal}');
  //         print('Destination: ${historyModelItem.destination}');
  //         print('OrderId: ${historyModelItem.orderId}');
  //         print('NamaItem: ${historyModelItem.namaItem}');
  //         print('Jumlah: ${historyModelItem.jumlah}');
  //         print('Berat: ${historyModelItem.berat}');
  //         print('TanggalMasuk: ${historyModelItem.tanggalMasuk}');
  //         print('Gedung: ${historyModelItem.gedung}');
  //         print('Aisle: ${historyModelItem.aisle}');
  //         print('Place: ${historyModelItem.place}');
  //         print('ServiceType: ${historyModelItem.serviceType}');
  //         print('RentDriver: ${historyModelItem.rentDriver}');
  //         print('TanggalAmbil: ${historyModelItem.tanggalAmbil}');
  //         print('Photo: ${historyModelItem.photo}');
  //         print('Notes: ${historyModelItem.notes}');
  //         print('KendaraanId: ${historyModelItem.kendaraanId}');
  //         print('UserId: ${historyModelItem.userId}');
  //         print('ClientId: ${historyModelItem.clientId}');
  //         print('NamaClient: ${historyModelItem.namaClient}');
  //         print('NamaUser: ${historyModelItem.namaUser}');
  //       }
  //     } else {
  //       // API call failed or returned an error status code
  //       print('API call failed with status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Error occurred during API call
  //     print('Error: $e');
  //   }
  // }

  Future<void> getHistory() async {
    steps.clear();
    final apiurl =
        "http://116.68.252.201:1945/DataHistoryANDDistributeWithUSERID/${widget.id}";

    final apiurl2 = "http://116.68.252.201:1945/HistoryDriver/${widget.id}";
    try {
      final response = await http.get(Uri.parse(apiurl));
      final response2 = await http.get(Uri.parse(apiurl2));

      if (response.statusCode == 200 && response2.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final List<dynamic> apihistoryData = responseJson['data']['History'];

        final responseJson2 = jsonDecode(response2.body);
        final List<dynamic> apihistoryData2 = responseJson2['data']['History'];

        final uniqueHistoryData = <String, dynamic>{};
        apihistoryData.forEach((data) {
          final id = data['Id'] as String;
          if (!uniqueHistoryData.containsKey(id)) {
            uniqueHistoryData[id] = data;
          }
        });

        List<HistoryModel2> historyModel2 = apihistoryData2
            .map((data2) => HistoryModel2.fromJson(data2))
            .toList();

        List<HistoryModel> historyModel = uniqueHistoryData.values
            .map((data) => HistoryModel.fromJson(data))
            .toList();

        setState(() {
          historyData2 = historyModel2;
          historyData = historyModel;
          steps.add(
            CustomStep(
              historyModel: historyData,
              historyModel2: historyData2,
              selectedDate: pickedDate,
            ),
          );
        });
        for (var historyModelItem in historyData) {
          print('Id: ${historyModelItem.Id}');
          print('DistributeId: ${historyModelItem.distibuteId}');
          print('NamaToko: ${historyModelItem.namaToko}');
          print('Alamat: ${historyModelItem.alamat}');
          print('Time: ${historyModelItem.time}');
          print('TanggalPickup: ${historyModelItem.tanggalPickup}');
          print('Status: ${historyModelItem.status}');
          print('TitikAwal: ${historyModelItem.titikAwal}');
          print('Destination: ${historyModelItem.destination}');
          print('OrderId: ${historyModelItem.orderId}');
          print('NamaItem: ${historyModelItem.namaItem}');
          print('Jumlah: ${historyModelItem.jumlah}');
          print('Berat: ${historyModelItem.berat}');
          print('TanggalMasuk: ${historyModelItem.tanggalMasuk}');
          print('Gedung: ${historyModelItem.gedung}');
          print('Aisle: ${historyModelItem.aisle}');
          print('Place: ${historyModelItem.place}');
          print('ServiceType: ${historyModelItem.serviceType}');
          print('RentDriver: ${historyModelItem.rentDriver}');
          print('TanggalAmbil: ${historyModelItem.tanggalAmbil}');
          print('Photo: ${historyModelItem.photo}');
          print('Notes: ${historyModelItem.notes}');
          print('KendaraanId: ${historyModelItem.kendaraanId}');
          print('UserId: ${historyModelItem.userId}');
          print('ClientId: ${historyModelItem.clientId}');
          print('NamaClient: ${historyModelItem.namaClient}');
          print('NamaUser: ${historyModelItem.namaUser}');
        }
        print("------------------------------------------");
        for (var historyModelItem in historyData2) {
          print('Id: ${historyModelItem.Id}');
          print('DistributeId: ${historyModelItem.distibuteId}');
          print('NamaToko: ${historyModelItem.namaToko}');
          print('Alamat: ${historyModelItem.alamat}');
          print('Time: ${historyModelItem.time}');
          print('TanggalPickup: ${historyModelItem.tanggalPickup}');
          print('Status: ${historyModelItem.status}');
          print('TitikAwal: ${historyModelItem.titikAwal}');
          print('Destination: ${historyModelItem.destination}');
          print('OrderId: ${historyModelItem.orderId}');
          print('NamaItem: ${historyModelItem.namaItem}');
          print('Jumlah: ${historyModelItem.jumlah}');
          print('Berat: ${historyModelItem.berat}');
          print('TanggalMasuk: ${historyModelItem.tanggalMasuk}');
          print('Gedung: ${historyModelItem.gedung}');
          print('Aisle: ${historyModelItem.aisle}');
          print('Place: ${historyModelItem.place}');
          print('ServiceType: ${historyModelItem.serviceType}');
          print('RentDriver: ${historyModelItem.rentDriver}');
          print('TanggalAmbil: ${historyModelItem.tanggalAmbil}');
          print('Photo: ${historyModelItem.photo}');
          print('Notes: ${historyModelItem.notes}');
          print('KendaraanId: ${historyModelItem.kendaraanId}');
          print('UserId: ${historyModelItem.userId}');
          print('ClientId: ${historyModelItem.clientId}');
          print('NamaClient: ${historyModelItem.namaClient}');
          print('NamaUser: ${historyModelItem.namaUser}');
        }
      } else {
        // Handle API call failures or error status codes
        print('API call failed with status code: ${response.statusCode}');
        print('API call failed with status code: ${response2.statusCode}');
      }
    } catch (e) {
      // Handle errors that occur during API calls
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    getHistory();
  }

  Future<void> _selectDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: pickedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (newDate != null) {
      setState(() {
        pickedDate = newDate;
        getHistory();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  top: 16,
                ),
                child: Text(
                  "History",
                  style: TextStyle(
                    color: Color(0xFF6AD6F9),
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Color(0xFFd9d9d9),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pickedDate != null
                                ? DateFormat('dd MMMM yyyy').format(pickedDate!)
                                : DateFormat('dd MMMM yyyy')
                                    .format(DateTime.now()),
                            style: TextStyle(
                              fontFamily: 'Sora',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF747474),
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Icon(Icons.calendar_today),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 43,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          hintText: "ID:",
                          hintStyle: TextStyle(
                            color: Color(0xffaaaaaa),
                            fontFamily: 'Sora',
                          ),
                          suffixIcon: Icon(Icons.bento),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      pickedDate != null
                          ? DateFormat('dd MMMM yyyy').format(pickedDate!)
                          : DateFormat('dd MMMM yyyy').format(DateTime.now()),
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6AD6F9),
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Expanded(child: Row()),
                    PopupMenuButton<String>(
                      // Use PopupMenuButton
                      onSelected: (value) {
                        setState(() {});
                      },
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'All',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF6AD6F9),
                                ),
                                Text(
                                  'All',
                                  style: TextStyle(
                                    fontFamily: 'Sora',
                                    color: Color(0xFF6AD6F9),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'Distribute',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF6AD6F9),
                                ),
                                Text(
                                  'Distribute',
                                  style: TextStyle(
                                    fontFamily: 'Sora',
                                    color: Color(0xFF6AD6F9),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'Pickup',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF6AD6F9),
                                ),
                                Text(
                                  'Pickup',
                                  style: TextStyle(
                                    fontFamily: 'Sora',
                                    color: Color(0xFF6AD6F9),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ];
                      },
                      child: Icon(
                        Icons.filter_alt,
                        color: Color(0xFF6AD6F9),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              CustomVerticalStepper(steps: steps)
            ],
          ),
        ),
      ),
    );
  }
}
