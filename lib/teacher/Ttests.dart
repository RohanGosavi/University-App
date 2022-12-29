import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:bottom_navigation_demo/teacher/testlist.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navigation_demo/backend/testback.dart';


class TTests extends StatefulWidget {
  @override
  _TTestsState createState() => _TTestsState();
}

class _TTestsState extends State<TTests> {

  SubjectData sobj = new SubjectData();
  List<SubjectData> detail;
  bool _loading;
  TestData obj = new TestData();
  String _value1;
  String _value2;
  String _link;
  final _controller1 = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  // List<List<DropdownMenuItem<dynamic>>> _sub = [
  //   [
  //     DropdownMenuItem(child: Text('Fsub1'),value: "fs1",),
  //     DropdownMenuItem(child: Text('Fsub2'),value: "fs2",),
  //     DropdownMenuItem(child: Text('Fsub3'),value: "fs3",),
  //     DropdownMenuItem(child: Text('Fsub4'),value: "fs4",),
  //     DropdownMenuItem(child: Text('Fsub5'),value: "fs5",),
  //   ],
  //   [
  //     DropdownMenuItem(child: Text('Ssub1'),value: "ss1",),
  //     DropdownMenuItem(child: Text('Ssub2'),value: "ss2",),
  //     DropdownMenuItem(child: Text('Ssub3'),value: "ss3",),
  //     DropdownMenuItem(child: Text('Ssub4'),value: "ss4",),
  //     DropdownMenuItem(child: Text('Ssub5'),value: "ss5",),
  //   ],
  //   [
  //     DropdownMenuItem(child: Text('Tsub1'),value: "ts1",),
  //     DropdownMenuItem(child: Text('Tsub2'),value: "ts2",),
  //     DropdownMenuItem(child: Text('Tsub3'),value: "ts3",),
  //     DropdownMenuItem(child: Text('Tsub4'),value: "ts4",),
  //     DropdownMenuItem(child: Text('Tsub5'),value: "ts5",),
  //   ],
  //   [
  //     DropdownMenuItem(child: Text('Bsub1'),value: "bs1",),
  //     DropdownMenuItem(child: Text('Bsub2'),value: "bs2",),
  //     DropdownMenuItem(child: Text('Bsub3'),value: "bs3",),
  //     DropdownMenuItem(child: Text('Bsub4'),value: "bs4",),
  //     DropdownMenuItem(child: Text('Bsub5'),value: "bs5",),
  //   ]
  // ];

  @override
  void initState(){
    super.initState();
    _loading=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tests'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: _value1,
                  hint: Text('class'),
                  items: [
                    DropdownMenuItem(child: Text('FE'),value: "FE",),
                    DropdownMenuItem(child: Text('SE'),value: "SE",),
                    DropdownMenuItem(child: Text('TE'),value: "TE",),
                    DropdownMenuItem(child: Text('BE'),value: "BE",),
                  ],
                  onChanged: (value) async{
                    _value1 = value;
                    sobj.getData(_value1).then((value) {
                      detail=value;
                      print(detail);
                      setState(() {
                        _loading=true;
                      });
                    });
                  },
                ),
                SizedBox(height: 20,),
                _loading ? DropdownButton(
                  value: _value2,
                  hint: Text('Select subject'),
                  items:[
                    DropdownMenuItem(child: Text(detail[0].subject),value: detail[0].subject,),
                    DropdownMenuItem(child: Text(detail[1].subject),value: detail[1].subject,),
                    DropdownMenuItem(child: Text(detail[2].subject),value: detail[2].subject,),
                    DropdownMenuItem(child: Text(detail[3].subject),value: detail[3].subject,),
                    DropdownMenuItem(child: Text(detail[4].subject),value: detail[4].subject,),
                  ],
                  onChanged: (value){
                    setState(() {
                      _value2 = value;
                    });
                  },
                ): Text("Select Class first"),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  maxLength: 80,
                  decoration: InputDecoration(
                    hintText: 'Enter Test Link',
                    labelText: 'Test Link',
                    focusedBorder: UnderlineInputBorder(),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _link = value;
                    });
                    //print(title);
                  },
                  controller: _controller1,
                  validator: (value) {
                    bool valid = Uri.tryParse(value)?.hasAbsolutePath ?? false;
                    if (!valid) {
                      return 'Enter a valid link';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: color2,
                  ),
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      _controller1.clear();
                      obj.putData(_value1,_value2,_link);
                    }
                  },
                  child: Text('Submit'),
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: color2,
                  ),
                  onPressed: (){
                    Navigator.push(context, ScaleRoute(page: TestList()));
                  },
                  child: Text('Previous uploads'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// To parse this JSON data, do
//
//     final testData = testDataFromJson(jsonString);

// List<TestData> testDataFromJson(String str) => List<TestData>.from(json.decode(str).map((x) => TestData.fromJson(x)));
//
// String testDataToJson(List<TestData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class TestData {
//   TestData({
//     this.id,
//     this.year,
//     this.subject,
//     this.link,
//     this.v,
//   });
//
//   String id;
//   String year;
//   String subject;
//   String link;
//   int v;
//
//   factory TestData.fromJson(Map<String, dynamic> json) => TestData(
//     id: json["_id"],
//     year: json["year"],
//     subject: json["subject"],
//     link: json["link"],
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "year": year,
//     "subject": subject,
//     "link": link,
//     "__v": v,
//   };
// }
