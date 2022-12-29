// To parse this JSON data, do
//
//     final studyMaterial = studyMaterialFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


List<StudyMaterial> studyMaterialFromJson(String str) => List<StudyMaterial>.from(json.decode(str).map((x) => StudyMaterial.fromJson(x)));

String studyMaterialToJson(List<StudyMaterial> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudyMaterial {

  List<StudyMaterial> data;
  var fname;

  StudyMaterial({
    this.id,
    this.topic,
    this.year,
    this.subject,
    this.by,
    this.file,
    this.v,
  });

  String id;
  String topic;
  String year;
  String subject;
  String by;
  String file;
  int v;

  factory StudyMaterial.fromJson(Map<String, dynamic> json) => StudyMaterial(
    id: json["_id"],
    topic: json["topic"],
    year: json["year"],
    subject: json["subject"],
    by: json["by"],
    file: json["file"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "topic": topic,
    "year": year,
    "subject": subject,
    "by": by,
    "file": file,
    "__v": v,
  };



  Future<bool> putData(topic,year,subject,by,filename) async{
    fname = filename;
    DateTime _date = DateTime.now();
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    //List<AssignmentData> data;
    var res = http.MultipartRequest('POST', Uri.parse('https://educationapp1.herokuapp.com/studymaterial/upload'));
    res.headers.addAll(headers);
    res.fields['topic'] = topic;
    res.fields['year'] = year;
    res.fields['subject'] = subject;
    res.fields['by'] = by;
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

  Future<List<StudyMaterial>> getData(year,subject) async{
    //print(subject+Studentinfo.testyear);
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/studymaterial/get',headers: headers,body: json.encode({
      "year":year,
      "subject":subject
    }));
    if(res.statusCode==200){
      var jsonString = res.body;
      data = studyMaterialFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

  Future<List<StudyMaterial>> getTeacherData(name) async{
    print(name);
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/studymaterial/getTeacher',headers: headers,body: json.encode({
      "by":name
    }));
    if(res.statusCode==200){
      var jsonString = res.body;
      data = studyMaterialFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }


  Future<bool> getFile(assignfile,filename) async{
    try {
      final response = await http.post("https://educationapp1.herokuapp.com/studymaterial/download",
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


  Future<bool> deleteData(id) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.delete('https://educationapp1.herokuapp.com/studymaterial/delete/$id',headers: headers);
    if(res.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }


}
