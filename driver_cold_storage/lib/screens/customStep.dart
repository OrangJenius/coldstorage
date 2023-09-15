import 'package:driver_cold_storage/screens/detail_history.dart';
import 'package:flutter/material.dart';
import 'linePainter.dart';

class CustomStep extends StatelessWidget {
  final List<String> time;
  final List<String> store;
  final List<String> receiver;
  final List<String> address;
  final List<String> id;

  CustomStep({
    required this.id,
    required this.time,
    required this.store,
    required this.receiver,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            (time.length / 3).ceil(),
            (groupIndex) {
              final startIndex = groupIndex * 3;
              final endIndex = (groupIndex + 1) * 3;
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
                          id[groupIndex], // Display the id for the group
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
                    for (int i = startIndex;
                        i < endIndex && i < time.length;
                        i++)
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Color(0xFF6AD6F9),
                                  ),
                                  if (i < endIndex)
                                    CustomPaint(
                                      size: Size(2, 65),
                                      painter: LinePainter(),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  time[i],
                                  style: TextStyle(
                                    fontFamily: 'Sora',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: Color(0xFF6AD6F9),
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              InkWell(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailHistory()),
                                  )
                                },
                                child: Container(
                                  width: 250,
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
                                        color: Colors.grey, // Warna bayangan
                                        offset: Offset(2,
                                            5), // Jarak bayangan pada sumbu X dan Y
                                        blurRadius: 6.0, // Radius blur bayangan
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Icon(Icons.directions_bus),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            store[i],
                                            style: TextStyle(
                                              fontFamily: 'Sora',
                                              color: Color(0xFF6AD6F9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            receiver[i],
                                            style: TextStyle(
                                              fontFamily: 'Sora',
                                              color: Color(0xFF989898),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            address[i],
                                            style: TextStyle(
                                              fontFamily: 'Sora',
                                              color: Color(0xFF989898),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
