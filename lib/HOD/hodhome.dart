import 'package:bottom_navigation_demo/teacher/teacherHomePage.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import 'hannounce.dart';
import 'hschedule.dart';
import 'hstudent.dart';
import 'hsubject.dart';
import 'hteacher.dart';

class HODhome extends StatefulWidget {
  @override
  _HODhomeState createState() => _HODhomeState();
}

class _HODhomeState extends State<HODhome> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height:_height/3.8,
              width: _width,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.menu_rounded),
                      color:color2,
                      iconSize: 30,
                      onPressed: (){

                      },),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        Icons.person_rounded,
                        size: 100,
                        color: color2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      // SizedBox(
                      //   width: 30,
                      // ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Admin",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                color: color2,
                                fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                boxShadow: shadows,
                color: color1,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100)),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Expanded(
              child: SingleChildScrollView(
                //physics: BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: 20,
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, ScaleRoute(page: Hannouncement()));
                        },
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height/5,
                            width: MediaQuery.of(context).size.width-28,
                            decoration: BoxDecoration(
                                boxShadow: shadows,
                                color: color1,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Center(child: Text("Create Announcement",style: TextStyle(fontSize: 20, color: color2)),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, ScaleRoute(page: Hstudent()));
                        },
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height/5,
                            width: MediaQuery.of(context).size.width-28,
                            decoration: BoxDecoration(
                                boxShadow: shadows,
                                color: color1,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Center(child: Text("Add New Student",style: TextStyle(fontSize: 20, color: color2)),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, ScaleRoute(page: Hteacher()));
                        },
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height/5,
                            width: MediaQuery.of(context).size.width-28,
                            decoration: BoxDecoration(
                                boxShadow: shadows,
                                color: color1,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Center(child: Text("Add New Teacher",style: TextStyle(fontSize: 20, color: color2)),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, ScaleRoute(page: Hsubject()));
                        },
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height/5,
                            width: MediaQuery.of(context).size.width-28,
                            decoration: BoxDecoration(
                                boxShadow: shadows,
                                color: color1,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Center(child: Text("Add subject",style: TextStyle(fontSize: 20, color: color2)),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, ScaleRoute(page: HSchedule()));
                        },
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height/5,
                            width: MediaQuery.of(context).size.width-28,
                            decoration: BoxDecoration(
                                boxShadow: shadows,
                                color: color1,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Center(child: Text("Modify Schedule",style: TextStyle(fontSize: 20, color: color2)),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
