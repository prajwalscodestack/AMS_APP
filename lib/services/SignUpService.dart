import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ams/utilities/constant.dart';
import 'dart:convert';
class SignUpService
{

  SignUpService({this.studentName,this.rollNo});
  String studentName;
  int rollNo;
   Future studentRegister()async{
    http.Response response=await http.get("$API/register/registerStudent/$studentName/$rollNo");
    if(response.statusCode==200){
      String data=response.body;
      return jsonDecode(data);
    }
    else{
      String data=response.body;
      return jsonDecode(data);
    }
  }
}