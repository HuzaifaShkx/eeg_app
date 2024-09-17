import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:flutter/material.dart';

class PatientDetailScreen extends StatelessWidget {
  const PatientDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patient Detail"),),
      body: Column(children: [
        SizedBox(height: 20,),
        Row(children: [
          SizedBox(width: 30,),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                image: AssetImage("assets/images/download.jpeg"),
                fit: BoxFit.cover
              )
            ),
             
          ),
          SizedBox(width: 20,),
          CircleAvatar(child:Icon(Icons.phone),),
          SizedBox(width: 10,),
          Container(
            alignment: Alignment.center,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(),
              //color: Colors.grey[300]
            ),
            child: Text("03032323454"),)
        ],),
       Padding(
         padding: const EdgeInsets.all(20.0),
         child: Table(
          children: [
            TableRow(
              
              children: [
              Text("Name :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              Text("Hamza Ali",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),)
         
            ]),
             TableRow(
              
              children: [
              Text("Gender :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              Text("Male",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),)
         
            ]),
             TableRow(
              
              children: [
              Text("Age :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              Text("10",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),)
         
            ]),
             TableRow(
              
              children: [
              Text("Height :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              Text("5'11",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),)
         
            ]),
             TableRow(
              
              children: [
              Text("Weight :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              Text("70",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),)
         
            ])
          ],
         ),
       ),
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Button2(text: "Results", onTap: (){}),
          Button2(text: "Medicine Info", onTap: (){})
        ],
       ),
       SizedBox(height: 5,),
       Divider(),
       SizedBox(height: 5,),
       Text("Completed Appointments",style: TextStyle(color: primary,fontSize: 20,fontWeight: FontWeight.w600),),
       SizedBox(
        width: 220,
         child: Container(
           child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                color: Color.fromARGB(150, 239, 216, 220)
                ),
                child: Text("Meeting on 10"),
              ),
            );
           }),
         ),
       )
      ],),
    );
  }
}