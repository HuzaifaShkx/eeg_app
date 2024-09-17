import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:eeg_app/Screens/patient_detail.dart';
import 'package:flutter/material.dart';

class DoctorPatientScreen extends StatefulWidget {
  const DoctorPatientScreen({super.key});

  @override
  State<DoctorPatientScreen> createState() => _DoctorPatientScreenState();
}

class _DoctorPatientScreenState extends State<DoctorPatientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Patients"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text("Registered Patients"),
            SizedBox(height: 20,),
            ListView.builder(
                  shrinkWrap: true, // Add this line
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
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
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: AssetImage("assets/images/person.png"),
                                      ),
                                    ),
                                    Text("Patient Name"),
                                  ],
                                ),
                               
            
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                  SizedBox(width: 20,),
                                   Align(
                                    alignment: Alignment.centerRight,
                                     child: Button2(text: "View Details",onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PatientDetailScreen()));
                                     },)
                                   ),
                                 ],
                               ),
                               SizedBox(height: 20,)
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