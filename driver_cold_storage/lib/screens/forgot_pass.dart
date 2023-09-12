import 'package:flutter/material.dart';
import 'forgot_pass2.dart';
import 'dart:math' as math;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class forgot_Pass extends StatefulWidget {
  @override
  _forgot_PassState createState() => _forgot_PassState();
}

class _forgot_PassState extends State<forgot_Pass> {
  var index = -1;

  String generateOtp() {
    // Generate a random 6-digit OTP
    int otp = math.Random().nextInt(9999);
    return otp.toString().padLeft(4, '0'); // Pad with leading zeros if needed
  }

  String? generatedOtp;

  Future<void> sendOtp() async {
    String recipientEmail = "wendyco1234567@gmail.com";
    generatedOtp = generateOtp(); // Store the generated OTP in a variable

    final smtpServer = gmail('wendyco1234567@gmail.com', 'nazaaelwxchouywv');

    final message = Message()
      ..from = Address('wendyco1234567@gmail.com', 'Company ')
      ..recipients.add(recipientEmail)
      ..subject = 'OTP Verification'
      ..text = 'Your OTP is: $generatedOtp';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending OTP email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                  "Select your which contact\nto send OTP code ",
                  style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFAAAAAA)),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: InkWell(
                  onTap: () => {
                    index = 0,
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xFFEDEDED),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.phone_android_rounded,
                          size: 62,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "via sms:",
                              style: TextStyle(
                                  fontFamily: 'Sora',
                                  color: Color(0xFFAAAAAA),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16),
                            ),
                            Text(
                              "**** **** 123",
                              style: TextStyle(
                                  fontFamily: 'Sora',
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: InkWell(
                  onTap: () => {
                    index = 1,
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xFFEDEDED),
                    ),
                    child: Row(children: [
                      Icon(
                        Icons.email,
                        size: 62,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "via email:",
                            style: TextStyle(
                                fontFamily: 'Sora',
                                color: Color(0xFFAAAAAA),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16),
                          ),
                          Text(
                            "****g@gmail.com",
                            style: TextStyle(
                                fontFamily: 'Sora',
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ]),
                  ),
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
                      if (index == 0) {
                        print("dikirim ke sms");
                      } else if (index == 1) {
                        sendOtp();
                      } else {
                        print("pilih salah satu metode yang tersedia");
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => forgot_Pass2(
                            generatedOtp: generatedOtp,
                          ),
                        ),
                      );
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
          ),
        ),
      ),
    );
  }
}
