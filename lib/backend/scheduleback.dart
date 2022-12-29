// To parse this JSON data, do
//
//     final scheduleData = scheduleDataFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;


List<ScheduleData> scheduleDataFromJson(String str) => List<ScheduleData>.from(json.decode(str).map((x) => ScheduleData.fromJson(x)));

String scheduleDataToJson(List<ScheduleData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleData {

  List<ScheduleData> data;

  ScheduleData({
    this.id,
    this.year,
    this.day,
    this.subject,
    this.teacher,
    this.time,
    this.v,
  });

  String id;
  String year;
  String day;
  String subject;
  String teacher;
  String time;
  int v;

  factory ScheduleData.fromJson(Map<String, dynamic> json) => ScheduleData(
    id: json["_id"],
    year: json["year"],
    day: json["day"],
    subject: json["subject"],
    teacher: json["teacher"],
    time: json["time"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "year": year,
    "day": day,
    "subject": subject,
    "teacher": teacher,
    "time": time,
    "__v": v,
  };

  Future<List<ScheduleData>> getData(year,day) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/schedule/get',headers: headers,body: json.encode({
      "year":year,
      "day":day
    }));
    if(res.statusCode==200){
      var jsonString = res.body;
      data = scheduleDataFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

  Future<bool> putData(dyear,dday,dsubject,dteacher,dtime) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/schedule',headers: headers,body: json.encode({
      "year": dyear,
      "day":dday,
      "subject": dsubject,
      "teacher": dteacher,
      "time":dtime
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
    var res = await http.delete('https://educationapp1.herokuapp.com/schedule/delete/$id',headers: headers);
    if(res.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }

}
