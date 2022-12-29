// To parse this JSON data, do
//
//     final studentinfo = studentinfoFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';




Studentinfo studentinfoFromJson(String str) => Studentinfo.fromJson(json.decode(str));
List<Studentinfo> allstudDataFromJson(String str) => List<Studentinfo>.from(json.decode(str).map((x) => Studentinfo.fromJson(x)));


String studentinfoToJson(Studentinfo data) => json.encode(data.toJson());

class Studentinfo {

  Studentinfo detail;
  List<Studentinfo>data;
  static String globalid;
  static String testyear;
  static String unirollnum;
  static String stname;

  Studentinfo({
    this.savedfeedid,
    this.savedblogid,
    this.id,
    this.studentinfoId,
    this.uniroll,
    this.name,
    this.email,
    this.year,
    this.div,
    this.phone,
    this.address,
    this.v,
  });

  List<int> savedfeedid;
  List<int> savedblogid;
  String id;
  String studentinfoId;
  String uniroll;
  String name;
  String email;
  String year;
  int div;
  int phone;
  String address;
  int v;

  factory Studentinfo.fromJson(Map<String, dynamic> json) => Studentinfo(
    savedfeedid: List<int>.from(json["savedfeedid"].map((x) => x)),
    savedblogid: List<int>.from(json["savedblogid"].map((x) => x)),
    id: json["_id"],
    studentinfoId: json["id"],
    uniroll: json["uniroll"],
    name: json["name"],
    email: json["email"],
    year: json["year"],
    div: json["div"],
    phone: json["phone"],
    address: json["address"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "savedfeedid": List<dynamic>.from(savedfeedid.map((x) => x)),
    "savedblogid": List<dynamic>.from(savedblogid.map((x) => x)),
    "_id": id,
    "id": studentinfoId,
    "uniroll": uniroll,
    "name": name,
    "email": email,
    "year": year,
    "div": div,
    "phone": phone,
    "address": address,
    "__v": v,
  };

  Future<Studentinfo> getStudentData() async{
    print(Studentinfo.globalid);
    Map<String, String> headers = {"Content-type": "application/json"};
    print("get");
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    var res = await http.post('https://educationapp1.herokuapp.com/student/get',headers: headers,body: json.encode({
      "id":id
    }));
    print(res.statusCode);
    if(res.statusCode==200){
      print("studentinfo");
      var jsonString = res.body;
      print(jsonString);
      detail = studentinfoFromJson(jsonString);
      globalid = detail.studentinfoId;
      testyear = detail.year;
      unirollnum = detail.uniroll;
      stname = detail.name;
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

  Future<bool> putStudentData(id,uniroll,name,email,year,div,phone,address) async {
    print(Studentinfo.globalid);
    Map<String, String> headers = {"Content-type": "application/json"};
    print("put student");
    var res = await http.post('https://educationapp1.herokuapp.com/student/add', headers: headers, body: json.encode({
      "id":id,
      "uniroll":uniroll,
      "name":name,
      "email":email,
      "year":year,
      "div":div,
      "phone":phone,
      "address":address
    }));
    print(res.statusCode);
    if (res.statusCode == 200) {
      print("studentinfo");
      var jsonString = res.body;
       print(jsonString);
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

  Future<List<Studentinfo>>getAll(syear)async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/student/getAll',headers: headers,body: json.encode({
      "year":syear
    }));
    if(res.statusCode==200){
      var jsonString = res.body;
      data = allstudDataFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

}
