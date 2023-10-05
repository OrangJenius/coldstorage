import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'linePainter.dart';
import 'sliderButton.dart';
import 'package:driver_cold_storage/models/pengantaranModel.dart';

class detail_Penjemputan extends StatefulWidget {
  final Map<String, List<PengantaranModel>> sortedGroupedData;
  final distributeId;

  const detail_Penjemputan(
      {super.key, required this.sortedGroupedData, required this.distributeId});

  @override
  _detailPenjemputanState createState() => _detailPenjemputanState();
}

class _detailPenjemputanState extends State<detail_Penjemputan> {
  final ScrollController _listViewController = ScrollController();

  @override
  void dispose() {
    // Dispose of the ScrollController when the widget is disposed
    _listViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<PengantaranModel>? items =
        widget.sortedGroupedData[widget.distributeId];
    final pengantaranItem = items![0];
    String timeString =
        pengantaranItem.Time.toString(); // Replace with your time string

    // Split the time string using the ':' delimiter
    List<String> timeParts = timeString.split(':');

    // Get the hour and minute parts
    String hour = timeParts[0];
    String minute = timeParts[1];

    // Now you have the hour and minute separately
    String formattedTime = "$hour:$minute"; // "hh:mm" format
    List<String> quantitiesList = items.isNotEmpty
        ? items.first.Quantities
            .split(',')
            .map((quantity) => quantity.trim())
            .toList()
        : [];

    List<String> NamaTokoList = items.isNotEmpty
        ? items.first.Nama_Toko
            .split(',')
            .map((namaToko) => namaToko.trim())
            .toList()
        : [];

    List<String> addressList = items.isNotEmpty
        ? items.first.Address
            .split(',')
            .map((address) => address.trim())
            .toList()
        : [];

    List<String> noHPlist = items.isNotEmpty
        ? items.first.Phone_Number
            .split(',')
            .map((noHP) => noHP.trim())
            .toList()
        : [];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                child: Text(
                  "Detail Order",
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
                color: Color(0xffd9d9d9),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'ID: ',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Sora',
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.distributeId,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Sora',
                                    color: Color(0xFF6AD6F9),
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            '${DateFormat('yyyy-MM-dd').format(pengantaranItem.Tanggal_PickUp.toLocal())} | ${formattedTime}',
                            style: TextStyle(
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFF505050),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            "Note: -",
                            style: TextStyle(
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFFA5A5A5),
                            ),
                          ),
                        ),
                      ],
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
                      "Customer",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF505050),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      items[0].Client,
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
                        color: Color(0xFF505050),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: items
                    .sublist(
                        1) // Skip the first item and get the rest of the items
                    .map((item) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      item.Client,
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF505050),
                      ),
                    ),
                  );
                }).toList(),
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
                  Expanded(child: Container()),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      items[0].Service_Type,
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
                        color: Color(0xFF505050),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: items
                    .sublist(
                        1) // Skip the first item and get the rest of the items
                    .map((item) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      item.Service_Type,
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF505050),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "Items",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF505050),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      items[0].Nama_Item,
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
                        color: Color(0xFF505050),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: items
                    .sublist(
                        1) // Skip the first item and get the rest of the items
                    .map((item) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      item.Nama_Item,
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF505050),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "Quantities",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF505050),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      quantitiesList[0],
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
                        color: Color(0xFF505050),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: quantitiesList
                    .sublist(
                        1) // Skip the first item and get the rest of the items
                    .map((item) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF505050),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "Weights",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF505050),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      '',
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
                      "Stops",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF505050),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      NamaTokoList.length.toString(),
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
              Container(
                height: 300,
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: _listViewController,
                  child: ListView.builder(
                    controller: _listViewController,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 4,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF6AD6F9),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                if (index < items.length - 1)
                                  CustomPaint(
                                    size: Size(3, 90),
                                    painter: DottedLinePainter(
                                      color: Color(0xFF6AD6F9),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(
                              width:
                                  12, // Adjust the spacing between the icon and content
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  items[index].Time.toString().substring(0,
                                      items[index].Time.toString().length - 3),
                                  style: TextStyle(
                                    fontFamily: 'Sora',
                                    color: Color(0xFF6AD6F9),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  NamaTokoList[index],
                                  style: TextStyle(
                                    fontFamily: 'Sora',
                                    color: Color(0xFF808080),
                                  ),
                                ),
                                Text("Client: ${items[index].Client}"),
                                Text("Address: ${addressList[index]}"),
                                Text("Qts: ${quantitiesList[index]}"),
                                Text("Item: ${items[index].Nama_Item}"),
                                Text("No Hp: ${noHPlist[index]}"),
                              ],
                            ),
                            // Expanded(child: Container()),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: SlideActionBtn(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
