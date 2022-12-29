import 'dart:convert';
import 'package:bottom_navigation_demo/backend/studentback.dart';
import 'package:bottom_navigation_demo/backend/teacherback.dart';
import 'package:http/http.dart' as http;

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login _list;
  static var globalid;
  Login({
    this.id,
    this.loginId,
    this.username,
    this.password,
    this.usertype,
    this.v,
  });

  String id;
  String loginId;
  String username;
  String password;
  String usertype;
  int v;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    id: json["_id"],
    loginId: json["id"],
    username: json["username"],
    password: json["password"],
    usertype: json["usertype"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "id": loginId,
    "username": username,
    "password": password,
    "usertype": usertype,
    "__v": v,
  };


  Future<Login> getData(String mail,String pass) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    print("get");
    print(mail+pass);
    var res = await http.post('https://educationapp1.herokuapp.com/login/authenticate',headers: headers,body: json.encode({
      'username': mail,
      'password': pass,
    }));
    print(res.statusCode);
    if(res.statusCode==200){
      var jsonString = res.body;
      _list = loginFromJson(jsonString);
      _list.usertype=="student"?Studentinfo.globalid = _list.loginId:Teacherinfo.globalid=_list.loginId;
      print(Studentinfo.globalid);
      print(Teacherinfo.globalid);
      print('here');
      return _list;
    }else if(res.statusCode==404){
      print('here2');
      return null;
    }else{
      print('here3');
      return null;
    }
  }

  Future<bool> putData(id,username,password,usertype) async{
    Map<String, String> headers = {"Content-type": "application/json"};
    var res = await http.post('https://educationapp1.herokuapp.com/login/add',headers: headers,body: json.encode({
      "id": id,
      "username": username,
      "password": password,
      "usertype": usertype
    }));
    if(res.statusCode==200){
      print("done");
      return true;
    }else{
      print("not done");
      return false;
    }
  }

}