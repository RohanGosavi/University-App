import 'package:bottom_navigation_demo/HOD/hodhome.dart';
import 'package:bottom_navigation_demo/student/account.dart';
import 'package:bottom_navigation_demo/student/blogs.dart';
import 'package:bottom_navigation_demo/student/feeds.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'file:///C:/Users/Rohan/AndroidStudioProjects/bottom_navigation_demo/lib/login.dart';
import 'package:bottom_navigation_demo/teacher/teacherHomePage.dart';
import 'package:bottom_navigation_demo/teacher/teacherAccount.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'HOD/hodacc.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var acctype = prefs.getString('acctype');
  var email = prefs.getString('email');
  var pass = prefs.getString('pass');
  //print(email+pass);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Education App',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: email==null && pass==null ? LoginPage() : acctype=='student' ? MyHomePage() : acctype=='teacher'? TeacherPage() : HHome(),
    )
  );
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selecteditem = 0;
  static List<Widget> _options = <Widget>[
    //Text('Home'),
    Home(),
    FeedPage(),
    //Text('Feeds'),
    // Text('Blogs'),
    Blog(),
    // Text('Account'),
    Account()
    //LoginPage(),
  ];

  void _tapped(int index) {
    setState(() {
      _selecteditem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      //backgroundColor: Color(0xFFCADCED),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('Gurucool'),
      // ),
      body: Center(
        child: _options.elementAt(_selecteditem),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: BottomNavigationBar(
          backgroundColor: Color(0x00ffffff),
          elevation: double.infinity,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home,color: Colors.black,size: 25,),
                label: 'Home',
                //backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.blur_circular,color: Colors.black,size: 25),
                label: 'Feed',
                //backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.all_out_outlined,color: Colors.black,size: 25),
                label: 'Blog',
                //backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle,color: Colors.black,size: 25),
                label: 'Account',
                //backgroundColor: Colors.white,
            ),
          ],
          currentIndex: _selecteditem,
          selectedItemColor: Colors.black,
          onTap: _tapped,
        ),
      ),
    );
  }
}

class TeacherPage extends StatefulWidget {
  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  int _selecteditem = 0;

  void _tapped(int index) {
    setState(() {
      _selecteditem = index;
    });
  }

  static List<Widget> _options = <Widget>[
    //Text('Home'),
    TeacherHomePage(),
    FeedPage(),
    Blog(),
    TeacherAccount()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _options.elementAt(_selecteditem),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: BottomNavigationBar(
          backgroundColor: Color(0x00ffffff),
          elevation: double.infinity,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.black,size: 25,),
              label: 'Home',
              //backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.blur_circular,color: Colors.black,size: 25),
              label: 'Feed',
              //backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.all_out_outlined,color: Colors.black,size: 25),
              label: 'Blog',
              //backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,color: Colors.black,size: 25),
              label: 'Account',
              //backgroundColor: Colors.white,
            ),
          ],
          currentIndex: _selecteditem,
          selectedItemColor: Colors.black,
          onTap: _tapped,
        ),
      ),
    );
  }
}


class HHome extends StatefulWidget {
  const HHome({Key key}) : super(key: key);

  @override
  _HHomeState createState() => _HHomeState();
}

class _HHomeState extends State<HHome> {
  int _selecteditem = 0;

  void _tapped(int index) {
    setState(() {
      _selecteditem = index;
    });
  }

  static List<Widget> _options = <Widget>[
    //Text('Home'),
    HODhome(),
    FeedPage(),
    Blog(),
    HODAccount()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _options.elementAt(_selecteditem),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: BottomNavigationBar(
          backgroundColor: Color(0x00ffffff),
          elevation: double.infinity,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.black,size: 25,),
              label: 'Home',
              //backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.blur_circular,color: Colors.black,size: 25),
              label: 'Feed',
              //backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.all_out_outlined,color: Colors.black,size: 25),
              label: 'Blog',
              //backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,color: Colors.black,size: 25),
              label: 'Account',
              //backgroundColor: Colors.white,
            ),
          ],
          currentIndex: _selecteditem,
          selectedItemColor: Colors.black,
          onTap: _tapped,
        ),
      ),
    );
  }
}
