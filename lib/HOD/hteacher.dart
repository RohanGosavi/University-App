import 'package:bottom_navigation_demo/backend/loginback.dart';
import 'package:bottom_navigation_demo/backend/subjectback.dart';
import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Hteacher extends StatefulWidget {
  const Hteacher({Key key}) : super(key: key);

  @override
  _HteacherState createState() => _HteacherState();
}

class _HteacherState extends State<Hteacher> {

  SubjectData sobj = new SubjectData();
  List<SubjectData> detail;

  Teacherinfo obj = new Teacherinfo();
  Login _lobj = new Login();
  String _name;
  String _educationqual;
  String _email;
  String _address;
  String _id;
  int _phone;
  List<String> _sub;
  String _username;
  String _password;
  bool _loading;
  dynamic _items;

  @override
  void initState(){
    super.initState();
    _loading=false;
    sobj.getAll().then((value) {
      _items = value.map((sub) => MultiSelectItem<String>(sub.subject, sub.subject)).toList();
      detail=value;
      print(detail);
      setState(() {
        _loading=true;
      });
    });
  }

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();
  final _controller5 = TextEditingController();
  final _controller6 = TextEditingController();
  final _controller7 = TextEditingController();
  final _controller8 = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Teacher'),
      ),
      body: _loading ? Form(
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
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Name',
                      labelText: 'teacher name',
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
                    controller: _controller3,
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
                    controller: _controller4,
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Educational Qualification',
                      labelText: 'Edu. Qualification',
                      focusedBorder: UnderlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _educationqual = value;
                      });
                      //print(title);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter qual!';
                      }
                      return null;
                    },
                    controller: _controller5,
                  ),
                  SizedBox(height: 8,),
                  MultiSelectDialogField(
                    title: Text("Select Subjects"),
                    listType: MultiSelectListType.CHIP,
                    selectedColor: color.withOpacity(0.5),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all( width: 1,),
                    ),
                    buttonText: Text(
                      "Select Subjects",
                      style: TextStyle(
                        color: color2,
                        fontSize: 16,
                      ),
                    ),
                    items: _items,
                    onConfirm: (results) {
                      _sub = results.cast<String>();
                    },
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
                        return 'Enter valid Phone no.!';
                      }
                      return null;
                    },
                    controller: _controller6,
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
                    controller: _controller7,
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
                    controller: _controller8,
                  ),
                  SizedBox(height: 8,),
                  ElevatedButton(
                    child: Text("Submit"),
                    onPressed: ()async{
                      if(_formKey.currentState.validate()){
                        bool res = await obj.putTeacherData(_id,_name,_email,_phone,_address,_educationqual,_sub);
                        bool res1 = await _lobj.putData(_id, _username, _password,"teacher");
                        print(res);
                        print(res1);
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
      ):Center(child: CircularProgressIndicator(),)
    );
  }
}
