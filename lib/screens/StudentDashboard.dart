import 'package:ams/screens/StudentLogin.dart';
import 'package:ams/screens/homeScreen.dart';
import 'package:ams/services/ActivateLink.dart';
import 'package:ams/services/MarkAttendance.dart';
import 'package:flutter/material.dart';
import 'package:ams/utilities/constant.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class StudentDashboard extends StatefulWidget {
  StudentDashboard(this.studentName,this.courses,this.rollNo,this.password);
  String studentName;
  var courses;
  int rollNo;
  String password;
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
int status;
var link;
var coursename="";
void getLink()async{
   status=0;
  var rollno=widget.rollNo;
  var sname=widget.studentName;
  ActivateLink markAttendance=new ActivateLink(sname, rollno);
  dynamic response=await markAttendance.getActivatedLink();
//  print(response);
  if(response!=null) {
    status = response["activated"];
    coursename = response["name"];
    link = response["link"];
  }

//  if(status==1) {
//    MarkAttendance markAttendance=new MarkAttendance(link, rollno, sname, coursename);
//   var response=await markAttendance.markAttendance();
//   print(response);
//  }
  if(status==1){
    Alert(
      context: context,
      type: AlertType.success,
      title: 'Mark Attendance',
      desc: 'Attendance Link of $coursename is Activated',
      buttons: [
        DialogButton(
          child: Text(
            "Mark",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: (){
            mark();
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (BuildContext context) => SuccessScreen()),
                ModalRoute.withName('/'));
          },
          width: 120,
        )
      ],
    ).show();
  }
  else
    {
      Alert(
        context: context,
        type: AlertType.error,
        title: 'Sorry',
        desc: 'Link is Not Activated',
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
void mark()async{
  var rollno=widget.rollNo;
  var sname=widget.studentName;
  if(status==1) {
    MarkAttendance markAttendance=new MarkAttendance(link, rollno, sname, coursename);
    var response=await markAttendance.markAttendance();
    print(response);
  }
}


//load buttons
  List<Widget> ListMyWidgets() {
    var arr=widget.courses;
    List<Widget> list = new List();
    arr.forEach((k,i)=>
        list.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: new FlatButton(
            onPressed: (){},
            color: kAppColor,
            child: Text(k,style: TextStyle(color: kAppTextColor,fontSize: 20),),
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
              Tab(icon: Icon(Icons.home),text: "Home",),
              Tab(icon: Icon(Icons.school),text:"Mark"),
              Tab(icon: Icon(Icons.history),text: "courses",)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.person_outline,size: 150,),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              child:Center(
                child: FlatButton(
                  color: kAppColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Mark Attendance",
                    style: TextStyle(color: kAppTextColor,fontSize: 30,),
                    ),
                  ),
                  onPressed: (){
                    getLink();
                  },
                ),
              )
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "Enrolled Courses",
                    style: TextStyle(color: kAppColor,fontSize: 40),
                  ),
                  Container(
                    child: Column(
                      children: ListMyWidgets(),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
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
            Text("Attendance Is Marked Successfully",style: TextStyle(
              color: kAppColor,
              fontSize: 40
            ),),
            Container(
              child: FlatButton(
                color: kAppColor,
                child: Text("login",style: TextStyle(color: kAppTextColor),),
                onPressed: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                    return HomeScreen();
//                  }));
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) => StudentLogin()),
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
