import 'dart:convert';
import 'dart:js_interop';

import 'package:http/http.dart' as http;

class APIHandler{
  String baseurl="http://127.0.0.1:5000/";

  Future<void> login(String email,String password) async {
    String url = "${baseurl}login";
    http.MultipartRequest req=http.MultipartRequest('GET',Uri.parse(url)); 
    req.fields['id'] = email;
    req.fields['password'] = password;

    var response=await req.send();
    if(response.statusCode==200){
      print("Login Successful!");
    }
  } 

  
}