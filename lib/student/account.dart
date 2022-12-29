import 'file:///C:/Users/Rohan/AndroidStudioProjects/bottom_navigation_demo/lib/login.dart';
import 'package:bottom_navigation_demo/student/allsub.dart';
import 'package:bottom_navigation_demo/student/allteachers.dart';
import 'package:bottom_navigation_demo/student/idpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bottom_navigation_demo/backend/studentback.dart';


import 'homepage.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {


  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: color1,
                boxShadow: shadows,
                shape: BoxShape.circle
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: (){
                  },
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Profile'),
            SvgPicture.asset('assets/illustrations/profile.svg',height: 75,),
          ],
        ),
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.account_circle,size: 70,),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Studentinfo.stname !=null ? Studentinfo.stname : "-",style: TextStyle(fontSize: 20),),
                      Text(Studentinfo.testyear!=null ? Studentinfo.testyear+"\n"+Studentinfo.unirollnum : "-",style: TextStyle(fontSize: 15),),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     height: 80,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //       boxShadow: shadows,
              //       color: color,
              //       borderRadius: BorderRadius.all(Radius.circular(20)),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(15.0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Text('500',style: TextStyle(fontSize: 20),),
              //               //SizedBox(height: 5,),
              //               Text('Followers')
              //             ],
              //           ),
              //           Spacer(),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Text('5',style: TextStyle(fontSize: 20),),
              //               //SizedBox(height: 5,),
              //               Text('Following')
              //             ],
              //           ),
              //           Spacer(),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Text('5',style: TextStyle(fontSize: 20),),
              //               //SizedBox(height: 5,),
              //               Text('Posts')
              //             ],
              //           ),
              //           Spacer(),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Text('5',style: TextStyle(fontSize: 20),),
              //               //SizedBox(height: 5,),
              //               Text('Blogs')
              //             ],
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, ScaleRoute(page: IDPage()));
                    },
                    child: Container(
                      height: 100,
                      width:120,
                      decoration: BoxDecoration(
                        boxShadow: shadows,
                        color: color1,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(child: Text('MY ID')),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, ScaleRoute(page: AllSubject()));
                    },
                    child: Container(
                      height: 100,
                      width:120,
                      decoration: BoxDecoration(
                        boxShadow: shadows,
                        color: color1,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(child: Text('My Subjects')),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, ScaleRoute(page: AllTeachers()));
                    },
                    child: Container(
                      height: 100,
                      width:120,
                      decoration: BoxDecoration(
                        boxShadow: shadows,
                        color: color1,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(child: Text('My Teachers')),
                    ),
                  ),
                  // Container(
                  //   height: 100,
                  //   width:120,
                  //   decoration: BoxDecoration(
                  //     boxShadow: shadows,
                  //     color: color1,
                  //     borderRadius: BorderRadius.all(Radius.circular(20)),
                  //   ),
                  //   child: Center(child: Text('Leaderboard')),
                  // ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: color2,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(child: Text('Logout',style: TextStyle(color: color1,fontSize: 20),)),
                ),
                onTap: ()async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('email');
                  prefs.remove('pass');
                  Navigator.pushReplacement(context, ScaleRoute(page: LoginPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
