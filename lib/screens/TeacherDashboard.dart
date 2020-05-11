import 'package:ams/screens/TeacherLogin.dart';
import 'package:ams/services/TakeAttendance.dart';
import 'package:ams/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TeacherDashboard extends StatefulWidget {
  TeacherDashboard({this.teacherName, this.courses});
  String teacherName;
  var courses;
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  //load courses
  List<Widget> ListMyWidgets() {
    var arr = widget.courses;
    List<Widget> list = new List();
    arr.forEach((k, i) => list.add(new RaisedButton(
          onPressed: () async {
            TakeAttendance takeAttendance =
                new TakeAttendance(widget.teacherName, k);
            dynamic response = await takeAttendance.activateAttendanceLink();
            if (response["activated"] == 1) {
              Alert(
                context: context,
                type: AlertType.success,
                title: 'Link is Activated',
                desc:
                    'Attendance Link of $k is Activated. Please wait for student to mark their attendance',
                buttons: [
                  DialogButton(
                    child: Text(
                      "Close Link",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () async {
                      dynamic response = await takeAttendance.deactivateLink();
                      if (response["ok"] == 1 && response["n"] == 1) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SuccessAttendance();
                        }));
                      }
                    },
                    width: 120,
                  )
                ],
              ).show();
            } else {
              Alert(
                context: context,
                type: AlertType.error,
                title: 'Failed',
                desc: 'Unable to Activate Link',
                buttons: [
                  DialogButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    width: 120,
                  )
                ],
              ).show();
            }
          },
          color: kAppColor,
          child: Text(
            k,
            style: TextStyle(color: kAppTextColor, fontSize: 20),
          ),
        )));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("AMS"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.school)),
              Tab(icon: Icon(Icons.history)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Center(
                child: Text(widget.teacherName),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "Your Courses",
                    style: TextStyle(color: kAppColor, fontSize: 40),
                  ),
                  Container(
                    child: Column(
                      children: ListMyWidgets(),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Text("hello 3"),
            )
          ],
        ),
      ),
    );
  }
}

class SuccessAttendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('AMS'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Attendance Successful",
              style: TextStyle(color: kAppColor, fontSize: 40),
            ),
            Container(
              child: FlatButton(
                color: kAppColor,
                child: Text(
                  "Please Re-login",
                  style: TextStyle(color: kAppTextColor),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => TeacherLogin()),
                      ModalRoute.withName('/'));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
