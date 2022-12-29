import 'package:bottom_navigation_demo/backend/announcementback.dart';
import 'package:bottom_navigation_demo/teacher/teacherHomePage.dart';
import 'package:flutter/material.dart';


class AnnouncelistPage extends StatefulWidget {
  final String name;
  AnnouncelistPage({this.name});
  @override
  _AnnouncelistPageState createState() => _AnnouncelistPageState();
}

class _AnnouncelistPageState extends State<AnnouncelistPage> {

  bool _loading;
  Announcementlist obj = new Announcementlist();
  List<Announcementlist> _list;
  @override
  void initState(){
    super.initState();
    _loading = false;
    obj.getTeacherData(widget.name).then((value){
      setState(() {
        _list=value;
        _loading=true;
        print(_list.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Announcement'),
      ),
      body:SafeArea(
        child:  _loading ? _list.length!=0 ? ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: _list.length,
          itemBuilder: (cnxt,i)=>  Container(
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
                Icon(Icons.announcement,size: 50,),
                SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _list[i].announcement,
                        //softWrap: false,
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        _list[i].year,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    _loading = false;
                    bool res = await obj.deleteData(_list[i].id);
                    if(res){
                      setState(() {
                        obj.getData().then((value){
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
          )
        ) : Center(child: Text("No Data")):Center(child: CircularProgressIndicator(),)
      ),
    );
  }
}