import 'dart:convert';
import 'dart:io';


import 'package:eeg_app/Screens/doctorSignup.dart';
import 'package:eeg_app/model/user.dart';
import 'package:http/http.dart' as http;

class APIHandler{
  String baseurl="http://172.16.218.127:5000/";

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
    required User user
  })async
  {
    String url='${baseurl}DoctorSignup';
    http.MultipartRequest request=http.MultipartRequest('POST',Uri.parse(url));
    String user_json=jsonEncode(user.toJson());
    request.fields["user"]=user_json;
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
    String user_json=jsonEncode(user.toJson());
    request.fields["user"]=user_json;
     if (image_file != null) {
    var imgfile = await http.MultipartFile.fromPath('image', image_file.path);
    request.files.add(imgfile);
  }
     var response= await request.send();
     return http.Response.fromStream(response);

  }
  
}