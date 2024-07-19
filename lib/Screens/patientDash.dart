import 'package:flutter/material.dart';

class PatientDash extends StatefulWidget {
  const PatientDash({super.key});

  @override
  State<PatientDash> createState() => _PatientDashState();
}

class _PatientDashState extends State<PatientDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patient Dashboard"),),
    );
  }
}