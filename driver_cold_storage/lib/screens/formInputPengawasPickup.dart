import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class FormInputPengawasPickup extends StatefulWidget {
  @override
  _FormInputPengawasPickupState createState() =>
      _FormInputPengawasPickupState();
}

class _FormInputPengawasPickupState extends State<FormInputPengawasPickup> {
  List<String> photos = [];

  Future<void> uploadPhoto(File imageFile) async {
    final url =
        Uri.parse('https://example.com/upload'); // Ganti dengan URL server Anda
    final response = await http.post(
      url,
      body: {
        'file': imageFile.path,
      },
    );

    if (response.statusCode == 200) {
      // Jika berhasil diunggah, Anda dapat menambahkannya ke daftar foto yang diunggah
      setState(() {
        photos.add(imageFile.path);
      });
    } else {
      // Tampilkan pesan kesalahan jika unggah gagal
      print('Gagal mengunggah foto: ${response.statusCode}');
    }
  }

  Future<void> chooseImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await uploadPhoto(imageFile);
    }
  }

  String selectedService = 'Service 1';
  String selectedBuilding = 'Building 1';
  String selectedAisle = 'Aisle 1';
  String selectedPlace = 'Place 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  top: 16,
                ),
                child: Text(
                  "Distribute",
                  style: TextStyle(
                    color: Color(0xFF6AD6F9),
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Sora",
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 18),
                    child: Text(
                      "ID:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Sora",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: Text(
                      "sda213271321",
                      style: TextStyle(
                        color: Color(0xFF6AD6F9),
                        fontSize: 24,
                        fontFamily: "Sora",
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedService,
                    items: [
                      DropdownMenuItem(
                          value: "Service 1", child: Text("Service 1")),
                      DropdownMenuItem(
                          value: "Service 2", child: Text("Service 2")),
                      DropdownMenuItem(
                          value: "Service 3", child: Text("Service 3")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedService = value ?? '';
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 16),
                    child: Text(
                      "Weight (kg) ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Sora",
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "10 kg ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Sora",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 16),
                    child: Text(
                      "Pieces (pcs) ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Sora",
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "10 pcs ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Sora",
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  top: 24,
                ),
                child: Text(
                  "Tanggal dan Waktu",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Sora",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  top: 16,
                ),
                child: Text(
                  "Tanggal",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Sora",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "22-06-2023",
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF747474),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  top: 16,
                ),
                child: Text(
                  "Waktu",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Sora",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceAround, // Mengatur posisi horizontal
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '12:30',
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF747474),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      Icon(Icons.alarm),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  top: 16,
                ),
                child: Text(
                  "Storage",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontFamily: "Sora",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  top: 16,
                ),
                child: Text(
                  "Building",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Sora",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Building A",
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF747474),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  top: 16,
                ),
                child: Text(
                  "Aisle",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Sora",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Aisle B",
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF747474),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  top: 16,
                ),
                child: Text(
                  "Place",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Sora",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Place c",
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF747474),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  top: 16,
                ),
                child: Text(
                  "Temperatur",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Sora",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, left: 24),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors
                                    .black), // Ganti warna garis bawah di sini
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .blue), // Ganti warna garis bawah saat difokuskan
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "Celcius ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Sora",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  top: 16,
                ),
                child: Text(
                  "Photos",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Sora",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, left: 24),
                child: InkWell(
                  onTap: chooseImage,
                  child: Container(
                    width: 100,
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[400],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '+',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Add Photos',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: Container(
              //     width: 100,
              //     height: 75,
              //     child: ListView.builder(
              //       itemCount: photos.length,
              //       itemBuilder: (context, index) {
              //         return ListTile(
              //           title: Image.file(File(photos[index])),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  top: 16,
                ),
                child: Text(
                  "Deskripsi",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Sora",
                      fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(left: 24.0, top: 16, right: 24),
                  child: Container(
                    width: 365,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1)),
                    child: TextField(
                      // Tambahkan TextField di sini
                      decoration: InputDecoration(
                        hintText: 'Masukkan teks di sini', // Teks placeholder
                        border: InputBorder.none, // Hapus garis bawah default
                        contentPadding:
                            EdgeInsets.all(8), // Jarak dari tepi kontainer
                      ),
                    ),
                  )),

              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 8), // Padding horizontal 32 dan vertikal 24
                child: Container(
                  width: double
                      .infinity, // Ini akan membuat Container mengambil lebar maksimal yang tersedia.
                  height:
                      50, // Anda bisa mengatur tinggi tombol sesuai kebutuhan Anda.

                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30), // border radius sebesar 30
                          side: BorderSide(
                            color: Color(0xFF6AD6F9), // Warna border
                            width:
                                1.0, // Lebar border (sesuaikan dengan kebutuhan Anda)
                          ),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {},
                    child: Text('HomePage',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Sora",
                            color: Color(0xFF6AD6F9))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 8), // Padding horizontal 32 dan vertikal 24
                child: Container(
                  width: double
                      .infinity, // Ini akan membuat Container mengambil lebar maksimal yang tersedia.
                  height:
                      50, // Anda bisa mengatur tinggi tombol sesuai kebutuhan Anda.
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30), // border radius sebesar 30
                        ),
                      ),
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF6AD6F9)),
                    ),
                    onPressed: () {},
                    child: Text('Save',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Sora",
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
