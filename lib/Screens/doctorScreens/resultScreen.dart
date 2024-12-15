import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:eeg_app/Screens/doctorScreens/add_prescribtion.dart';
import 'package:eeg_app/model/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fl_chart/fl_chart.dart';

class Resultscreen extends StatefulWidget {
  final int id;
  const Resultscreen({super.key, required this.id});

  @override
  State<Resultscreen> createState() => _ResultscreenState();
}

class _ResultscreenState extends State<Resultscreen> {
  Patient ?p;
  Map<String,dynamic> AF7={};
    Map<String,dynamic> AF8={};
    Map<String,dynamic> TP9={};
    Map<String,dynamic> TP10={};
  late List<dynamic> eeg=[];
  Future _getEEGData() async {
    eeg=await APIHandler().GetEEGData();
    setState(() {
      
    });
  }
  _getPatient(int id) async {
    //get patient data
    p=await APIHandler().GetPatient(id);
    setState(() {
      
    });
  }
  _extractEEG(eeg){
    AF7=eeg[0];
    AF8=eeg[1];
    TP9=eeg[3];
    TP10=eeg[2];
    
  }
  _extractAF7Alpha(){
   // List<double> AF7Alpha=AF7[0][];
    // print(AF7Alpha);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPatient(widget.id);
    _getEEGData();
    
  }
  List<FlSpot> convertToFlSpot(List<dynamic> yValues) {
  return List<FlSpot>.generate(
    yValues.length,
    (index) => FlSpot(index.toDouble(), yValues[index]),
  );
}
List<FlSpot> convertToReducedFlSpot(List<dynamic> yValues) {
  return List<FlSpot>.generate(
    (yValues.length / 2).ceil(),
    (index) => FlSpot(
      (index * 2).toDouble(), // x-value (index multiplied by 2)
      yValues[index * 2],    // y-value (element at even index)
    ),
  );
}
List<FlSpot> convertToQuarterFlSpot(List<dynamic> yValues) {
  return List<FlSpot>.generate(
    (yValues.length / 4).ceil(),
    (index) => FlSpot(
      (index * 4).toDouble(), // x-value (index multiplied by 4)
      yValues[index * 4],    // y-value (element at every 4th index)
    ),
  );
}
List<FlSpot> convertToEightFlSpot(List<dynamic> yValues) {
  return List<FlSpot>.generate(
    (yValues.length / 8).ceil(),
    (index) => FlSpot(
      (index * 8).toDouble(), // x-value (index multiplied by 4)
      yValues[index * 8],    // y-value (element at every 4th index)
    ),
  );
}
List<FlSpot> convertToSixteentFlSpot(List<dynamic> yValues) {
  return List<FlSpot>.generate(
    (yValues.length / 100).ceil(),
    (index) => FlSpot(
      (index * 100).toDouble(), // x-value (index multiplied by 4)
      yValues[index * 100],    // y-value (element at every 4th index)
    ),
  );
}
  @override
  Widget build(BuildContext context) {
   // _getPatient(widget.id);
   _extractEEG(eeg);
  
  print(AF7["Alpha"]);
    return Scaffold(
      appBar: AppBar(title: const Text("Result Screen",style: TextStyle(color: Colors.white),),
      backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
                  margin: EdgeInsets.all(5),
                  alignment: AlignmentDirectional.center,
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(color: primary,
                  borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("AF7",style: TextStyle(color: Colors.white),)),
                Container(
                  height: 300,
                    width: 400,
                  child: LineChart(LineChartData(
                     titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides Y-axis labels
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides X-axis labels
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides Top axis (optional)
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides Right axis (optional)
      ),
    ),
                    lineBarsData: [
                      LineChartBarData(
          
                        color: Colors.red,
                        spots:convertToSixteentFlSpot(AF7["Alpha"]) ,
                        // [
                        //   // FlSpot(0, 3),
                        //   // FlSpot(1, 4),
                        //   // FlSpot(2, 3),
                        //   // FlSpot(3, 5),
                        //   // FlSpot(4, 4),
                        //   // FlSpot(5, 6),
                          
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                       LineChartBarData(
                        color: Colors.blue,
                        spots:convertToSixteentFlSpot(AF7["Beta"]) ,
                        //  [
                        //   FlSpot(0, 6),
                        //   FlSpot(1, 2),
                        //   FlSpot(2, 8),
                        //   FlSpot(3, 1),
                        //   FlSpot(4, 9),
                        //   FlSpot(5, 5),
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                       LineChartBarData(
                        color: Colors.green,
                        spots:convertToSixteentFlSpot(AF7["Delta"]) ,
                        // [
                        //   // FlSpot(0, 3),
                        //   // FlSpot(1, 4),
                        //   // FlSpot(2, 3),
                        //   // FlSpot(3, 5),
                        //   // FlSpot(4, 4),
                        //   // FlSpot(5, 6),
                          
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                       LineChartBarData(
                        color: Colors.black,
                        spots:convertToSixteentFlSpot(AF7["Theta"]) ,
                        // [
                        //   // FlSpot(0, 3),
                        //   // FlSpot(1, 4),
                        //   // FlSpot(2, 3),
                        //   // FlSpot(3, 5),
                        //   // FlSpot(4, 4),
                        //   // FlSpot(5, 6),
                          
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  )),
                  
                ),
                SizedBox(height: 5,),
                Container(child: Row(
                  children: [
                    Container(width: 10,height: 10,color: Colors.red,),SizedBox(width: 5,),Text("Alpha"),SizedBox(width: 5,),
                    Container(width: 10,height: 10,color: Colors.blue,),SizedBox(width: 5,),Text("Beta"),SizedBox(width: 5,),
                    Container(width: 10,height: 10,color: Colors.green,),SizedBox(width: 5,),Text("Delta"),SizedBox(width: 5,),
                    Container(width: 10,height: 10,color: Colors.black,),SizedBox(width: 5,),Text("Theta"),SizedBox(width: 5,),
                  ],
                ),),
                Container(
                  margin: EdgeInsets.all(5),
                  alignment: AlignmentDirectional.center,
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(color: primary,
                  borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("AF8",style: TextStyle(color: Colors.white),)),
                 Container(
                  height: 300,
                    width: 400,
                  child: LineChart(
                    
                    duration: Duration(seconds: 59),
                    LineChartData(
                       titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides Y-axis labels
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides X-axis labels
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides Top axis (optional)
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides Right axis (optional)
      ),
    ),
                    lineBarsData: [
                      LineChartBarData(
                        belowBarData: BarAreaData(show: false),
                        aboveBarData: BarAreaData(show: false),
                        color: Colors.red,
                        spots:convertToSixteentFlSpot(AF8["Alpha"]) ,
                        // [
                        //   // FlSpot(0, 3),
                        //   // FlSpot(1, 4),
                        //   // FlSpot(2, 3),
                        //   // FlSpot(3, 5),
                        //   // FlSpot(4, 4),
                        //   // FlSpot(5, 6),
                          
                         
                        // ],
                        
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                       // belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                        
                      ),
                       LineChartBarData(
                        color: Colors.blue,
                        spots:convertToSixteentFlSpot(AF8["Beta"]) ,
                        //  [
                        //   FlSpot(0, 6),
                        //   FlSpot(1, 2),
                        //   FlSpot(2, 8),
                        //   FlSpot(3, 1),
                        //   FlSpot(4, 9),
                        //   FlSpot(5, 5),
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                       LineChartBarData(
                        color: Colors.green,
                        spots:convertToSixteentFlSpot(AF8["Delta"]) ,
                        // [
                        //   // FlSpot(0, 3),
                        //   // FlSpot(1, 4),
                        //   // FlSpot(2, 3),
                        //   // FlSpot(3, 5),
                        //   // FlSpot(4, 4),
                        //   // FlSpot(5, 6),
                          
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                       LineChartBarData(
                        color: Colors.black,
                        spots:convertToSixteentFlSpot(AF8["Theta"]) ,
                        // [
                        //   // FlSpot(0, 3),
                        //   // FlSpot(1, 4),
                        //   // FlSpot(2, 3),
                        //   // FlSpot(3, 5),
                        //   // FlSpot(4, 4),
                        //   // FlSpot(5, 6),
                          
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  )),
                  
                ),
                SizedBox(height: 5,),
                Container(child: Row(
                  children: [
                    Container(width: 10,height: 10,color: Colors.red,),SizedBox(width: 5,),Text("Alpha"),SizedBox(width: 5,),
                    Container(width: 10,height: 10,color: Colors.blue,),SizedBox(width: 5,),Text("Beta"),SizedBox(width: 5,),
                    Container(width: 10,height: 10,color: Colors.green,),SizedBox(width: 5,),Text("Delta"),SizedBox(width: 5,),
                    Container(width: 10,height: 10,color: Colors.black,),SizedBox(width: 5,),Text("Theta"),SizedBox(width: 5,),
                  ],
                ),),
                  Container(
                  margin: EdgeInsets.all(5),
                  alignment: AlignmentDirectional.center,
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(color: primary,
                  borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("TP9",style: TextStyle(color: Colors.white),)),
                 Container(
                  height: 300,
                    width: 400,
                  child: LineChart(
                    
                    duration: Duration(seconds: 59),
                    LineChartData(
                       titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides Y-axis labels
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides X-axis labels
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides Top axis (optional)
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides Right axis (optional)
      ),
    ),
                    lineBarsData: [
                      LineChartBarData(
                        belowBarData: BarAreaData(show: false),
                        aboveBarData: BarAreaData(show: false),
                        color: Colors.red,
                        spots:convertToSixteentFlSpot(TP9["Alpha"]) ,
                        // [
                        //   // FlSpot(0, 3),
                        //   // FlSpot(1, 4),
                        //   // FlSpot(2, 3),
                        //   // FlSpot(3, 5),
                        //   // FlSpot(4, 4),
                        //   // FlSpot(5, 6),
                          
                         
                        // ],
                        
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                       // belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                        
                      ),
                       LineChartBarData(
                        color: Colors.blue,
                        spots:convertToSixteentFlSpot(TP9["Beta"]) ,
                        //  [
                        //   FlSpot(0, 6),
                        //   FlSpot(1, 2),
                        //   FlSpot(2, 8),
                        //   FlSpot(3, 1),
                        //   FlSpot(4, 9),
                        //   FlSpot(5, 5),
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                       LineChartBarData(
                        color: Colors.green,
                        spots:convertToSixteentFlSpot(TP9["Delta"]) ,
                        // [
                        //   // FlSpot(0, 3),
                        //   // FlSpot(1, 4),
                        //   // FlSpot(2, 3),
                        //   // FlSpot(3, 5),
                        //   // FlSpot(4, 4),
                        //   // FlSpot(5, 6),
                          
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                       LineChartBarData(
                        color: Colors.black,
                        spots:convertToSixteentFlSpot(TP9["Theta"]) ,
                        // [
                        //   // FlSpot(0, 3),
                        //   // FlSpot(1, 4),
                        //   // FlSpot(2, 3),
                        //   // FlSpot(3, 5),
                        //   // FlSpot(4, 4),
                        //   // FlSpot(5, 6),
                          
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  )),
                  
                ),
                SizedBox(height: 5,),
                Container(child: Row(
                  children: [
                    Container(width: 10,height: 10,color: Colors.red,),SizedBox(width: 5,),Text("Alpha"),SizedBox(width: 5,),
                    Container(width: 10,height: 10,color: Colors.blue,),SizedBox(width: 5,),Text("Beta"),SizedBox(width: 5,),
                    Container(width: 10,height: 10,color: Colors.green,),SizedBox(width: 5,),Text("Delta"),SizedBox(width: 5,),
                    Container(width: 10,height: 10,color: Colors.black,),SizedBox(width: 5,),Text("Theta"),SizedBox(width: 5,),
                  ],
                ),),
                  Container(
                  margin: EdgeInsets.all(5),
                  alignment: AlignmentDirectional.center,
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(color: primary,
                  borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("TP10",style: TextStyle(color: Colors.white),)),
                 Container(
                  height: 300,
                    width: 400,
                  child: LineChart(
                    
                    duration: Duration(seconds: 59),
                    LineChartData(
                       titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides Y-axis labels
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides X-axis labels
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides Top axis (optional)
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false), // Hides Right axis (optional)
      ),
    ),
                    lineBarsData: [
                      LineChartBarData(
                        belowBarData: BarAreaData(show: false),
                        aboveBarData: BarAreaData(show: false),
                        color: Colors.red,
                        spots:convertToSixteentFlSpot( TP10["Alpha"]) ,
                        // [
                        //   // FlSpot(0, 3),
                        //   // FlSpot(1, 4),
                        //   // FlSpot(2, 3),
                        //   // FlSpot(3, 5),
                        //   // FlSpot(4, 4),
                        //   // FlSpot(5, 6),
                          
                         
                        // ],
                        
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                       // belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                        
                      ),
                       LineChartBarData(
                        color: Colors.blue,
                        spots:convertToSixteentFlSpot(TP10["Beta"]) ,
                        //  [
                        //   FlSpot(0, 6),
                        //   FlSpot(1, 2),
                        //   FlSpot(2, 8),
                        //   FlSpot(3, 1),
                        //   FlSpot(4, 9),
                        //   FlSpot(5, 5),
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                       LineChartBarData(
                        color: Colors.green,
                        spots:convertToSixteentFlSpot(TP10["Delta"]) ,
                        // [
                        //   // FlSpot(0, 3),
                        //   // FlSpot(1, 4),
                        //   // FlSpot(2, 3),
                        //   // FlSpot(3, 5),
                        //   // FlSpot(4, 4),
                        //   // FlSpot(5, 6),
                          
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                       LineChartBarData(
                        color: Colors.black,
                        spots:convertToSixteentFlSpot(TP10["Theta"]) ,
                        // [
                        //   // FlSpot(0, 3),
                        //   // FlSpot(1, 4),
                        //   // FlSpot(2, 3),
                        //   // FlSpot(3, 5),
                        //   // FlSpot(4, 4),
                        //   // FlSpot(5, 6),
                          
                         
                        // ],
                        isCurved: true,
                      
                        barWidth: 1,
                        isStrokeCapRound: false,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  )),
                  
                ),
                SizedBox(height: 5,),
                Container(child: Row(
                  children: [
                    Container(width: 10,height: 10,color: Colors.red,),SizedBox(width: 5,),Text("Alpha"),SizedBox(width: 5,),
                    Container(width: 10,height: 10,color: Colors.blue,),SizedBox(width: 5,),Text("Beta"),SizedBox(width: 5,),
                    Container(width: 10,height: 10,color: Colors.green,),SizedBox(width: 5,),Text("Delta"),SizedBox(width: 5,),
                    Container(width: 10,height: 10,color: Colors.black,),SizedBox(width: 5,),Text("Theta"),SizedBox(width: 5,),
                  ],
                ),),
                Container(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPrescribtion()));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.add_task_outlined,size: 50,color: primary,),
                        Text("Add Prescribtion",style: TextStyle(color: primary,),)
                      ],
                    ),
                  ),
                )
            ],),
        ),
      )
    );
  }
}