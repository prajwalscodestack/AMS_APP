import 'package:ams/utilities/constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MarkAttendance {
  MarkAttendance(this.link, this.rollNo, this.studentName, this.course);
  String link;
  String course;
  String studentName;
  int rollNo;
  Future markAttendance() async {
    var url = "$API/mark/student/$link/$studentName/$rollNo/$course";
    print(url);
    http.Response response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      var data = response.body;
      return jsonDecode(data);
    }
  }
}
