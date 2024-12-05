import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:eeg_app/Screens/doctorScreens/add_prescribtion.dart';
import 'package:eeg_app/model/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultscreenP extends StatefulWidget {
  final int id;
  const ResultscreenP({super.key, required this.id});

  @override
  State<ResultscreenP> createState() => _ResultscreenPState();
}

class _ResultscreenPState extends State<ResultscreenP> {
  Patient ?p;
  _getPatient(int id) async {
    //get patient data
    p=await APIHandler().GetPatient(id);
    setState(() {
      
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPatient(widget.id);
  }
  @override
  Widget build(BuildContext context) {
   // _getPatient(widget.id);
    return Scaffold(
      appBar: AppBar(title: const Text("Result Screen",style: TextStyle(color: Colors.white),),
      backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
             p == null
                ? CircularProgressIndicator(color: primary)
                : Text(
                    "${p!.name}",
                    style: TextStyle(fontSize: 30, color: primary),
                  ),
            SizedBox(height: 20,),
            Table(
              children: [
                TableRow(
                  children: [
                    Text("Emotion :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: primary),),
                    Text("Happy",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: primary),)
                  ]
                ),
              ]),
              SizedBox(height: 20,),
              Container(
              //decoration: BoxDecoration(color: Colors.amber),
              child: Table(
                border: TableBorder.all(color: primary),
                children: [
                  TableRow(
                    children: [
                      Text("True Label",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: primary),),
                      Text("EEG Emotion",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: primary),),
                      Text("Facial Emotion",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: primary),)
                    ]
                  ),
                  TableRow(
                    children: [
                      Text("Happy",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: primary),),
                      Text("Sad",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: primary),),
                      Text("Sad",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: primary),)
                    ]
                  ),
                  // TableRow(
                  //   children: [
                  //     Text("Duration",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: primary),),
                  //     Text("1 week",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: primary),)
                  //   ]
                  // ),
                  // TableRow(
                  //   children: [
                  //     Text("Note",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: primary),),
                  //     Text("Take after meal",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: primary),)
                  //   ]
                  // ),
                ],
              ),
              ),
              Container(
                height: 220,
                child: LineChart(LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      color: Colors.red,
                      spots: [
                        FlSpot(0, 3),
                        FlSpot(1, 4),
                        FlSpot(2, 3),
                        FlSpot(3, 5),
                        FlSpot(4, 4),
                        FlSpot(5, 6),
                       
                      ],
                      isCurved: true,
                    
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                      dotData: FlDotData(show: true),
                    ),
                     LineChartBarData(
                      color: Colors.blue,
                      spots: [
                        FlSpot(0, 6),
                        FlSpot(1, 2),
                        FlSpot(2, 8),
                        FlSpot(3, 1),
                        FlSpot(4, 9),
                        FlSpot(5, 5),
                       
                      ],
                      isCurved: true,
                    
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(show: false),
                      dotData: FlDotData(show: true),
                    )
                  ],
                )),
              ),
              SizedBox(height: 10,),
              // Container(
              //   alignment: Alignment.topRight,
              //   child: InkWell(
              //     onTap: (){
              //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPrescribtion()));
              //     },
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Icon(Icons.add_task_outlined,size: 50,color: primary,),
              //         Text("Add Prescribtion",style: TextStyle(color: primary,),)
              //       ],
              //     ),
              //   ),
              // )
          ],),
      )
    );
  }
}