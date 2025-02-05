import 'dart:convert';

import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Screens/patientScreens/resultScreen_p.dart';
import 'package:flutter/material.dart';

class ExperimentScreenP extends StatefulWidget {
  final int sessionid;
  const ExperimentScreenP({super.key, required this.sessionid});

  @override
  State<ExperimentScreenP> createState() => _ExperimentScreenPState();
}

class _ExperimentScreenPState extends State<ExperimentScreenP> {
  List<dynamic> experiments=[];
  @override
  _getExperiments() async {
    var s=await APIHandler().GetExperiments(widget.sessionid);
    var re=jsonDecode(s.body);
    experiments=re;
    setState(() {
      
    });
    print(re[0]['EEGPath']); // print the experiments
  }
  void initState(){
    super.initState();
    _getExperiments(); // fetch experiments when the screen is initialized
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Experiments"),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
          itemCount: experiments.length,
          itemBuilder:(context,index){
            dynamic e=experiments[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button1(text: "${e['id']}", onTap: () { 
                 //Navigate to result screen
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ResultscreenP(id: e['id'],result:e['Result'],eegPath:e['EEGPath'])));
               },),
            );
                  },
                  
                   ),
        ),
      )
        
    );
  }
}