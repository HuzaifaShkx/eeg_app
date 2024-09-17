import 'package:eeg_app/Screens/patient_detail.dart';
import 'package:flutter/material.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({super.key});

  @override
  State<DoctorAppointmentScreen> createState() => _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appointments"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text("Upcoming Appointments"),
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
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                  SizedBox(width: 10,),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6),topLeft: Radius.circular(6),topRight: Radius.circular(6)),
                                      //color: Color(0xFF7C0909) ,
                                      border: Border.all()
                                    ),
                                    height: 50,
                                   width: 130,
                                    alignment: Alignment.center,
                                    child: Text("Schedule Meeting on 10 june",style: TextStyle(color: Colors.black),)
                                      ),
                                  SizedBox(width: 20,),
                                   InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PatientDetailScreen()));
                                    },
                                     child: Container(
                                      
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6),topLeft: Radius.circular(6),topRight: Radius.circular(6)),
                                        color: Color(0xFF7C0909) ,
                                      ),
                                      height: 30,
                                     width: 130,
                                      alignment: Alignment.center,
                                      child: Text("View Details",style: TextStyle(color: Colors.white),)
                                        ),
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