import 'package:flutter/material.dart';
import 'reportDetail.dart';

class reportScreen extends StatefulWidget {
  @override
  _reportScreenState createState() => _reportScreenState();
}

class _reportScreenState extends State<reportScreen> {
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
                  "Report Services",
                  style: TextStyle(
                    color: Color(0xFF6AD6F9),
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Divider(
                  height: 1, // Atur tinggi garis sesuai kebutuhan
                  color: Color(0xFFd9d9d9), // Atur warna garis sesuai kebutuhan
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => reportDetailScreen()))
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          style: BorderStyle.solid, color: Colors.grey),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
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
                                text: 'BJE290012KLOP',
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
                        Text(
                          "7 Juli 2023 | 20.00",
                          style: TextStyle(
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                        Text(
                          "Note: andkjnqwujdiuna",
                          style: TextStyle(
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 10,
                              color: Color(0xffA5A5A5)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Qty",
                                  style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12),
                                ),
                                Text(
                                  "10",
                                  style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Weights",
                                  style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '10',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Sora',
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Kg',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Sora',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "price",
                                  style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12),
                                ),
                                Text(
                                  "Rp 100.000",
                                  style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Amount Left",
                                  style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12),
                                ),
                                Text(
                                  "Rp 99.000",
                                  style: TextStyle(
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
