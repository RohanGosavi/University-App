import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:bottom_navigation_demo/backend/studymaterialback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:flutter/material.dart';

class StudyMaterialList extends StatefulWidget {

  final String subject;
  StudyMaterialList({this.subject});

  @override
  _StudyMaterialListState createState() => _StudyMaterialListState();
}

class _StudyMaterialListState extends State<StudyMaterialList> {
  bool _loading;
  List<bool>_loading2;
  StudyMaterial obj = new StudyMaterial();
  Icon icon3 = Icon(Icons.download_outlined);
  Icon icon4 = Icon(Icons.download_done_outlined);

  @override
  void initState(){
    super.initState();
    _loading = false;
    _loading2 = List.filled(1, false,growable: true);
    // _uploaded = false;
    obj.getData(Studentinfo.testyear,widget.subject).then((value) {
      _list=value;
      print(_list);
      setState(() {
        _loading2 = List.filled(_list.length, false);
        _loading=true;
      });
    });
  }

  List<StudyMaterial>  _list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Material'),
      ),
      body: _loading ? _list.length == 0 ? Center(child: Text('No Data')) : ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: _list.length,
        itemBuilder: (ctx,i)=>Container(
          padding: EdgeInsets.symmetric(
              horizontal: 20
          ),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color1,
            boxShadow: shadows,
          ),
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: Icon(Icons.book_rounded,size: 50,)),
              SizedBox(width: 15,),
              Expanded(
                child: Text(
                  _list[i].topic,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(width: 15,),
              Expanded(
                child: IconButton(
                  icon: _loading2[i] ? icon4 : icon3,
                  onPressed: ()async{
                    print("here");
                    String filename = "uploads/${_list[i].topic}-${_list[i].subject}.pdf";
                    bool res = await obj.getFile(_list[i].file,filename);
                    if(res){
                      setState(() {
                        print("here");
                        _loading2[i] = true;
                      });
                    }else{
                      print("here");
                    }
                  },
                ),
              )
            ],
          ),
        ),

      ):Center(child: CircularProgressIndicator())
    );
  }
}
