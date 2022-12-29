import 'package:bottom_navigation_demo/backend/blogback.dart';
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class AddBlog extends StatefulWidget {
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {

  String title;
  String desc;
  bool _submitted;
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  Icon icon1 = Icon(Icons.upload_rounded);
  Icon icon2 = Icon(Icons.assignment_turned_in_rounded);
  BlogData obj = new BlogData();
  String _image;
  String acctype;
  @override
  _loadID()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      acctype = prefs.getString("acctype");
    });
  }
  void initState(){
    super.initState();
    _loadID();
    _submitted = false;
  }

  void _openFileExp() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _submitted = true;
      });
      PlatformFile file = result.files.first;
      _image = file.path;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      _image = null;
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Blog'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  maxLength: 80,
                  decoration: InputDecoration(
                      hintText: 'write topic name',
                      labelText: 'Blog Topic',
                    focusedBorder: UnderlineInputBorder(),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      title = value;
                    });
                    print(title);
                  },
                  controller: _controller1,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5000,
                  minLines: 2,
                  maxLength: 5000,
                  decoration: InputDecoration(
                      hintText: 'write description',
                      labelText: 'Description',
                      focusedBorder: UnderlineInputBorder(),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      desc = value;
                    });
                    print(desc);
                  },
                  controller: _controller2,
                ),
                SizedBox(
                  height: 20,
                ),
                IconButton(
                  icon: _submitted ? icon2 : icon1,
                  onPressed: () {
                    _openFileExp();
                  },
                  iconSize: 40,
                ),
                Text(
                  _submitted ? 'Uploaded' : 'Upload Image',
                  style: TextStyle(fontSize: 20, color: color2),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: color2,
                  ),
                  onPressed: () async{
                    bool res;
                      if(title!=null && _submitted && desc!=null) {
                        res = await obj.putData(_image,acctype=='student'?Studentinfo.stname:acctype=='teacher'?Teacherinfo.tname:"HOD",title,desc);
                        if(res) {
                          setState(() {
                            _submitted = !_submitted;
                            title = null;
                            desc = null;
                            _controller1.clear();
                            _controller2.clear();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Uploaded'),
                            duration: Duration(seconds: 2),
                          ),
                          );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Upload Fail'),
                            duration: Duration(seconds: 2),
                          ),
                          );
                        }
                      }else{
                        print("no caption");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Enter All Data'),
                          duration: Duration(seconds: 2),
                        ),
                        );
                      }
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
