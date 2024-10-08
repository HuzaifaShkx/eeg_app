import 'dart:io';

import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:eeg_app/Custom%20Widget/genderField.dart';
import 'package:eeg_app/Custom%20Widget/textFormFeild1.dart';
import 'package:eeg_app/Custom%20Widget/textFormFeild2.dart';
import 'package:eeg_app/Screens/loginscreen.dart';
import 'package:eeg_app/model/user.dart';
import 'package:eeg_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DoctorSignup extends StatefulWidget {
  const DoctorSignup({super.key});

  @override
  State<DoctorSignup> createState() => _DoctorSignupState();
}

class _DoctorSignupState extends State<DoctorSignup> {
  TextEditingController _contName = TextEditingController();
  TextEditingController _contEmail = TextEditingController();
  TextEditingController _contPassword = TextEditingController();
  TextEditingController _contGender = TextEditingController();
  TextEditingController _contDob = TextEditingController();
  TextEditingController _contContact = TextEditingController();
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
        _contDob.text = "${picked.day}-${picked.month}-${picked.year}"; // Format date as needed
      });
    }
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor SignUp"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: _img == null
                      ? AssetImage("assets/images/person.png")
                      : FileImage(_img!) as ImageProvider,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(children: [
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () async {
                          XFile? _image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          setState(() {
                            _img = File(_image!.path);
                          });
                        },
                        icon: Icon(Icons.camera_alt_outlined),
                        alignment: Alignment.bottomRight,
                      )
                    ])),
              ],
            ),
            Text(
              "Enter Your Details",
              style: TextStyle(
                  fontSize: 18,
                  color:maincolor,
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
            SizedBox(
              height: 20,
            ),
            Button2(
              text: "SignUp",
              onTap: () {
                User u=User(contact:_contContact.text,dob: _contDob.text,gender: _contGender.text=="Male"?"M":_contGender=="Female"?"F":"",id: _contEmail.text,name: _contName.text,password: _contPassword.text,role: "doctor");
                APIHandler().DoctorSignup(image_file: _img, user: u);
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ]),
        ),
      ),
    );
  }
}
