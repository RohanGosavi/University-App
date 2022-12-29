import 'package:bottom_navigation_demo/HOD/subjects.dart';
import 'package:bottom_navigation_demo/login.dart';
import 'package:bottom_navigation_demo/student/allteachers.dart';
import 'package:bottom_navigation_demo/teacher/allstudents.dart';
import 'package:bottom_navigation_demo/teacher/teacherHomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HODAccount extends StatefulWidget {
  const HODAccount({Key key}) : super(key: key);

  @override
  _HODAccountState createState() => _HODAccountState();
}

class _HODAccountState extends State<HODAccount> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle,size: 50,),
              SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ADMIN",style: TextStyle(fontSize: 20),),
                  Text('Department of IT',style: TextStyle(fontSize: 15),),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 70,
          ),
          GestureDetector(
            child: Container(
              height: 100,
              width:MediaQuery.of(context).size.width-100,
              decoration: BoxDecoration(
                boxShadow: shadows,
                color: color1,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Student List',style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
            onTap: (){
              Navigator.push(context, ScaleRoute(page: AllStudents()));
            },
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            child: Container(
              height: 100,
              width:MediaQuery.of(context).size.width-100,
              decoration: BoxDecoration(
                boxShadow: shadows,
                color: color1,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Teacher List',style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
            onTap: (){
              Navigator.push(context, ScaleRoute(page: AllTeachers()));
            },
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            child: Container(
              height: 100,
              width:MediaQuery.of(context).size.width-100,
              decoration: BoxDecoration(
                boxShadow: shadows,
                color: color1,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Subjects List',style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
            onTap: (){
              Navigator.push(context, ScaleRoute(page: AllSubjecth()));
            },
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.all(32),
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: color2,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Center(child: Text('Logout',style: TextStyle(color: color1,fontSize: 20),)),
            ),
            onTap: ()async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
              prefs.remove('pass');
              Navigator.pushReplacement(context, ScaleRoute(page: LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
