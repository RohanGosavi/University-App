import 'package:bottom_navigation_demo/backend/assignmentback.dart';
import 'package:bottom_navigation_demo/backend/studentAssignback.dart';
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:flutter/material.dart';
import 'assignment.dart';
import 'homepage.dart';
import 'package:file_picker/file_picker.dart';


class Upload extends StatefulWidget {

  final Data data;
  Upload({this.data});

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  StudAssignData obj2 = new StudAssignData();
  DateTime pickdate = DateTime.now();
  String _assignFile;
  AssignmentData obj = new AssignmentData();
  List<AssignmentData>  _list;
  bool _loading;
  List<bool> _loading2;
  List<bool> _uploaded;

  Icon icon1 = Icon(Icons.upload_file);
  Icon icon2 = Icon(Icons.assignment_turned_in_rounded);
  Icon icon3 = Icon(Icons.download_outlined);
  Icon icon4 = Icon(Icons.download_done_outlined);

  @override
  void initState(){
    super.initState();
    _loading = false;
    _loading2 = List.filled(1, false,growable: true);
    // _uploaded = false;
    obj.getData(Studentinfo.testyear,widget.data.sub).then((value) {
      _list=value;
      print(_list);
      setState(() {
        _loading2 = List.filled(_list.length, false);
        _uploaded = List.filled(_list.length, false);
        _loading=true;
      });
    });
  }

  Future<bool> _openFileExp() async{
    FilePickerResult result = await FilePicker.platform.pickFiles(type :FileType.custom,allowedExtensions: ['pdf']);
    //type :FileType.custom,allowedExtensions: ['pdf']

    if(result != null) {
      PlatformFile file = result.files.first;
      _assignFile = file.path;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
      return true;
    } else {
      _assignFile = null;
      return false;
      // User canceled the picker
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _loading ? _list.length == 0 ? Center(child: Text('No Assignment')) :  ListView.builder(
        //controller: controller,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (ctx,i)=> Container(
          padding: EdgeInsets.symmetric(
              horizontal: 10
          ),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color1,
            boxShadow: shadows,
          ),
          height: 130,
          width: MediaQuery.of(context).size.width - 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Icon(Icons.book_rounded,size: 50,)),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  _list[i].topic,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              _list[i].file!=null ? Expanded(
                child: IconButton(
                  icon: _loading2[i] ? icon4 : icon3,
                  onPressed: ()async{
                    String filename = "uploads/${_list[i].topic}-${_list[i].subject}.pdf";
                    bool res = await obj.getFile(_list[i].file,filename);
                    if(res){
                      setState(() {
                        _loading2[i] = true;
                      });
                    }
                  },
                ),
              ):Text("NA"),
              Expanded(
                child: IconButton(
                  icon:  _uploaded[i] ? icon2 : icon1,
                  onPressed: () async{
                    bool fileopen = await _openFileExp();
                    if(fileopen) {
                      String _date = "${pickdate.day}.${pickdate.month}.${pickdate.year}";
                      bool res = await obj2.putData(_list[i].topic, Studentinfo.testyear, _list[i].subject, Studentinfo.stname, _date,fileopen, _assignFile);
                      if (res) {
                        setState(() {
                          _uploaded[i] = true;
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
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Upload Fail'),
                      ),
                      );
                    }
                  },
                  iconSize: 30,
                ),
              ),
            ],
          ),
        ),
        itemCount: _list.length,
      ) :Center(child: CircularProgressIndicator())
    );
  }
}

// List<List<Map>> _assignments = [
//   [
//     {'Assignment':'MLA 1','Submitted':false},
//     {'Assignment':'MLA 2','Submitted':false}
//   ],
//   [
//     {'Assignment':'ICS 1','Submitted':false}
//   ],
//   [
//     {'Assignment':'BAI 1','Submitted':false}
//   ],
//   [],
//   [
//     {'Assignment':'SDM 1','Submitted':false},
//     {'Assignment':'SDM 2','Submitted':false},
//     {'Assignment':'SDM 2','Submitted':false}
//   ]
// ];