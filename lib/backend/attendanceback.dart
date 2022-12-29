// To parse this JSON data, do
//
//     final attendance = attendanceFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;


List<Attendance> attendanceFromJson(String str) => List<Attendance>.from(json.decode(str).map((x) => Attendance.fromJson(x)));

String attendanceToJson(List<Attendance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Attendance {

  List<Attendance> data;

  Attendance({
    this.attendancelist,
    this.id,
    this.year,
    this.date,
    this.subject,
    this.v,
  });

  List<int> attendancelist;
  String id;
  String year;
  String date;
  String subject;
  int v;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    attendancelist: List<int>.from(json["attendancelist"].map((x) => x)),
    id: json["_id"],
    year: json["year"],
    date: json["date"],
    subject: json["subject"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "attendancelist": List<dynamic>.from(attendancelist.map((x) => x)),
    "_id": id,
    "year": year,
    "date": date,
    "subject": subject,
    "__v": v,
  };

  Future<bool> putData(dyear,ddate,dsubject,dlist) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/attendance',headers: headers,body: json.encode({
      "year": dyear,
      "date":ddate,
      "subject": dsubject,
      "attendancelist":dlist
    }));
    if(res.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }

  Future<List<Attendance>> getData(year,subject) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/attendance/get',headers: headers,body: json.encode({
      "year":year,
      "subject":subject
    }));
    if(res.statusCode==200){
      var jsonString = res.body;
      data = attendanceFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

}
