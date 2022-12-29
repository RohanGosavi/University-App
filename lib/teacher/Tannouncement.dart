import 'package:bottom_navigation_demo/backend/announcementback.dart';
import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:flutter/material.dart';

import 'announcelist.dart';

class Tannouncement extends StatefulWidget {
  @override
  _TannouncementState createState() => _TannouncementState();
}

class _TannouncementState extends State<Tannouncement> {

  Announcementlist obj = new Announcementlist();
  String _value1;
  String _link;
  final _controller1 = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcement'),
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
                  hint: Text('Select class'),
                  items: [
                    DropdownMenuItem(child: Text('FE'),value: "FE",),
                    DropdownMenuItem(child: Text('SE'),value: "SE",),
                    DropdownMenuItem(child: Text('TE'),value: "TE",),
                    DropdownMenuItem(child: Text('BE'),value: "BE",),
                  ],
                  onChanged: (value){
                    setState(() {
                      _value1 = value;
                    });
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  maxLength: 5000,
                  maxLines: 5000,
                  minLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Enter Announcement',
                    labelText: 'Announcement',
                    focusedBorder: UnderlineInputBorder(),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _link = value;
                    });
                    //print(title);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Assignment topic!';
                    }
                    return null;
                  },
                  controller: _controller1,
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: color2,
                  ),
                  onPressed: ()async{
                    if(_formKey.currentState.validate()) {
                      _controller1.clear();
                      bool res = await obj.putData(_link, _value1, Teacherinfo.tname);
                      if(res) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Uploaded Successfully'),),);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Upload fail'),),);
                      }
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
                    Navigator.push(context, ScaleRoute(page: AnnouncelistPage(name: Teacherinfo.tname,)));
                  },
                  child: Text('Announcements List'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
