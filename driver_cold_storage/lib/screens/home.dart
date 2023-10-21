import 'dart:convert';

import 'package:driver_cold_storage/models/pengantaranModel.dart';
import 'package:driver_cold_storage/screens/detail_penjemputan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;

class homeScreen extends StatefulWidget {
  final String userID;
  homeScreen({required this.userID});
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int? selectedIndex;

  int jumlahDistribute = 0;
  List<String> hari = [];
  List<String> tanggal = [];
  int countDistribute = 0;
  int countPickup = 0;

  @override
  void initState() {
    super.initState();
    fetchPengantaranData(); // Fetch pengantaran data from API when the screen initializes
    selectedIndex = 0;

    // Mendapatkan tanggal saat ini
    DateTime now = DateTime.now();

    // Loop untuk mengisi daftar tanggal dan hari untuk 7 hari ke depan
    for (int i = 0; i < 7; i++) {
      // Menambahkan tanggal saat ini ditambah i hari
      DateTime nextDate = now.add(Duration(days: i));
      tanggal.add(nextDate.day.toString().padLeft(2, '0'));

      // Menambahkan nama hari sesuai dengan tanggal
      String dayName = DateFormat('E').format(nextDate);
      hari.add(dayName);
    }
  }

  Map<String, List<PengantaranModel>> groupedData = {};
  Map<String, List<PengantaranModel>> sortedGroupedData = {};

