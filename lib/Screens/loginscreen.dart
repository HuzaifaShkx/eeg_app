import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:eeg_app/Custom%20Widget/loginTextFormField.dart';
import 'package:eeg_app/Custom%20Widget/textFormFeild1.dart';
import 'package:eeg_app/Screens/doctorDash.dart';
import 'package:eeg_app/Screens/patientDash.dart';
import 'package:eeg_app/Screens/roleScreen.dart';
import 'package:eeg_app/Screens/supervisorDash.dart';
import 'package:eeg_app/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _contUsername = TextEditingController();
  TextEditingController _contPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(400, 100),bottomRight: Radius.elliptical(400, 100)),
          child: Container(
            height: 300,
            width: width,
            color: maincolor,
            child: Column(
              children: [
                SizedBox(height: 50,),
                Text("Decode Your Emotions\n with EEG Technology",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22)),
              ],
            ),
          ),
        ),
        Container(
        
          alignment: Alignment.center,
          width: width-40,
          height: height-220,
          margin: EdgeInsets.only(top: 200,left: 20),
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(2, 3),
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
          ),
          child: Column(children: [
          Text("LOGIN",style: TextStyle(color: maincolor,fontWeight: FontWeight.w600,fontSize: 24)),
          SizedBox(height: 20,),
          LoginMyTextFormField(controller: _contUsername, hintText: "User name or Email", labelText: "Username", 
          //icon: Icon(Icons.email)
          ),
          SizedBox(height: 20,),
          LoginMyTextFormField(controller: _contPassword, hintText: "Password", labelText: "Password", 
          //icon: Icon(Icons.lock)
          )
          ,
          SizedBox(height: 20,),
          Button2(text: "Login", onTap: () async {
           String r=await APIHandler().login(_contUsername.text, _contPassword.text);
            if(r=="patient"){
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) => PatientDash())));
            }else if(r=="doctor"){
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) => DoctorDash())));
            }else if(r=="supervisor"){
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) => SupervisorDash())));
            }else
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid username or password"),duration: Duration(seconds: 3),backgroundColor: maincolor,));
            }

          }),
          SizedBox(height: 20,),
          Text("Don't have an account?",style: TextStyle(color: Colors.black),),
          TextButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: ((context) => RoleScreen())));
          }, child: Text("Signup"))

        ],),)
      ]),
    );

  }
}