import 'dart:convert';

import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:eeg_app/Screens/doctorScreens/resultScreen.dart';
import 'package:flutter/material.dart';

class ExperimentScreen extends StatefulWidget {
  final int sessionid;
  final int appid;
  const ExperimentScreen({super.key, required this.sessionid, required this.appid});

  @override
  State<ExperimentScreen> createState() => _ExperimentScreenState();
}

class _ExperimentScreenState extends State<ExperimentScreen> {
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
      body: experiments.length==0?Center(child: Text("No Experiments"),):
      SafeArea(
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
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Resultscreen(id: e['id'],result:e['Result'],eegPath:e['EEGPath'],appid:widget.appid)));
               },),
            );
                  },
                  
                   ),
        ),
      )
        
    );
  }
}