  Future<void> fetchPengantaranData() async {
    final apiUrl =
        'http://116.68.252.201:1945/DataDistributeWithUSERID/${widget.userID}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Successfully fetched data from the API
        final responseJson = jsonDecode(response.body);
        final List<dynamic> apiPengantaranData = responseJson['data'];

        List<PengantaranModel> pengantaranModel = apiPengantaranData
            .map((data) => PengantaranModel.fromJson(data))
            .toList();

        groupedData.clear();

        for (var item in pengantaranModel) {
          if (!groupedData.containsKey(item.Id)) {
            groupedData[item.Id] = [item];
          } else {
            groupedData[item.Id]!.add(item);
          }
        }

        setState(() {
          // Konversi groupedData ke daftar entri yang berisi Distribute_Id dan waktu
          List<Map<String, dynamic>> dataEntries = [];
          groupedData.forEach((distributeId, items) {
            if (items.isNotEmpty) {
              final time = items[0].Time;
              dataEntries.add({'Distribute_Id': distributeId, 'Time': time});
            }
          });

// Urutkan dataEntries berdasarkan waktu
          dataEntries.sort((a, b) {
            final timeA = a['Time'] as String;
            final timeB = b['Time'] as String;
            return timeA.compareTo(timeB);
          });

// Buat daftar baru yang akan berisi groupedData yang sudah diurutkan

// Iterasi melalui dataEntries yang sudah diurutkan
          dataEntries.forEach((entry) {
            final distributeId = entry['Distribute_Id'] as String;
            final items = groupedData[distributeId];
            sortedGroupedData[distributeId] = items!;
          });
        });

// Iterasi melalui sortedGroupedData

        for (String distributeId in groupedData.keys) {
          List<PengantaranModel> items = sortedGroupedData[distributeId]!;

          for (PengantaranModel item in items) {
            String itemDate = item.Tanggal_PickUp;

            // Di sini Anda dapat mengakses dan melakukan operasi pada setiap item
            if (itemDate == tanggal[selectedIndex ?? 0]) {
              // Periksa status item
              if (item.Status == "Distribute") {
                countDistribute++; // Jika status "Distribute", tambahkan ke hitung Distribute
                break;
              } else if (item.Status == "Pick-Up") {
                countPickup++; // Jika status "Pick-Up", tambahkan ke hitung Pickup
                break;
              }
            }
          }
        }

// Hasil groupedAttributes akan berisi nilai-nilai yang digabungkan sesuai dengan keys yang sama
      } else {
        // API call failed or returned an error status code
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred during API call
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: fetchPengantaranData,
        child: SafeArea(
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
                            scale:
                                1.2, // Ubah faktor skala sesuai keinginan Anda
                            child: InkWell(
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => profileScreen(
                                            id: widget.userID,
                                          )),
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
                                      countDistribute =
                                          0; // Reset countDistribute menjadi 0
                                      countPickup =
                                          0; // Reset countPickup menjadi 0

                                      for (String distributeId
                                          in sortedGroupedData.keys) {
                                        List<PengantaranModel> items =
                                            sortedGroupedData[distributeId]!;

                                        for (PengantaranModel item in items) {
                                          String itemDate =
                                              item.Tanggal_PickUp.substring(8);

                                          print(itemDate);
                                          print(tanggal[selectedIndex ?? 0]);

                                          // Di sini Anda dapat mengakses dan melakukan operasi pada setiap item
                                          if (itemDate ==
                                              tanggal[selectedIndex ?? 0]) {
                                            // Periksa status item
                                            if (item.Status == "Distribute") {
                                              countDistribute++; // Jika status "Distribute", tambahkan ke hitung Distribute
                                              break;
                                            } else if (item.Status ==
                                                "Pick-Up") {
                                              countPickup++; // Jika status "Pick-Up", tambahkan ke hitung Pickup
                                              break;
                                            }
                                          }
                                        }
                                      }
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          tanggal[index],
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
                                          borderRadius:
                                              BorderRadius.circular(8)),
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
                                        countDistribute.toString(),
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
                                        countPickup.toString(),
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: sortedGroupedData
                        .length, // Replace 'itemCount' with the number of items you have

                    itemBuilder: (BuildContext context, int index) {
                      String distributeId = sortedGroupedData.keys.elementAt(
                          index); // Ambil Distribute_Id berdasarkan indeks
                      List<PengantaranModel>? items =
                          sortedGroupedData[distributeId];

                      final pengantaranItem = items![0];

                      String timeString = pengantaranItem.Time
                          .toString(); // Replace with your time string

                      // Split the time string using the ':' delimiter
                      List<String> timeParts = timeString.split(':');

                      // Get the hour and minute parts
                      String hour = timeParts[0];
                      String minute = timeParts[1];

                      // Now you have the hour and minute separately
                      String formattedTime = "$hour:$minute"; // "hh:mm" format

                      List<String> NamaTokoList = items.isNotEmpty
                          ? items.first.Nama_Toko
                              .split(',')
                              .map((namaToko) => namaToko.trim())
                              .toList()
                          : [];

                      List<String> quantitiesList = items.isNotEmpty
                          ? items.first.Quantities
                              .split(',')
                              .map((quantity) => quantity.trim())
                              .toList()
                          : [];

                      List<String> berat = items.isNotEmpty
                          ? items.first.Berat
                              .split(',')
                              .map((Berat) => Berat.trim())
                              .toList()
                          : [];

                      print(NamaTokoList);
                      print(quantitiesList);

                      int totalJumlah = 0;
                      int totalBerat = 0;

                      for (String angka in quantitiesList) {
                        totalJumlah += int.parse(angka);
                      }

                      for (String angka in berat) {
                        totalBerat += int.parse(angka);
                      }

                      String itemDate =
                          pengantaranItem.Tanggal_PickUp.substring(8);

                      //    print(groupedAttributes);

                      if (itemDate == tanggal[selectedIndex ?? 0]) {
                        return Column(
                          children: [
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
                                    formattedTime,
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
                                //   Navigasi ke halaman DetailDistribusi
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => detail_Penjemputan(
                                      sortedGroupedData: sortedGroupedData,
                                      distributeId: distributeId,
                                    ), // Ganti dengan widget halaman DetailDistribusi yang sesuai
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 16),
                                child: Container(
                                  width: 390,
                                  height: 152,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 215, 215, 215)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      // Left Side Content
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // ID Section
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, left: 8),
                                                  child: Text(
                                                    "ID:",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "Sora",
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8, left: 8),
                                                  child: Text(
                                                    distributeId,
                                                    style: TextStyle(
                                                      color: Color(0xFF6AD6F9),
                                                      fontSize: 22,
                                                      fontFamily: "Sora",
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, top: 4),
                                                child: Text(
                                                  '${pengantaranItem.Tanggal_PickUp} | ${formattedTime}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: "Sora",
                                                  ),
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 4),
                                              child: Text(
                                                pengantaranItem.Item,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: "Sora",
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 8),
                                              child: Text(
                                                pengantaranItem.Status,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: "Sora",
                                                ),
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, top: 8),
                                                    child: Text(
                                                      "Cold Storage",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 15,
                                                        fontFamily: "Sora",
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      for (int index = 0;
                                                          index <
                                                              NamaTokoList
                                                                  .length;
                                                          index++)
                                                        Row(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  '${quantitiesList[index]} pcs',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        "Sora",
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      true,
                                                                ),
                                                                Text(
                                                                  "-----",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        15,
                                                                    fontFamily:
                                                                        "Sora",
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  softWrap:
                                                                      true,
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 8,
                                                                      top: 8,
                                                                      right: 8),
                                                              child: Text(
                                                                NamaTokoList[
                                                                    index],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      "Sora",
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 8),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, right: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ..._buildDetailColumn("Items",
                                                totalJumlah.toString()),
                                            SizedBox(height: 8),
                                            ..._buildDetailColumn("Weight",
                                                totalBerat.toString()),
                                            SizedBox(height: 8),
                                            ..._buildDetailColumn("Stops",
                                                NamaTokoList.length.toString()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  )
                ]),
          ),
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
