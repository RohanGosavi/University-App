import 'dart:ui';
import 'package:bottom_navigation_demo/backend/scheduleback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TSchedule extends StatefulWidget {
  @override
  _TScheduleState createState() => _TScheduleState();
}

class _TScheduleState extends State<TSchedule> {

  String _year;
  // List<List<TimeTable>> _tb = _timeTableFE;
  var _index = DateTime.now().weekday;
  var _day = DateFormat('EEEE').format(DateTime.now());
  ScheduleData obj = new ScheduleData();
  List<ScheduleData> _list;
  bool _loading;

  @override
  void initState(){
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    if(_index==7){_index= 0; }
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children  :[ Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/1.25,
              child: Column(
                children: [
                  DropdownButton(
                    value: _year,
                    hint: Text('Select class'),
                    items: [
                      DropdownMenuItem(child: Text('FE'),value: "FE",),
                      DropdownMenuItem(child: Text('SE'),value: "SE",),
                      DropdownMenuItem(child: Text('TE'),value: "TE",),
                      DropdownMenuItem(child: Text('BE'),value: "BE",),
                    ],
                    onChanged: (value){
                      setState(() {
                        _year = value;
                        obj.getData(_year,_day).then((value){
                          setState(() {
                            _list=value;
                            _loading=true;
                          });
                        });
                        // switch(value){
                        //   case 0 : _tb = _timeTableFE; break;
                        //   case 1 : _tb = _timeTableSE; break;
                        //   case 2 : _tb = _timeTableTE; break;
                        //   case 3 : _tb = _timeTableBE; break;
                        // }
                      });
                    },
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = 0;
                            _loading=false;
                            obj.getData(_year,"Sunday").then((value){
                              setState(() {
                                _list=value;
                                _loading=true;
                              });
                            });
                          });
                        },
                        child: Container(
                          decoration:
                          _index ==0 ? _boxDecoration1 : _boxDecoration2,
                          height: 60,
                          width: 45,
                          child: Center(
                              child: Text('Sun',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = 1;
                            _loading=false;
                            obj.getData(_year,"Monday").then((value){
                              setState(() {
                                _list=value;
                                _loading=true;
                              });
                            });
                          });
                        },
                        child: Container(
                          decoration:
                          _index == 1 ? _boxDecoration1 : _boxDecoration2,
                          height: 60,
                          width: 45,
                          child: Center(
                              child: Text('Mon',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = 2;
                            _loading=false;
                            obj.getData(_year,"Tuesday").then((value){
                              setState(() {
                                _list=value;
                                _loading=true;
                              });
                            });
                          });
                        },
                        child: Container(
                          decoration:
                          _index == 2 ? _boxDecoration1 : _boxDecoration2,
                          height: 60,
                          width: 45,
                          child: Center(
                              child: Text('Tue',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = 3;
                            _loading=false;
                            obj.getData(_year,"Wednesday").then((value){
                              setState(() {
                                _list=value;
                                _loading=true;
                              });
                            });
                          });
                        },
                        child: Container(
                          decoration:
                          _index == 3 ? _boxDecoration1 : _boxDecoration2,
                          height: 60,
                          width: 45,
                          child: Center(
                              child: Text('Wed',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = 4;
                            _loading=false;
                            obj.getData(_year,"Thursday").then((value){
                              setState(() {
                                _list=value;
                                _loading=true;
                              });
                            });
                          });
                        },
                        child: Container(
                          decoration:
                          _index == 4 ? _boxDecoration1 : _boxDecoration2,
                          height: 60,
                          width: 45,
                          child: Center(
                              child: Text('Thu',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = 5;
                            _loading=false;
                            obj.getData(_year,"Friday").then((value){
                              setState(() {
                                _list=value;
                                _loading=true;
                              });
                            });
                          });
                        },
                        child: Container(
                          decoration:
                          _index == 5 ? _boxDecoration1 : _boxDecoration2,
                          height: 60,
                          width: 45,
                          child: Center(
                              child: Text(
                                'Fri',
                                style: TextStyle(fontSize: 15, color: Colors.white),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = 6;
                            _loading=false;
                            obj.getData(_year,"Saturday").then((value){
                              setState(() {
                                _list=value;
                                _loading=true;
                              });
                            });
                          });
                        },
                        child: Container(
                          decoration:
                          _index == 6 ? _boxDecoration1 : _boxDecoration2,
                          height: 60,
                          width: 45,
                          child: Center(
                              child: Text(
                                'Sat',
                                style: TextStyle(fontSize: 15, color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                //height: MediaQuery.of(context).size.height/1.25,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: _loading ? _list.length == 0
                    ? Center(
                  child: Text(
                    'HOLIDAY',
                    style: TextStyle(fontSize: 30,color: Colors.white),
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (cnxt, i) => Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: color1,
                      boxShadow: shadows,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: color2,
                          child: Text(
                            _list[i].time,
                            style: TextStyle(fontSize: 15,color: color1),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _list[i].subject,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              _list[i].teacher,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  itemCount: _list.length,
                ):Center(child: CircularProgressIndicator(),),
              ),
            )
          ],
        ),
        ]
      ),
    );
  }
}

// class TimeTable {
//   String time;
//   String subjectName;
//   String teacherName;
//
//   TimeTable({this.time = '', this.subjectName = '', this.teacherName = ''});
// }
//
// List<List<TimeTable>> _timeTableFE = [
//   [],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'FEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'FEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'FEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'FEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'FEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'FEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'FEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'FEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'FEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'FEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'FEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'FEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'FEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'FEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'FEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   []
// ];
//
//
// List<List<TimeTable>> _timeTableSE = [
//   [],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'SEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'SEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'SEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'SEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'SEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'SEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'SEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'SEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'SEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'SEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'SEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'SEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'SEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'SEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'SEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   []
// ];
//
// List<List<TimeTable>> _timeTableTE = [
//   [],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'TEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'TEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'TEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'TEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'TEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'TEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'TEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'TEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'TEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'UC',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'TEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'TEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'TEsub',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'TEsub',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'TEsub',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   []
// ];
//
// List<List<TimeTable>> _timeTableBE = [
//   [],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'DCS',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'UC',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'ISR',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'SMA',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'DCS',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'ISR',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'DCS',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'ISR',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'UC',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'UC',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'SMA',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'DCS',
//         teacherName: 'Mrs. B. P. Vasgi'),
//   ],
//   [
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'ISR',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '10.05-10.45',
//         subjectName: 'SMA',
//         teacherName: 'Mr. G. R. Pathak'),
//     TimeTable(
//         time: '10.55-11.35',
//         subjectName: 'UC',
//         teacherName: 'Mrs. B. P. Vasgi'),
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'ISR',
//         teacherName: 'Mr. K. B. Sadafale'),
//     TimeTable(
//         time: '09.15-09.55',
//         subjectName: 'ISR',
//         teacherName: 'Mr. K. B. Sadafale'),
//   ],
//   []
// ];



BoxDecoration _boxDecoration1 = BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(Radius.circular(15)));

BoxDecoration _boxDecoration2 = BoxDecoration(
    color: color2,
    borderRadius: BorderRadius.all(Radius.circular(15)));