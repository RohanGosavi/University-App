//import 'file:///C:/Users/Rohan/AndroidStudioProjects/bottom_navigation_demo/lib/student/homepage.dart';
import 'package:bottom_navigation_demo/backend/livelecback.dart';
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveLec extends StatefulWidget {

  @override
  _LiveLecState createState() => _LiveLecState();
}

class _LiveLecState extends State<LiveLec> {

  Livelecdata obj =new Livelecdata();
  List<Livelecdata> _list;
  bool _loading;

  @override
  void initState(){
    super.initState();
    _loading = false;
    obj.getData(Studentinfo.testyear).then((value){
      setState(() {
        _list=value;
        _loading=true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //centerTitle: true,
          toolbarHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Live Lectures'),
              SvgPicture.asset('assets/illustrations/live.svg',height: 75,),
            ],
          ),
          elevation: 4,
        ),
        body: SafeArea(
          child: _loading ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (cnxt,i)=>Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width-100,
              decoration: BoxDecoration(
                  boxShadow: shadows,
                  borderRadius: BorderRadius.circular(30),
                  color: color
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Subject: ${_list[i].subject}",style: TextStyle(fontSize: 17),),
                        //Text("Time: ${_list[i].}",style: TextStyle(fontSize: 17),),

                      ],
                    ),
                    IconButton(icon: Icon(Icons.play_arrow), iconSize:50,onPressed:()=>_launchTest(_list[i].link))
                  ],
                ),
              ),
            ),
            itemCount: _list.length,
          ) : Center(child: CircularProgressIndicator())
        ),
      ),
    );
  }
}
void _launchTest (url) async{
  print(url);
  await canLaunch(url) ? await launch(url) : throw 'could not load test';
}
