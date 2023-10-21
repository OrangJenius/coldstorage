import 'package:driver_cold_storage/screens/profile.dart';
import 'package:flutter/material.dart';

class HomePengawas extends StatefulWidget {
  final String userID;
  HomePengawas({required this.userID});
  @override
  _homePengawasState createState() => _homePengawasState();
}

class _homePengawasState extends State<HomePengawas> {
  double containerHeight = 150.0; // Tinggi awal kontainer
  bool isExpanded = false;

  void toggleContainerSize() {
    setState(() {
      if (isExpanded) {
        containerHeight = 150.0; // Tinggi awal kontainer
      } else {
        containerHeight = 300.0; // Tinggi yang diperbesar
      }
      isExpanded = !isExpanded;
    });
  }

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        top: 16,
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
                  ),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Mengatur posisi ke tengah
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, right: 20),
                        child: Transform.scale(
                          scale: 1.2,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => profileScreen(
                                    id: widget.userID,
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              child: Icon(
                                Icons.alarm,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 20),
                        child: Text(
                          "History",
                          style: TextStyle(
                              color: Color(0xFF6AD6F9),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Sora"),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Mengatur posisi ke tengah
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, right: 16),
                        child: Transform.scale(
                          scale: 1.2,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => profileScreen(
                                    id: widget.userID,
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.image),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 16),
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              color: Color(0xFF6AD6F9),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Sora"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                child: Divider(
                  height: 1, // Atur tinggi garis sesuai kebutuhan
                  color: Colors.grey, // Atur warna garis sesuai kebutuhan
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 24),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 380,
                      height: containerHeight,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
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
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 8),
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
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 4),
                                  child: Text(
                                    "7 Juli 2023 | 10:00",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: "Sora",
                                    ),
                                  ),
                                ),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 1),
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
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 1),
                                        child: Text(
                                          "jhjsahd jsahdjas sad asdsa hjdhzf ",
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
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ..._buildDetailColumn("Items", "20"),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ..._buildDetailColumn(
                                              "Weight", "20kg"),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ..._buildDetailColumn(
                                              "Location", "Gedung A"),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5, // Posisi dari kiri
                    top: 0, // Posisi dari atas
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFF6AD6F9)),
                          child: Center(
                            child: Text(
                              "Distribute",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontFamily: "Sora",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedPositioned(
                    right: 20, // Posisi dari kiri
                    bottom: isExpanded
                        ? containerHeight - 290
                        : 10, // Posisi dari atas
                    duration: Duration(milliseconds: 300),
                    child: GestureDetector(
                      onTap:
                          toggleContainerSize, // Panggil fungsi ketika ikon ditekan
                      child: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 50,
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                        isExpanded, // Tampilkan widget ini hanya jika kontainer diperluas
                    child: Positioned(
                      left: 24,
                      top: 160, // Atur posisi sesuai kebutuhan Anda
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                Text(
                                  "Item 1",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: "Sora",
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                          width: 2, color: Color(0xFF6AD6F9)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Check Items",
                                        style: TextStyle(
                                          fontFamily: 'Sora',
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF6AD6F9),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Text(
                                "Item 2",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: "Sora",
                                ),
                              ),
                              SizedBox(
                                width: 147,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                        width: 2, color: Color(0xFF6AD6F9)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Check Items",
                                      style: TextStyle(
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF6AD6F9),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ), // Gantilah dengan widget tambahan yang ingin Anda tambahkan
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            Expanded(child: Container()),
            Container(
              height: 75,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/Delivery Truck.png',
                        fit: BoxFit.cover,
                        color: Colors.black,
                        scale: 0.8,
                      ),
                      Text("Distribute")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/Boxes.png',
                        fit: BoxFit.cover,
                        color: Colors.black,
                        scale: 1.2,
                      ),
                      Text("Pickup")
                    ],
                  ),
                ],
              ),
            )
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
