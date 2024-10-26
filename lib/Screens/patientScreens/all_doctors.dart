import 'dart:io';

import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:eeg_app/Custom%20Widget/textFormFeild1.dart';
import 'package:eeg_app/Custom%20Widget/textFormFeild2.dart';
import 'package:eeg_app/Screens/doctorScreens/patient_detail.dart';
import 'package:eeg_app/model/doctor.dart';
import 'package:eeg_app/utils/colors.dart';
import 'package:flutter/material.dart';

class AllDoctorsScreen extends StatefulWidget {
  const AllDoctorsScreen({super.key});

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  TextEditingController _contDate = TextEditingController();
  TextEditingController _contTime = TextEditingController();
  
  // Initialize _doctors with an empty list
 
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _contDate.text = "${picked.day}/${picked.month}/${picked.year}"; // Format date as needed
      });
    }
  }
  
  _scheduleDialog(){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Schedule Appointment"),
          alignment: Alignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min, // Ensure content size is controlled
            children: [
              MyTextFormField2(
                controller: _contDate,
                hintText: "Date",
                labelText: "Date",
                icon: IconButton(onPressed: (){
                  _selectDate(context);
                }, icon: Icon(
                  Icons.calendar_today_outlined,
                  color: maincolor,
                )),
              ),
              const SizedBox(height: 10),
              MyTextFormField(
                controller: _contTime,
                hintText: "Time",
                labelText: "Time",
              ),
              const SizedBox(height: 30),
              Button2(text: "Schedule", onTap: () {}),
              const SizedBox(height: 10),
              Button2(text: "Cancel", onTap: () {
                Navigator.pop(context);
              }),
            ],
          ),
        );
      }
    );
  }
  late List<dynamic> ?_doctors=[] ;
  bool _isLoading = true; // To show loading indicator while fetching data

  _fetchDoctors() async {
    // Fetch doctors and set _doctors
    _doctors = await APIHandler().AllDoctors();
    setState(() {
     // _isLoading = false; // Data is loaded
    });
  }

  @override
  void initState() {
    super.initState();
   _fetchDoctors(); // Fetch doctors data when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
   // _fetchDoctors();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors"),
        backgroundColor: primary,
      ),
      body: _doctors?.length==0
        ? const Center(child: CircularProgressIndicator()) // Show loading indicator
        : SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true, // Add this line
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _doctors?.length,
                itemBuilder: (context, index) {
                  Doctor d = _doctors![index];
                  return SizedBox(
                    width: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Card(
                        child: Container(
                          width: 30,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: d.imgpath != null 
                                        ? NetworkImage("${APIHandler().baseurl}/image/${d.imgpath!}") as ImageProvider
                                        : AssetImage('assets/images/person.png'),
                                    ),
                                  ),
                                  Text("${d.name}"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(width: 20),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Button1(
                                      text: "Schedule Appointment",
                                      onTap: () {
                                        _scheduleDialog();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
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
