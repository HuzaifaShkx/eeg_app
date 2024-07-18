

import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Screens/loginscreen.dart';
import 'package:eeg_app/Screens/roleScreen.dart';
import 'package:flutter/material.dart';

class StartHomePage extends StatelessWidget {
  const StartHomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(children: [
        
        Container(
          padding: EdgeInsets.only(top: 20),
          height: 450,
          width: width,
          decoration: BoxDecoration(
            color: Color(0xFF7C0909),
          ),
          child: Column(
          children: [
            Text("Decode Your Emotions\n with EEG Technology",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22)),
          ],
        ),),
        SizedBox(height: 20,),
        Button1(text: "Login", onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          print("login");
        }),
        SizedBox(height: 20,),
        Button1(text: "Create an Account", onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => RoleScreen()));
          print("Create an Account");
        })
      ]),
    );
  }
}