import 'package:flutter/material.dart';

class detail_Penjemputan extends StatefulWidget {
  @override
  _detailPenjemputanState createState() => _detailPenjemputanState();
}

class _detailPenjemputanState extends State<detail_Penjemputan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 16, top: 24, bottom: 16, right: 263),
                child: Text(
                  "Detail",
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
                color: Colors.grey,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            "Percobaan detail",
                            style: TextStyle(
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Color(0xFF505050),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            "7 Juli 2023 | 20.00",
                            style: TextStyle(
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF505050),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            "Note: andkjnqwujdiuna",
                            style: TextStyle(
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Color(0xFFA5A5A5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'ID: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Sora',
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'BJE290012KLOP',
                            style: TextStyle(
                              fontSize: 14,
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
                ],
              ),
              SizedBox(
                height: 8,
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
