// To parse this JSON data, do
//
//     final blogData = blogDataFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;


List<BlogData> blogDataFromJson(String str) => List<BlogData>.from(json.decode(str).map((x) => BlogData.fromJson(x)));

String blogDataToJson(List<BlogData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogData {
  List<BlogData> data;
  BlogData({
    this.likes,
    this.id,
    this.image,
    this.name,
    this.topic,
    this.desc,
    this.v,
  });

  List<dynamic> likes;
  String id;
  String image;
  String name;
  String topic;
  String desc;
  int v;

  factory BlogData.fromJson(Map<String, dynamic> json) => BlogData(
    likes: List<dynamic>.from(json["likes"].map((x) => x)),
    id: json["_id"],
    image: json["image"],
    name: json["name"],
    topic: json["topic"],
    desc: json["desc"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "likes": List<dynamic>.from(likes.map((x) => x)),
    "_id": id,
    "image": image,
    "name": name,
    "topic": topic,
    "desc": desc,
    "__v": v,
  };


  Future<List<BlogData>> getAll() async{
    print("getAll");
    var res = await http.get('https://educationapp1.herokuapp.com/blogs/get');
    if(res.statusCode==200){
      var jsonString = res.body;
      data = blogDataFromJson(jsonString);
      print(data);
      return data;
    }else{
      return null;
    }
  }

  Future<bool> putData(filename,stdname,topic,desc) async{
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    //List<AssignmentData> data;
    var res = http.MultipartRequest('POST', Uri.parse('https://educationapp1.herokuapp.com/blogs/upload'));
    res.headers.addAll(headers);
    if(filename!=null) {
      res.files.add(await http.MultipartFile.fromPath('myFile', filename));
    }
    res.fields['name'] = stdname;
    res.fields['topic'] = topic;
    res.fields['desc'] = desc;
    var request = await res.send();
    if(request.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }

  Future<void> addlike(id,saveid)async{
    print(id);
    print(saveid);
    print("here");
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.patch('https://educationapp1.herokuapp.com/blogs/update',headers: headers,body: json.encode({
      "id":id,
      "saveid":saveid
    }));
    if(res.statusCode==200){
      print(res.body);
    }
  }

  Future<void> deletelike(id,saveid)async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.patch('https://educationapp1.herokuapp.com/blogs/deletelike',headers: headers,body: json.encode({
      "id":id,
      "saveid":saveid
    }));
    if(res.statusCode==200){
      print(res.body);
    }
  }


}
