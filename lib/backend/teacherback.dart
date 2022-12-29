// To parse this JSON data, do
//
//     final teacherinfo = teacherinfoFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:shared_preferences/shared_preferences.dart';

Teacherinfo teacherinfoFromJson(String str) => Teacherinfo.fromJson(json.decode(str));

List<Teacherinfo> teacherDataFromJson(String str) => List<Teacherinfo>.from(json.decode(str).map((x) => Teacherinfo.fromJson(x)));

String teacherinfoToJson(Teacherinfo data) => json.encode(data.toJson());

class Teacherinfo {
  List<Teacherinfo> data;

  Teacherinfo detail;
  static String globalid;
  static String tname;

  Teacherinfo({
    this.subjects,
    this.savedfeedid,
    this.savedblogid,
    this.id,
    this.teacherinfoId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.educationqual,
    this.v,
  });

  List<String> subjects;
  List<int> savedfeedid;
  List<dynamic> savedblogid;
  String id;
  String teacherinfoId;
  String name;
  String email;
  int phone;
  String address;
  String educationqual;
  int v;

  factory Teacherinfo.fromJson(Map<String, dynamic> json) => Teacherinfo(
    subjects: List<String>.from(json["subjects"].map((x) => x)),
    savedfeedid: List<int>.from(json["savedfeedid"].map((x) => x)),
    savedblogid: List<dynamic>.from(json["savedblogid"].map((x) => x)),
    id: json["_id"],
    teacherinfoId: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    educationqual: json["educationqual"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "subjects": List<dynamic>.from(subjects.map((x) => x)),
    "savedfeedid": List<dynamic>.from(savedfeedid.map((x) => x)),
    "savedblogid": List<dynamic>.from(savedblogid.map((x) => x)),
    "_id": id,
    "id": teacherinfoId,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "educationqual": educationqual,
    "__v": v,
  };

  Future<Teacherinfo> getTeacherData() async{
    //print(Stu.globalid);
    Map<String, String> headers = {"Content-type": "application/json"};
    print("get");
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    var res = await http.post('https://educationapp1.herokuapp.com/teacher/get',headers: headers,body: json.encode({
      "id":id
    }));
    print(res.statusCode);
    if(res.statusCode==200){
      print("studentinfo");
      var jsonString = res.body;
      // var jsonmap = json.decode(jsonString);
      print(jsonString);
      detail = teacherinfoFromJson(jsonString);
      tname = detail.name;
      // testyear = detail.year;
      // unirollnum = detail.uniroll;
      tname = detail.name;
      print('here');
      return detail;
    }else if(res.statusCode==404){
      print('here2');
      return null;
    }else{
      print('here3');
      return null;
    }
  }

  Future<bool> putTeacherData(id,name,email,phone,address,educationqualification,sub) async {
    //print(Studentinfo.globalid);
    Map<String, String> headers = {"Content-type": "application/json"};
    print("put student");
    var res = await http.post('https://educationapp1.herokuapp.com/teacher/add', headers: headers, body: json.encode({
      "id":id,
      "name":name,
      "email":email,
      "phone":phone,
      "address":address,
      "educationqual": educationqualification,
      "subjects": sub,
    }));
    print(res.statusCode);
    if (res.statusCode == 200) {
      print("studentinfo");
      var jsonString = res.body;
      // var jsonmap = json.decode(jsonString);
      print(jsonString);
      // detail = teacherinfoFromJson(jsonString);
      // globals.globalname = detail.name;
      print('here');
      return true;
    } else if (res.statusCode == 404) {
      print('here2');
      return false;
    } else {
      print('here3');
      return false;
    }
  }

  Future<List<Teacherinfo>> getAll() async{
    var res = await http.get('https://educationapp1.herokuapp.com/teacher/');
    if(res.statusCode==200){
      var jsonString = res.body;
      data = teacherDataFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }
}