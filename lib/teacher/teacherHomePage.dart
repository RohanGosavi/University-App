import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:bottom_navigation_demo/teacher/TAttendance.dart';
import 'package:bottom_navigation_demo/teacher/TLiveLec.dart';
import 'package:bottom_navigation_demo/teacher/TSchedule.dart';
import 'package:bottom_navigation_demo/teacher/TStudyMaterial.dart';
import 'package:bottom_navigation_demo/teacher/Tannouncement.dart';
import 'package:bottom_navigation_demo/teacher/Tassignments.dart';
import 'package:bottom_navigation_demo/teacher/Ttests.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




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



class TeacherHomePage extends StatefulWidget {
  @override
  _TeacherHomePageState createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {

  Teacherinfo obj =new Teacherinfo();
  static String myName;
  Teacherinfo detail;
  bool _loading;
  @override
  void initState(){
    super.initState();
    _loading = false;
    obj.getTeacherData().then((value) {
      detail=value;
      print(detail.name);
      myName = detail.name;
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
      body:_loading ? Container(
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
                                'Teacher ID :'+detail.teacherinfoId,
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
                              Navigator.push(context, ScaleRoute(page: Tannouncement()));
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
                                child: Center(child: Text("Create Announcement",style: TextStyle(fontSize: 20, color: color2),),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10
                            ),
                            child: GridView.count(
                              physics: ScrollPhysics(),
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              children: [
                                Card(
                                  color: color1,
                                  elevation: 0,
                                  child: InkWell(
                                    onTap:  (){
                                      Navigator.push(context, ScaleRoute(page: TAssignments()));
                                    } ,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                      Navigator.push(context, ScaleRoute(page: TTests()));
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.pending_actions,size: 70,color: color2),
                                        //Image(image: AssetImage('assets/sinhgad.png'),height: 100,),
                                        Text('Assign\nTests',style: TextStyle(
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
                                      Navigator.push(context, ScaleRoute(page: TStudyMaterial()));
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.book,size: 70,color: color2),
                                        //Image(image: AssetImage('assets/sinhgad.png'),height: 100,),
                                        Text('Provide\nStudy Material',style: TextStyle(
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
                                      Navigator.push(context, ScaleRoute(page: TLiveLec()));
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.video_collection,size: 70,color: color2),
                                        //Image(image: AssetImage('assets/sinhgad.png'),height: 100,),
                                        Text('Live Lectures\nLinks',style: TextStyle(
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
                                      Navigator.push(context, ScaleRoute(page: TSchedule()));
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                      Navigator.push(context, ScaleRoute(page: TAttendance()));
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.watch_later,size: 70,color: color2),
                                        //Image(image: AssetImage('assets/sinhgad.png'),height: 100,),
                                        Text('Take\nAttendance',
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
      ):Center(child: CircularProgressIndicator())
    );
  }
}
