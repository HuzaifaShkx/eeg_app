import 'dart:convert';
import 'dart:io';

import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:eeg_app/Custom%20Widget/textFormFeild1.dart';
import 'package:eeg_app/Custom%20Widget/textFormFeild2.dart';
import 'package:eeg_app/Screens/loginscreen.dart';
import 'package:eeg_app/model/supervisor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'supervisor_provider.dart';

class SupervisorUploadScreen extends StatefulWidget {
  final int supervisorid;
  final int appid;
  final int sessionid;
  const SupervisorUploadScreen({super.key, required this.supervisorid, required this.appid, required this.sessionid});

  @override
  State<SupervisorUploadScreen> createState() => _SupervisorUploadScreenState();
}

class _SupervisorUploadScreenState extends State<SupervisorUploadScreen> {
  File? selectedFile;
  TextEditingController filename=TextEditingController();
  bool isRecording = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment Screen'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // Handle back action
        //   },
        // ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildDropdown(context, 'Patient', 'Select Patient', (String value) {
            //  // Provider.of<SupervisorProvider>(context, listen: false).selectPatient(value);
            // }),
            // const SizedBox(height: 16),
            // _buildDropdown(context, 'Select Video', 'Select Video', (String value) {
            //   //Provider.of<SupervisorProvider>(context, listen: false).selectVideo(value);
            // }),
            // const SizedBox(height: 24),
            // //Center(child: Button1(text: "Start", onTap: (){})),
            MyTextFormField(controller: filename, hintText: "Enter File Name", labelText: "File Name"),
            const SizedBox(height: 32),
            //_buildAttachRow(context, 'Attach EEG', Icons.add_box),
            // const SizedBox(height: 16),
            // _buildAttachRow(context, 'Attach Captured Video', Icons.add_box),
            const SizedBox(height: 32),
            Center(child: Button1(text: "Start Recording", onTap: () async {
              setState(() {
                isRecording =true;
              });
             var res=await APIHandler().StartRecording(filename.text);
             if(res.statusCode==200){
              setState(() {
                isRecording =false;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Recording Completed successfully!')));
             // var res=await APIHandler().AddSession(widget.supervisorid, widget.appid);
              
                var emotion=await APIHandler().PredictEmotion("${filename.text}.csv");
                if(emotion.statusCode==200){
                  String result=jsonDecode(emotion.body).toString();
                 await APIHandler().AddExperiment("C:/FYP_Code/FYPAPIs/Uploads/eeg/${filename.text}.csv", result, widget.sessionid);
                }else if(emotion.statusCode==404){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AlertDialog(content: Text('Failed to predict because file not found'))));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AlertDialog(content: Text('Failed to predict'))));
                }
                
              
             }else{
               setState(() {
                isRecording =false;
              });
             }
      //          var res=await APIHandler().UploadEEG(eeg_file: selectedFile);
      // if(res.statusCode==200){
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('File uploaded successfully!')));
      // }else{
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload!')));
      // }
            })),
          isRecording?CircularProgressIndicator():Container()
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(BuildContext context, String label, String hint, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          hint: Text(hint),
          onChanged: (s){},
          items: const [
            DropdownMenuItem(value: 'patient1', child: Text('Patient 1')),
            DropdownMenuItem(value: 'patient2', child: Text('Patient 2')),
          ],
        ),
      ],
    );
  }

  Widget _buildAttachRow(BuildContext context, String label, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primary)),
        IconButton(
          icon: Icon(icon, color: primary),
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        selectedFile = file;
      });
     
    } else {
      // User canceled the picker
    }
          },
        ),
      ],
    );
  }
}
