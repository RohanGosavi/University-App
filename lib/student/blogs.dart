import 'package:bottom_navigation_demo/backend/blogback.dart';
import 'package:bottom_navigation_demo/student/add_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'homepage.dart';


class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {

  BlogData obj = new BlogData();
  List<BlogData> _list;
  bool _loading;
  Icon _likedicon = Icon(Icons.favorite);
  Icon _tolikeicon = Icon(Icons.favorite_border);
  int likecount;
  String id;
  int length;



  @override
  void initState() {
    super.initState();
    _loading = false;
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
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        actions: [
          IconButton(
            iconSize: 30,
            color: color2,
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, ScaleRoute(page: AddBlog()));
            },
          )
        ],
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Blogs'),
            SvgPicture.asset('assets/illustrations/blogging.svg',height: 75,),
          ],
        ),
        elevation: 4,
      ),
      body: SafeArea(
        child: _loading ? _list.length==0 ? Center(child: Text("No Data"),) :ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _list.length,
          itemBuilder: (cxt,i)=>Container(
            width: MediaQuery.of(context).size.width,
            //color: color1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                Text(_list[length-i-1].topic, style: TextStyle(fontSize: 17),),
                Divider(thickness: 2,),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Container(
                    child: Text(
                      _list[length-i-1].desc,
                      style: TextStyle(
                        fontSize: 17,
                        color: color2
                      ),
                    ),
                  ),
                ),
                Container(
                  //width: 350,
                  height: 200,
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage("https://educationapp1.herokuapp.com/${_list[length-i-1].image}"),
                  ),
                ),
                Divider(thickness: 4,),
              ],
            ),
          ),
        ):Center(child: CircularProgressIndicator(),)
      ),
    );
  }
}
