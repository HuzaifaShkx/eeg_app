import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Screens/doctorScreens/patient_detail.dart';
import 'package:eeg_app/model/doctor.dart';
import 'package:eeg_app/model/patient.dart';
import 'package:flutter/material.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  final Doctor doctor;
  const DoctorAppointmentScreen({super.key, required this.doctor});

  @override
  State<DoctorAppointmentScreen> createState() => _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
   List<dynamic> _patients = [];
  _getPatient() async {
     _patients=await APIHandler().GetNewPatients(widget.doctor.id!);
      setState(() {
       
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPatient();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Appointments"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text("Upcoming Appointments"),
            const SizedBox(height: 20,),
            ListView.builder(
                  shrinkWrap: true, // Add this line
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _patients.length,
                  itemBuilder: (context, index) {
                    dynamic p=_patients[index];
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
                                        backgroundImage:widget.doctor.imgpath != null? 
                                         NetworkImage("${APIHandler().baseurl}/image/${p["imgpath"]}") as ImageProvider
                                        : AssetImage('assets/images/person.png'),
                                      ),
                                    ),
                                    Text("${p["name"]}"),
                                  ],
                                ),
                               
            
                               Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                  const SizedBox(width: 10,),
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6),topLeft: Radius.circular(6),topRight: Radius.circular(6)),
                                      //color: Color(0xFF7C0909) ,
                                      border: Border.all()
                                    ),
                                    height: 50,
                                   width: 130,
                                    alignment: Alignment.center,
                                    child: const Text("Schedule Meeting on 10 june",style: TextStyle(color: Colors.black),)
                                      ),
                                  const SizedBox(width: 20,),
                                   InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PatientDetailScreen(id: p["id"],)));
                                    },
                                     child: Container(
                                      
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6),topLeft: Radius.circular(6),topRight: Radius.circular(6)),
                                        color: Color(0xFF7C0909) ,
                                      ),
                                      height: 30,
                                     width: 130,
                                      alignment: Alignment.center,
                                      child: const Text("View Details",style: TextStyle(color: Colors.white),)
                                        ),
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