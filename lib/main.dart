import 'package:eeg_app/Screens/Start_home_page.dart';
import 'package:eeg_app/Screens/doctorDash.dart';
import 'package:eeg_app/Screens/doctor_appointments.dart';
import 'package:eeg_app/Screens/doctor_patients.dart';
import 'package:eeg_app/Screens/loginscreen.dart';
import 'package:eeg_app/Screens/patient_detail.dart';
import 'package:eeg_app/Screens/roleScreen.dart';
import 'package:eeg_app/Screens/splash_Screen.dart';
import 'package:eeg_app/Screens/supervisor_upload_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF7C0909)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

