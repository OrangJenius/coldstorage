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
  DateTime? pickedDate = DateTime.now();

  late List<HistoryModel> historyData;

  Future<void> getHistory() async {
    final apiurl =
        "http://116.68.252.201:1945/DataHistoryANDDistributeWithUSERID/${widget.id}";
    try {
      final response = await http.get(Uri.parse(apiurl));

      if (response.statusCode == 200) {
        // Successfully fetched data from the API
        final responseJson = jsonDecode(response.body);
        final List<dynamic> apihistoryData = responseJson['data']['History'];

        List<HistoryModel> historyModel =
            apihistoryData.map((data) => HistoryModel.fromJson(data)).toList();

        setState(() {
          historyData = historyModel;
          print('test');
          print('historydata: ${historyData[0]}');
          steps.add(
            CustomStep(
              historyModel: historyData,
            ),
          );
        });
      } else {
        // API call failed or returned an error status code
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred during API call
      print('Error: $e');
    }
  }

  // List<String> id = [
  //   'BJE290012KLOP',
  //   'BJE290012KLOP',
  //   'BJE290012KLOP',
  // ];
  // List<String> store = [
  //   'Store A',
  //   'Store B',
  //   'Store C',
  //   'Store D',
  //   'Store A',
  //   'Store B',
  //   'Store C',
  //   'Store A',
  //   'Store B',
  //   'Store C',
  // ];
  // List<String> reciver = [
  //   'Receiver: Budianto',
  //   'Receiver: Budianto',
  //   'Receiver: Budianto',
  //   'Receiver: Budianto',
  //   'Receiver: Budianto',
  //   'Receiver: Budianto',
  //   'Receiver: Budianto',
  //   'Receiver: Budianto',
  //   'Receiver: Budianto',
  // ];
  // List<String> address = [
  //   'Address: Jl. aksjdnaiyd',
  //   'Address: Jl. aksjdnaiyd',
  //   'Address: Jl. aksjdnaiyd',
  //   'Address: Jl. aksjdnaiyd',
  //   'Address: Jl. aksjdnaiyd',
  //   'Address: Jl. aksjdnaiyd',
  //   'Address: Jl. aksjdnaiyd',
  //   'Address: Jl. aksjdnaiyd',
  //   'Address: Jl. aksjdnaiyd',
  // ];
  // List<String> time = [
  //   '10.00 AM',
  //   '11.00 AM',
  //   '02.00 AM',
  //   '10.00 AM',
  //   '11.00 AM',
  //   '02.00 AM',
  //   '10.00 AM',
  //   '11.00 AM',
  //   '02.00 AM',
  // ];

  List<Widget> steps = [];

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
                                : '',
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
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      pickedDate != null
                          ? DateFormat('dd MMMM yyyy').format(pickedDate!)
                          : '',
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
