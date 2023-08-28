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
                ElevatedButton(onPressed: () {}, child: Text('Login'))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
