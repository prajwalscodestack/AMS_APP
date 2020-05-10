import 'package:ams/services/SignUpService.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
class StudentRegister extends StatefulWidget {
  @override
  _StudentRegisterState createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
  String name;
  String rollNo;
  String pass;
  String textFirstLable="Student Name";
  String textrollLable="Roll No";

  void signUp()async {
    var rollno = int.parse(rollNo);
    SignUpService signUpService = new SignUpService(
        studentName: name, rollNo: rollno);
    var response = await signUpService.studentRegister();
    var msg = response["message"];
    if (response["registered"] == 1 && msg=='successfully registered') {
      Alert(
        context: context,
        type: AlertType.success,
        title: 'Success!',
        desc: '$msg',
        buttons: [
          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
    else{
      if (response["registered"] == 1 && msg == 'failed') {
        Alert(
          context: context,
          type: AlertType.info,
          title: 'Already Registered!',
          desc: 'Please login',
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
      else{
        Alert(
          context: context,
          type: AlertType.warning,
          title: 'Failed!',
          desc: '$msg',
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
                      'Registration',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value){
                     setState(() {
                       name=value;
                     });

                    },
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
                        labelText: '$textFirstLable',
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,

                    onChanged: (value){
                      setState(() {
                        rollNo=value;
                      });
                    },
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
                      labelText: '$textrollLable',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    onChanged: (value){
                     setState(() {
                       pass=value;
                     });
                    },
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
                      labelText: 'password',
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
                      child: Text('Register'),
                      onPressed: () {
                          signUp();
                      },
                    )),

              ],
            )
        ),
      );
  }
}
