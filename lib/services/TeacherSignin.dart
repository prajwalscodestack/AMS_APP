import 'package:ams/utilities/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeacherSignin {
  TeacherSignin({this.teacherName, this.password});

  String teacherName;
  String password;

  bool empty() {
    if (teacherName.isEmpty && password.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future teacherSignIn() async {
    if (empty()) {
      var url = "$API/login/teacher/$teacherName/$password";
      print(url);
      http.Response response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        String data = response.body;
        return jsonDecode(data);
      }
    }
  }
}
