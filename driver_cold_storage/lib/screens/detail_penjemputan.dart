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
  final ScrollController _listViewController2 = ScrollController();
  final ScrollController _listViewController3 = ScrollController();

  @override
  void dispose() {
    // Dispose of the ScrollController when the widget is disposed
    _listViewController.dispose();
    _listViewController2.dispose();
    _listViewController3.dispose();
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

    final totalBerat = items.map((item) => item.Berat).reduce((a, b) => a + b);

    int totalJumlah = 0;

    for (String angka in quantitiesList) {
      totalJumlah += int.parse(angka);
    }

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

    List<String> time = items.isNotEmpty
        ? items.first.Time.split(',').map((time) => time.trim()).toList()
        : [];

    List<String> totalNamaItem = [];
    List<String> clientItem = [];
    List<String> serviceItem = [];
    for (PengantaranModel item in items) {
      totalNamaItem.add(item.Nama_Item);
      clientItem.add(item.Client);
      serviceItem.add(item.Service_Type);
    }

    print(time);
    print(totalNamaItem);
    print(NamaTokoList);

    Map<String, List<int>> groupedQuantities = {};
    Map<String, List<String>> groupedTime = {};
    Map<String, List<String>> groupedNamaItem = {};
    Map<String, List<String>> groupedPhone = {};
    Map<String, List<String>> groupedAddress = {};
    Map<String, List<String>> groupedClient = {};
    Map<String, List<String>> groupedService = {};

    for (int i = 0; i < NamaTokoList.length; i++) {
      String namaToko = NamaTokoList[i];
      int quantity = int.parse(quantitiesList[i]);
      String times = time[i];
      String namaItem = totalNamaItem[i];
      String phone = noHPlist[i];
      String address = addressList[i];
      String client = clientItem[i];
      String service = serviceItem[i];

      if (groupedQuantities.containsKey(namaToko)) {
        // If the store name already exists in the map, add the quantity to the existing list
        groupedQuantities[namaToko]!.add(quantity);
        groupedNamaItem[namaToko]!.add(namaItem);
        // Check if times for this store name has already been added, and if not, add it
        if (!groupedTime[namaToko]!.contains(times)) {
          groupedTime[namaToko]!.add(times);
          groupedPhone[namaToko]!.add(phone);
          groupedAddress[namaToko]!.add(address);
          groupedAddress[namaToko]!.add(client);
          groupedService[namaToko]!.add(service);
        }
      } else {
        // If the store name is encountered for the first time, create a new list in the map
        groupedQuantities[namaToko] = [quantity];
        groupedTime[namaToko] = [times];
        groupedNamaItem[namaToko] = [namaItem];
        groupedPhone[namaToko] = [phone];
        groupedAddress[namaToko] = [address];
        groupedClient[namaToko] = [client];
        groupedService[namaToko] = [service];
      }
    }

// Extract unique store names and merged quantities
    List<String> uniqueStoreNames = groupedQuantities.keys.toList();
    List<List<int>> mergedQuantitiesList = uniqueStoreNames
        .map((namaToko) => groupedQuantities[namaToko]!)
        .toList();
    List<List<String>> mergedNamaItem =
        uniqueStoreNames.map((namaToko) => groupedNamaItem[namaToko]!).toList();

    List<List<String>> mergedTimesList =
        uniqueStoreNames.map((namaToko) => groupedTime[namaToko]!).toList();

    List<List<String>> mergedPhoneList =
        uniqueStoreNames.map((namaToko) => groupedPhone[namaToko]!).toList();
    List<List<String>> mergedAddressItem =
        uniqueStoreNames.map((namaToko) => groupedAddress[namaToko]!).toList();

    List<List<String>> mergedClientItem =
        uniqueStoreNames.map((namaToko) => groupedClient[namaToko]!).toList();

    List<List<String>> mergeService =
        uniqueStoreNames.map((namaToko) => groupedService[namaToko]!).toList();
    List<String> times = mergedTimesList.expand((list) => list).toList();
    List<String> client = mergedClientItem.expand((list) => list).toList();
    List<String> service = mergeService.expand((list) => list).toList();

    List<String> phone = mergedPhoneList.expand((list) => list).toList();
    List<String> address = mergedAddressItem.expand((list) => list).toList();

    List<String> client2 = mergedClientItem
        .expand((list) => list)
        .toSet() // Menghapus duplikat dengan Set
        .toList(); // Kembali ke List

    print(uniqueStoreNames);
    print(times);
    print(client);
    print(phone);
    print(address);
    print(mergedNamaItem);

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
                      client2[0],
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
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: client2
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
                  Expanded(child: Container()),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      pengantaranItem.Status,
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
                        color: Color(0xFF505050),
                      ),
                    ),
                  ),
                ],
              ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: service
              //           .sublist(
              //               1) // Skip the first item and get the rest of the items
              //           .map((item) {
              //         return Padding(
              //           padding: EdgeInsets.only(right: 16),
              //           child: Text(
              //             item,
              //             style: TextStyle(
              //               fontFamily: 'Sora',
              //               fontSize: 18,
              //               fontWeight: FontWeight.w400,
              //               color: Color(0xFF505050),
              //             ),
              //           ),
              //         );
              //       }).toList(),
              //     ),
              //   ],
              // ),
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
                    padding: const EdgeInsets.only(right: 16),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                scrollable: true,
                                title: Text(
                                  "Details",
                                  style: TextStyle(
                                    fontFamily: 'Sora',
                                    fontSize: 25,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff6ad6f9),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                content: Container(
                                  width: 250,
                                  height: 100,
                                  child: Scrollbar(
                                    thumbVisibility: true,
                                    controller: _listViewController2,
                                    child: ListView.builder(
                                      controller: _listViewController2,
                                      shrinkWrap: true,
                                      itemCount: totalNamaItem.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  totalNamaItem[index],
                                                  style: TextStyle(
                                                    fontFamily: 'Sora',
                                                    fontSize: 18,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                                Text(
                                                  '${quantitiesList[index]} pcs',
                                                  style: TextStyle(
                                                    fontFamily: 'Sora',
                                                    fontSize: 18,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
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
                                                  color: Color(0xff6AD6F9),
                                                )),
                                          ),
                                          elevation:
                                              MaterialStateProperty.all(5),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xff6AD6F9)),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Go back",
                                          style: TextStyle(
                                              fontFamily: 'Sora',
                                              fontSize: 15,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                  )
                                ],
                              );
                            });
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border:
                              Border.all(width: 2, color: Color(0xFF6AD6F9)),
                        ),
                        child: Center(
                          child: Text(
                            "Detail",
                            style: TextStyle(
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6AD6F9),
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
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
                      '${totalJumlah.toString()} pcs',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
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
                      '${totalBerat.toString()} kg',
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
                      uniqueStoreNames.length.toString(),
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
                    itemCount: times.length,
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
                                if (index < times.length - 1)
                                  CustomPaint(
                                    size: Size(3, 145),
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
                                  times[index].substring(0, 5).toString(),
                                  style: TextStyle(
                                      fontFamily: 'Sora',
                                      color: Color(0xFF6AD6F9),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  uniqueStoreNames[index],
                                  style: TextStyle(
                                      fontFamily: 'Sora',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text("Client: ${client[index]}"),
                                ),
                                Text("Address: ${address[index]}"),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text("No Hp: ${phone[index]}"),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 16),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            scrollable: true,
                                            title: Text(
                                              "Details Items",
                                              style: TextStyle(
                                                fontFamily: 'Sora',
                                                fontSize: 25,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff6ad6f9),
                                              ),
                                            ),
                                            content: Container(
                                              width: 300,
                                              height: 100,
                                              child: Scrollbar(
                                                thumbVisibility: true,
                                                controller:
                                                    _listViewController3,
                                                child: Column(
                                                  children: [
                                                    ListView(
                                                      controller:
                                                          _listViewController3,
                                                      shrinkWrap: true,
                                                      children: [
                                                        for (int i = 0;
                                                            i <
                                                                mergedNamaItem[
                                                                        index]
                                                                    .length;
                                                            i++)
                                                          Row(
                                                            children: [
                                                              Text(
                                                                mergedNamaItem[
                                                                    index][i],
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Sora',
                                                                  fontSize: 18,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      Container()),
                                                              Text(
                                                                '${mergedQuantitiesList[index][i]} pcs',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Sora',
                                                                  fontSize: 18,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              Center(
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        side: BorderSide(
                                                          color:
                                                              Color(0xff6AD6F9),
                                                        ),
                                                      ),
                                                    ),
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all(5),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(Color(
                                                                0xff6AD6F9)),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Go back",
                                                    style: TextStyle(
                                                      fontFamily: 'Sora',
                                                      fontSize: 15,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                            width: 2, color: Color(0xFF6AD6F9)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Detail Items",
                                          style: TextStyle(
                                            fontFamily: 'Sora',
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF6AD6F9),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
