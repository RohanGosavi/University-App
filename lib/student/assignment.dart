//import 'file:///C:/Users/Rohan/AndroidStudioProjects/bottom_navigation_demo/lib/student/upload_assignment.dart';
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:bottom_navigation_demo/student/upload_assignment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'homepage.dart';

class Assign extends StatefulWidget {
  @override
  _AssignState createState() => _AssignState();
}

class _AssignState extends State<Assign> {

  SubjectData obj = new SubjectData();
  List<SubjectData> detail;
  bool _loading;
  @override
  void initState(){
    super.initState();
    _loading = false;
    obj.getData(Studentinfo.testyear).then((value) {
      detail=value;
      print(detail);
      setState(() {
        _loading=true;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //centerTitle: true,
          toolbarHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Assignment'),
              SvgPicture.asset('assets/illustrations/task.svg',height: 75,),
            ],
          ),
          elevation: 4,
        ),
      body: _loading ?ListView.builder(
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
                  detail[i].subject,
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    final data1 = Data(num: i,sub: detail[i].subject);
                    Navigator.push(context, ScaleRoute(page: Upload(data: data1,)));
                  },
                  iconSize: 30,
                ),
              ),
            ],
          ),
        ),
        itemCount: subjects.length,
      ):Center(child: CircularProgressIndicator())
    );
  }
}
List<String> subjects = [
  'MLA',
  'ICS',
  'BAI',
  'STQA',
  'SDM'
];

class Data {
  int num;
  String sub;
  Data({this.num,this.sub});
}