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
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 24.0,
                  top: 32,
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
