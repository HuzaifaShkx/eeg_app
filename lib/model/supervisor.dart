import 'package:eeg_app/model/user.dart';

class Supervisor extends User {
  int? doctorId; // Supervisor-specific field
  String? imgpath;  // Supervisor-specific field

  Supervisor({
    required String contact,
    required String dob,
    required String gender,
    required String email,
    required String name,
    required String password,
    required String role,
    required this.doctorId,
   this.imgpath,
  }) : super(
          contact: contact,
          dob: dob,
          gender: gender,
          email: email,
          name: name,
          password: password,
          role: role,
        );

  Supervisor.fromJson(Map<String, dynamic> json)
      : doctorId = json['doctor_id'],
        imgpath = json['imgpath'],
        super.fromJson(json); // Initialize User fields from JSON

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson(); // Get User fields as a JSON map
    data['doctor_id'] = doctorId; // Add Supervisor-specific fields
    data['imgpath'] = imgpath;
    return data;
  }
}
