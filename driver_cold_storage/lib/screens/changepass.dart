import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userModel.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

class change_pass extends StatefulWidget {
  final String email;
  final String role;

  const change_pass({super.key, required this.email, required this.role});

  @override
  _change_PassState createState() => _change_PassState();
}

class _change_PassState extends State<change_pass> {
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  List<UserModel> userData = [];

  Future<List<UserModel>> cekEmail() async {
    final apiUrl = 'http://116.68.252.201:1945/DataUser';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Successfully fetched data from the API
        // Parse the response body (JSON), which should be a Map<String, dynamic>
        Map<String, dynamic> apiResponse = jsonDecode(response.body);

        //print(apiResponse); // Print the API response to check the data format

        // Assuming that the API response contains a key called 'users' that holds the list of users
        List<dynamic> userList = apiResponse['data'];

        //print(userList);

        // Convert each item in the list to a UserModel instance using the factory method
        List<UserModel> users =
            (userList as List).map((json) => UserModel.fromJson(json)).toList();

        //print(users);

        return users;
      } else {
        // API call failed or returned an error status code
        print('API call failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Error occurred during API call
      print('Error: $e');
      return [];
    }
  }

  void _logout() async {
    // Hapus status login dan data terkait lainnya dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
    prefs.remove('userID');

    // Navigate to the Login screen and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false, // Pop all routes until the login screen
    );
  }

  void compareEmailandChangePass() async {
    userData = await cekEmail();
    String email = widget.email;
    String? role;

    for (var user in userData) {
      if (user.Email == email) {
        role = user.Role;
        break; // Exit the loop once a match is found
      }
    }

    if (role != null) {
      if (role.toLowerCase() == "driver") {
        gantiPass();
        _logout();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
        // Send OTP if the email matches and the role is "driver"
      } else {
        print("Anda bukan driver"); // Otherwise, print the error message
      }
    } else {
      print("Email tidak ditemukan");
    }
  }

  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureNewPassword = !_obscureNewPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _message = '';

  bool _submitNewPassword() {
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;
    if (newPassword == confirmPassword) {
      // TODO: Implement password reset logic here
      print('Password Match');
      return true;
    } else {
      print('Passwords do not match');
      return false;
    }
  }

  Future<void> gantiPass() async {
    setState(() {
      _message = '';
    });
    final apiUrl = 'http://116.68.252.201:1945/ForgetPassAdminNDriver';
    final password = _newPasswordController.text;
    bool passwordsMatch = _submitNewPassword();
    print(passwordsMatch); // Print the result here
    if (passwordsMatch) {
      print("yoho");
      print(widget.email);
      try {
        final response = await http.put(Uri.parse(apiUrl),
            body: {'Email': widget.email, 'Password': password});

        if (response.statusCode == 200) {
          // Login successful
          setState(() {
            _message = 'password changed successful';
            _showSuccessSnackbar(
                _message); // Use a custom method for success snackbar
            // Navigate to the HomeScreen if needed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          });
        } else if (response.statusCode == 401) {
          setState(() {
            _message = 'Invalid Password or Confirm password';
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
    } else {
      _message = "password dan confirm password harus sama";
      _showErrorSnackbar(_message);
    }
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green, // Use a success color
      ),
    );
  }

  void _showErrorSnackbar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 32, top: 80),
                child: Text(
                  "Forgot\nPassword",
                  style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 36,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6AD6F9)),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.only(left: 32),
                child: Text(
                  "New Password",
                  style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6AD6F9)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 32, right: 32, top: 8),
                child: TextFormField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(
                        color: Color(0xff6AD6F9),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(
                        color: Color(0xff6AD6F9),
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: _toggleNewPasswordVisibility,
                      child: Icon(
                        _obscureNewPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    suffixIconColor: Color(0xff6AD6F9),
                    prefixIcon: Icon(Icons.lock_outline),
                    prefixIconColor: Color(0xff6AD6F9),
                  ),
                  obscureText: _obscureNewPassword,
                ),
              ),
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.only(left: 32),
                child: Text(
                  "Confirm New Password",
                  style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6AD6F9)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 32, right: 32, top: 8),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(
                        color: Color(0xff6AD6F9),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(
                        color: Color(0xff6AD6F9),
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: _toggleConfirmPasswordVisibility,
                      child: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    suffixIconColor: Color(0xff6AD6F9),
                    prefixIcon: Icon(Icons.lock_outline),
                    prefixIconColor: Color(0xff6AD6F9),
                  ),
                  obscureText: _obscureConfirmPassword,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 50), // Padding horizontal 32 dan vertikal 24
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
                      compareEmailandChangePass();
                    },
                    child: Text('Change Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Sora",
                        )), // Anda juga bisa mengatur style dari teks jika diperlukan.
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
