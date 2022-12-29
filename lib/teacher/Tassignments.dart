import 'package:bottom_navigation_demo/backend/assignmentback.dart';
import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:bottom_navigation_demo/teacher/studentsub.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'assignlist.dart';


class TAssignments extends StatefulWidget {
  @override
  _TTAssignmentsState createState() => _TTAssignmentsState();
}

class _TTAssignmentsState extends State<TAssignments> {

  SubjectData sobj = new SubjectData();
  List<SubjectData> detail;
  bool _loading2;
  @override
  void initState(){
    super.initState();
    _loading2=false;
    // _loading = false;
     _submitted = false;
    // sobj.getData(_value1).then((value) {
    //   detail=value;
    //   print(detail);
    //   setState(() {
    //     _loading=true;
    //   });
    // });
  }

  AssignmentData obj = new AssignmentData();
  DateTime pickdate = DateTime.now();
  String _assignFile;
  String _value1;
  String _value2;
  // List<int>tapped=[];
  final _controller1 = TextEditingController();
  bool _submitted;
  String _link;

  var _formKey = GlobalKey<FormState>();

  Icon icon1 = Icon(Icons.upload_rounded);
  Icon icon2 = Icon(Icons.assignment_turned_in_rounded);


  void _openFileExp() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(type :FileType.custom,allowedExtensions: ['pdf']);

    if (result != null) {
      setState(() {
        _submitted = true;
      });
      PlatformFile file = result.files.first;
      _assignFile = file.path;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      _assignFile = null;
      // User canceled the picker
    }
  }

  _pickDate() async{
    DateTime date = await showDatePicker(
        context: context,
        initialDate: pickdate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year+3)
    );
    if(date!=null){
      setState(() {
        pickdate = date;
      });
    }
  }


  // List<List<DropdownMenuItem<dynamic>>> _sub = [
  //   [
  //     DropdownMenuItem(child: Text('Fsub1'),value: "fs1",),
  //     DropdownMenuItem(child: Text('Fsub2'),value: "fs2",),
  //     DropdownMenuItem(child: Text('Fsub3'),value: "fs3",),
  //     DropdownMenuItem(child: Text('Fsub4'),value: "fs4",),
  //     DropdownMenuItem(child: Text('Fsub5'),value: "fs5",),
  //   ],
  //   [
  //     DropdownMenuItem(child: Text('Ssub1'),value: "ss1",),
  //     DropdownMenuItem(child: Text('Ssub2'),value: "ss2",),
  //     DropdownMenuItem(child: Text('Ssub3'),value: "ss3",),
  //     DropdownMenuItem(child: Text('Ssub4'),value: "ss4",),
  //     DropdownMenuItem(child: Text('Ssub5'),value: "ss5",),
  //   ],
  //   [
  //     DropdownMenuItem(child: Text('Tsub1'),value: "ts1",),
  //     DropdownMenuItem(child: Text('Tsub2'),value: "ts2",),
  //     DropdownMenuItem(child: Text('Tsub3'),value: "ts3",),
  //     DropdownMenuItem(child: Text('Tsub4'),value: "ts4",),
  //     DropdownMenuItem(child: Text('Tsub5'),value: "ts5",),
  //   ],
  //   [
  //     DropdownMenuItem(child: Text('Bsub1'),value: "bs1",),
  //     DropdownMenuItem(child: Text('Bsub2'),value: "bs2",),
  //     DropdownMenuItem(child: Text('Bsub3'),value: "bs3",),
  //     DropdownMenuItem(child: Text('Bsub4'),value: "bs4",),
  //     DropdownMenuItem(child: Text('Bsub5'),value: "bs5",),
  //   ]
  // ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key :_formKey,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    onChanged: (value) {
                      _value1 = value;
                      sobj.getData(_value1).then((value) {
                        detail=value;
                        print(detail);
                        setState(() {
                          _loading2=true;
                        });
                      });
                    },
                  ),
                  SizedBox(height: 20,),
                  _loading2 ? DropdownButton(
                    value: _value2,
                    hint: Text('Select subject'),
                    items:[
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
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    maxLength: 80,
                    decoration: InputDecoration(
                      hintText: 'Enter Assignment Topic',
                      labelText: 'Assignment Topic',
                      focusedBorder: UnderlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _link = value;
                      });
                      //print(title);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Assignment topic!';
                      }
                      return null;
                    },
                    controller: _controller1,
                  ),
                  SizedBox(height: 15,),
                  IconButton(
                    icon: _submitted ? icon2 : icon1,
                    onPressed: () {
                      _openFileExp();
                    },
                    iconSize: 40,
                  ),
                  Text(
                    _submitted ? 'Uploaded' : 'Upload File',
                    style: TextStyle(fontSize: 20, color: color2),
                  ),
                  SizedBox(height: 15,),
                  ListTile(
                    title: Text("Enter Due Date: ${pickdate.day}/${pickdate.month}/${pickdate.year}"),
                    trailing: Icon(Icons.keyboard_arrow_down),
                    onTap: ()=>_pickDate(),
                  ),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: color2,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        String _date = "${pickdate.day}.${pickdate
                            .month}.${pickdate.year}";
                        bool res = await obj.putData(
                            _link, _value1, _value2, Teacherinfo.tname, _date,
                            _assignFile);
                        if (res) {
                          setState(() {
                            pickdate = DateTime.now();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Uploaded Successfully'),
                            ),
                            );
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Upload Fail'),
                          ),
                          );
                        }
                        _controller1.clear();
                      }
                    },
                    child: Text('Submit'),
                  ),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: color2,
                    ),
                    onPressed: (){
                      Navigator.push(context, ScaleRoute(page: AssignPagelist()));
                    },
                    child: Text('Assignment List'),
                  ),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: color2,
                    ),
                    onPressed: (){
                      Navigator.push(context, ScaleRoute(page: StudentSub()));
                    },
                    child: Text('Student Submissions'),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
