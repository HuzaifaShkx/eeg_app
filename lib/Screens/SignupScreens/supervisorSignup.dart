import 'dart:io';

import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:eeg_app/Custom%20Widget/genderField.dart';
import 'package:eeg_app/Custom%20Widget/textFormFeild1.dart';
import 'package:eeg_app/Custom%20Widget/textFormFeild2.dart';
import 'package:eeg_app/Screens/loginscreen.dart';
import 'package:eeg_app/model/supervisor.dart';
import 'package:eeg_app/model/user.dart';
import 'package:eeg_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SupervisorSignup extends StatefulWidget {
  final int doctorid;
  const SupervisorSignup({super.key, required this.doctorid});

  @override
  State<SupervisorSignup> createState() => _SupervisorSignupState();
}

class _SupervisorSignupState extends State<SupervisorSignup> {
  final TextEditingController _contName = TextEditingController();
  final TextEditingController _contEmail = TextEditingController();
  final TextEditingController _contPassword = TextEditingController();
  final TextEditingController _contGender = TextEditingController();
  final TextEditingController _contDob = TextEditingController();
  final TextEditingController _contContact = TextEditingController();
  File? _img;

   Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _contDob.text = "${picked.year}-${picked.month}-${picked.day}"; // Format date as needed
      });
    }
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supervisor SignUp"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: _img == null
                      ? const AssetImage("assets/images/person.png")
                      : FileImage(_img!) as ImageProvider,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(children: [
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () async {
                          XFile? image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            // Check if image is not null
                            setState(() {
                              _img = File(image.path);
                            });
                          }
                        },
                        icon: const Icon(Icons.camera_alt_outlined),
                        alignment: Alignment.bottomRight,
                      )
                    ])),
              ],
            ),
            Text(
              "Enter Your Details",
              style: TextStyle(
                  fontSize: 18,
                  color: maincolor,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),
            MyTextFormField(
              controller: _contName,
              hintText: "Full Name",
              labelText: "Full Name",
            ),
            MyTextFormField(
              controller: _contEmail,
              hintText: "Email",
              labelText: "Email",
            ),
            MyTextFormField(
              controller: _contPassword,
              hintText: "Password",
              labelText: "Password",
            ),
            GenderFormField(
              controller: _contGender,
              hintText: "Select Gender",
              labelText: "Gender",
            ),
            MyTextFormField2(
                controller: _contDob,
                hintText: "DOB",
                labelText: "DOB",
                icon: IconButton(onPressed: (){
                  _selectDate(context);
                  
                }, icon: Icon(
                  Icons.calendar_today_outlined,
                  color: maincolor,
                )),),
                MyTextFormField(
              controller: _contContact,
              hintText: "Contact",
              labelText: "Contact",
            ),
            const SizedBox(
              height: 20,
            ),
            Button2(
              text: "Register",
              onTap: () async {
                Supervisor u=Supervisor(dob: _contDob.text,gender: _contGender.text=="Male"?"M":_contGender=="Female"?"F":"",email: _contEmail.text,name: _contName.text,password: _contPassword.text,role: "supervisor", contact: _contContact.text,doctorId: widget.doctorid);
                var res=await APIHandler().SupervisorSignup(image_file: _img, user: u);
                if(res.statusCode==200){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Supervior Registered Successfully"),duration: const Duration(seconds: 3),backgroundColor: maincolor,));
                  Navigator.pop(context);
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                }else if(res.statusCode==409){
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("User with the same email already exists"),duration: const Duration(seconds: 3),backgroundColor: maincolor,));
                }else if(res.statusCode==500){
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Server Error"),duration: const Duration(seconds: 3),backgroundColor: maincolor,));
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
