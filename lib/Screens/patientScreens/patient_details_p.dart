import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:eeg_app/Screens/doctorScreens/ExperimentScreen.dart';
import 'package:eeg_app/Screens/doctorScreens/patient_prescribtion.dart';
import 'package:eeg_app/Screens/doctorScreens/resultScreen.dart';
import 'package:eeg_app/Screens/loginscreen.dart';
import 'package:eeg_app/Screens/patientScreens/all_doctors.dart';
import 'package:eeg_app/Screens/patientScreens/experimentScreenP.dart';
import 'package:eeg_app/Screens/patientScreens/resultScreen_p.dart';
import 'package:eeg_app/model/patient.dart';
import 'package:flutter/material.dart';

class PatientDetailPa extends StatefulWidget {
  final Patient patient;

  PatientDetailPa({super.key, required this.patient});

  @override
  State<PatientDetailPa> createState() => _PatientDetailPaState();
}

class _PatientDetailPaState extends State<PatientDetailPa> {
  var sessions;

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

  _getSessions() async {
    var a =await APIHandler().GetSessionForPatient(widget.patient.id!);
    if(a!=null){
      setState(() {
        sessions = a;
      });
    }
   
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSessions();
  }
  @override
  Widget build(BuildContext context) {
    List<String> dob = widget.patient.dob!.split("-");
    DateTime birthDate =
        DateTime(int.parse(dob[0]), int.parse(dob[1]), int.parse(dob[2]));
    int age = calculateAge(birthDate);
    String? gender;
    if (widget.patient.gender == 'M') {
      gender = "Male";
    } else if (widget.patient.gender == 'F') {
      gender = "Female";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Detail"),
      ),
      drawer: Drawer(
        backgroundColor: primary,
        child: Column(children: [
          SizedBox(
            height: 200,
          ),
          ListTile(
            leading: Icon(Icons.people_outlined,color: Colors.white,),
            title: Text(
              "All Doctors",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllDoctorsScreen(id:  widget.patient.id!)));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout,color: Colors.white,),
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ]),
      ),
      body:sessions==null?Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                          image: widget.patient.imgpath == null
                              ? AssetImage('assets/images/person.png')
                              : NetworkImage(
                                      "${APIHandler().baseurl}/image/${widget.patient.imgpath}")
                                  as ImageProvider,
                          fit: BoxFit.cover)),
                ),
                const SizedBox(
                  width: 20,
                ),
                const CircleAvatar(
                  child: Icon(Icons.phone),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(),
                    //color: Colors.grey[300]
                  ),
                  child: Text("${widget.patient.contact}"),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Table(
                children: [
                  TableRow(children: [
                    Text(
                      "Name :",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${widget.patient.name}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "Gender :",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${gender}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "Age :",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${age}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "Height :",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${widget.patient.height}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "Weight :",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${widget.patient.weight}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    )
                  ])
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               
                Button2(
                    text: "Medicine Info",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientPrescribtion(
                                    id: widget.patient.id!,
                                  )));
                    })
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Completed Appointments",
              style: TextStyle(
                  color: primary, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 220,
              child: Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sessions.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExperimentScreenP(sessionid: sessions[index]['sessionid'])));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(150, 239, 216, 220)),
                            child: Text("Session ${sessions[index]['sessionid']}"),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
