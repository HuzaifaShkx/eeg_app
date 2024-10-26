import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Screens/SignupScreens/doctorSignup.dart';
import 'package:eeg_app/Screens/loginscreen.dart';
import 'package:eeg_app/Screens/SignupScreens/patientSignup.dart';
import 'package:eeg_app/Screens/SignupScreens/supervisorSignup.dart';
import 'package:eeg_app/utils/colors.dart';
import 'package:flutter/material.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.elliptical(400, 250),bottomRight: Radius.elliptical(400, 250),),
          child: Container(
            alignment: Alignment.center,
            height: 300,
            width: MediaQuery.of(context).size.width,
            color: maincolor,
            child:const Text("Select Your Role",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 30)),
          ),
        ),
        const SizedBox(height: 20,),
        Button1(text: "Doctor", onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const DoctorSignup()));
        }),
        const SizedBox(height: 20,),
        Button1(text: "Patient", onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PatientSignUp()));
        }),
        const SizedBox(height: 20,),
        Button1(text: "Supervisor", onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SupervisorSignup()));
        }),
        const SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account? "),
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginScreen()));
            }, child: Text("Login",style: TextStyle(color: maincolor,fontWeight: FontWeight.w600,fontSize: 18),),),
          ],
        ),
      ],),
    );
  }
}