// import 'package:eeg_app/API/APIHandler.dart';
// import 'package:eeg_app/Custom%20Widget/button1.dart';
// import 'package:eeg_app/Screens/supervisorDash.dart';
// import 'package:eeg_app/Screens/supervisor_upload_screen.dart';
// import 'package:eeg_app/model/supervisor.dart';
// import 'package:flutter/material.dart';

// class SupervisorHome extends StatefulWidget {
//   final Supervisor supervisor;
//   const SupervisorHome( {super.key, required this.supervisor});

//   @override
//   State<SupervisorHome> createState() => _SupervisorHomeState();
// }

// class _SupervisorHomeState extends State<SupervisorHome> {
//   // Supervisor ?_supervisor;
//   // Future<void> fetchSupervisorData() async {
//   //   // Fetch data from API
//   //   _supervisor = await APIHandler().GetSupervisorById(1);
//   //   setState(() {});
//   // }
//   initState() {
//     super.initState();

//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Supervisor Home'),
//       ),
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CircleAvatar(radius: 100,
//             backgroundImage: NetworkImage(
//                                       "${APIHandler().baseurl}/image/${widget.supervisor.imgpath}")
//                                   ,
//             ),
//             Text("Hello!"),
//             Text("${widget.supervisor.name}"),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Button1(text: "Manage Channels", onTap: (){
//                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => SupervisorDash()));
//               }),
//             ),
//             Button1(text: "Upload Files", onTap: (){
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) => SupervisorUploadScreen()));
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }