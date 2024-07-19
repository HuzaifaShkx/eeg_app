import 'dart:convert';


import 'package:http/http.dart' as http;

class APIHandler{
  String baseurl="http://127.0.0.1:5000/";

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

  
}