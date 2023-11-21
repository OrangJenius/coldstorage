import 'package:camera/camera.dart';
import 'package:driver_cold_storage/models/pengawasModel.dart';
import 'package:driver_cold_storage/screens/cameraPage2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

class DetailHistoryDistributePengawas extends StatefulWidget {
  final Map<String, Map<String, List<PengawasModel>>> groupDistribute;

  final distributeId;
  final userId;
  final orderId;

  const DetailHistoryDistributePengawas({
    super.key,
    required this.groupDistribute,
    required this.distributeId,
    required this.userId,
    required this.orderId,
  });
  @override
  detailHistoryDistributeState createState() => detailHistoryDistributeState();
}

class detailHistoryDistributeState
    extends State<DetailHistoryDistributePengawas> {
  List<String> photos = [];
  String selectedWeight = '';
  String selectedPieces = '';
  String selectedTanggal = '';
  String selectedWaktu = '';
  TextEditingController temperatureController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  Future<String> tampilkanFoto() async {
    final params = {'folder': 'order_item', 'id': widget.orderId};
    final apiurl = Uri.http('116.68.252.201:1945', '/getPhoto', params);
    try {
      final response = await http.get(apiurl);

      if (response.statusCode == 200) {
        print("sukses");
        return "http://116.68.252.201:1945/getPhoto?folder=order_item&id=${widget.orderId}";
      } else {
        print("gagal");
        return "";
      }
    } catch (e) {
      print("error $e");
      return "";
    }
  }

  Future<Uint8List> getImageBytes() async {
    String imgurl = await tampilkanFoto();
    print("url image: ${imgurl}");
    http.Response response = await http.get(Uri.parse(imgurl));
    return response.bodyBytes;
  }

  List<String> namaItems = [];
  List<String> weight = [];
  List<String> pieces = [];
  List<String> tanggal = [];
  List<String> temperature = [];
  List<String> note = [];
  String time = '';
  @override
  void initState() {
    widget.groupDistribute.values.forEach((dataByIdOrder) {
      dataByIdOrder.forEach((distributeId, items) {
        if (distributeId == widget.distributeId) {
          items.forEach((item) {
            namaItems.add(item.Nama_Item);
            weight.add(item.Berat);
            pieces.add(item.Jumlah);
            tanggal.add(item.Tanggal_Masuk);
            temperature.add(item.Temperature);
            time = item.time.substring(0, 5);
            note.add(item.Notes);
          });
        }
      });
    });

    List<String> itemsTerpisah = [];
    List<String> itemsTerpisah2 = [];
    List<String> itemsTerpisah3 = [];

    for (String items in namaItems) {
      List<String> itemPerString = items.split(',');
      itemsTerpisah.addAll(itemPerString);
    }

    for (String items in weight) {
      List<String> itemPerString = items.split(',');
      itemsTerpisah2.addAll(itemPerString);
    }

    for (String items in pieces) {
      List<String> itemPerString = items.split(',');
      itemsTerpisah3.addAll(itemPerString);
    }

    namaItems = itemsTerpisah;
    weight = itemsTerpisah2;
    pieces = itemsTerpisah3;

    print(namaItems);
    print(weight);
    print(pieces);

    if (namaItems.isNotEmpty) {
      selectedWeight = weight[0];
      selectedPieces = pieces[0];
      selectedTanggal = tanggal[0];
    }
    super.initState();
  }

  void _updateSelectedData(String selectedItem) {
    final index = namaItems.indexOf(selectedItem);
    print("hahahhahahahhahhahaa");
    print(index);
    if (index != -1) {
      setState(() {
        selectedWeight = weight[index];
        selectedPieces = pieces[index];

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
    print(widget.groupDistribute);
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
                        print("hahahhaa");
                        print(selectedService);
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
                        time,
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
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 24),
                    child: InkWell(
                      onTap: () async => {
                        print("tes"),
                        await availableCameras().then(
                          (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CameraPage2(
                                      cameras: value, id: widget.orderId))),
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
                  Container(
                    height: 75,
                    width: 100,
                    child: FutureBuilder<Uint8List>(
                      future: getImageBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return Image.memory(snapshot.data!);
                        return SizedBox(
                          width: 100,
                          height: 75,
                          child: Text("NO DATA"),
                        );
                      },
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
