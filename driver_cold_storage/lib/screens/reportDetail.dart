import 'package:flutter/material.dart';

class reportDetailScreen extends StatefulWidget {
  @override
  _reportDetailScreenState createState() => _reportDetailScreenState();
}

class _reportDetailScreenState extends State<reportDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
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
                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                child: Divider(
                  height: 1, // Atur tinggi garis sesuai kebutuhan
                  color: Color(0xFFd9d9d9), // Atur warna garis sesuai kebutuhan
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 8),
                child: RichText(
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "7 Juli 2023 | 20.00",
                  style: TextStyle(
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Note: andkjnqwujdiuna",
                  style: TextStyle(
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 10,
                      color: Color(0xffA5A5A5)),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 16, bottom: 8, right: 16, top: 16),
                child: Row(
                  children: [
                    Text(
                      "Customer",
                      style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff505050)),
                    ),
                    Expanded(
                      child: Row(),
                    ),
                    Text(
                      "Budianto",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff505050),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 16, bottom: 8, right: 16, top: 8),
                child: Row(
                  children: [
                    Text(
                      "Service",
                      style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff505050)),
                    ),
                    Expanded(
                      child: Row(),
                    ),
                    Text(
                      "Door to Port",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff505050),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 16, bottom: 8, right: 16, top: 8),
                child: Row(
                  children: [
                    Text(
                      "Items",
                      style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff505050)),
                    ),
                    Expanded(
                      child: Row(),
                    ),
                    Text(
                      "Ayam Goyeng",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff505050),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 16, bottom: 8, right: 16, top: 8),
                child: Row(
                  children: [
                    Text(
                      "Weights",
                      style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff505050)),
                    ),
                    Expanded(
                      child: Row(),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '10',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Sora',
                              color: Color(0xff505050),
                            ),
                          ),
                          TextSpan(
                            text: 'Kg',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Sora',
                              color: Color(0xff505050),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 16, bottom: 8, right: 16, top: 8),
                child: Row(
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff505050)),
                    ),
                    Expanded(
                      child: Row(),
                    ),
                    Text(
                      "Rp 100.000",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff505050),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 16, bottom: 8, right: 16, top: 8),
                child: Row(
                  children: [
                    Text(
                      "Deadline payment",
                      style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff505050)),
                    ),
                    Expanded(
                      child: Row(),
                    ),
                    Text(
                      "1 Agustus 2023",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff505050),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 16, bottom: 8, right: 16, top: 8),
                child: Row(
                  children: [
                    Text(
                      "Location:",
                      style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff505050)),
                    ),
                    Expanded(
                      child: Row(),
                    ),
                    Text(
                      "Building A - Aisle A - Number A-01",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff505050),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Color(0xff6AD6F9),
                    ),
                    Text(
                      "...",
                      style: TextStyle(color: Color(0xff6AD6F9), fontSize: 30),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Picked at 4.01 PM",
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffababab),
                          ),
                        ),
                        Text(
                          "Cold Storage Building A",
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff6AD6F9),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "...",
                      style: TextStyle(color: Color(0xff6AD6F9), fontSize: 30),
                    ),
                    Icon(
                      Icons.location_on_outlined,
                      color: Color(0xff6AD6F9),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivered at 4.10 PM",
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffababab),
                          ),
                        ),
                        Text(
                          "Siwalankerto",
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff6AD6F9),
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Row()),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) => RadialGradient(
                        center: Alignment.topCenter,
                        stops: [0, 0.541667, 1],
                        colors: [
                          Color(0xff48FFFF),
                          Color(0xff9DE7DA),
                          Color(0xffC5F0FD)
                        ],
                      ).createShader(bounds),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Delivered",
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff6AD6F9),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset("assets/gambar.jpg")),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    hintText: "Masukkan keluhan disini",
                    hintStyle: TextStyle(
                      color: Color(0xffaaaaaa),
                      fontFamily: 'Sora',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20), // Padding horizontal 32 dan vertikal 24
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Sora",
                      ),
                    ), // Anda juga bisa mengatur style dari teks jika diperlukan.
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
