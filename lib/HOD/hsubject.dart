import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:flutter/material.dart';

class Hsubject extends StatefulWidget {
  const Hsubject({Key key}) : super(key: key);

  @override
  _HsubjectState createState() => _HsubjectState();
}

class _HsubjectState extends State<Hsubject> {

  SubjectData _obj = new SubjectData();
  final _controller = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String _year;
  String _sub;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Subject'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: _year,
                hint: Text('Select class'),
                items: [
                  DropdownMenuItem(child: Text('FE'),value: "FE",),
                  DropdownMenuItem(child: Text('SE'),value: "SE",),
                  DropdownMenuItem(child: Text('TE'),value: "TE",),
                  DropdownMenuItem(child: Text('BE'),value: "BE",),
                ],
                onChanged: (value){
                  setState(() {
                    _year = value;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Subject',
                  labelText: 'Subject',
                  focusedBorder: UnderlineInputBorder(),
                ),
                onChanged: (String value) {
                  setState(() {
                    _sub = value;
                  });
                  //print(title);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Subject!';
                  }
                  return null;
                },
                controller: _controller,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                child: Text("Submit"),
                onPressed: ()async {
                  if (_formKey.currentState.validate()) {
                    bool res = await _obj.putData(_year, _sub);
                    if (res) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Uploaded Successfully'),),);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Upload Fail'),),);
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Upload Fail'),),);
                  }
                }
              )
            ]
          ),
        ),
      ),
    );
  }
}
