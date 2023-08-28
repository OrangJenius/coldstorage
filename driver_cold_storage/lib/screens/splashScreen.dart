import 'package:flutter/material.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //_loadMainScreen();
  }

  Future<void> _loadMainScreen() async {
    // Simulate some initialization process or delay
    await Future.delayed(Duration(seconds: 2));

    // Navigate to the main screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 159, bottom: 98),
              child: Image.asset('assets/c.png'),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 159, bottom: 98),
            //   child: Text(
            //     'C',
            //     style: TextStyle(
            //       fontSize: 200,
            //       fontWeight: FontWeight.bold,
            //       fontFamily: 'Montserrat',
            //       color: Color(0xFF6AD6F9),
            //       fontStyle: FontStyle.normal,
            //     ),
            //   ),
            // ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Cold',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Sora',
                      color: Color(0xFF6AD6F9),
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  TextSpan(
                    text: 'Storage',
                    style: TextStyle(
                        fontSize: 48,
                        fontFamily: 'Sora',
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
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
