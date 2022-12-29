import 'package:bottom_navigation_demo/backend/studymaterialback.dart';
import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TStudyMaterial extends StatefulWidget {
  @override
  _TStudyMaterialState createState() => _TStudyMaterialState();
}

class _TStudyMaterialState extends State<TStudyMaterial> {

  SubjectData sobj = new SubjectData();
  List<SubjectData> detail;
  bool _loading2;

  StudyMaterial obj = new StudyMaterial();

  String _assignFile;
  String _value1;
  String _value2;
  bool _submitted;
  String _link;
  Icon icon1 = Icon(Icons.upload_rounded);
  Icon icon2 = Icon(Icons.assignment_turned_in_rounded);
  var _formKey = GlobalKey<FormState>();
  final _controller1 = TextEditingController();

  @override
  void initState(){
    super.initState();
    _submitted = false;
    _loading2=false;
  }

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
      // User canceled the picker
      _assignFile = null;
    }
  }

  // List<List<DropdownMenuItem<int>>> _sub = [
  //   [
  //     DropdownMenuItem(child: Text('Fsub1'),value: 0,),
  //     DropdownMenuItem(child: Text('Fsub2'),value: 1,),
  //     DropdownMenuItem(child: Text('Fsub3'),value: 2,),
  //     DropdownMenuItem(child: Text('Fsub4'),value: 3,),
  //     DropdownMenuItem(child: Text('Fsub5'),value: 4,),
  //   ],
  //   [
  //     DropdownMenuItem(child: Text('Ssub1'),value: 0,),
  //     DropdownMenuItem(child: Text('Ssub2'),value: 1,),
  //     DropdownMenuItem(child: Text('Ssub3'),value: 2,),
  //     DropdownMenuItem(child: Text('Ssub4'),value: 3,),
  //     DropdownMenuItem(child: Text('Ssub5'),value: 4,),
  //   ],
  //   [
  //     DropdownMenuItem(child: Text('Tsub1'),value: 0,),
  //     DropdownMenuItem(child: Text('Tsub2'),value: 1,),
  //     DropdownMenuItem(child: Text('Tsub3'),value: 2,),
  //     DropdownMenuItem(child: Text('Tsub4'),value: 3,),
  //     DropdownMenuItem(child: Text('Tsub5'),value: 4,),
  //   ],
  //   [
  //     DropdownMenuItem(child: Text('Bsub1'),value: 0,),
  //     DropdownMenuItem(child: Text('Bsub2'),value: 1,),
  //     DropdownMenuItem(child: Text('Bsub3'),value: 2,),
  //     DropdownMenuItem(child: Text('Bsub4'),value: 3,),
  //     DropdownMenuItem(child: Text('Bsub5'),value: 4,),
  //   ]
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Material'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
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
                  onChanged: (value) async{
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
                    hintText: 'Enter Topic',
                    labelText: 'Topic',
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
                      return 'Enter topic!';
                    }
                    return null;
                  },
                  controller: _controller1,
                ),
                SizedBox(
                  height: 15,
                ),
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: color2,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate() && _assignFile!=null){
                      bool res = await obj.putData(_link, _value1, _value2, Teacherinfo.tname, _assignFile);
                      if (res) {
                        setState(() {
                          _submitted = false;
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
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Upload File.....'),
                      ),
                      );
                    }
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
