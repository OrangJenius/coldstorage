import 'package:flutter/material.dart';
import 'history.dart';
import 'forgot_pass3.dart';
import 'splashScreen.dart';
import 'report.dart';

class profileScree extends StatefulWidget {
  @override
  _profileScreeState createState() => _profileScreeState();
}

class _profileScreeState extends State<profileScree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 24, bottom: 16),
              child: Text(
                "Profile",
                style: TextStyle(
                  color: Color(0xFF6AD6F9),
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Divider(
                height: 1, // Atur tinggi garis sesuai kebutuhan
                color: Color(0xFFd9d9d9), // Atur warna garis sesuai kebutuhan
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 28, left: 48, right: 48),
                  child: Transform.scale(
                    scale: 2.5, // Ubah faktor skala sesuai keinginan Anda
                    child: CircleAvatar(
                      child: Icon(
                        Icons.image,
                      ), // Ganti dengan thumbnail Anda
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Budi",
                        style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000)),
                      ),
                      Text(
                        "budi@coldstorage.com",
                        style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff929292)),
                      ),
                      Text(
                        "+62 9128912983",
                        style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff929292)),
                      ),
                      Text(
                        "Role: Driver",
                        style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff929292)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 8, bottom: 64),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      color: Color(0xff6AD6F9),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.access_alarm),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "History",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff929292),
                    ),
                  ),
                  Expanded(
                    child: Row(),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => historyScreen())),
                    },
                    child: Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1, // Atur tinggi garis sesuai kebutuhan
              color: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.lock),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Change Password",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff929292),
                    ),
                  ),
                  Expanded(
                    child: Row(),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => forgot_Pass3())),
                    },
                    child: Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1, // Atur tinggi garis sesuai kebutuhan
              color: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.heart_broken),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Report Services",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff929292),
                    ),
                  ),
                  Expanded(
                    child: Row(),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => reportScreen())),
                    },
                    child: Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1, // Atur tinggi garis sesuai kebutuhan
              color: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff929292),
                    ),
                  ),
                  Expanded(
                    child: Row(),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SplashScreen())),
                    },
                    child: Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}