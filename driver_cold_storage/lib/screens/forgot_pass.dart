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
  final TextEditingController _EmailInputController = TextEditingController();

  String generateOtp() {
    // Generate a random 6-digit OTP
    int otp = math.Random().nextInt(9999);
    return otp.toString().padLeft(4, '0'); // Pad with leading zeros if needed
  }

  String? generatedOtp;

  bool _isSendingEmail = false;

  Future<void> sendOtp() async {
    String recipientEmail = _EmailInputController.text;
    generatedOtp = generateOtp();

    final smtpServer = gmail('wendyco1234567@gmail.com', 'nazaaelwxchouywv');

    final message = Message()
      ..from = Address('wendyco1234567@gmail.com', 'Company ')
      ..recipients.add(recipientEmail)
      ..subject = 'OTP Verification'
      ..text = 'Your OTP is: $generatedOtp';

    try {
      setState(() {
        _isSendingEmail = true;
      });

      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending OTP email: $e');
      // Handle the email sending error and provide feedback to the user.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send OTP. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

      // Return early to prevent navigation when email sending fails.
      return;
    } finally {
      setState(() {
        _isSendingEmail = false;
      });
    }

    // Navigate to the next screen only if email sending is successful.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => forgot_Pass2(
          generatedOtp: generatedOtp,
        ),
      ),
    );
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
                child: Column(
                  children: [
                    Row(children: [
                      Icon(
                        Icons.email,
                        color: Color(0xff6AD6F9),
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                          color: Color(0xff6AD6F9),
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ]),
                    TextFormField(
                      controller: _EmailInputController,
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
                        hintText: "Email@gmail.com",
                        hintStyle: TextStyle(
                          color: Color(0xffaaaaaa),
                          fontFamily: 'Sora',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 50),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          _isSendingEmail ? Colors.grey : Color(0xFF6AD6F9)),
                    ),
                    onPressed: _isSendingEmail
                        ? null
                        : () async {
                            await sendOtp();
                          },
                    child: _isSendingEmail
                        ? CircularProgressIndicator()
                        : Text('Send Code',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Sora",
                            )),
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
