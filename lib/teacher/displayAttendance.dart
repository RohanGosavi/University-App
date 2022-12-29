import 'package:bottom_navigation_demo/backend/attendanceback.dart';
import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:bottom_navigation_demo/teacher/teacherHomePage.dart';
import 'package:flutter/material.dart';

class DisplayAttendance extends StatefulWidget {
  const DisplayAttendance({Key key}) : super(key: key);

  @override
  _DisplayAttendanceState createState() => _DisplayAttendanceState();
}

class _DisplayAttendanceState extends State<DisplayAttendance> {

  Attendance aobj = new Attendance();
  List<Attendance> _list;
  String _value1;
  String _value2;
  SubjectData sobj = new SubjectData();
  List<SubjectData> detail;
  bool _loading;
  bool _loading2;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _loading2=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            DropdownButton(
              value: _value1,
              hint: Text('Select class'),
              items: [
                DropdownMenuItem(child: Text('FE'),value: "FE",),
                DropdownMenuItem(child: Text('SE'),value: "SE",),
                DropdownMenuItem(child: Text('TE'),value: "TE",),
                DropdownMenuItem(child: Text('BE'),value: "BE",),
              ],
              onChanged: (value){
                _value1 = value;
                sobj.getData(_value1).then((value){
                  detail=value;
                  print(detail);
                  setState(() {
                    _loading=true;
                  });
                });
              },
            ),
            SizedBox(height: 5,),
            _loading ?DropdownButton(
              value: _value2,
              hint: Text('Select subject'),
              items: [
                DropdownMenuItem(child: Text(detail[0].subject),value: detail[0].subject,),
                DropdownMenuItem(child: Text(detail[1].subject),value: detail[1].subject,),
                DropdownMenuItem(child: Text(detail[2].subject),value: detail[2].subject,),
                DropdownMenuItem(child: Text(detail[3].subject),value: detail[3].subject,),
                DropdownMenuItem(child: Text(detail[4].subject),value: detail[4].subject,),
              ],
              onChanged: (value){
                  _value2 = value;
                  aobj.getData(_value1, _value2).then((value){
                    _list=value;
                    setState(() {
                      _loading2 = true;
                    });
                  });
              },
            ): Text("Select Class first"),
            SizedBox(height: 5,),
            _loading2 ? ListView.builder(
              physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx,i)=>Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: color1,
                    boxShadow: shadows,
                  ),
                  //height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text("Date: "+_list[i].date),
                        SizedBox(height: 10,),
                        Text("Present Students: "+_list[i].attendancelist.toString(),maxLines:5),
                      ],
                    ),
                  ),
                ),
              itemCount: _list.length,
            ):Center(child: CircularProgressIndicator(),)
          ],
        ),
      ),
    );
  }
}
