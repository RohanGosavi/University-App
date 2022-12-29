import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:bottom_navigation_demo/teacher/teacherHomePage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AllTeachers extends StatefulWidget {
  const AllTeachers({Key key}) : super(key: key);

  @override
  _AllTeachersState createState() => _AllTeachersState();
}

class _AllTeachersState extends State<AllTeachers> {

  Teacherinfo obj = new Teacherinfo();
  bool _loading;

  List<Teacherinfo> _list;
  void initState(){
    super.initState();
    _loading = false;
    obj.getAll().then((value) {
      _list=value;
      print(_list);
      setState(() {
        _loading=true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Teacher List"),
        ),
        body: SingleChildScrollView(
          child: Column(
              children:[
                SizedBox(height: 20,),
                _loading ? ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (ctx,i)=>Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: color1,
                      boxShadow: shadows,
                    ),
                    //height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: 5,),
                          Icon(Icons.account_circle,size: 30,),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Name: ${_list[i].name}"),
                                Text("ID: ${_list[i].teacherinfoId}"),
                                Text("Phone No.: ${_list[i].phone.toString()}"),
                                Text("Email: ${_list[i].email}",overflow: TextOverflow.ellipsis,maxLines: 2),
                                Text("Address: ${_list[i].address}",overflow: TextOverflow.ellipsis,maxLines: 2),
                                Text("Qualification: ${_list[i].educationqual}")
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.call),
                            onPressed: (){
                              _call('tel:+91${_list[i].phone}');
                            },
                          ),
                          SizedBox(width: 4,),
                          IconButton(
                            icon: Icon(Icons.message),
                            onPressed: (){
                              _whatsapp('https://wa.me/91${_list[i].phone}');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: _list.length,
                ):Center(child: CircularProgressIndicator(),)
              ]
          ),
        )
    );
  }
}

void _call (phone) async{
  print(phone);
  await canLaunch(phone) ? await launch(phone) : throw 'could not call';
}

void _whatsapp(url)async{
  await canLaunch(url) ? await launch(url) : throw 'could not message';
}