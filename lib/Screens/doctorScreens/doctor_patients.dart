import 'dart:ffi';

import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:eeg_app/Screens/doctorScreens/patient_detail.dart';
import 'package:eeg_app/model/patient.dart';
import 'package:flutter/material.dart';

class DoctorPatientScreen extends StatefulWidget {
  final int? doctorId;
  const DoctorPatientScreen( {super.key, this.doctorId});

  @override
  State<DoctorPatientScreen> createState() => _DoctorPatientScreenState();
}

class _DoctorPatientScreenState extends State<DoctorPatientScreen> {
  late List<dynamic> patients=[];
  _getRegisteredPatients() async {
    patients=await APIHandler().GetRegisteredPatients(widget.doctorId!);
    setState(() {
      
    });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRegisteredPatients();
  }
  @override
  Widget build(BuildContext context) {
    //_getRegisteredPatients();
    return Scaffold(
      appBar: AppBar(title: const Text("My Patients"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text("Registered Patients"),
            const SizedBox(height: 20,),
            patients.length==0?Center(child: Text("No registered patients")):
            ListView.builder(
                  shrinkWrap: true, // Add this line
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: patients.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20,top: 5),
                        child: Card(
                          child: Container(
                            width: 30,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                            //padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: patients[index].imgpath != null? 
                                         NetworkImage("${APIHandler().baseurl}/image/${patients[index].imgpath}") as ImageProvider
                                        : AssetImage('assets/images/person.png'),
                                      ),
                                    ),
                                    Text("${patients[index].name}"),
                                  ],
                                ),
                               
            
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                   SizedBox(width: 20,),
                                   Align(
                                    alignment: Alignment.centerRight,
                                     child: Button2(text: "View Details",onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PatientDetailScreen(id:patients[index].id,doctorid: widget.doctorId!,)));
                                     },)
                                   ),
                                 ],
                               ),
                               const SizedBox(height: 20,)
                              ],
                              
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
          ],
        ),
      ),
    );
    

  }
}