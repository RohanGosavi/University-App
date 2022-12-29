import 'package:bottom_navigation_demo/backend/feedsback.dart';
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

class uploadPost extends StatefulWidget {
  @override
  _uploadPostState createState() => _uploadPostState();
}

class _uploadPostState extends State<uploadPost> {

  bool _submitted;
  Icon icon1 = Icon(Icons.upload_rounded);
  Icon icon2 = Icon(Icons.assignment_turned_in_rounded);
  final fieldText = TextEditingController();
  String caption;
  FeedData obj = new FeedData();
  String _image;
  String id;
  String acctype;

  _loadID()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id");
      acctype = prefs.getString("acctype");
    });
  }

  @override
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Upload Post'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                    //filled: true,
                    //fillColor: color,
                    //border: OutlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(),
                    hintText: 'Write about post',
                    labelText: 'Caption'),
                onChanged: (String value) {
                  setState(() {
                    caption = value;
                  });
                  print(caption);
                },
                controller: fieldText,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: color2,
              ),
              onPressed: () async{
                print('pressed');
                bool res;
                if(caption!=null && _submitted) {
                  res = await obj.putData(_image,acctype=='student'?Studentinfo.stname:acctype=='teacher'?Teacherinfo.tname:"HOD",id, caption);
                  if(res){
                    setState(() {
                      _submitted = !_submitted;
                      caption = null;
                      fieldText.clear();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Uploaded'),
                      duration: Duration(seconds: 2),
                    ),
                    );
                    //Navigator.pop(context);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Upload Fail'),
                    ),
                    );
                  }
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Enter All Data'),
                  ),
                  );
                  print("no caption");
                }
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
