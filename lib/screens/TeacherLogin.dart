import 'dart:convert';

import 'package:ams/screens/TeacherDashboard.dart';
import 'package:ams/services/TeacherSignin.dart';
import 'package:ams/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TeacherLogin extends StatefulWidget {
  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  String name;
  String password;

  final String textLable = "Name";
  final String mainLable = "Teacher Login";

  void teacherSignin() async {
    name = name.replaceAll(RegExp(' +'), '%20');
    print(password);
    TeacherSignin signIn =
        new TeacherSignin(teacherName: name, password: password);
    var response = await signIn.teacherSignIn();
    var teachername = response["teacher"]["name"];
    var courses = response["teacher"]["coursesTaken"];
    if (response["found"] == 1) {
      print("logged in");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return TeacherDashboard(
          teacherName: teachername,
          courses: courses,
        );
      }));
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: 'Failed',
        desc: 'No teacher Found',
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AMS"),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '$mainLable',
                    style: TextStyle(
                        color: kAppColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: kAppColor),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: '$textLable',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: kAppColor),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: kAppColor)),
                    labelText: 'Password',
                  ),
                ),
              ),
//
              SizedBox(height: 15),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: kAppTextColor,
                    color: kAppColor,
                    child: Text('Login'),
                    onPressed: () {
                      teacherSignin();
                    },
                  )),
            ],
          )),
    );
  }
}
