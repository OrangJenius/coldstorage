import 'package:driver_cold_storage/screens/detail_history.dart';
import 'package:flutter/material.dart';
import 'linePainter.dart';
import 'package:driver_cold_storage/models/historyModel.dart';

class CustomStep extends StatelessWidget {
  final List<HistoryModel> historyModel;

  CustomStep({required this.historyModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            (historyModel.length),
            (groupIndex) {
              List<List<String>> indexOrder = [];
              List<List<String>> indexTime = [];
              List<List<String>> indexToko = [];
              List<List<String>> indexAlamat = [];
              for (int i = 0; i < historyModel.length; i++) {
                List<String> temp = historyModel[i].orderId.contains(',')
                    ? historyModel[i].orderId.split(',')
                    : [historyModel[i].orderId];
                indexOrder.add(temp);
                List<String> temp2 = historyModel[i].orderId.contains(',')
                    ? historyModel[i].time.split(',')
                    : [historyModel[i].time];
                indexTime.add(temp2);
                List<String> temp3 = historyModel[i].orderId.contains(',')
                    ? historyModel[i].namaToko.split(',')
                    : [historyModel[i].namaToko];
                indexToko.add(temp3);
                List<String> temp4 = historyModel[i].orderId.contains(',')
                    ? historyModel[i].alamat.split(',')
                    : [historyModel[i].alamat];
                indexAlamat.add(temp4);
              }

              return Padding(
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
                          '${historyModel[historyModel.length - groupIndex - 1].Id}', // Display the id for the group
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
                    for (int i = 0; i < indexOrder[groupIndex].length; i++)
                      Container(
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
                                    indexTime[groupIndex][i],
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
                                  child: InkWell(
                                    onTap: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailHistory()),
                                      )
                                    },
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
                                            color:
                                                Colors.grey, // Warna bayangan
                                            offset: Offset(2,
                                                5), // Jarak bayangan pada sumbu X dan Y
                                            blurRadius:
                                                6.0, // Radius blur bayangan
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  color: Color(0xFF6AD6F9),
                                                  size: 45,
                                                ),
                                                Image.asset(
                                                    "assets/Delivery Truck.png")
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
                                                    indexToko[groupIndex][i],
                                                    style: TextStyle(
                                                      fontFamily: 'Sora',
                                                      color: Color(0xFF6AD6F9),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    historyModel[historyModel
                                                                .length -
                                                            groupIndex -
                                                            1]
                                                        .namaClient,
                                                    style: TextStyle(
                                                      fontFamily: 'Sora',
                                                      color: Color(0xFF989898),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    indexAlamat[groupIndex][i],
                                                    style: TextStyle(
                                                      fontFamily: 'Sora',
                                                      color: Color(0xFF989898),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                ),
                              ],
                            ),
                            if (i < indexOrder[groupIndex].length - 1)
                              Container(
                                padding: EdgeInsets.only(left: 11.5),
                                child: CustomPaint(
                                  size: Size(0, 80),
                                  painter: LinePainter(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
