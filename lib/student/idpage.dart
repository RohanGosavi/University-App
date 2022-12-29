import "package:flutter/material.dart";
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IDPage extends StatefulWidget {
  @override
  _IDPageState createState() => _IDPageState();
}

class _IDPageState extends State<IDPage> {
  String id;
  bool _loading;
  _loadID()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getString("id");
  }

  @override
  void initState(){
    super.initState();
    _loading=false;
    _loadID().whenComplete((){
      setState(() {
        _loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ID"),
      ),
      body: Center(
        child:_loading? QrImage(
          data: id,
          version: QrVersions.auto,
          size: 200,
        ):CircularProgressIndicator()
      ),
    );
  }
}
