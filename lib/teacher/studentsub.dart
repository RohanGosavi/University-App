import 'package:bottom_navigation_demo/backend/studentAssignback.dart';
import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:bottom_navigation_demo/teacher/teacherHomePage.dart';
import 'package:flutter/material.dart';

class StudentSub extends StatefulWidget {
  @override
  _StudentSubState createState() => _StudentSubState();
}

class _StudentSubState extends State<StudentSub> {


  String _year;
  String _sub;

  SubjectData sobj = new SubjectData();
  List<SubjectData> detail;
  bool _loading2;
  bool _loading;
  List<bool> _loading3;
  Icon icon3 = Icon(Icons.download_outlined);
  Icon icon4 = Icon(Icons.download_done_outlined);

  StudAssignData obj = new StudAssignData();
  List<StudAssignData> _list;

  @override
  void initState(){
    super.initState();
    _loading2=false;
    _loading = false;
    // obj.getData(_year, _sub).then((value){
    //   setState(() {
    //     _list=value;
    //     _loading=true;
    //     print(_list);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Submissions'),
      ),
      body:SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15,),
            DropdownButton(
              value: _year,
              hint: Text('Select class'),
              items: [
                DropdownMenuItem(child: Text('FE'),value: "FE",),
                DropdownMenuItem(child: Text('SE'),value: "SE",),
                DropdownMenuItem(child: Text('TE'),value: "TE",),
                DropdownMenuItem(child: Text('BE'),value: "BE",),
              ],
              onChanged: (value) async{
                _year = value;
                sobj.getData(_year).then((value) {
                  detail=value;
                  print(detail);
                  setState(() {
                    _loading2=true;
                  });
                });
              },
            ),
            SizedBox(height: 15,),
            _loading2 ? DropdownButton(
              value: _sub,
              hint: Text('Select subject'),
              items:[
                DropdownMenuItem(child: Text(detail[0].subject),value: detail[0].subject,),
                DropdownMenuItem(child: Text(detail[1].subject),value: detail[1].subject,),
                DropdownMenuItem(child: Text(detail[2].subject),value: detail[2].subject,),
                DropdownMenuItem(child: Text(detail[3].subject),value: detail[3].subject,),
                DropdownMenuItem(child: Text(detail[4].subject),value: detail[4].subject,),
              ],
              onChanged: (value) {
                _sub = value;
                obj.getData(_year, _sub).then((value){
                  setState(() {
                    _list=value;
                    _loading=true;
                    print(_list);
                    _loading3 = List.filled(_list.length, false);
                  });
                });
              },
            ): Text("Select Class first"),
            SizedBox(height: 15,),
            _loading ? _list.length!=0 ? ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _list.length,
                itemBuilder: (cnxt,i)=>Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: color1,
                    boxShadow: shadows,
                  ),
                  height: 150,
                  width: MediaQuery.of(context).size.width - 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.assignment,size: 50,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Topic: "+_list[i].topic,
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "Name: "+_list[i].submittedBy,
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "Date: "+_list[i].submissionDate,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(width: 15,),
                      IconButton(
                        icon: _loading3[i] ? icon4 : icon3,
                        onPressed: ()async{
                          String filename = "uploads/${_list[i].topic}-${_list[i].subject}-${_list[i].submittedBy}.pdf";
                          bool res = await obj.getFile(_list[i].file,filename);
                          if(res){
                            setState(() {
                              _loading3[i] = true;
                            });
                          }
                        },
                      ),
                      SizedBox(width: 15,),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          _loading = false;
                          bool res = await obj.deleteData(_list[i].id);
                          if(res){
                            setState(() {
                              obj.getData(_year, _sub).then((value){
                                setState(() {
                                  _list=value;
                                  _loading=true;
                                });
                              });
                            });
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Deleted Successfully'),
                            ),);
                            setState(() {
                              _loading = true;
                            });
                          }
                        },
                      )
                    ],
                  ),
                ),
              ) : Center(child: Text("No Data"),): Center(child: CircularProgressIndicator(),),
          ],
        ),
      ),
    );
  }
}
