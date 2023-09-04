import 'package:flutter/material.dart';
import 'otp_input.dart';
import 'login.dart';

class forgot_Pass2 extends StatefulWidget {
  String? generatedOtp;
  forgot_Pass2({required this.generatedOtp});
  @override
  _forgot_PassState2 createState() => _forgot_PassState2();
}

class _forgot_PassState2 extends State<forgot_Pass2> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  String? _otp;

  bool verify() {
    String? otpSent =
        widget.generatedOtp; // Get the OTP sent to the user's email
    String? userOtp = _otp; // Get the user-entered OTP

    // Compare the user-entered OTP with the OTP sent to the user's email
    bool isOtpValid = otpSent == userOtp;

    return isOtpValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              "The OTP code was sent\nPlease check your message.",
              style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAAAAAA)),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OtpInput(_fieldOne, true), // auto focus
              OtpInput(_fieldTwo, false),
              OtpInput(_fieldThree, false),
              OtpInput(_fieldFour, false)
            ],
          ),
          const SizedBox(
            height: 30,
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
                      borderRadius:
                          BorderRadius.circular(30), // border radius sebesar 30
                    ),
                  ),
                  elevation: MaterialStateProperty.all(5),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF6AD6F9)),
                ),
                onPressed: () {
                  setState(() {
                    _otp = _fieldOne.text +
                        _fieldTwo.text +
                        _fieldThree.text +
                        _fieldFour.text;
                  });
                  if (verify()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  }
                },
                child: Text('Send Code',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Sora",
                    )), // Anda juga bisa mengatur style dari teks jika diperlukan.
              ),
            ),
          )
        ],
      )),
    );
  }
}
