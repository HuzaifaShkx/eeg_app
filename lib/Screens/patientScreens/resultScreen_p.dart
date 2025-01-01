import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:eeg_app/Screens/doctorScreens/add_prescribtion.dart';
import 'package:eeg_app/Screens/doctorScreens/resultScreen.dart';
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
  Map<String,dynamic> AF7={};
    Map<String,dynamic> AF8={};
    Map<String,dynamic> TP9={};
    Map<String,dynamic> TP10={};
    double _sliderValue=0.0;
  late List<dynamic> eeg=[];
   Future<void> _getEEGData() async {
    try {
      eeg = await APIHandler().GetEEGData();
      if (eeg.isNotEmpty) {
        _extractEEG(eeg);
      }
      setState(() {});
    } catch (e) {
      print("Error fetching EEG data: $e");
    }
  }
  _extractEEG(eeg){
    AF7=eeg[0];
    AF8=eeg[1];
    TP9=eeg[3];
    TP10=eeg[2];
    
  }
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
    _getEEGData();
  }
  List<FlSpot> convertToSliderFlSpot(List<dynamic> yValues, double sliderValue) {
  // Determine the start index based on slider value
  int totalSeconds = 60; // Assuming 60 seconds total
  int pointsPerSecond = 256; // Assuming 256 points per second
  int totalPoints = yValues.length;

  // Map slider value (0-60) to the data index
  int startIndex = ((sliderValue / totalSeconds) * totalPoints).round();
  startIndex = startIndex.clamp(0, totalPoints - pointsPerSecond);

  // Extract 256 points from the start index
  List<dynamic> slicedData = yValues.sublist(
    startIndex,
    startIndex + pointsPerSecond,
  );

  // Convert the sliced data to FlSpot
  return List<FlSpot>.generate(
    slicedData.length,
    (index) => FlSpot(
      index.toDouble(),
      slicedData[index],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
   // _getPatient(widget.id);
    return Scaffold(
      appBar: AppBar(title: const Text("Result Screen",style: TextStyle(color: Colors.white),),
      backgroundColor: primary,
      ),
      body: eeg.isEmpty?Center(child:CircularProgressIndicator()):Padding(
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
                           Slider(
                label: "${_sliderValue}",
                divisions: 60,
                min: 0,
                max: 60,
                value: _sliderValue,onChanged: (value){
                _sliderValue=value;
                setState(() {
                  
                });
              },),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(children: [
          GraphTitle(title: "AF7-Alpha",),
          

                  GraphSingleBand(color: Colors.red, flspot:convertToSliderFlSpot(AF7["Alpha"],_sliderValue ),),
                  
                   GraphTitle(title: "AF7-Beta",),
                  GraphSingleBand(color: Colors.blue, flspot:convertToSliderFlSpot(AF7["Beta"],_sliderValue ),),
                   GraphTitle(title: "AF7-Theta",),
                 GraphSingleBand(color: Colors.green, flspot:convertToSliderFlSpot(AF7["Theta"],_sliderValue ),),
                   GraphTitle(title: "AF7-Delta",),
                  GraphSingleBand(color: Colors.black, flspot:convertToSliderFlSpot(AF7["Delta"],_sliderValue ),),
                   GraphTitle(title: "AF7",),
                  Container(
                    height: 300,
                      width: 400,
                    child: LineChart(
                      duration: Duration(seconds: 5),
                      LineChartData(
                       titlesData: FlTitlesData(
                       leftTitles: AxisTitles(
                            
                            axisNameWidget: Text("Amplitude"),
                            sideTitles: SideTitles(showTitles: true,reservedSize: 44), // Hides Y-axis labels
                          ),
                          bottomTitles: AxisTitles(
                            axisNameWidget: Text("Timepoints"),
                            sideTitles: SideTitles(showTitles: true,reservedSize: 30), // Hides X-axis labels
                          ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false), // Hides Top axis (optional)
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false), // Hides Right axis (optional)
                        ),
                      ),
                      borderData: FlBorderData(border: Border(bottom: BorderSide(),left: BorderSide())),
                      lineBarsData: [
                        LineChartBarData(
                            
                          color: Colors.red,
                          spots:convertToSliderFlSpot(AF7["Alpha"],_sliderValue) ,
                         
                          isCurved: true,
                        
                          barWidth: 1,
                          isStrokeCapRound: false,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                        ),
                         LineChartBarData(
                          color: Colors.blue,
                          spots:convertToSliderFlSpot(AF7["Beta"],_sliderValue) ,
                          
                          isCurved: true,
                        
                          barWidth: 1,
                          isStrokeCapRound: false,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                        ),
                         LineChartBarData(
                          color: Colors.green,
                          spots:convertToSliderFlSpot(AF7["Delta"],_sliderValue) ,
                         
                          isCurved: true,
                        
                          barWidth: 1,
                          isStrokeCapRound: false,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                        ),
                         LineChartBarData(
                          color: Colors.black,
                          spots:convertToSliderFlSpot(AF7["Theta"],_sliderValue) ,
                         
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
                    GraphTitle(title: "AF8-Alpha",),
                  GraphSingleBand(color: Colors.red, flspot:convertToSliderFlSpot(AF8["Alpha"],_sliderValue ),),
                   GraphTitle(title: "AF8-Beta",),
                  GraphSingleBand(color: Colors.blue, flspot:convertToSliderFlSpot(AF8["Beta"],_sliderValue ),),
                   GraphTitle(title: "AF8-Theta",),
                 GraphSingleBand(color: Colors.green, flspot:convertToSliderFlSpot(AF8["Theta"],_sliderValue ),),
                   GraphTitle(title: "AF8-Delta",),
                  GraphSingleBand(color: Colors.black, flspot:convertToSliderFlSpot(AF8["Delta"],_sliderValue ),),
                  GraphTitle(title: "AF8",),
                   Container(
                    height: 300,
                      width: 400,
                    child: LineChart(
                      
                      duration: Duration(seconds: 5),
                      LineChartData(
                         titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                            
                            axisNameWidget: Text("Amplitude"),
                            sideTitles: SideTitles(showTitles: true,reservedSize: 44), // Hides Y-axis labels
                          ),
                          bottomTitles: AxisTitles(
                            axisNameWidget: Text("Timepoints"),
                            sideTitles: SideTitles(showTitles: true,reservedSize: 30), // Hides X-axis labels
                          ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false), // Hides Top axis (optional)
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false), // Hides Right axis (optional)
                        ),
                      ),
                      borderData: FlBorderData(border: Border(bottom: BorderSide(),left: BorderSide())),
                      lineBarsData: [
                        LineChartBarData(
                          belowBarData: BarAreaData(show: false),
                          aboveBarData: BarAreaData(show: false),
                          color: Colors.red,
                          spots:convertToSliderFlSpot(AF8["Alpha"],_sliderValue) ,
                         
                          
                          isCurved: true,
                        
                          barWidth: 1,
                          isStrokeCapRound: false,
                         // belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                          
                        ),
                         LineChartBarData(
                          color: Colors.blue,
                          spots:convertToSliderFlSpot(AF8["Beta"],_sliderValue) ,
                        
                          isCurved: true,
                        
                          barWidth: 1,
                          isStrokeCapRound: false,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                        ),
                         LineChartBarData(
                          color: Colors.green,
                          spots:convertToSliderFlSpot(AF8["Delta"],_sliderValue) ,
                          
                          isCurved: true,
                        
                          barWidth: 1,
                          isStrokeCapRound: false,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                        ),
                         LineChartBarData(
                          color: Colors.black,
                          spots:convertToSliderFlSpot(AF8["Theta"],_sliderValue) ,
                          
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
                   GraphTitle(title: "TP9-Alpha",),
                  GraphSingleBand(color: Colors.red, flspot:convertToSliderFlSpot(TP9["Alpha"],_sliderValue ),),
                   GraphTitle(title: "TP9-Beta",),
                  GraphSingleBand(color: Colors.blue, flspot:convertToSliderFlSpot(TP9["Beta"],_sliderValue ),),
                   GraphTitle(title: "TP9-Theta",),
                 GraphSingleBand(color: Colors.green, flspot:convertToSliderFlSpot(TP9["Theta"],_sliderValue ),),
                   GraphTitle(title: "TP9-Delta",),
                  GraphSingleBand(color: Colors.black, flspot:convertToSliderFlSpot(TP9["Delta"],_sliderValue ),),
                     GraphTitle(title: "TP9",),
                   Container(
                    height: 300,
                      width: 400,
                    child: LineChart(
                      
                      duration: Duration(seconds: 5),
                      LineChartData(
                         titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                            
                            axisNameWidget: Text("Amplitude"),
                            sideTitles: SideTitles(showTitles: true,reservedSize: 44), // Hides Y-axis labels
                          ),
                          bottomTitles: AxisTitles(
                            axisNameWidget: Text("Timepoints"),
                            sideTitles: SideTitles(showTitles: true,reservedSize: 30), // Hides X-axis labels
                          ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false), // Hides Top axis (optional)
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false), // Hides Right axis (optional)
                        ),
                      ),
                      borderData: FlBorderData(border: Border(bottom: BorderSide(),left: BorderSide())),
                      lineBarsData: [
                        LineChartBarData(
                          belowBarData: BarAreaData(show: false),
                          aboveBarData: BarAreaData(show: false),
                          color: Colors.red,
                          spots:convertToSliderFlSpot(TP9["Alpha"],_sliderValue) ,
                         
                          
                          isCurved: true,
                        
                          barWidth: 1,
                          isStrokeCapRound: false,
                         // belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                          
                        ),
                         LineChartBarData(
                          color: Colors.blue,
                          spots:convertToSliderFlSpot(TP9["Beta"],_sliderValue) ,
                         
                          isCurved: true,
                        
                          barWidth: 1,
                          isStrokeCapRound: false,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                        ),
                         LineChartBarData(
                          color: Colors.green,
                          spots:convertToSliderFlSpot(TP9["Delta"],_sliderValue) ,
                         
                          isCurved: true,
                        
                          barWidth: 1,
                          isStrokeCapRound: false,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                        ),
                         LineChartBarData(
                          color: Colors.black,
                          spots:convertToSliderFlSpot(TP9["Theta"],_sliderValue) ,
                          
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
                   GraphTitle(title: "TP10-Alpha",),
                 GraphSingleBand(color: Colors.red, flspot:convertToSliderFlSpot(TP10["Alpha"],_sliderValue ),),
                   GraphTitle(title: "TP10-Beta",),
                  GraphSingleBand(color: Colors.blue, flspot:convertToSliderFlSpot(TP10["Beta"],_sliderValue ),),
                   GraphTitle(title: "TP10-Theta",),
                  GraphSingleBand(color: Colors.green, flspot:convertToSliderFlSpot(TP10["Theta"],_sliderValue ),),
                   GraphTitle(title: "TP10-Delta",),
                 
                  GraphSingleBand(color: Colors.black, flspot:convertToSliderFlSpot(TP10["Delta"],_sliderValue ),),
                     GraphTitle(title: "TP10",),
                   Container(
                    height: 300,
                      width: 400,
                    child: LineChart(
                      
                      duration: Duration(seconds: 5),
                      LineChartData(
                         titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                            
                            axisNameWidget: Text("Amplitude"),
                            sideTitles: SideTitles(showTitles: true,reservedSize: 44), // Hides Y-axis labels
                          ),
                          bottomTitles: AxisTitles(
                            axisNameWidget: Text("Timepoints"),
                            sideTitles: SideTitles(showTitles: true,reservedSize: 30), // Hides X-axis labels
                          ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false), // Hides Top axis (optional)
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false), // Hides Right axis (optional)
                        ),
                      ),
                      borderData: FlBorderData(border: Border(bottom: BorderSide(),left: BorderSide())),
                      lineBarsData: [
                        LineChartBarData(
                          belowBarData: BarAreaData(show: false),
                          aboveBarData: BarAreaData(show: false),
                          color: Colors.red,
                          spots:convertToSliderFlSpot( TP10["Alpha"],_sliderValue) ,
                          
                          
                          isCurved: true,
                        
                          barWidth: 1,
                          isStrokeCapRound: false,
                         // belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                          
                        ),
                         LineChartBarData(
                          color: Colors.blue,
                          spots:convertToSliderFlSpot(TP10["Beta"],_sliderValue) ,
                          
                          isCurved: true,
                        
                          barWidth: 1,
                          isStrokeCapRound: false,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                        ),
                         LineChartBarData(
                          color: Colors.green,
                          spots:convertToSliderFlSpot(TP10["Delta"],_sliderValue) ,
                          
                          isCurved: true,
                        
                          barWidth: 1,
                          isStrokeCapRound: false,
                          belowBarData: BarAreaData(show: false),
                          dotData: FlDotData(show: false),
                        ),
                         LineChartBarData(
                          color: Colors.black,
                          spots:convertToSliderFlSpot(TP10["Theta"],_sliderValue) ,
                          
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
                  ],),
                ),
              ),
              

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