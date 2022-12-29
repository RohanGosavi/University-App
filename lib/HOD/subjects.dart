import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:flutter/material.dart';

class AllSubjecth extends StatefulWidget {
  const AllSubjecth({Key key}) : super(key: key);

  @override
  _AllSubjecthState createState() => _AllSubjecthState();
}

class _AllSubjecthState extends State<AllSubjecth> {
  SubjectData obj = new SubjectData();
  List<SubjectData> _list;
  bool _loading;
  @override
  void initState(){
    super.initState();
    _loading = false;
    obj.getAll().then((value) {
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _list[i].subject,
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        "Year: ${_list[i].year}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Expanded(
                      child:IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: ()async {
                          bool res = await obj.deleteData(_list[i].id);
                          if(res){
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Deleted'),),);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Failed to delete'),),);
                          }
                        },
                      )
                  ),
                ],
              ),
            )
        ):Center(child: CircularProgressIndicator(),)
    );
  }
}
