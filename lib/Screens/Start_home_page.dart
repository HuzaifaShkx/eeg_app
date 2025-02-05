

import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Screens/loginscreen.dart';
import 'package:eeg_app/Screens/roleScreen.dart';
import 'package:eeg_app/utils/colors.dart';
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
          padding: const EdgeInsets.only(top: 50),
          height: 450,
          width: width,
          decoration: BoxDecoration(
            color: maincolor,
          ),
          child:  Column(
          children: [
            Text("Decode Your Emotions\n with EEG Technology",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22)),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Image.asset("assets/images/brain2.png",height: 200,width: 200,)),
          ],
        ),),
        const SizedBox(height: 20,),
        Button1(text: "Login", onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          print("login");
        }),
        const SizedBox(height: 20,),
        Button1(text: "Create an Account", onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const RoleScreen()));
          print("Create an Account");
        })
      ]),
    );
  }
}