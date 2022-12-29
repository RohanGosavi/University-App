import 'package:bottom_navigation_demo/backend/assignmentback.dart';
import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:bottom_navigation_demo/teacher/teacherHomePage.dart';
import 'package:flutter/material.dart';

class AssignPagelist extends StatefulWidget {
  @override
  _AssignPagelistState createState() => _AssignPagelistState();
}

class _AssignPagelistState extends State<AssignPagelist> {


  bool _loading;
  AssignmentData obj = new AssignmentData();
  List<AssignmentData> _list;

  @override
  void initState(){
    super.initState();
    _loading = false;
    obj.getTeacherData(Teacherinfo.tname).then((value){
      setState(() {
        _list=value;
        _loading=true;
        print(_list);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Assignment'),
      ),
      body:SafeArea(
          child:  _loading ? _list.length!=0 ? ListView.builder(
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
                        "Subject: "+_list[i].subject,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Year"+_list[i].year,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(width: 15,),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      _loading = false;
                      bool res = await obj.deleteData(_list[i].id);
                      if(res){
                        setState(() {
                          obj.getTeacherData(Teacherinfo.tname).then((value){
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
          ) : Center(child: Text("No Data"),): Center(child: CircularProgressIndicator(),)
      ),
    );
  }
}
