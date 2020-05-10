import 'package:ams/screens/StudentLogin.dart';
import 'package:ams/screens/StudentRegister.dart';
import 'package:ams/screens/TeacherLogin.dart';
import 'package:ams/utilities/constant.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      "AMS",
                      style: TextStyle(fontSize: 50,fontWeight: FontWeight.w500,color: kAppColor),
                    ),
                  ),
                ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonTheme(
                buttonColor: kAppColor,
                minWidth: 230.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return TeacherLogin();
                    }));
                  },
                  child: Text("Teacher Login",
                    style: TextStyle(
                        fontSize: 22,
                      color: kAppTextColor,
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonTheme(
                minWidth: 231.0,
                height: 50.0,
                buttonColor: kAppColor,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return StudentLogin();
                    }));
                  },
                  child: Text("Student Login", style: TextStyle(
                      fontSize: 22,
                      color: kAppTextColor
                  ),),
                ),
            ),
          ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    buttonColor: kAppColor,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return StudentRegister();
                        }));
                      },
                      child: Text("Student Registration",
                      style: TextStyle(
                        fontSize: 22,
                          color: kAppTextColor
                      ),
                      ),
                    ),
                  ),
                )
              ],
    ),
          ),
        )
    );
  }
}
