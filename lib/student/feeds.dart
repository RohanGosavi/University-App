//import 'file:///C:/Users/Rohan/AndroidStudioProjects/bottom_navigation_demo/lib/student/homepage.dart';
//import 'file:///C:/Users/Rohan/AndroidStudioProjects/bottom_navigation_demo/lib/student/upload_post.dart';
import 'package:bottom_navigation_demo/backend/feedsback.dart';
import 'package:bottom_navigation_demo/student/homepage.dart';
import 'package:bottom_navigation_demo/student/upload_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with SingleTickerProviderStateMixin {
  // bool _isVisible =false;
  FeedData obj = new FeedData();
  List<FeedData> _list;
  bool _loading;
  Icon _likedicon = Icon(Icons.favorite);
  Icon _tolikeicon = Icon(Icons.favorite_border);
  Icon _tosave = Icon(Icons.bookmark_border,size: 35,);
  Icon _saved = Icon(Icons.bookmark,size: 35,);
  bool _savefeed;
  int likecount;
  String id;
  int length;

  _loadID()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id");
    });
  }

  @override
  void initState() {
    super.initState();
    _savefeed = false;
    _loading = false;
    _loadID();
    obj.getAll().then((value){
      _list = value;
      print(_list);
      setState(() {
        length = _list.length;
        _loading = true;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    //int _widgetIndex = 0;
    // obj.getAll().then((value){
    //   _list = value;
    //   print(_list);
    //   setState(() {
    //     length = _list.length;
    //     _loading = true;
    //   });
    // });
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        actions: [
          IconButton(
            iconSize: 30,
            color: color2,
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, ScaleRoute(page: uploadPost()));
            },
          )
        ],
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Feeds'),
            SvgPicture.asset('assets/illustrations/post.svg',height: 75,),
          ],
        ),
        elevation: 4,
      ),
      body: SafeArea(
        child: _loading ? _list.length==0 ? Center(child: Text("No Data"),) : ListView.builder(
          //controller: PageController(viewportFraction: 0.95),
          scrollDirection: Axis.vertical,
          itemCount: _list.length,
          itemBuilder: (cnxt, i) => Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            //height: MediaQuery.of(context).size.height - 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              //color: color1,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              //boxShadow: shadows,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _list[length-i-1].name,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                // SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(_list[length-i-1].desc, style: TextStyle(fontSize: 15)),
                ),
                Divider(
                  thickness: 2,
                  //height: 5,
                ),
                Container(
                  //width: 350,
                  //height: MediaQuery.of(context).size.height - 300,
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage("https://educationapp1.herokuapp.com/${_list[length-i-1].image}"),
                  ),
                ),
                Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(_list[length-i-1].likes.length.toString() + ' Likes',
                      style: TextStyle(fontSize: 15),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  child: Row(
                    children: [
                      IconButton(
                          icon: _list[length-i-1].likes.contains(id)
                              ? _likedicon
                              : _tolikeicon,
                          onPressed: () {
                            setState(() {
                              if (_list[length-i-1].likes.contains(id)) {
                                _list[length-i-1].likes.remove(id);
                                //print(Studentinfo.globalid);
                                obj.deletelike(_list[length-i-1].id, id);
                              } else {
                                _list[length-i-1].likes.add(id);
                                obj.addlike(_list[length-i-1].id,id);
                              }
                            });
                          }),
                      Spacer(),
                      IconButton(
                          icon: _savefeed ? _saved : _tosave,
                          onPressed: () {
                            setState(() {
                              _savefeed = !_savefeed;
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ):Center(child: CircularProgressIndicator(),)
      ),
    );
  }
}

