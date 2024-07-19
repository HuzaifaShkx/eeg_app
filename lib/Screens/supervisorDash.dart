import 'package:flutter/material.dart';

class SupervisorDash extends StatefulWidget {
  const SupervisorDash({super.key});

  @override
  State<SupervisorDash> createState() => _SupervisorDashState();
}

class _SupervisorDashState extends State<SupervisorDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Supervisor Dashboard"),),
    );
  }
}