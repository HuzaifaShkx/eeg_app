import 'package:eeg_app/Screens/doctor_appointments.dart';
import 'package:eeg_app/Screens/doctor_patients.dart';
import 'package:eeg_app/Screens/results_screen.dart';
import 'package:flutter/material.dart';

class DoctorDash extends StatefulWidget {
  const DoctorDash({super.key});

  @override
  State<DoctorDash> createState() => _DoctorDashState();
}

class _DoctorDashState extends State<DoctorDash> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Dashboard"),
        actions: [],
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFF7C0909),
        child: ListView(
          children: [
            SizedBox(
              height: 200,
            ),
            ListTile(
              title: Text(
                "My Patients",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DoctorPatientScreen()));
              },
            ),
            ListTile(
              title: Text(
                "Registered Patients",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DoctorPatientScreen()));
              },
            ),
            // ListTile(
            //   title: Text(
            //     "Upcoming Patients",
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onTap: () {},
            // ),
            ListTile(
              title: Text(
                "Appointments",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DoctorAppointmentScreen()));
              },
            ),
            ListTile(
              title: Text(
                "Diagnostic Reports",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ResultSreen()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      backgroundImage: AssetImage("assets/images/person.png"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello", style: TextStyle(fontSize: 20)),
                        Text("Dr.Bilal", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Search box code
              Container(
                width: 250,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(2, 3),
                  )
                ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Container(
                      width: 200,
                      child: TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Search patient",
                          ),
                          onChanged: (value) {}),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Today's Appointments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              //This Expanded allows the ListView to take up remaining space
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
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage("assets/images/person.png"),
                                ),
                              ),
                             Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Text("Patient Name"),
                             ),
          
                             Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6),),
                                color: Color(0xFF7C0909) ,
                              ),
                              height: 30,
                             width: double.infinity,
                              alignment: Alignment.center,
                              child: Row(
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
