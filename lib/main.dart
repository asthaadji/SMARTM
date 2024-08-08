import 'package:flutter/material.dart';
// import 'package:smartm/page/data_display_page.dart';
// import 'package:smartm/page/main_nav_page.dart';
import 'package:smartm/page/splash_screen.dart';
//import 'screens/splash_screen.dart';

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
