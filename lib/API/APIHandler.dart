import 'dart:convert';
import 'dart:io';


import 'package:eeg_app/Screens/SignupScreens/doctorSignup.dart';
import 'package:eeg_app/Screens/SignupScreens/patientSignup.dart';
import 'package:eeg_app/Screens/doctorScreens/add_prescribtion.dart';
import 'package:eeg_app/model/doctor.dart';
import 'package:eeg_app/model/patient.dart';
import 'package:eeg_app/model/supervisor.dart';
import 'package:eeg_app/model/user.dart';
import 'package:http/http.dart' as http;

class APIHandler{
  String baseurl="http://192.168.0.106:5000/";

  Future<String> login(String email,String password) async {
    String url = "${baseurl}login";
   var res=await http.post(Uri.parse(url),
   headers:  {'Content-Type': 'application/json'},
   body: jsonEncode({'id':email,'password':password}),
   );
    if(res.statusCode==200){
      var result=jsonDecode(res.body);
      return result['role'];
      //return "Login Successful!";
    }
    else{
      return "Login Failed!";
    }
  } 
Future<http.Response> DoctorSignup({
   File? image_file,
    required Doctor user
  })async
  {
    String url='${baseurl}DoctorSignup';
    http.MultipartRequest request=http.MultipartRequest('POST',Uri.parse(url));
    String userJson=jsonEncode(user.toJson());
    print(userJson);
    request.fields["user"]=userJson;
     if (image_file != null) {
    var imgfile = await http.MultipartFile.fromPath('image', image_file.path);
    request.files.add(imgfile);
  }
     var response= await request.send();
     return http.Response.fromStream(response);

  }

  Future<http.Response> SupervisorSignup({
   File? image_file,
    required User user
  })async
  {
    String url='${baseurl}SupervisorSignup';
    http.MultipartRequest request=http.MultipartRequest('POST',Uri.parse(url));
    String userJson=jsonEncode(user.toJson());
    request.fields["user"]=userJson;
     if (image_file != null) {
    var imgfile = await http.MultipartFile.fromPath('image', image_file.path);
    request.files.add(imgfile);
  }
     var response= await request.send();
     return http.Response.fromStream(response);

  }
  
  Future<http.Response> PatientSignUp({
   File? image_file,
    required Patient user
  })async
  {
    String url='${baseurl}PatientSignup';
    http.MultipartRequest request=http.MultipartRequest('POST',Uri.parse(url));
    String userJson=jsonEncode(user.toJson());
    request.fields["user"]=userJson;
     if (image_file != null) {
    var imgfile = await http.MultipartFile.fromPath('image', image_file.path);
    request.files.add(imgfile);
  }
     var response= await request.send();
     return http.Response.fromStream(response);

  }

  Future<List<dynamic>> AllDoctors() async {
    String url = "${baseurl}getAllDoctors";
    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((data) => Doctor.fromJson(data)).toList();
  }

  Future<Patient> GetPatient(int id) async {
    String url = "${baseurl}getPatientById/$id";
    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body);
    return Patient.fromJson(jsonResponse);
  }

  Future<List<dynamic>> GetRegisteredPatients(int id) async {
    String url = "${baseurl}getRegisteredPatient/$id";
    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((data) => Patient.fromJson(data)).toList();
  }

  // Future<List<dynamic>> GetNewPatients(int id) async {
  //   String url = "${baseurl}getNewPatient/$id";
  //   var response = await http.get(Uri.parse(url));
  //   var jsonResponse = jsonDecode(response.body);
  //   return jsonResponse.map((data) => Patient.fromJson(data)).toList(); 
  // }

  Future<List<dynamic>> GetNewPatients(int id) async {
  String url = "${baseurl}getNewPatient/$id";
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Decode the JSON response into a List of dynamic objects
    List<dynamic> jsonResponse = jsonDecode(response.body);

    // Return the decoded list directly without mapping it to a model
    return jsonResponse;
  } else {
    throw Exception('Failed to load new patients');
  }
}
  Future<Patient> GetPatientByEmail(String email) async{
    String url = "${baseurl}getPatientByEmail/$email";
    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body);
    return Patient.fromJson(jsonResponse);
  }
  
  Future<Doctor> GetDoctorByEmail(String email) async{
    String url = "${baseurl}getDoctorByEmail/$email";
    var response = await http.get(Uri.parse(url));
    var jsonResponse = jsonDecode(response.body);
    return Doctor.fromJson(jsonResponse);
  }

