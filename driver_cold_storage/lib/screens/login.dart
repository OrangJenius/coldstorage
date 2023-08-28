import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login> {
  bool _obscurePassword = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 32.0, top: 180),
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
                  style: TextStyle(fontSize: 20),
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
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: GestureDetector(
                          onTap: _togglePasswordVisibility,
                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
