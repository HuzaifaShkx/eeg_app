import 'dart:io';

import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:eeg_app/Custom%20Widget/textFormFeild1.dart';
import 'package:eeg_app/Custom%20Widget/textFormFeild2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PatientSignUp extends StatefulWidget {
  const PatientSignUp({super.key});

  @override
  State<PatientSignUp> createState() => _PatientSignUpState();
}

class _PatientSignUpState extends State<PatientSignUp> {
  TextEditingController _contName = TextEditingController();
  TextEditingController _contEmail = TextEditingController();
  TextEditingController _contPassword = TextEditingController();
  TextEditingController _contGender = TextEditingController();
  TextEditingController _contDob = TextEditingController();
  File? _img;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient SignUp"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
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
                color: Color(0xFF7C0909),
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
          MyTextFormField(
            controller: _contGender,
            hintText: "Gender",
            labelText: "Gender",
          ),
          MyTextFormField(
            controller: _contGender,
            hintText: "Gender",
            labelText: "Height",
          ),
          MyTextFormField(
            controller: _contGender,
            hintText: "Gender",
            labelText: "Weight",
          ),
          MyTextFormField2(
              controller: _contDob,
              hintText: "DOB",
              labelText: "DOB",
              icon: Icon(
                Icons.calendar_today_outlined,
                color: Color(0xFF7C0909),
              )),
          SizedBox(
            height: 20,
          ),
          Button2(
            text: "SignUp",
            onTap: () {},
          ),
        ]),
      ),
    );
  }
}
