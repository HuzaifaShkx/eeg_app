import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:eeg_app/Custom%20Widget/loginTextFormField.dart';
import 'package:eeg_app/Custom%20Widget/textFormFeild1.dart';
import 'package:eeg_app/Screens/doctorScreens/doctorDash.dart';
import 'package:eeg_app/Screens/patientScreens/patientDash.dart';
import 'package:eeg_app/Screens/patientScreens/patient_details_p.dart';
import 'package:eeg_app/Screens/roleScreen.dart';
import 'package:eeg_app/Screens/supervisorDash.dart';
import 'package:eeg_app/Screens/supervisorHome.dart';
import 'package:eeg_app/Screens/supervisor_upload_screen.dart';
import 'package:eeg_app/model/doctor.dart';
import 'package:eeg_app/model/patient.dart';
import 'package:eeg_app/model/supervisor.dart';
import 'package:eeg_app/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _contUsername = TextEditingController();
  final TextEditingController _contPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.elliptical(400, 100),bottomRight: Radius.elliptical(400, 100)),
            child: Container(
              height: 300,
              width: width,
              color: maincolor,
              child:  Column(
                children: [
                  SizedBox(height: 30,),
                  Image.asset("assets/images/brain2.png",height: 150,width: 150,),
                  //Text("Decode Your Emotions\n with EEG Technology",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22)),
                ],
              ),
            ),
          ),
          Container(
          
            alignment: Alignment.center,
            width: width-40,
            height: height-220,
            margin: const EdgeInsets.only(top: 200,left: 20),
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(2, 3),
                )
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
            ),
            child: Column(children: [
            Text("LOGIN",style: TextStyle(color: maincolor,fontWeight: FontWeight.w600,fontSize: 24)),
            const SizedBox(height: 20,),
            LoginMyTextFormField(controller: _contUsername, hintText: "User name or Email", labelText: "Username",obsecure: false, 
            //icon: Icon(Icons.email)
            ),
            const SizedBox(height: 20,),
            LoginMyTextFormField(controller: _contPassword, hintText: "Password", labelText: "Password", obsecure: true,
            //icon: Icon(Icons.lock)
            )
            ,
            const SizedBox(height: 20,),
            Button2(text: "Login", onTap: () async {
             String r=await APIHandler().login(_contUsername.text, _contPassword.text);

              if(r=="patient"){
                Patient patient=await APIHandler().GetPatientByEmail(_contUsername.text);
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>  PatientDetailPa(patient: patient))));
              }else if(r=="doctor"){
                Doctor doctor=await APIHandler().GetDoctorByEmail(_contUsername.text);
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>  DoctorDash(doctor: doctor))));
              }else if(r=="supervisor"){
                 Supervisor supervisor=await APIHandler().GetSupervisorByEmail(_contUsername.text);
                Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>  SupervisorHome(supervisor:  supervisor))));
              }else
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Invalid username or password"),duration: const Duration(seconds: 3),backgroundColor: maincolor,));
              }
        
            }),
            const SizedBox(height: 20,),
            const Text("Don't have an account?",style: TextStyle(color: Colors.black),),
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const RoleScreen())));
            }, child: const Text("Signup"))
        
          ],),)
        ]),
      ),
    );

  }
}