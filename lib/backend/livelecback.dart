// To parse this JSON data, do
//
//     final livelecdata = livelecdataFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;


List<Livelecdata> livelecdataFromJson(String str) => List<Livelecdata>.from(json.decode(str).map((x) => Livelecdata.fromJson(x)));

String livelecdataToJson(List<Livelecdata> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Livelecdata {

  List<Livelecdata> data;

  Livelecdata({
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

  factory Livelecdata.fromJson(Map<String, dynamic> json) => Livelecdata(
    id: json["_id"],
    year: json["year"],
    subject: json["subject"],
    link: json["link"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "year": year,
    "subject": subject,
    "link": link,
    "__v": v,
  };

  Future<List<Livelecdata>> getData(year) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/livelec/get',headers: headers,body: json.encode({
      "year":year
    }));
    if(res.statusCode==200){
      var jsonString = res.body;
      data = livelecdataFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

  Future<void> putData(String _value1,String _value2,String _link) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/livelec',headers: headers,body: json.encode({
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
    var res = await http.delete('https://educationapp1.herokuapp.com/livelec/delete/$id',headers: headers);
    if(res.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }


}