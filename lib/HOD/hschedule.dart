import 'package:bottom_navigation_demo/backend/scheduleback.dart';
import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:flutter/material.dart';

class HSchedule extends StatefulWidget {
  const HSchedule({Key key}) : super(key: key);

  @override
  _HScheduleState createState() => _HScheduleState();
}

class _HScheduleState extends State<HSchedule> {

  TimeOfDay _from = TimeOfDay.now();
  TimeOfDay _to = TimeOfDay.now();
  ScheduleData obj = new ScheduleData();
  SubjectData subobj = new SubjectData();
  Teacherinfo tobj = new Teacherinfo();
  String _year;
  String _day;
  String _teacher;
  String _subject;
  bool _loading;
  bool _loading2;
  String time;
  dynamic _items1;
  dynamic _items2;


  Future<TimeOfDay> _pickTime(BuildContext context,time) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: time, builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
      );});

    if (picked_s != null && picked_s != time )
      return picked_s;
    return TimeOfDay.now();
  }


  @override
  void initState(){
    super.initState();
    _loading = false;
    _loading2 = false;
    tobj.getAll().then((value){
      setState(() {
        _items1 = value.map((teacher) => DropdownMenuItem<String>(child: Text(teacher.name),value: teacher.name,)).toList();
        _loading=true;
      });
    });
    // subobj.getAll().then((value){
    //   setState(() {
    //     _items2 = value.map((sub) => DropdownMenuItem<String>(child: Text(sub.subject),value: sub.subject,)).toList();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: SafeArea(
        child: _loading ? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  String tyear = value;
                  subobj.getData(tyear).then((value){
                    setState(() {
                      _items2 = value.map((sub) => DropdownMenuItem<String>(child: Text(sub.subject),value: sub.subject,)).toList();
                      _year = tyear;
                      _loading2 = true;
                    });
                  });
                },
              ),
              SizedBox(height: 20,),
              DropdownButton(
                value: _day,
                hint: Text('Select Day'),
                items: [
                  DropdownMenuItem(child: Text('Monday'),value: "Monday",),
                  DropdownMenuItem(child: Text('Tuesday'),value: "Tuesday",),
                  DropdownMenuItem(child: Text('Wednesday'),value: "Wednesday",),
                  DropdownMenuItem(child: Text('Thursday'),value: "Thursday",),
                  DropdownMenuItem(child: Text('Friday'),value: "Friday",),
                  DropdownMenuItem(child: Text('Saturday'),value: "Saturday",),
                  DropdownMenuItem(child: Text('Sunday'),value: "Sunday",),
                ],
                onChanged: (value){
                  setState(() {
                    _day = value;
                  });
                },
              ),
              SizedBox(height: 20,),
              DropdownButton(
                value:_teacher,
                hint: Text("Select Teacher"),
                items: _items1,
                onChanged: (value){
                  setState(() {
                    _teacher = value;
                  });
                },
              ),
              SizedBox(height: 20,),
              _loading2 ? DropdownButton(
                value:_subject,
                hint: Text("Select Subject"),
                items: _items2,
                onChanged: (value){
                  setState(() {
                    _subject = value;
                  });
                },
              ):Text("Select class first"),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: ListTile(
                      title: Text("From: ${_from.hour}:${_from.minute}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                        onTap: () async{
                        dynamic t = await _pickTime(context,_from);
                          setState(() {
                            //_pickTime(context,_from).then((value) => _from=value);
                            _from = t;
                          });
                        }
                    ),
                  ),
                  Text("  -  "),
                  Flexible(
                    child: ListTile(
                      title: Text("To  : ${_to.hour}:${_to.minute}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: () async{
                        dynamic t = await _pickTime(context,_to);
                        setState(() {
                          _to = t;
                        });
                      }
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                child: Text("Submit"),
                onPressed: ()async{
                  time = "${_from.hour}:${_from.minute}-${_to.hour}:${_to.minute}";
                  if(_year==null || _teacher==null || _subject==null || _day==null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Enter All Data'),
                    ),
                    );
                  }else{
                    bool res = await obj.putData(_year, _day, _subject, _teacher, time);
                    if(res){
                      setState(() {
                        _year=null;
                        _teacher=null;
                        _subject=null;
                        _day=null;
                        _to = TimeOfDay.now();
                        _from = TimeOfDay.now();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Upload Successful'),
                      ),
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Upload Fail'),
                      ),
                      );
                    }
                  }
                },
              )
            ],
          ),
        ) : Center(child: CircularProgressIndicator(),)
      ),
    );
  }
}
