import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 56, right: 206, top: 189, bottom: 58),
              child: Text(
                "Sign In",
                style: TextStyle(
                  fontFamily: 'Sora',
                  color: Color(0xFF6AD6F9),
                  fontSize: 36,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Username"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 33.5),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 85, left: 16, right: 157),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6AD6F9)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 100),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // border radius sebesar 30
                          ),
                        ),
<<<<<<< Updated upstream
                        elevation: MaterialStateProperty.all(5),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF6AD6F9)),
=======
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontFamily: "Sora")),
                    obscureText: _obscurePassword),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 32, top: 16),
                child: InkWell(
                  onTap: () {
                    print('Tombol teks ditekan!');
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: Color(0xFF6AD6F9),
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontFamily: "Sora"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 100), // Padding horizontal 32 dan vertikal 24
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
>>>>>>> Stashed changes
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => homeScreen()),
                        );
                      },
                      child: Text('Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Sora",
                          )), // Anda juga bisa mengatur style dari teks jika diperlukan.
                    ),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
