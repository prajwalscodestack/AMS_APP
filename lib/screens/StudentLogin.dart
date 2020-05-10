import 'package:ams/screens/StudentDashboard.dart';
import 'package:ams/services/StudentSignin.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class StudentLogin extends StatefulWidget {
  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  String textLable = "StudentName";
  final String mainLable = "Student Login";

  void studentSignin() async {
    var rollno = int.parse(rollController.text);
    StudentSignin studentSignin = new StudentSignin(
        studentName: nameController.text,
        rollNo: rollno,
        password: passwordController.text);
    var response = await studentSignin.studentSignIn();
    var studentName = response["student"]["name"];
    var courses = response["student"]["courses"];
    var roll = response["student"]["rollno"];
    print(response["found"]);
    if (response["found"] == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return StudentDashboard(studentName,courses,roll,passwordController.text);
      }));
    }
    else  {
      Alert(
        context: context,
        type: AlertType.error,
        title: 'Failed',
        desc: 'No Student Found',
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
      appBar: AppBar(title: Text("AMS"),),
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
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.black
                    ),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    labelText: '$textLable',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: rollController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.black
                    ),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
                    labelText: 'roll no',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.black
                    ),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        )
                    ),
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
                    textColor: Colors.white,
                    color: Colors.black,
                    child: Text('Login'),
                    onPressed: () {
                      studentSignin();
                    },
                  )),

            ],
          )
      ),
    );
  }
}