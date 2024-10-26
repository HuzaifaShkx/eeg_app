import 'package:eeg_app/API/APIHandler.dart';
import 'package:flutter/material.dart';

class PatientPrescribtion extends StatefulWidget {
  final int id;
  const PatientPrescribtion({super.key, required this.id});

  @override
  State<PatientPrescribtion> createState() => _PatientPrescribtionState();
}

class _PatientPrescribtionState extends State<PatientPrescribtion> {
  late List<dynamic> prescribtion=[];
  _getPrescribtion(int id) async {
    prescribtion=await APIHandler().GetPatientPrescribtion(id);
    setState(() {
      
    });
  }
  @override
  void initState() {
    super.initState();
    _getPrescribtion(widget.id); // replace 1 with the patient id
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Patient Prescribtion'),
      ),
      body: 
      prescribtion.length==0?Center(child: CircularProgressIndicator(),):
      ListView.builder(
        itemCount: prescribtion.length,
        itemBuilder: (context,index){
          return Container(
            //height: 200,
            child: Column(
              children: [
                 Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('${APIHandler().baseurl}/image/${prescribtion[0]["imgpath"]}'),
                      ),
                    ),
                    Text("${prescribtion[0]["name"]}",style: TextStyle(fontSize: 20),)
                  ],
                ),
               SizedBox(
                height: 100,
                width: 300,
                 child:  Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("${prescribtion[0]["prescribtion"]}"),
                  ),
                 ),
               ),
                const Divider()
              ],
            ),
          );
        }),
    );
  }
}