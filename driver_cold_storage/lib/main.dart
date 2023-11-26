import 'dart:convert';
import 'package:driver_cold_storage/screens/homePengawas.dart';
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
          return Text(
            'Error: ${snapshot.error}',
            textDirection: TextDirection.ltr,
          );
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
                  userID: userID,
                ), // Pass userID and pengantaranItems to Pengiriman screen
              );
            } else if (initialScreen == 'staffHome') {
              return MaterialApp(
                home: HomePengawas(userID: userID), // Pass userID to HomeScreen
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
  String role = prefs.getString('role') ?? '';
  String pengantaranItem = prefs.getString('pengantaran_model') ?? '';
  print("Items: ${pengantaranItem}");

  if (pengantaranItem.isNotEmpty) {
    print("ga kosong");
    Map<String, dynamic> pengantaranJson = json.decode(pengantaranItem);
    print("Step 1");
    print("pengantaran JSON ${pengantaranJson}");
    PengantaranModel pengantaranModel =
        PengantaranModel.fromJson(pengantaranJson);
    print("step 2");
    print("Pengantaran Model ${pengantaranModel}");
    print("User ID ${userID}");

    if (lastScreen) {
      return 'pengiriman| $userID |${json.encode(pengantaranModel)}'; // Pass userID and pengantaranItem JSON to Pengiriman screen
    }
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn && role == 'driver') {
      return 'home|$userID';
    } else {
      return 'staffHome|$userID';
    }
  } else {
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn && role == 'driver') {
      return 'home|$userID';
    } else if (isLoggedIn && role == 'staff') {
      return 'staffHome|$userID';
    }
  }
  return 'login'; // Return 'login' as the default case
}
