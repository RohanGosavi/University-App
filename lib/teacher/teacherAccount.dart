import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:bottom_navigation_demo/student/idpage.dart';
import 'package:bottom_navigation_demo/teacher/allstudents.dart';
import 'package:bottom_navigation_demo/teacher/mySub.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';

class TeacherAccount extends StatefulWidget {
  @override
  _TeacherAccountState createState() => _TeacherAccountState();
}

class _TeacherAccountState extends State<TeacherAccount> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(Icons.account_circle,size:70,),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Teacherinfo.tname!=null ? Teacherinfo.tname : "-",style: TextStyle(fontSize: 20),),
                  Text(Teacherinfo.tname!=null ? 'Department of IT': "-",style: TextStyle(fontSize: 15),),
                ],
              ),
            ],
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
                  Text('Student List',style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
            onTap: (){
              Navigator.push(context, ScaleRoute(page: AllStudents()));
            },
          ),
          // Text('4.8',style: TextStyle(fontSize: 20),),
          // //SizedBox(height: 5,),
          // Text('Ratings'),
          SizedBox(
            height: 25,
          ),
          // Container(
          //   height: 70,
          //   width:90,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     boxShadow: shadows,
          //     color: color1,
          //     //borderRadius: BorderRadius.all(Radius.circular(20)),
          //   ),
          //   child: Center(child: IconButton(icon: Icon(Icons.call,)),),
          // ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, ScaleRoute(page: MySub()));
                },
                child: Container(
                  height: 100,
                  width:120,
                  decoration: BoxDecoration(
                    boxShadow: shadows,
                    color: color1,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(child: Text('My Subjects')),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, ScaleRoute(page: IDPage()));
                },
                child: Container(
                  height: 100,
                  width:120,
                  decoration: BoxDecoration(
                    boxShadow: shadows,
                    color: color1,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(child: Text('ID')),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Container(
          //       height: 100,
          //       width:120,
          //       decoration: BoxDecoration(
          //         boxShadow: shadows,
          //         color: color1,
          //         borderRadius: BorderRadius.all(Radius.circular(20)),
          //       ),
          //       child: Center(child: Text('My Teachers')),
          //     ),
          //     Container(
          //       height: 100,
          //       width:120,
          //       decoration: BoxDecoration(
          //         boxShadow: shadows,
          //         color: color1,
          //         borderRadius: BorderRadius.all(Radius.circular(20)),
          //       ),
          //       child: Center(child: Text('Leaderboard')),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 20,
          // ),
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
