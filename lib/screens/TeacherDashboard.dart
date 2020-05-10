import 'package:ams/utilities/constant.dart';
import 'package:flutter/material.dart';
class TeacherDashboard extends StatefulWidget {
  TeacherDashboard({this.teacherName,this.courses});
  String teacherName;
  var courses;
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {

  List<Widget> ListMyWidgets() {
    var arr=widget.courses;
    List<Widget> list = new List();
    arr.forEach((k,i)=>
        list.add(new RaisedButton(
        onPressed: (){},
          color: kAppColor,
          child: Text(k,style: TextStyle(color: kAppTextColor,fontSize: 20),),
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
              child:Column(
              children: <Widget>[
                Text("Your Courses",style: TextStyle(
                  color: kAppColor,
                  fontSize: 40
                ),),
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
