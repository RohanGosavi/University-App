// To parse this JSON data, do
//
//     final feedData = feedDataFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

List<FeedData> feedDataFromJson(String str) => List<FeedData>.from(json.decode(str).map((x) => FeedData.fromJson(x)));

String feedDataToJson(List<FeedData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedData {
  List<FeedData> data;
  var fname;
  FeedData({
    this.likes,
    this.id,
    this.image,
    this.name,
    this.studentid,
    this.desc,
    this.v,
  });

  List<dynamic> likes;
  String id;
  String image;
  String name;
  String studentid;
  String desc;
  int v;

  factory FeedData.fromJson(Map<String, dynamic> json) => FeedData(
    likes: List<dynamic>.from(json["likes"].map((x) => x)),
    id: json["_id"],
    image: json["image"],
    name: json["name"],
    studentid: json["studentid"],
    desc: json["desc"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "likes": List<dynamic>.from(likes.map((x) => x)),
    "_id": id,
    "image": image,
    "name": name,
    "studentid": studentid,
    "desc": desc,
    "__v": v,
  };


  Future<List<FeedData>> getAll() async{
    print("getAll");
    var res = await http.get('https://educationapp1.herokuapp.com/feeds/get');
    if(res.statusCode==200){
      var jsonString = res.body;
      data = feedDataFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

  Future<void> addlike(id,saveid)async{
    print(id);
    print(saveid);
    print("here");
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.patch('https://educationapp1.herokuapp.com/feeds/update',headers: headers,body: json.encode({
      "id":id,
      "saveid":saveid
    }));
    if(res.statusCode==200){
      print(res.body);
    }
  }

  Future<void> deletelike(id,saveid)async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.patch('https://educationapp1.herokuapp.com/feeds/deletelike',headers: headers,body: json.encode({
      "id":id,
      "saveid":saveid
    }));
    if(res.statusCode==200){
      print(res.body);
    }
  }




  Future<bool> putData(filename,stdname,studid,desc) async{
    //fname = filename;
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    //List<AssignmentData> data;
    var res = http.MultipartRequest('POST', Uri.parse('https://educationapp1.herokuapp.com/feeds/upload'));
    res.headers.addAll(headers);
    if(filename!=null) {
      res.files.add(await http.MultipartFile.fromPath('myFile', filename));
    }
    res.fields['name'] = stdname;
    res.fields['studentid'] = studid;
    res.fields['desc'] = desc;
    var request = await res.send();
    print(request.statusCode);
    if(request.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }


}

