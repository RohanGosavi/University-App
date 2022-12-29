// To parse this JSON data, do
//
//     final assignmentData = assignmentDataFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


List<AssignmentData> assignmentDataFromJson(String str) => List<AssignmentData>.from(json.decode(str).map((x) => AssignmentData.fromJson(x)));

String assignmentDataToJson(List<AssignmentData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssignmentData {

  List<AssignmentData> data;
  var fname;

  AssignmentData({
    this.id,
    this.topic,
    this.year,
    this.subject,
    this.assignedBy,
    this.createDate,
    this.submissionDate,
    this.file,
    this.v,
  });

  String id;
  String topic;
  String year;
  String subject;
  String assignedBy;
  String createDate;
  String submissionDate;
  dynamic file;
  int v;

  factory AssignmentData.fromJson(Map<String, dynamic> json) => AssignmentData(
    id: json["_id"],
    topic: json["topic"],
    year: json["year"],
    subject: json["subject"],
    assignedBy: json["assignedBy"],
    createDate: json["createDate"],
    submissionDate: json["submissionDate"],
    file: json["file"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "topic": topic,
    "year": year,
    "subject": subject,
    "assignedBy": assignedBy,
    "createDate": createDate,
    "submissionDate": submissionDate,
    "file": file,
    "__v": v,
  };

  Future<bool> putData(topic,year,subject,assignedBy,submissionDate,filename) async{
    fname = filename;
    DateTime _date = DateTime.now();
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    //List<AssignmentData> data;
    var res = http.MultipartRequest('POST', Uri.parse('https://educationapp1.herokuapp.com/assignment/upload'));
    res.headers.addAll(headers);
    res.fields['topic'] = topic;
    res.fields['year'] = year;
    res.fields['subject'] = subject;
    res.fields['assignedBy'] = assignedBy;
    res.fields['createDate'] = "${_date.day}.${_date.month}.${_date.year}";
    res.fields['submissionDate'] = submissionDate;
    if(filename!=null) {
      res.files.add(await http.MultipartFile.fromPath('myFile', filename));
    }
      var request = await res.send();
      if(request.statusCode==200){
        print("done");
        return true;
      }else{
        print("not done");
        return false;
      }
    }

  Future<bool> getFile(assignfile,filename) async{
    try {
      final response = await http.post("https://educationapp1.herokuapp.com/assignment/download",
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "file":assignfile
          }));

      if (response.contentLength == 0){
        return false;
      }
      Directory tempDir = await getExternalStorageDirectory();
      RegExp pathToDownloads = new RegExp(r'.+0\/');
      final outputPath = '${pathToDownloads.stringMatch(tempDir.path).toString()}Download';
      print("here");
      print(outputPath);
      File file = new File('$outputPath/$filename');
      await file.writeAsBytes(response.bodyBytes);
      return true;
    }
    catch (value) {
      print(value);
      return false;
    }
  }

  Future<List<AssignmentData>> getData(year,subject) async{
    print(subject+Studentinfo.testyear);
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/assignment/get',headers: headers,body: json.encode({
      "year":year,
      "subject":subject
    }));
    if(res.statusCode==200){
      var jsonString = res.body;
      data = assignmentDataFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

  Future<List<AssignmentData>> getTeacherData(name) async{
    print(name);
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/assignment/getTeacher',headers: headers,body: json.encode({
      "assignedBy":name
    }));
    if(res.statusCode==200){
      var jsonString = res.body;
      data = assignmentDataFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

  Future<bool> deleteData(id) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.delete('https://educationapp1.herokuapp.com/assignment/delete/$id',headers: headers);
    if(res.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }


}