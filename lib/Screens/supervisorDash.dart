import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:flutter/material.dart';

class SupervisorDash extends StatefulWidget {
  const SupervisorDash({super.key});

  @override
  State<SupervisorDash> createState() => _SupervisorDashState();
}

class _SupervisorDashState extends State<SupervisorDash> {
  
  bool switch1 = false;
  bool switch2 = false;
  bool switch3 = false;
  bool switch4 = false;
  bool switch5 = false;
  bool switch6 = false;
  bool switch7 = false;
  bool switch8 = false;
  bool switch9 = false;
  bool switch10 = false;
  bool switch11 = false;
  bool switch12 = false;
  bool switch13 = false;
  bool switch14 = false;
  bool switch15 = false;
  bool switch16 = false;
  bool switch17 = false;
  bool switch18 = false;
  bool switch19 = false;
  bool switch20= false;
  bool switch21 = false;
  bool switch22= false;
  bool switch23 = false;
  bool switch24 = false;
  bool switch25 = false;
  bool switch26 = false;
  bool switch27 = false;
  bool switch28 = false;
  bool switch29 = false;
  bool switch30 = false;
  bool switch31 = false;
  bool switch32 = false;
   
   
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text("Supervisor Dashboard",style: TextStyle(color: Colors.white),),
      backgroundColor: primary,
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(children: [
            SwitchCategory(text: "FrontoPolo",),
            Switch(value:switch1 , onChanged: (value){
              switch1=value;
              setState(() {
                
              });
            }),
            Text("FP1"),
            Switch(value: switch2, onChanged: (value){
              switch2=value;
              setState(() {
                
              });
            }),
            Text("FP2"),
          ],),
          Row(children: [
            SwitchCategory(text: "Frontal",),

            Switch(value:switch3 , onChanged: (value){
              switch3=value;
              setState(() {
                
              });
            }),
            Text("F3"),
            Switch(value: switch4, onChanged: (value){
              switch4=value;
              setState(() {
                
              });
            }),
            Text("F4"),
          ],),
          Row(children: [
            SizedBox(width: 100,),
            Switch(value:switch5 , onChanged: (value){
              switch5=value;
              setState(() {
                
              });
            }),
            Text("F8"),
            Switch(value: switch6, onChanged: (value){
              switch6=value;
              setState(() {
                
              });
            }),
            Text("F7"),
          ],),
          Row(children: [
            SwitchCategory(text: "Temporal",),
            Switch(value:switch7 , onChanged: (value){
              switch7=value;
              setState(() {
                
              });
            }),
            Text("T7"),
            Switch(value: switch8, onChanged: (value){
              switch8=value;
              setState(() {
                
              });
            }),
            Text("T8"),
          ],),
          Row(children: [
            SwitchCategory(text: "Central",),
            Switch(value:switch9 , onChanged: (value){
              switch9=value;
              setState(() {
                
              });
            }),
            Text("C4"),
            Switch(value: switch10, onChanged: (value){
              switch10=value;
              setState(() {
                
              });
            }),
            Text("C3"),
          ],),
          Row(children: [
            SwitchCategory(text: "Parietal",),
            Switch(value:switch11 , onChanged: (value){
              switch11=value;
              setState(() {
                
              });
            }),
            Text("P4"),
            Switch(value: switch12, onChanged: (value){
              switch12=value;
              setState(() {
                
              });
            }),
            Text("P8"),
          ],),
          Row(children: [
            SizedBox(width: 100,),
            Switch(value:switch13 , onChanged: (value){
              switch13=value;
              setState(() {
                
              });
            }),
            Text("P3"),
            Switch(value: switch14, onChanged: (value){
              switch14=value;
              setState(() {
                
              });
            }),
            Text("P7"),
          ],),
          Row(children: [
            SwitchCategory(text: "MidLine",),
            Switch(value:switch15 , onChanged: (value){
              switch15=value;
              setState(() {
                
              });
            }),
            Text("FZ"),
            Switch(value: switch16, onChanged: (value){
              switch16=value;
              setState(() {
                
              });
            }),
            Text("PZ"),
          ],),
          Row(children: [
            SizedBox(width: 100,),
            Switch(value:switch17 , onChanged: (value){
              switch17=value;
              setState(() {
                
              });
            }),
            Text("CZ"),
            Switch(value: switch18, onChanged: (value){
              switch18=value;
              setState(() {
                
              });
            }),
            Text("OZ"),
          ],),
          Row(children: [
            SwitchCategory(text: "Ocipital",),
            Switch(value:switch19 , onChanged: (value){
              switch19=value;
              setState(() {
                
              });
            }),
            Text("O2"),
            Switch(value: switch20, onChanged: (value){
              switch20=value;
              setState(() {
                
              });
            }),
            Text("O1"),
          ],),
          Row(children: [
           
            Switch(value:switch21 , onChanged: (value){
              switch21=value;
              setState(() {
                
              });
            }),
            Text("CP2"),
            Switch(value: switch22, onChanged: (value){
              switch22=value;
              setState(() {
                
              });
              
            }),
            Text("PO4"),
            Switch(value: switch23, onChanged: (value){
              switch23=value;
              setState(() {
                
              });
            }),
             Text("FC1"),
          ],),
           Row(children: [
            
            Switch(value:switch24 , onChanged: (value){
              switch24=value;
              setState(() {
                
              });
            }),
            Text("PO3"),
            Switch(value: switch25, onChanged: (value){
              switch25=value;
              setState(() {
                
              });
              
            }),
            Text("CP6"),
            Switch(value: switch26, onChanged: (value){
              switch26=value;
              setState(() {
                
              });
            }),
            Text("FC5"),
          ],),
           Row(children: [
            Switch(value:switch27 , onChanged: (value){
              switch27=value;
              setState(() {
                
              });
            }),
            Text("CP1"),
            Switch(value: switch28, onChanged: (value){
              switch28=value;
              setState(() {
                
              });
              
            }),
            Text("FC6"),
            Switch(value: switch29, onChanged: (value){
              switch29=value;
              setState(() {
                
              });
            }),
            Text("CP5"),
          ],),
           Row(children: [
            Switch(value:switch30 , onChanged: (value){
              switch30=value;
              setState(() {
                
              });
            }),
            Text("FC2"),
            Switch(value: switch31, onChanged: (value){
              switch31=value;
              setState(() {
                
              });
              
            }),
            Text("AF3"),
            Switch(value: switch32, onChanged: (value){
              switch32=value;
              setState(() {
                
              });
            }),
            Text("AF4"),
          ],)
        ],),
      )
    );
  }
}

class SwitchCategory extends StatelessWidget {
  final String text;
  const SwitchCategory({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Text("${text}",style: TextStyle(color: Colors.white),),);
  }
}

