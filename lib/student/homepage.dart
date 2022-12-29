import 'dart:ui';
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:bottom_navigation_demo/student/announcements.dart';
import 'package:bottom_navigation_demo/student/assignment.dart';
import 'package:bottom_navigation_demo/student/attendance.dart';
import 'package:bottom_navigation_demo/student/live_lecture.dart';
import 'package:bottom_navigation_demo/student/schedule.dart';
import 'package:bottom_navigation_demo/student/studyMaterial.dart';
import 'package:bottom_navigation_demo/student/test.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        ),
  );
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Studentinfo obj = new Studentinfo();
  Studentinfo detail;
  bool _loading;
  @override
  void initState(){
    super.initState();
    _loading = false;
    obj.getStudentData().then((value) {
      detail=value;
      print(detail.name);
      setState(() {
        _loading=true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _loading ?Container(
        color: color,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Container(
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
                                detail.name,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: color2,
                                    fontSize: 25),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                detail.studentinfoId+"/ "+detail.uniroll+"\n"+detail.year,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w300,
                                    color: color2,
                                    fontSize: 15),
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
                  height: 10,
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
                          Announcement(),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10
                            ),
                            child: GridView.count(
                              physics: ScrollPhysics(),
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              children: [
                                Card(
                                  color: color1,
                                  elevation: 0,
                                  child: InkWell(
                                    onTap:  (){
                                      Navigator.push(context, ScaleRoute(page: Assign()));
                                    } ,
                                    child: Column(
                                      children: [
                                        Icon(Icons.article,size: 70,color: color2,),
                                        //Image(image: AssetImage('assets/sinhgad.png'),height: 100,),
                                        Text('Assignments',style: TextStyle(
                                          fontSize: 13,
                                            color: color2
                                        ),),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  color: color1,
                                  elevation: 0,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, ScaleRoute(page: Test()));
                                    },
                                    child: Column(
                                      children: [
                                        Icon(Icons.pending_actions,size: 70,color: color2),
                                        //Image(image: AssetImage('assets/sinhgad.png'),height: 100,),
                                        Text('Tests',style: TextStyle(
                                            fontSize: 13,
                                            color: color2
                                        ),),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  color: color1,
                                  elevation: 0,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, ScaleRoute(page: StudyMaterial()));
                                    },
                                    child: Column(
                                      children: [
                                        Icon(Icons.book,size: 70,color: color2),
                                        //Image(image: AssetImage('assets/sinhgad.png'),height: 100,),
                                        Text('Study Material',style: TextStyle(
                                          fontSize: 13,
                                            color: color2
                                        ),),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  color: color1,
                                  elevation: 0,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, ScaleRoute(page: LiveLec()));
                                    },
                                    child: Column(
                                      children: [
                                        Icon(Icons.video_collection,size: 70,color: color2),
                                        //Image(image: AssetImage('assets/sinhgad.png'),height: 100,),
                                        Text('Live Lectures',style: TextStyle(
                                            fontSize: 13,
                                            color: color2
                                        ),),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  color: color1,
                                  elevation: 0,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, ScaleRoute(page: Schedule()));
                                    },
                                    child: Column(
                                      children: [
                                        Icon(Icons.schedule,size: 70,color: color2),
                                        //Image(image: AssetImage('assets/sinhgad.png'),height: 100,),
                                        Text('Schedule',style: TextStyle(
                                            fontSize: 13,
                                            color: color2
                                        ),),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  color: color1,
                                  elevation: 0,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, ScaleRoute(page: Attendance()));
                                    },
                                    child: Column(
                                      children: [
                                        Icon(Icons.watch_later,size: 70,color: color2),
                                        //Image(image: AssetImage('assets/sinhgad.png'),height: 100,),
                                        Text('Attendance',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: color2
                                        ),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ): Center(child: CircularProgressIndicator())
    );
  }
}

List<BoxShadow> shadows = [
  BoxShadow(
    color: Colors.white.withOpacity(0.5),
    spreadRadius: -5,
    offset: Offset(-5,-5),
    blurRadius: 30
  ),
  BoxShadow(
    color: Colors.blue[900].withOpacity(.2),
    spreadRadius: 2,
    offset: Offset(7,7),
    blurRadius: 20
  )
];
Color color = Color(0xFFCADCED);
Color color2 = Color(0xFF000000);
Color color1 = Color(0xFFFFFFFF);

