// To parse this JSON data, do
//
//     final announcementlist = announcementlistFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bottom_navigation_demo/backend/studentback.dart';

List<Announcementlist> announcementlistFromJson(String str) => List<Announcementlist>.from(json.decode(str).map((x) => Announcementlist.fromJson(x)));

String announcementlistToJson(List<Announcementlist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Announcementlist {

  List<Announcementlist> datalist;

  Announcementlist({
    this.id,
    this.announcement,
    this.year,
    this.by,
    this.v,
  });

  String id;
  String announcement;
  String year;
  String by;
  int v;

  factory Announcementlist.fromJson(Map<String, dynamic> json) => Announcementlist(
    id: json["_id"],
    announcement: json["announcement"],
    year: json["year"],
    by: json["by"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "announcement": announcement,
    "year": year,
    "by": by,
    "__v": v,
  };

  Future<List<Announcementlist>> getData() async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/announcement/get',headers: headers,body: json.encode({
      "year":Studentinfo.testyear
    }));
    if(res.statusCode==200){
      var jsonString = res.body;
      // var jsonmap = json.decode(jsonString);
      datalist = announcementlistFromJson(jsonString);
      print(datalist);
      return datalist;
    }else{
      return null;
    }
  }

  Future<bool> putData(String announce,String year,String by) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/announcement/add',headers: headers,body: json.encode({
      "announcement":announce,
      "year":year,
      "by":by
    }));
    if(res.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }

  Future<bool> deleteData(id) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.delete('https://educationapp1.herokuapp.com/announcement/delete/$id',headers: headers);
    if(res.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }

  Future<List<Announcementlist>> getTeacherData(name) async{
    print(name);
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/announcement/getTeacher',headers: headers,body: json.encode({
      "by":name
    }));
    // var res = await http.get('https://educationapp1.herokuapp.com/testlink');
    if(res.statusCode==200){
      var jsonString = res.body;
      datalist = announcementlistFromJson(jsonString);
      print(datalist);
      return datalist;
    }else{
      return null;
    }
  }

}

