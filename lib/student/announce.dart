import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Announce extends StatefulWidget {
  String announcement;
  Announce({this.announcement});
  @override
  _AnnounceState createState() => _AnnounceState();
}

class _AnnounceState extends State<Announce> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcement'),
      ),
      body :Center(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width-80,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        child: RichText(
          text: TextSpan(
            text: widget.announcement,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black)
          ),
        ),
      )
    )
    );
  }
}
