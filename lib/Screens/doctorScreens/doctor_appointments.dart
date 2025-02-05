import 'package:eeg_app/API/APIHandler.dart';
import 'package:eeg_app/Screens/doctorScreens/patient_detail.dart';
import 'package:eeg_app/model/doctor.dart';
import 'package:flutter/material.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  final Doctor doctor;
  const DoctorAppointmentScreen({super.key, required this.doctor});

  @override
  State<DoctorAppointmentScreen> createState() => _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  List<dynamic> _patients = [];
  Map<int, String> _appointmentDates = {}; // Stores appointment dates for each patient
  bool _isLoading = true; // Tracks if data is being loaded

  @override
  void initState() {
    super.initState();
    _getPatientsAndAppointments();
  }

  /// Fetch patients and their appointment dates before updating UI
  Future<void> _getPatientsAndAppointments() async {
    _patients = await APIHandler().GetNewPatients(widget.doctor.id!);

    for (var p in _patients) {
      int patientId = p['id'] != null ? int.parse(p['id']) : 0;
      int doctorId = widget.doctor.id ?? 0;

      var data = await APIHandler().getAppointmentDateTime(doctorId, patientId);
      
      if (data != null && data['date'] != null) {
        DateTime appointmentDate = DateTime.parse(data['date']);
        _appointmentDates[patientId] = "${appointmentDate.day}-${appointmentDate.month}-${appointmentDate.year}";
      } else {
        _appointmentDates[patientId] = "No date available";
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Appointments")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text("Upcoming Appointments"),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _patients.length,
                    itemBuilder: (context, index) {
                      dynamic p = _patients[index];
                      int patientId = p['id'] != null ? int.parse(p['id']) : 0;
                      int doctorId = widget.doctor.id ?? 0;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: p["imgpath"] != null
                                            ? NetworkImage("${APIHandler().baseurl}/image/${p["imgpath"]}") as ImageProvider
                                            : const AssetImage('assets/images/person.png'),
                                      ),
                                    ),
                                    Text("${p["name"]}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      height: 50,
                                      width: 130,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Schedule Meeting on ${_appointmentDates[patientId] ?? 'Loading...'}",
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => PatientDetailScreen(
                                            id: patientId,
                                            doctorid: doctorId,
                                          ),
                                        ));
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(6)),
                                          color: Color(0xFF7C0909),
                                        ),
                                        height: 30,
                                        width: 130,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "View Details",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
