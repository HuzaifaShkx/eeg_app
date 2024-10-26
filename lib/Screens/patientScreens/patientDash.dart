import 'package:eeg_app/API/APIHandler.dart';
import 'package:flutter/material.dart';

class PatientDash extends StatefulWidget {
  const PatientDash({super.key});

  @override
  State<PatientDash> createState() => _PatientDashState();
}

class _PatientDashState extends State<PatientDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patient Dashboard"),),
      body: FutureBuilder(future: APIHandler().AllDoctors(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }else{
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context,index){
              return ListTile(
                title: Text("${snapshot.data?[index].name}"),
                subtitle: Text("${snapshot.data?[index].contact}"),
              );
            });
        }
      },
      ),
    );
  }
}