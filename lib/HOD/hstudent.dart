import 'package:bottom_navigation_demo/backend/loginback.dart';
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Hstudent extends StatefulWidget {
  const Hstudent({Key key}) : super(key: key);

  @override
  _HstudentState createState() => _HstudentState();
}

class _HstudentState extends State<Hstudent> {

  Studentinfo obj = new Studentinfo();
  Login _lobj = new Login();
  String _year;
  String _name;
  String _uniroll;
  String _email;
  String _address;
  String _id;
  int _div;
  int _phone;
  String _username;
  String _password;

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();
  final _controller5 = TextEditingController();
  final _controller6 = TextEditingController();
  final _controller7 = TextEditingController();
  final _controller8 = TextEditingController();
  final _controller9 = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add student'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 8,),
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
                  SizedBox(height: 8,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Student Name',
                      labelText: 'student name',
                      focusedBorder: UnderlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _name = value;
                      });
                      //print(title);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Name!';
                      }
                      return null;
                    },
                    controller: _controller1,
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter ID',
                      labelText: 'ID',
                      focusedBorder: UnderlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _id = value;
                      });
                      //print(title);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter ID!';
                      }
                      return null;
                    },
                    controller: _controller2,
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter university roll no.',
                      labelText: 'university roll no.',
                      focusedBorder: UnderlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _uniroll = value;
                      });
                      //print(title);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter valid roll no.!';
                      }
                      return null;
                    },
                    controller: _controller3,
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter email',
                      labelText: 'email',
                      focusedBorder: UnderlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _email = value;
                      });
                      //print(title);
                    },
                    validator: (value) {
                      if (value.isEmpty || !EmailValidator.validate(value)) {
                        return 'Enter valid email!';
                      }
                      return null;
                    },
                    controller: _controller4,
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Address',
                      labelText: 'Address',
                      focusedBorder: UnderlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _address = value;
                      });
                      //print(title);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter address!';
                      }
                      return null;
                    },
                    controller: _controller5,
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Division',
                      labelText: 'Divison',
                      focusedBorder: UnderlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _div = int.parse(value);
                      });
                      //print(title);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Division!';
                      }
                      return null;
                    },
                    controller: _controller6,
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Phone no.',
                      labelText: 'Phone no.',
                      focusedBorder: UnderlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _phone = int.parse(value);
                      });
                      //print(title);
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length!=10) {
                        return 'Enter Valid Phone no.!';
                      }
                      return null;
                    },
                    controller: _controller7,
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Username',
                      labelText: 'Username',
                      focusedBorder: UnderlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _username = value;
                      });
                      //print(title);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Username!';
                      }
                      return null;
                    },
                    controller: _controller8,
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Password',
                      labelText: 'Password',
                      focusedBorder: UnderlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _password = value;
                      });
                      //print(title);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Password!';
                      }
                      return null;
                    },
                    controller: _controller9,
                  ),
                  SizedBox(height: 8,),
                  ElevatedButton(
                    child: Text("Submit"),
                    onPressed: ()async{
                      if(_formKey.currentState.validate()){
                        bool res = await obj.putStudentData(_id,_uniroll,_name,_email,_year,_div,_phone,_address);
                        bool res1 = await _lobj.putData(_id, _username, _password,"student");
                        if(res && res1){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Uploaded Successfully'),),);
                          _controller1.clear();
                          _controller2.clear();
                          _controller3.clear();
                          _controller4.clear();
                          _controller5.clear();
                          _controller6.clear();
                          _controller7.clear();
                          _controller8.clear();
                          _controller9.clear();
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Upload fail, id might already exist'),),);
                        }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Upload fail'),),);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
