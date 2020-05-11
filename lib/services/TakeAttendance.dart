import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:ams/utilities/constant.dart';

class TakeAttendance {
  TakeAttendance(this.teacherName, this.courseName);

  String teacherName;
  var courseName;

  Future<dynamic> activateAttendanceLink() async {
    var url = "$API/attendance/teacher/markAttendance/$teacherName/$courseName";
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = response.body;
        return jsonDecode(data);
      } else {
        var data = response.body;
        return jsonDecode(data);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> deactivateLink() async {
    var url =
        "$API/attendance/teacher/closeAttendance/$teacherName/$courseName";
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var data = response.body;
        return jsonDecode(data);
      } else {
        var data = response.body;
        return jsonDecode(data);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
