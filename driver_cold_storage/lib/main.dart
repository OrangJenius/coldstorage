import 'package:driver_cold_storage/screens/home.dart';
import 'package:flutter/material.dart';
import 'screens/splashScreen.dart';
import 'screens/detail_penjemputan.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
