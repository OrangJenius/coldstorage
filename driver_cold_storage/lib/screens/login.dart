import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 32.0, top: 200),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: Color(0xFF6AD6F9),
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Sora"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 32, right: 32, top: 24),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontFamily: "Sora")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 32, right: 32, top: 24),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontFamily: "Sora")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 32, top: 16),
                child: InkWell(
                  onTap: () {
                    print('Tombol teks ditekan!');
                  },
                  child: Text(
                    'Forget Password',
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
                      ),
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF6AD6F9)),
                    ),
                    onPressed: () {
                      print("Button Login ditekan");
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
            ],
          ),
        ),
      ),
    );
  }
}
