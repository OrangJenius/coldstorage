import 'package:flutter/material.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

class forgot_Pass3 extends StatefulWidget {
  final String email;

  const forgot_Pass3({super.key, required this.email});

  @override
  _forgot_PassState3 createState() => _forgot_PassState3();
}

class _forgot_PassState3 extends State<forgot_Pass3> {
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

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
                      gantiPass();
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
