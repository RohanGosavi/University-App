// To parse this JSON data, do
//
//     final studAssignData = studAssignDataFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


List<StudAssignData> studAssignDataFromJson(String str) => List<StudAssignData>.from(json.decode(str).map((x) => StudAssignData.fromJson(x)));

String studAssignDataToJson(List<StudAssignData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudAssignData {

  List<StudAssignData> data;

  var fname;
  StudAssignData({
    this.id,
    this.topic,
    this.year,
    this.subject,
    this.submittedBy,
    this.submissionDate,
    this.submitted,
    this.file,
    this.v,
  });

  String id;
  String topic;
  String year;
  String subject;
  String submittedBy;
  String submissionDate;
  bool submitted;
  String file;
  int v;

  factory StudAssignData.fromJson(Map<String, dynamic> json) => StudAssignData(
    id: json["_id"],
    topic: json["topic"],
    year: json["year"],
    subject: json["subject"],
    submittedBy: json["submittedBy"],
    submissionDate: json["submissionDate"],
    submitted: json["submitted"],
    file: json["file"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "topic": topic,
    "year": year,
    "subject": subject,
    "submittedBy": submittedBy,
    "submissionDate": submissionDate,
    "submitted": submitted,
    "file": file,
    "__v": v,
  };

  Future<bool> putData(topic,year,subject,submittedBy,submissionDate,submitted,filename) async{
    fname = filename;
    DateTime _date = DateTime.now();
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    var res = http.MultipartRequest('POST', Uri.parse('https://educationapp1.herokuapp.com/studentAssign/upload'));
    res.headers.addAll(headers);
    res.fields['topic'] = topic;
    res.fields['year'] = year;
    res.fields['subject'] = subject;
    res.fields['submittedBy'] = submittedBy;
    res.fields['submissionDate'] = submissionDate;
    res.fields['submitted'] = submitted.toString();
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

  Future<List<StudAssignData>> getData(year,sub) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/studentAssign/get',headers: headers,body: json.encode({
      "year":year,
      "subject":sub
    }));
    if(res.statusCode==200){
      var jsonString = res.body;
      data = studAssignDataFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

  Future<bool> deleteData(id) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.delete('https://educationapp1.herokuapp.com/studentAssign/delete/$id',headers: headers);
    if(res.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }


  Future<bool> getFile(assignfile,filename) async{
    try {
      final response = await http.post("https://educationapp1.herokuapp.com/studentAssign/download",
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


}

