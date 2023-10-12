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
  final TextEditingController searchIdController = TextEditingController();
  DateTime? pickedDate;
  String? selectedStatus;
  late List<HistoryModel> historyData;
  late List<HistoryModel2> historyData2;
  List<Widget> steps = [];
  String? idHistory;

  Future<void> getHistory() async {
    print('gethistory');
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

        Map<String, List<HistoryModel2>> groupedHistoryModel2 = {};

        setState(() {
          historyData = historyModel;
          historyData2 = historyModel2;
          steps.add(
            CustomStep(
              historyModel: historyData,
              historyModel2: historyData2,
            ),
          );
        });
        print(groupedHistoryModel2);
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

  void filterData() {
    steps.clear();
    steps.add(
      CustomStep(
        historyModel: historyData,
        historyModel2: historyData2,
        selectedDate: pickedDate,
        selectedStatus: selectedStatus,
        idHistory: idHistory,
      ),
    );
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
        selectedStatus = null;
        idHistory = null;
        searchIdController.text = "";
        pickedDate = newDate;
        filterData();
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
                        controller: searchIdController,
                        onChanged: (value) => {
                          pickedDate = null,
                          selectedStatus = null,
                          idHistory = value.toLowerCase(),
                          filterData(),
                        },
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
                          suffixIcon: Icon(Icons.search_outlined),
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
                        setState(() {
                          selectedStatus = value;
                          searchIdController.text = "";
                          idHistory = null;
                          pickedDate = null;
                          filterData();
                        });
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
