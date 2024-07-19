import 'package:flutter/material.dart';

class DoctorDash extends StatefulWidget {
  const DoctorDash({super.key});

  @override
  State<DoctorDash> createState() => _DoctorDashState();
}

class _DoctorDashState extends State<DoctorDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor Dashboard")),
    );
  }
}
