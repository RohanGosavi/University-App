// To parse this JSON data, do
//
//     final subjectData = subjectDataFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

List<SubjectData> subjectDataFromJson(String str) => List<SubjectData>.from(json.decode(str).map((x) => SubjectData.fromJson(x)));

String subjectDataToJson(List<SubjectData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectData {
  List<SubjectData> data;

  SubjectData({
    this.id,
    this.year,
    this.subject,
    this.v,
  });

  String id;
  String year;
  String subject;
  int v;

  factory SubjectData.fromJson(Map<String, dynamic> json) => SubjectData(
    id: json["_id"],
    year: json["year"],
    subject: json["subject"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "year": year,
    "subject": subject,
    "__v": v,
  };

  Future<List<SubjectData>> getData(year) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/subjects/get',headers: headers,body: json.encode({
      "year":year
    }));
    if(res.statusCode==200){
      var jsonString = res.body;
      data = subjectDataFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

  Future<List<SubjectData>> getAll() async{
    var res = await http.get('https://educationapp1.herokuapp.com/subjects/getAll');
    if(res.statusCode==200){
      var jsonString = res.body;
      data = subjectDataFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

  Future<bool>putData(pyear,psub)async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post("https://educationapp1.herokuapp.com/subjects/add",headers: headers, body: json.encode({
      "year":pyear,
      "subject":psub
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
    var res = await http.delete('https://educationapp1.herokuapp.com/subjects/delete/$id',headers: headers);
    if(res.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }

}
