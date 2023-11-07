import 'dart:convert';

import 'package:flutter/material.dart';
import 'models/pengantaranModel.dart';
import 'screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home.dart';
import 'screens/pengiriman.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getInitialScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String initialScreenWithUserID = snapshot.data ?? '';
          List<String> parts = initialScreenWithUserID.split('|');

          if (parts.length >= 2) {
            String initialScreen = parts[0];
            String userID = parts[1];
            late PengantaranModel pengantaranItems;
            if (parts.length >= 3) {
              pengantaranItems =
                  PengantaranModel.fromJson(json.decode(parts[2]));
            }

            if (initialScreen == 'home') {
              return MaterialApp(
                home: homeScreen(userID: userID), // Pass userID to HomeScreen
              );
            } else if (initialScreen == 'pengiriman') {
              return MaterialApp(
                home: pengirimanScreen(
                  pengantaran: pengantaranItems,
                ), // Pass userID and pengantaranItems to Pengiriman screen
              );
            }
          }
          return MaterialApp(
            home: SplashScreen(),
          );
        }
      },
    );
  }
}

Future<String> getInitialScreen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool lastScreen = prefs.getBool('isOnTheWay') ?? false;
  String userID = prefs.getString('userID') ?? '';
  String pengantaranItem = prefs.getString('pengantaran_model') ?? '';

  if (pengantaranItem.isNotEmpty) {
    Map<String, dynamic> pengantaranJson = json.decode(pengantaranItem);
    PengantaranModel pengantaranModel =
        PengantaranModel.fromJson(pengantaranJson);

    if (lastScreen) {
      return 'pengiriman|${json.encode(pengantaranModel)}'; // Pass userID and pengantaranItem JSON to Pengiriman screen
    }
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      return 'home|$userID';
    }
  } else {
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      return 'home|$userID';
    }
  }
  return 'login'; // Return 'login' as the default case
}
