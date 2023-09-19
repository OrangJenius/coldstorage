import 'package:driver_cold_storage/screens/detail_distribusi.dart';
import 'package:driver_cold_storage/screens/detail_penjemputan.dart';
import 'package:flutter/material.dart';
import 'profile.dart';

class homeScreen extends StatefulWidget {
  final String userID;
  homeScreen({required this.userID});
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final List<String> hari = ['M', 'T', 'W', 'T', 'F', 'S'];

  final List<String> angka = ['01', '02', '03', '04', '05', '06', '07'];
  Map<int, bool> selectedItems = {};
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          top: 16,
                        ),
                        child: Text(
                          "Your Task",
                          style: TextStyle(
                              color: Color(0xFF6AD6F9),
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Sora"),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 16, right: 16),
                        child: Transform.scale(
                          scale: 1.2, // Ubah faktor skala sesuai keinginan Anda
                          child: InkWell(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => profileScree()),
                              )
                            },
                            child: CircleAvatar(
                              child: Icon(
                                  Icons.image), // Ganti dengan thumbnail Anda
                            ),
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Divider(
                    height: 1, // Atur tinggi garis sesuai kebutuhan
                    color:
                        Colors.grey[350], // Atur warna garis sesuai kebutuhan
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 24,
                    top: 12,
                  ),
                  child: Text(
                    "Today",
                    style: TextStyle(
                        color: Color(0xFF6AD6F9),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Sora"),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          height: 85,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemExtent: 85,
                            itemCount: hari.length,
                            itemBuilder: (context, index) {
                              // Cek apakah item ini adalah yang dipilih
                              bool isSelected = index == selectedIndex;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // Mengubah state item ketika diklik
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.5, color: Color(0xFF6AD6F9)),
                                    color: isSelected
                                        ? Color(0xFF6AD6F9)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        12), // Tambahkan ini
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        angka[index],
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors
                                                  .black, // Perubahan di sini
                                        ),
                                      ),
                                      Text(
                                        hari[index],
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black, // Dan di sini
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF6AD6F9),
                              ),
                              width: 175,
                              height: 175,
                            ),

                            Positioned(
                              left: 20, // Posisi dari kiri
                              top: 1, // Posisi dari atas
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white70),
                                  ),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF6AD6F9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 10, // Posisi dari kiri
                              top: 70, // Posisi dari atas
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white70),
                                  ),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF6AD6F9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 80, // Posisi dari kiri
                              top: 90, // Posisi dari atas
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white70),
                                  ),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF6AD6F9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 4, // Posisi dari kiri
                              top: 140, // Posisi dari atas
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "Distribute",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xFF6AD6F9),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Positioned(
                              left: 75, // Posisi dari kiri
                              top: -25, // Posisi dari atas
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 125,
                                    height: 125,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "01",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontFamily: "Sora"),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 175,
                              height: 175,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF6AD6F9),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),

                            // Tambahkan Positioned lain sesuai dengan kebutuhan Anda
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, top: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF6AD6F9),
                              ),
                              width: 175,
                              height: 175,
                            ),
                            Positioned(
                              left: 5, // Posisi dari kiri
                              top: 20, // Posisi dari atas
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white70),
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF6AD6F9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 70, // Posisi dari kiri
                              top: 35, // Posisi dari atas
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white70),
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF6AD6F9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 10, // Posisi dari kiri
                              top: 100, // Posisi dari atas
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white70),
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF6AD6F9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 50, // Posisi dari kiri
                              top: 10, // Posisi dari atas
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "Pickup",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xFF6AD6F9),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Positioned(
                              left: 80, // Posisi dari kiri
                              top: 80, // Posisi dari atas
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 125,
                                    height: 125,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "10",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontFamily: "Sora"),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 175,
                              height: 175,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF6AD6F9),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),

                            // Tambahkan Positioned lain sesuai dengan kebutuhan Anda
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: 16,
                  ),
                  child: Text(
                    "Tasks",
                    style: TextStyle(
                        color: Color(0xFF6AD6F9),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Sora"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: 8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Target Time :",
                        style: TextStyle(
                            color: Color(0xFF6AD6F9),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Sora"),
                      ),
                      Text(
                        " 10.00",
                        style: TextStyle(
                            color: Color(0xFF6AD6F9),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Sora"),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigasi ke halaman DetailDistribusi
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            detail_Penjemputan(), // Ganti dengan widget halaman DetailDistribusi yang sesuai
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: Container(
                      width: 390,
                      height: 152,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 215, 215, 215)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          // Left Side Content
                          Flexible(
                            // <-- Tambahkan ini
                            child: Column(
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
                                    Padding(
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
                                          decoration: TextDecoration.underline,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 4),
                                  child: Text(
                                    "Daging ayam",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: "Sora",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  child: Text(
                                    "Distribute",
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
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 8),
                                      child: Text(
                                        "Cold Storage",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontFamily: "Sora",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            8), // Add a SizedBox for spacing between the two Text widgets
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start, // Align content to start
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Align content to start
                                      children: [
                                        Text(
                                          "10pcs",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontFamily: "Sora",
                                          ),
                                        ),
                                        Text(
                                          "-----",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontFamily: "Sora",
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 8),
                                        child: Text(
                                          "Toko ABCDEasdadadas",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontFamily: "Sora",
                                          ),
                                          maxLines: 1, // Set maximum lines to 2
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
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
                                ..._buildDetailColumn("Stops", "2"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Target Time :",
                        style: TextStyle(
                            color: Color(0xFF6AD6F9),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Sora"),
                      ),
                      Text(
                        " 13.00",
                        style: TextStyle(
                            color: Color(0xFF6AD6F9),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Sora"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Container(
                    width: 390,
                    height: 152,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 215, 215, 215)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        // Left Side Content
                        Flexible(
                          // <-- Tambahkan ini
                          child: Column(
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      left: 8,
                                    ),
                                    child: Text(
                                      "BJE432529BJEP",
                                      style: TextStyle(
                                        color: Color(0xFF6AD6F9),
                                        fontSize: 22,
                                        fontFamily: "Sora",
                                        decoration: TextDecoration.underline,
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
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Text(
                                  "Pickup",
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
                                      "Cold Storage",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontFamily: "Sora",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Add a SizedBox for spacing between the two Text widgets
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start, // Align content to start
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Align content to start
                                    children: [
                                      Text(
                                        "10pcs",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontFamily: "Sora",
                                        ),
                                      ),
                                      Text(
                                        "-----",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontFamily: "Sora",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 8),
                                      child: Text(
                                        "Toko ABCDEasdadadas",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontFamily: "Sora",
                                        ),
                                        maxLines: 1, // Set maximum lines to 2
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
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
                              ..._buildDetailColumn("Stops", "2"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                )
              ]),
        ),
      ),
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
