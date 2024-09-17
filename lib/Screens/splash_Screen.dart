
import 'dart:async';

import 'package:eeg_app/Screens/Start_home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a timer for splash duration, then navigate to Home screen
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => StartHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          
        ),
           child: Image.asset('assets/images/splash.png', height: 100, width: 100),
          
        //     CircularProgressIndicator(
        //       valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        // ),
      ),
    );
  }
}