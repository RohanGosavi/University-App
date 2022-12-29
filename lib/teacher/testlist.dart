import 'package:bottom_navigation_demo/backend/testback.dart';
import 'package:bottom_navigation_demo/teacher/teacherHomePage.dart';
import 'package:flutter/material.dart';

class TestList extends StatefulWidget {
  @override
  _TestListState createState() => _TestListState();
}

class _TestListState extends State<TestList> {


  bool _loading;
  String _year;
  TestData obj = new TestData();
  List<TestData> _list;

  @override
  void initState(){
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Test'),
      ),
      body:SafeArea(
          child:  Column(
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
                    obj.getData(_year).then((value){
                      setState(() {
                        _list=value;
                        _loading=true;
                        print(_list);
                      });
                    });
                  },
                ),
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
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Subject: "+_list[i].subject,
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "link:"+_list[i].link,
                                //softWrap: false,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                            ],
                          ),
                        ),
                        //SizedBox(width: ,),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            _loading = false;
                            bool res = await obj.deleteData(_list[i].id);
                            if(res){
                              setState(() {
                                obj.getData(_year).then((value){
                                  setState(() {
                                    _list=value;
                                    _loading=true;
                                    print(_list);
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
                ): Center(child: Text("No Data"),): Center(child: CircularProgressIndicator(),)
              ]
          )
      ),
    );
  }
}
