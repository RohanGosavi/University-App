import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:bottom_navigation_demo/backend/testback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'homepage.dart';

class Test extends StatefulWidget {

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  TestData obj = new TestData();
  List<TestData> _list;
  bool _loading ;

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
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Test'),
            SvgPicture.asset('assets/illustrations/test.svg',height: 75,),
          ],
        ),
        elevation: 4,
      ),
      body: _loading ?  ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (cnxt,i)=>Container(
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
                  Icon(Icons.article_outlined,size: 50,),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _list[i].subject,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Text(
                      //   DateTime.now().toString(),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      ElevatedButton(
                        child: Text('Launch',style: TextStyle(fontSize: 15),),
                        onPressed: (){
                          _launchTest(_list[i].link);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
              itemCount: _list.length,
            ) : Center(child: CircularProgressIndicator())
    );
  }
}

void _launchTest (url) async{
  print(url);
  await canLaunch(url) ? await launch(url) : throw 'could not load test';
}