Future<Doctor> GetDoctorById(int id) async {
  String url = "${baseurl}getDoctorById/$id";
  var response = await http.get(Uri.parse(url));
  var jsonResponse = jsonDecode(response.body);
  return Doctor.fromJson(jsonResponse);
}
Future<Supervisor> GetSupervisorById(int id) async {
  String url = "${baseurl}getSupervisorById/$id";
  var response = await http.get(Uri.parse(url));
  var jsonResponse = jsonDecode(response.body);
  return Supervisor.fromJson(jsonResponse);
}
Future<Supervisor> GetSupervisorByEmail(String email) async {
  String url = "${baseurl}getSupervisorByEmail/$email";
  var response = await http.get(Uri.parse(url));
  var jsonResponse = jsonDecode(response.body);
  return Supervisor.fromJson(jsonResponse);
}
Future<List<dynamic>> GetPatientPrescribtion(int id) async {
  String url = "${baseurl}getPatientPrescription/$id";
  var response = await http.get(Uri.parse(url));
  var jsonResponse = jsonDecode(response.body);
  return jsonResponse.map((data) => data).toList();
}
Future<http.Response> AddAppointment(String date,String time,int doctorid,int patientid) async {
 
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['status'] = false;
    data['doctorid'] = doctorid;
    data['patientid'] = patientid;
    
  String userJson=jsonEncode(data);
  
  String url='${baseurl}addAppointment';
  var response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},  // Set content type to JSON
    body: userJson,  // Send the JSON directly in the body
  );
  return response;
  
}

Future<http.Response> UpdateAppointment(int id, DateTime date, DateTime time, int doctorid, int patientid) async {
 
    final Map<String, dynamic> data = <String, dynamic>{};
   
    data['date'] = date;
    data['time'] = time;
    data['status'] = false;
    data['doctorid'] = doctorid;
    data['patientid'] = patientid;
    
  String userJson=jsonEncode(data);
  
  String url='${baseurl}addAppointment';
  var response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},  // Set content type to JSON
    body: userJson,  // Send the JSON directly in the body
  );
  return response;
}

Future<http.Response> AddPrescribtion(int appId,String prescription) async {
  
  final Map<String, dynamic> data = <String, dynamic>{};
   
    data['prescribtion'] = prescription;
    data['appId'] = appId;
    data['appStatus'] = true;
   
    
  String json=jsonEncode(data);
  
  String url='${baseurl}prescribe';
  var response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},  // Set content type to JSON
    body: json,  // Send the JSON directly in the body
  );
  return response;
}
Future<List<dynamic>> GetEEGData() async {
  String url = "${baseurl}eeg_bands";
  var response = await http.get(Uri.parse(url));
 if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse is Map<String, dynamic>) {
      // Transform the Map to a List of its values
      return jsonResponse.values.toList();
    } else {
      throw Exception("Unexpected response format: Expected a Map");
    }
  } else {
    throw Exception("Failed to load data, status code: ${response.statusCode}");
  }
}

Future<List<dynamic>> getTimeSlots(String date, String doctorId) async {
  String url = "${baseurl}getTimeSlots";
  
  // Sending the POST request
  var response = await http.post(
    Uri.parse(url),
    body: {
     
      'date': date,
      'doctor_id': doctorId,
    },
  );

  // Decode the response
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse; // Return the decoded JSON directly
  } else if (response.statusCode == 405) {
    throw Exception("Slots not found");
  } else {
    throw Exception("Failed to fetch slots: ${response.body}");
  }
}

}

