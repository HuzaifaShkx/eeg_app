import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:eeg_app/Screens/loginscreen.dart';
import 'package:eeg_app/Screens/supervisor_upload_screen.dart';
import 'package:eeg_app/model/supervisor.dart';
import 'package:flutter/material.dart';

class Supervisordashboard2 extends StatefulWidget {
  final Supervisor supervisor;
  const Supervisordashboard2({super.key, required this.supervisor});

  @override
  State<Supervisordashboard2> createState() => _Supervisordashboard2State();
}

class _Supervisordashboard2State extends State<Supervisordashboard2> {

  List<dynamic> _patients = [];
   late final doctorId;
  _getPatient() async {
    
    if(doctorId!=null){
     _patients=await APIHandler().GetNewPatients(doctorId!);
      setState(() {
       
    });
    }
  }
  _getDoctorId() async {
    
     doctorId=await APIHandler().GetSupervisorDoctor(widget.supervisor.id!);
      setState(() {});
    
  }
  @override
  void initState() {
    super.initState();
    _getDoctorId();
    
  }
  @override
  Widget build(BuildContext context) {
  _getPatient();
    return Scaffold(
      appBar: AppBar(title: Text("Supervisor Dashboard"),),
      drawer: Drawer(
        backgroundColor: primary,
        child: ListView(
          children: [
            const SizedBox(
              height: 200,
            ),
            ListTile(
              leading: Icon(Icons.person_3_outlined,color:  Colors.white,),
              title: const Text(
                "My Patients",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                
               // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DoctorPatientScreen(doctorId: doctorId,)));
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration_outlined,color: Colors.white,),
              title: const Text(
                "Registered Patients",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
              //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DoctorPatientScreen(doctorId: doctorId,)));
              },
            ),
            
            ListTile(
              leading: Icon(Icons.calendar_month_outlined,color: Colors.white,),
              title:  Text(
                "Appointments",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
               // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DoctorAppointmentScreen(doctor: widget.doctor,)));
              },
            ),
            
            ListTile(
              leading: Icon(Icons.logout,color: Colors.white,),
              title: Text(
                "LogOut",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // TODO: Logout and navigate to login screen
                 Navigator.of(context).pop();
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginScreen()));
              },
            ),
            // ListTile(
            //   title: const Text(
            //     "Diagnostic Reports",
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Resultscreen()));
            //   },
            // ),
          ],
        ),
      ),
       body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      radius: 40,
                      //  backgroundImage: widget.doctor.imgpath != null? 
                      //                    NetworkImage("${APIHandler().baseurl}/image/${widget.doctor.imgpath!}") as ImageProvider
                      //                   :
                      // AssetImage('assets/images/person.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello", style: TextStyle(fontSize: 20)),
                       // Text("Dr.${widget.doctor.name}", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Search box code
              // Container(
              //   width: 250,
              //   decoration: BoxDecoration(boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.2),
              //       spreadRadius: 2,
              //       blurRadius: 5,
              //       offset: const Offset(2, 3),
              //     )
              //   ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              //   child: Row(
              //     children: [
              //       const Icon(Icons.search),
              //       SizedBox(
              //         width: 200,
              //         child: TextFormField(
              //             controller: _searchController,
              //             decoration: const InputDecoration(
              //               hintText: "Search patient",
              //             ),
              //             onChanged: (value) {}),
              //       )
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Today's Appointments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              //This Expanded allows the ListView to take up remaining space
              _patients.length==0?
              Text("No Appointments found"):
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
                               Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: 
                                   p["imgpath"]!=null? NetworkImage("${APIHandler().baseurl}/image/${p["imgpath"]}") as ImageProvider
                                        : AssetImage('assets/images/person.png'),
                                 
                                ),
                              ),
                              Padding(
                               padding: EdgeInsets.all(10.0),
                               child: Text("${p["name"]}",style: TextStyle(fontSize: 27),),
                             ),
                            Center(child: Button2(text: "Start Session", onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SupervisorUploadScreen()));
                            })),
                            SizedBox(height: 10,),
                             Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6),),
                                color: Color(0xFF7C0909) ,
                              ),
                              height: 30,
                             width: double.infinity,
                              alignment: Alignment.center,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [Icon(Icons.access_time,color: Colors.white,),Text("Time: 10:00 AM",style: TextStyle(color: Colors.white),),])),
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
      ),
    );
  }
}