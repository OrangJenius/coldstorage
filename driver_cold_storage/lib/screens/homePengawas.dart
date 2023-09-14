import 'package:flutter/material.dart';

class HomePengawas extends StatefulWidget {
  @override
  _homePengawasState createState() => _homePengawasState();
}

class _homePengawasState extends State<HomePengawas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  top: 8,
                ),
                child: Text(
                  "Home",
                  style: TextStyle(
                      color: Color(0xFF6AD6F9),
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Sora"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Divider(
                  height: 1, // Atur tinggi garis sesuai kebutuhan
                  color: Colors.grey, // Atur warna garis sesuai kebutuhan
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 32,
                  top: 16,
                ),
                child: Text(
                  "Last Input",
                  style: TextStyle(
                      color: Color(0xFF6AD6F9),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Sora"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 8),
                child: Container(
                  width: 360,
                  height: 152,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey, // Warna bayangan
                        offset:
                            Offset(2, 5), // Jarak bayangan pada sumbu X dan Y
                        blurRadius: 6.0, // Radius blur bayangan
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Side Content
                      Flexible(
                        // <-- Tambahkan ini
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ID Section
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 8),
                                  child: Text(
                                    "ID:",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Sora",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      left: 8,
                                    ),
                                    child: Text(
                                      "BJE454879BJEP",
                                      style: TextStyle(
                                        color: Color(0xFF6AD6F9),
                                        fontSize: 22,
                                        fontFamily: "Sora",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 4),
                              child: Text(
                                "7 Juli 2023 | 10:00",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Sora",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 4),
                              child: Text(
                                "Daging ayam",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "Sora",
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: Text(
                                    "Note :",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: "Sora",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 8),
                                    child: Text(
                                      "jhjsahd jsahdjas sad asdsa hjdhzf sdfsafsdfs",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: "Sora",
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ..._buildDetailColumn("Items", "20"),
                            SizedBox(height: 8),
                            ..._buildDetailColumn("Weight", "20kg"),
                            SizedBox(height: 8),
                            ..._buildDetailColumn("Location", "Building A "),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xFF6AD6F9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Warna bayangan
                        spreadRadius: 2, // Besar penyebaran bayangan
                        blurRadius: 4, // Besar blur bayangan
                        offset: Offset(0, 2), // Posisi bayangan (x, y)
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '+',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ])),
    );
  }
}

List<Widget> _buildDetailColumn(String title, String value) {
  return [
    Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontFamily: "Sora",
      ),
    ),
    Text(
      value,
      style: TextStyle(
          color: Color(0xFF6AD6F9),
          fontSize: 15,
          fontFamily: "Sora",
          fontWeight: FontWeight.bold),
    ),
  ];
}
