import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ams/utilities/constant.dart';
class ActivateLink{

  ActivateLink(this.studentName,this.rollNo);
  String studentName;
  int rollNo;
  Future<dynamic>getActivatedLink()async{
    var url="$API/mark/student/fetchLink/$studentName/$rollNo";
    print(url);
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      }
    }
    catch(e){
      return null;
    }
//    else{
//      var data=jsonDecode(response.body);
//      return data;
//    }
  }



}