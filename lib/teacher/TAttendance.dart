import 'package:bottom_navigation_demo/backend/attendanceback.dart';
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:bottom_navigation_demo/teacher/displayAttendance.dart';
import 'package:flutter/material.dart';

class TAttendance extends StatefulWidget {
  @override
  _TAttendanceState createState() => _TAttendanceState();
}

class _TAttendanceState extends State<TAttendance> {

  Attendance aobj = new Attendance();

  String _value1;
  int _num = 0;
  String _value2;
  List<String>tapped=[];
  SubjectData sobj = new SubjectData();
  List<SubjectData> detail;
  bool _loading;
  bool _loading2;
  Studentinfo obj = new Studentinfo();
  List<Studentinfo> _list;

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
        child: Center(
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
                  obj.getAll(_value1).then((value) {
                    _list=value;
                    print(_list);
                    setState(() {
                      _loading2 = true;
                    });
                  });
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
                  setState(() {
                    _value2 = value;
                  });
                },
              ): Text("Select Class first"),
              SizedBox(height: 5,),
              _loading2 ? Expanded(
                child: GridView.count(
                  physics: ScrollPhysics(),
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  children: List.generate(_list.length, (index){
                    return Center(
                      child: GestureDetector(
                        onTap: (){
                          //print(tapped);
                          if(tapped.contains((index+1).toString())){
                            print("here");
                            setState(() {
                              tapped.remove((index+1).toString());
                              print(tapped);
                            });
                          }else{
                            setState(() {
                              tapped.add((index+1).toString());
                              print(tapped);
                            });
                          }
                        },
                        child: Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width/7,
                          child: Center(child: Text('${index+1}',)),
                          color: tapped.contains((index+1).toString())?Colors.black: color,
                        ),
                      ),
                    );
                  })
                ),
              ):Center(child: CircularProgressIndicator(),),
              SizedBox(height: 5,),
              ElevatedButton(
                child: Text("SUBMIT"),
                onPressed: ()async{
                  String date = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
                  bool res = await aobj.putData(_value1, date, _value2, tapped);
                  if(res){
                    setState(() {
                      tapped.clear();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Done...'),
                      duration: Duration(seconds: 2),
                    ),
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed...'),
                      duration: Duration(seconds: 2),
                    ),
                    );
                  }
                },
              ),
              SizedBox(height: 5,),
              ElevatedButton(
                child: Text("Display Attendance"),
                onPressed: (){
                  Navigator.push(context, ScaleRoute(page: DisplayAttendance()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
