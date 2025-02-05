import 'dart:async';
import 'dart:convert';

import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:eeg_app/Screens/doctorScreens/ExperimentScreen.dart';
import 'package:eeg_app/Screens/doctorScreens/patient_prescribtion.dart';
import 'package:eeg_app/Screens/doctorScreens/resultScreen.dart';
import 'package:eeg_app/model/patient.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';

class PatientDetailScreen extends StatefulWidget {
  final int id;
  final int doctorid;
  const PatientDetailScreen( {super.key, required this.id, required this.doctorid});

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  Patient ?p;
   _getPatient() async {
   p=await APIHandler().GetPatient(widget.id);
   var se=await APIHandler().GetSessions(widget.doctorid, widget.id);
   
   s=jsonDecode(se.body);
   print(s);
   setState(() {
     
   });
  }
  List<dynamic> s=[];
  _getExperiments(){

  }
  
  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    // Adjust age if birthdate hasn't occurred yet this year
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPatient();
    
  }
  
  @override
  Widget build(BuildContext context) {
    if (p!=null){
     List<String> ?dob = p!.dob!.split("-");
    DateTime birthDate =
        DateTime(int.parse(dob[0]), int.parse(dob[1]), int.parse(dob[2]));
    int age = calculateAge(birthDate);
    
   // _getPatient();
    String ?gender;
    if (p?.gender== 'M') {
       gender="Male";
    }else if (p?.gender== 'F') {
       gender="Female";
    }

    // Function to open the default caller
  // Future<void> _makePhoneCall(String phoneNumber) async {
  //   final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
  //   if (await canLaunchUrl(callUri)) {
  //     await launchUrl(callUri);
  //   } else {
  //     throw 'Could not launch $callUri';
  //   }
  // }
    return Scaffold(
      appBar: AppBar(title: const Text("Patient Detail"),),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 20,),
          Row(children: [
            const SizedBox(width: 30,),
            Container(
              width: 120,
              height: 120,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image:p?.imgpath==null?
                   AssetImage("assets/images/person.png"):
                   NetworkImage("${APIHandler().baseurl}/image/${p?.imgpath!}") as ImageProvider,
                  fit: BoxFit.cover
                )
              ),
               
            ),
            const SizedBox(width: 20,),
            InkWell(
              onTap: () {
               // _makePhoneCall('${p!.contact}');
              },
              child: const CircleAvatar(child:Icon(Icons.phone),)),
            const SizedBox(width: 10,),
            Container(
              alignment: Alignment.center,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(),
                //color: Colors.grey[300]
              ),
              child: Text("${p?.contact}"),)
          ],),
         Padding(
           padding: const EdgeInsets.all(20.0),
           child: Table(
            children:  [
              TableRow(
                
                children: [
                Text("Name :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                Text("${p?.name}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),)
           
              ]),
               TableRow(
                
                children: [
                Text("Gender :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                Text("$gender",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),)
           
              ]),
               TableRow(
                
                children: [
                Text("Age :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                Text("${age}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),)
           
              ]),
               TableRow(
                
                children: [
                Text("Height :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                Text("${p?.height}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),)
           
              ]),
               TableRow(
                
                children: [
                Text("Weight :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                Text("${p?.weight}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),)
           
              ])
            ],
           ),
         ),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
  //          
  
            Button2(text: "Medicine Info", onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) => PatientPrescribtion(id: widget.id))));
            })
          ],
         ),
         const SizedBox(height: 5,),
         const Divider(),
         const SizedBox(height: 5,),
         Text("Completed Sessions",style: TextStyle(color: primary,fontSize: 20,fontWeight: FontWeight.w600),),
         SizedBox(
          width: 220,
           child: Container(
             child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: s.length,itemBuilder: (context,index){
              return InkWell(
                onTap: (){
                  //navigate to ExperimentScreen
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExperimentScreen(sessionid: s[index]['sessionid'],appid:s[index]['appid'])));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: const BoxDecoration(
                    color: Color.fromARGB(150, 239, 216, 220)
                    ),
                    child:  Text("Session ${s[index]['sessionid']}"),
                  ),
                ),
              );
             }),
           ),
         )
        ],),
      ),
    );
  }
  else{
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: primary,),
      ),
    );  // Show loading indicator while data is fetching.  // You can also return an empty state widget here.  // For example: SizedBox(height: 200) with a Text("No data found")  // or a CircularProgressIndicator() if you prefer.  // This is just an example. You may need to adjust the UI according to your needs.  // For example, you can show a Snackbar or a Toast when there is no data to display.  // The exact implementation will depend on your specific requirements.  // You may also need to handle errors gracefully.  // For example, you can catch exceptions and show an error message to the user.  // In a real-world application, you would likely use a separate error management library like Riverpod or Provider to handle errors and provide a consistent error experience.  // Please note that this is a simplified example and might not cover all possible scenarios.  // You
  }
  }
}