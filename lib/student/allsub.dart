import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:flutter/material.dart';

class AllSubject extends StatefulWidget {
  const AllSubject({Key key}) : super(key: key);

  @override
  _AllSubjectState createState() => _AllSubjectState();
}

class _AllSubjectState extends State<AllSubject> {
  SubjectData obj = new SubjectData();
  List<SubjectData> _list;
  bool _loading;
  @override
  void initState(){
    super.initState();
    _loading = false;
    obj.getData(Studentinfo.testyear).then((value) {
      _list=value;
      //print(_list);
      setState(() {
        _loading=true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subjects'),
      ),
      body:_loading ? ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: _list.length,
          itemBuilder: (ctx,i)=>Container(
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
                Expanded(child: Icon(Icons.subject,size: 50,)),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    _list[i].subject,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          )
      ):Center(child: CircularProgressIndicator(),)
    );
  }
}
