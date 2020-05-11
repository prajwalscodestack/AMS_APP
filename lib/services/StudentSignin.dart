import 'package:ams/utilities/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentSignin {
  StudentSignin({this.studentName, this.rollNo, this.password});

  String studentName;
  String password;
  int rollNo;

  bool empty() {
    if (studentName.isEmpty && password.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future studentSignIn() async {
    if (empty()) {
      var url = "$API/login/student/$studentName/$rollNo/$password";
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
