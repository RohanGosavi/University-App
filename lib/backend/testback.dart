import 'dart:convert';
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:http/http.dart' as http;



List<TestData> testFromJson(String str) => List<TestData>.from(json.decode(str).map((x) => TestData.fromJson(x)));

String testToJson(List<TestData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestData {
  List<TestData> data;

  TestData({
    this.id,
    this.year,
    this.subject,
    this.link,
    this.v,
  });

  String id;
  String year;
  String subject;
  String link;
  int v;

  factory TestData.fromJson(Map<String, dynamic> json) => TestData(
    id: json["_id"],
    year: json["year"],
    subject: json["subject"],
    link: json["link"] == null ? null : json["link"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "year": year,
    "subject": subject,
    "link": link == null ? null : link,
    "__v": v,
  };

  Future<List<TestData>> getData(year) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/testlink/get',headers: headers,body: json.encode({
      "year":year
    }));
    if(res.statusCode==200){
      var jsonString = res.body;
      data = testFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

  Future<void> putData(String _value1,String _value2,String _link) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/testlink',headers: headers,body: json.encode({
      "year": _value1,
      "subject": _value2,
      "link": _link
    }));
    if(res.statusCode==200){
      print("done");
    }else{
      print("not done");
    }
  }

  Future<bool> deleteData(id) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.delete('https://educationapp1.herokuapp.com/testlink/delete/$id',headers: headers);
    if(res.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }

}