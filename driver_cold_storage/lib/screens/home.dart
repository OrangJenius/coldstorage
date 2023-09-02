import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
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
                          left: 24.0,
                          top: 32,
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
                        padding: const EdgeInsets.only(top: 32, right: 24),
                        child: Transform.scale(
                          scale: 1.2, // Ubah faktor skala sesuai keinginan Anda
                          child: CircleAvatar(
                            child: Icon(
                                Icons.image), // Ganti dengan thumbnail Anda
                          ),
                        )),
                  ],
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
                    top: 32,
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
                        padding: const EdgeInsets.only(left: 25),
                        child: Container(
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemExtent: 90,
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
                                  margin: EdgeInsets.all(8.0),
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
                                          fontSize: 20,
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
                                          fontSize: 20,
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
                      padding:
                          const EdgeInsets.only(left: 32, right: 32, top: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF6AD6F9),
                              ),
                              width: 150,
                              height: 150,
                            ),

                            Positioned(
                              left: -10, // Posisi dari kiri
                              top: -10, // Posisi dari atas
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
                              top: 50, // Posisi dari atas
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
                              left: 40, // Posisi dari kiri
                              top: 130, // Posisi dari atas
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
                              left: 4, // Posisi dari kiri
                              top: 100, // Posisi dari atas
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 110,
                                    height: 23,
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
                              left: 70, // Posisi dari kiri
                              top: -20, // Posisi dari atas
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
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
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),

                            // Tambahkan Positioned lain sesuai dengan kebutuhan Anda
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 32, top: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF6AD6F9),
                                ),
                                width: 150,
                                height: 150,
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
                                left: 35, // Posisi dari kiri
                                top: 10, // Posisi dari atas
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 110,
                                      height: 23,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
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
                                left: 70, // Posisi dari kiri
                                top: 70, // Posisi dari atas
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
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
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),

                              // Tambahkan Positioned lain sesuai dengan kebutuhan Anda
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 32,
                    top: 32,
                  ),
                  child: Text(
                    "Task",
                    style: TextStyle(
                        color: Color(0xFF6AD6F9),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Sora"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 32,
                    top: 16,
                  ),
                  child: Text(
                    "10:00",
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
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Text(
                                  "Distribute",
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
                                  "Cold Storage -> Toko ABCD -> Toko EFGH -> Toko IJKLM -> Toko AFJSAJF",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontFamily: "Sora",
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
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
                Padding(
                  padding: EdgeInsets.only(
                    left: 32,
                    top: 16,
                  ),
                  child: Text(
                    "13:00",
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
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Text(
                                  "Distribute",
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
                                  "Cold Storage -> Toko ABCD -> Toko EFGH -> Toko IJKLM -> Toko AFJSAJF",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontFamily: "Sora",
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
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
