import 'dart:io';

import 'package:camera/camera.dart';
import 'package:driver_cold_storage/models/pengawasModel.dart';
import 'package:driver_cold_storage/screens/camerapage.dart';
import 'package:driver_cold_storage/screens/homePengawas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class DetailHistoryPickupPengawas extends StatefulWidget {
  final Map<String, Map<String, List<PengawasModel>>> groupPickup;

  final distributeId;
  final userId;

  const DetailHistoryPickupPengawas(
      {super.key,
      required this.groupPickup,
      required this.distributeId,
      required this.userId});
  @override
  _detailHistoryPickupState createState() => _detailHistoryPickupState();
}

class _detailHistoryPickupState extends State<DetailHistoryPickupPengawas> {
  List<String> photos = [];
  String selectedWeight = '';
  String selectedPieces = '';
  String selectedTanggal = '';
  String selectedWaktu = '';
  TextEditingController temperatureController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  Future<void> uploadPhoto(File imageFile) async {
    final url = Uri.parse('https://example.com/upload');
    final response = await http.post(
      url,
      body: {
        'file': imageFile.path,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        photos.add(imageFile.path);
      });
    } else {
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

  List<String> namaItems = [];
  List<String> weight = [];
  List<String> pieces = [];
  List<String> tanggal = [];
  List<String> temperature = [];
  List<String> note = [];

  @override
  void initState() {
    widget.groupPickup.values.forEach((dataByIdOrder) {
      dataByIdOrder.forEach((distributeId, items) {
        if (distributeId == widget.distributeId) {
          items.forEach((item) {
            namaItems.add(item.Nama_Item);
            weight.add(item.Berat);
            pieces.add(item.Jumlah);
            tanggal.add(item.Tanggal_Masuk);
            temperature.add(item.Temperature);
            note.add(item.Notes);
          });
        }
      });
    });

    if (namaItems.isNotEmpty) {
      selectedWeight = weight[0];
      selectedPieces = pieces[0];
      selectedTanggal = tanggal[0];
    }
    super.initState();
  }

  void _updateSelectedData(String selectedItem) {
    final index = namaItems.indexOf(selectedItem);
    if (index != -1) {
      setState(() {
        selectedWeight = weight[index];
        selectedPieces = pieces[index];
        selectedTanggal = tanggal[index];
        // Perbarui selectedWaktu jika diperlukan
      });
    }
  }

  Future<void> putDataToApi() async {
    final apiUrl =
        'http://116.68.252.201:1945/TambahTemperature/${widget.distributeId}';
    final temperature = temperatureController.text;
    print(temperature);
    final response =
        await http.put(Uri.parse(apiUrl), body: {'Temperature': temperature});

    if (response.statusCode == 200) {
      print('Data temperatur berhasil dipost ke API');
    } else {
      print('Gagal melakukan POST data temperatur ke API');
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  Future<void> putIschecked() async {
    final apiUrl =
        'http://116.68.252.201:1945/UpdateISCHECK/${widget.distributeId}';

    final response =
        await http.put(Uri.parse(apiUrl), body: {'Is_Check': "true"});

    if (response.statusCode == 200) {
      print('Data ischeck berhasil dipost ke API');
    } else {
      print('Gagal melakukan put data ischeck ke API');
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  Future<void> putDataToApi2() async {
    final apiUrl =
        'http://116.68.252.201:1945/TambahNotes/${widget.distributeId}';
    final notes = notesController.text;
    print(notes);
    final response = await http.put(Uri.parse(apiUrl), body: {'Notes': notes});

    if (response.statusCode == 200) {
      print('Data note berhasil dipost ke API');
    } else {
      print('Gagal melakukan POST data note ke API');
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    temperatureController.text = temperature[0];
    notesController.text = note[0];
    print(namaItems);
    String selectedService = namaItems.isNotEmpty ? namaItems[0] : '';
    print(tanggal);
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
                    padding: const EdgeInsets.only(top: 16, left: 8),
                    child: Text(
                      widget.distributeId,
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
                    items: namaItems.map((namaItem) {
                      return DropdownMenuItem(
                        value: namaItem,
                        child: Text(namaItem),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedService = value ?? '';

                        _updateSelectedData(selectedService);
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
                      selectedWeight,
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
                      selectedPieces,
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
                        selectedTanggal,
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
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
                        controller: temperatureController,
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
                  onTap: () async => {
                    print("tes"),
                    await availableCameras().then(
                      (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CameraPage(cameras: value))),
                    ),
                  },
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
                      controller: notesController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan teks di sini',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  )),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                            color: Color(0xFF6AD6F9),
                            width: 1.0,
                          ),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Container(
                  width: double.infinity,
                  height: 50,
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
                    onPressed: () {
                      putIschecked();

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePengawas(
                            userID: widget.userId,
                          ),
                        ),
                      );
                    },
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
