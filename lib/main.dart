import 'package:eeg_app/Screens/Start_home_page.dart';
import 'package:eeg_app/Screens/doctorScreens/add_prescribtion.dart';
import 'package:eeg_app/Screens/doctorScreens/doctorDash.dart';
import 'package:eeg_app/Screens/doctorScreens/doctor_appointments.dart';
import 'package:eeg_app/Screens/doctorScreens/doctor_patients.dart';
import 'package:eeg_app/Screens/doctorScreens/resultScreen.dart';
import 'package:eeg_app/Screens/loginscreen.dart';
import 'package:eeg_app/Screens/doctorScreens/patient_detail.dart';
import 'package:eeg_app/Screens/doctorScreens/patient_prescribtion.dart';
import 'package:eeg_app/Screens/patientScreens/all_doctors.dart';
import 'package:eeg_app/Screens/patientScreens/patientDash.dart';
import 'package:eeg_app/Screens/patientScreens/patient_details_p.dart';

import 'package:eeg_app/Screens/roleScreen.dart';
import 'package:eeg_app/Screens/splash_Screen.dart';
import 'package:eeg_app/Screens/supervisorDash.dart';
import 'package:eeg_app/Screens/supervisorHome.dart';
import 'package:eeg_app/Screens/supervisor_upload_screen.dart';
import 'package:eeg_app/supervisorDashboard2.dart';
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
        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7C0909)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      //home:SupervisorUploadScreen()
    );
  }
}

