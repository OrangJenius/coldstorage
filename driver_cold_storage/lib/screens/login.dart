import 'package:driver_cold_storage/screens/homePengawas.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'forgot_pass.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green, // Use a success color
      ),
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _message = '';

  void _showErrorSnackbar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
  }

  String simpanData = "";

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    final apiUrl = 'http://116.68.252.201:1945/loginDriver';
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: {'Email': email, 'Password': password});

      if (response.statusCode == 200) {
        // Login successful
        final responseData = jsonDecode(response.body);
        final idValue = responseData['id'];
        final roleValue = responseData['role'];

        // Simpan status login ke dalam SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('userID', idValue.toString());

        setState(() {
          _message = 'Login successful';
          simpanData = idValue.toString();
          _showSuccessSnackbar(_message);
          if (roleValue == "driver") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => homeScreen(userID: simpanData),
              ),
            );
          } else if (roleValue == "staff  ") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePengawas(),
              ),
            );
          }
        });
      } else if (response.statusCode == 401) {
        // Incorrect login credentials
        setState(() {
          _message = 'Invalid email or password';
          _showErrorSnackbar(_message);
        });
      } else {
        // Other server errors
        setState(() {
          _message = 'Server error occurred. Please try again later.';
          _showErrorSnackbar(_message);
        });
      }
    } catch (e) {
      // Error occurred during API call
      setState(() {
        _message =
            'Failed to connect to the server. Please check your internet connection.';
        _showErrorSnackbar(_message);
      });
    }

    setState(() {
      _isLoading = false;
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
                      hintText: "Email",
                      hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontFamily: "Sora")),
                  controller: _emailController,
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
                  obscureText: _obscurePassword,
                  controller: _passwordController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 32, top: 16),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => forgot_Pass()),
                    );
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
                      ),
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF6AD6F9)),
                    ),
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text('Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Sora",
                            )),
                    // child: Text('Login',
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: "Sora",
                    //     )), // Anda juga bisa mengatur style dari teks jika diperlukan.
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
