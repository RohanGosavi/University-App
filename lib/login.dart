import 'package:bottom_navigation_demo/student/homepage.dart' as homepage;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'backend/loginback.dart';
import 'main.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  var _formKey = GlobalKey<FormState>();
  String mail;
  String pass;

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  bool _loading =false;

  Login obj =new Login();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              SvgPicture.asset('assets/illustrations/login1.svg',height: MediaQuery.of(context).size.height/3,),
              // SizedBox(
              //   height: 25,
              // ),
              Text('Sinhgad College Of Engineering',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
              SizedBox(
                height: 25,
              ),
              Form(
                key: _formKey,
                child: Container(
                  //transform: Matrix4.translationValues(0, 30 , 1),
                  decoration: BoxDecoration(
                    color: homepage.color,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _controller1,
                          decoration: InputDecoration(
                            //hintText: '',
                            labelText: 'Username/Email',
                            focusedBorder: UnderlineInputBorder(),
                          ),
                          onChanged: (String value) {
                            mail = value;
                            print(mail);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a valid username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _controller2,
                          decoration: InputDecoration(
                            //hintText: '',
                            labelText: 'Password',
                            focusedBorder: UnderlineInputBorder(),
                          ),
                          onChanged: (String value) {
                            pass = value;
                            print(pass);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a valid password!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(32),
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: homepage.color2,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(child: _loading ? CircularProgressIndicator() : Text('Login',style: TextStyle(color: homepage.color1,fontSize: 20),)),
                          ),
                          onTap: () async{
                            if(_formKey.currentState.validate()){
                              _controller1.clear();
                              _controller2.clear();
                              // _handleSubmit();
                              Login data = await obj.getData(mail,pass);
                              print(data);
                              if(data!=null){
                                //globalid=data.id;
                                SharedPreferences prefs =  await SharedPreferences.getInstance();
                                prefs.setString('acctype', data.usertype);
                                prefs.setString("id", data.loginId);
                                prefs.setString('email', mail);
                                prefs.setString('pass', pass);
                                Navigator.pushReplacement(context, homepage.ScaleRoute(page: data.usertype =='student'?MyHomePage() : data.usertype =='teacher' ?TeacherPage() : HHome()));
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content:Text('Invalid Data'),
                                ),
                                );
                                setState(() {
                                  _loading = false;
                                });
                              }
                            }

                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('<In case you forgot credentials, contact HOD>'),
            ],
          ),
        ),
      ),
    );
  }
}
