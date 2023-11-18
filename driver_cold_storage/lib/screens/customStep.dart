import 'package:driver_cold_storage/screens/detail_history.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'linePainter.dart';
import 'package:driver_cold_storage/models/historyModel.dart';

class CustomStep extends StatefulWidget {
  final List<HistoryModel> historyModel;
  final List<HistoryModel2> historyModel2;
  final DateTime? selectedDate;
  final String? selectedStatus;
  final String? idHistory;
  CustomStep({
    required this.historyModel,
    required this.historyModel2,
    this.selectedDate,
    this.selectedStatus,
    this.idHistory,
  });
  @override
  State<CustomStep> createState() => _CustomStepState();
}

class _CustomStepState extends State<CustomStep> {
  List<Widget> displayItems = [];
  // Create an empty list to hold display items
  @override
  Widget build(BuildContext context) {
    print('Selected Date: ${widget.selectedDate}');
    print("panjang data 1: ${widget.historyModel.length}");
    print("panjang data 2: ${widget.historyModel2.length}");
    print("history date ${widget.historyModel[0].tanggalPickup}");
    displayItems.clear(); // Clear the existing display items
    List<HistoryModel> filteredHistory = widget.historyModel;
    if (widget.selectedDate != null) {
      print("Filtering by ID2: ${widget.selectedDate}");
      filteredHistory = filteredHistory.where((history) {
        final tanggalPickup = (history.tanggalPickup.toString()).trim();
        if (tanggalPickup.isNotEmpty) {
          final historyDate = DateFormat('yyyy-MM-dd').parse(tanggalPickup);
          final selectedDateString =
              DateFormat('yyyy-MM-dd').format(widget.selectedDate!);
          return selectedDateString ==
              DateFormat('yyyy-MM-dd').format(historyDate);
        }
        return false;
      }).toList();
    } else if (widget.selectedStatus != null &&
        widget.selectedStatus != 'All') {
      print("Filtering by ID3: ${widget.selectedStatus}");
      filteredHistory = filteredHistory.where((history) {
        return (widget.selectedStatus == 'Distribute' &&
                history.status == 'Distribute') ||
            (widget.selectedStatus == 'Pickup' && history.status == 'Pickup');
      }).toList();
      print(filteredHistory);
    } else if (widget.idHistory != null) {
      print("Filtering by ID: ${widget.idHistory}");
      filteredHistory = filteredHistory.where((history) {
        return history.Id.toLowerCase()
            .contains(widget.idHistory!.toLowerCase());
      }).toList();
      print("Filtered History Count: ${filteredHistory.length}");
      print(filteredHistory.map((history) => history.Id).toList());
    }
    print('Filtered History Count: ${filteredHistory.length}');
    print("filter history date: ${filteredHistory[0].tanggalPickup}");
    // Group the filtered history by the 'tanggal' (date) field
    final groupedHistory = groupBy(filteredHistory, (HistoryModel history) {
      final tanggalPickup = (history.tanggalPickup.toString()).trim();
      if (tanggalPickup.isNotEmpty) {
        final historyDate = DateFormat('yyyy-MM-dd').parse(tanggalPickup);
        return DateFormat('yyyy-MM-dd').format(historyDate);
      }
      return ''; // Return an empty string if tanggalPickup is empty
    });
    // Sort the groups by date
    final sortedDates = groupedHistory.keys.toList()
      ..sort((a, b) {
        final aDate = DateFormat('yyyy-MM-dd').parse(a);
        final bDate = DateFormat('yyyy-MM-dd').parse(b);
        return aDate.compareTo(bDate);
      });
    for (var date in sortedDates) {
      print("Data date ${date}");
      final itemsForDate = groupedHistory[date];
      String orders = '';
      for (var lists in itemsForDate!) {
        if (orders.length > 0) {
          orders = '$orders, ${lists.orderId}';
        } else {
          orders = lists.orderId;
        }
      }
      displayItems.add(
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'ID: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Sora',
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Text(
                    orders, // Display the id for the group
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Sora',
                      color: Color(0xFF6AD6F9),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      );
      List<HistoryModel> historyList = itemsForDate;
      List<HistoryModel2> historyList2 = [];
      print("Data panjang ${itemsForDate.length}");
      for (var history in itemsForDate) {
        print("Data history ${history}");
        // Find the corresponding data from historyModel2
        final historyModel2ItemsForDate = widget.historyModel2
            .where((element) => element.Id == history.Id)
            .toList();
        historyList2.addAll(historyModel2ItemsForDate);
        int index = 0;
        displayItems.add(
          InkWell(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailHistory(
                    historyModel: historyList,
                    historyModel2: historyList2,
                  ),
                ),
              )
            },
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle,
                          color: Color(0xFF6AD6F9),
                        ),
                        SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            history.time,
                            style: TextStyle(
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Color(0xFF6AD6F9),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            width: 240,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(2, 5),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Color(0xFF6AD6F9),
                                        size: 45,
                                      ),
                                      Image.asset("assets/Delivery Truck.png"),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          history.namaToko,
                                          style: TextStyle(
                                            fontFamily: 'Sora',
                                            color: Color(0xFF6AD6F9),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          "penerima: ${historyModel2ItemsForDate[index].namaClient}",
                                          style: TextStyle(
                                            fontFamily: 'Sora',
                                            color: Color(0xFF989898),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          "Alamat: ${history.alamat}",
                                          style: TextStyle(
                                            fontFamily: 'Sora',
                                            color: Color(0xFF989898),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (history.Id != itemsForDate[itemsForDate.length - 1].Id)
                      Container(
                        padding: EdgeInsets.only(left: 11.5),
                        child: CustomPaint(
                          size: Size(0, 80),
                          painter: LinePainter(),
                        ),
                      ),
                  ]),
            ),
          ),
        );
      }
      displayItems.add(
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: displayItems,
          ),
        ),
      ),
    );
  }
}
