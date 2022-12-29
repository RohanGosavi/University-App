import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:flutter/material.dart';

class MySub extends StatefulWidget {
  const MySub({Key key}) : super(key: key);

  @override
  _MySubState createState() => _MySubState();
}

class _MySubState extends State<MySub> {

  Teacherinfo obj = new Teacherinfo();
  bool _loading;
  Teacherinfo detail;

  @override
  void initState(){
    super.initState();
    _loading = false;
    obj.getTeacherData().then((value) {
      setState(() {
        detail = value;
        _loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Subjects'),
      ),
      body: _loading  ? ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: detail.subjects.length,
        itemBuilder: (cnxt,i)=>Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color1,
            boxShadow: shadows,
          ),
          height: 150,
          width: MediaQuery.of(context).size.width - 100,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.subject,size: 50,),
                Text(detail.subjects[i],style: TextStyle(fontSize: 25),)
              ],
            ),
          ),
        ),
      ):Center(child: CircularProgressIndicator(),)
    );
  }
}
