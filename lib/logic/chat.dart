import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Chatlogic{
  var contexta;
  Chatlogic(BuildContext context) {
    contexta = context;
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  getmessages( id )async{
    print(id);
    var url = "https://azz.sla-request.com/api/messages";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    alertwait();
    var token = sharedPreferences.getString("token");
    var userid = sharedPreferences.getString("id");
    print(userid);
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    List messages =[];
    Navigator.of(contexta).pop("dialog");
    var body = jsonDecode(response.body);
    if( body["status"] ==true){
      for(int g= 0 ; g<body["data"].length ;g++ ){
        if(body["data"][g]["user_id"].toString().trim() == userid &&
            body["data"][g]["provider_id"].toString().trim() == id.toString() ){
           messages.add(body["data"][g]);
        }
      }
    }
    return messages;
  }
  sendmessage(message , id )async{
    print(id);
    var url = "https://azz.sla-request.com/api/messages";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    alertwait();
    var token = sharedPreferences.getString("token");
    var userid = sharedPreferences.getString("id");
    print(userid);
    var data = {
        "msg": message.toString(),
        "user_id": userid.toString(),
        "provider_id": id.toString(),
      };
    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    }, body: data);
    var body = jsonDecode(response.body);
    Navigator.of(contexta).pop();
    if( body["status"] ==true &&body["msg"].toString() !="هذا المستخدم غير موجود"){

    }
    else{
      return showDialog(context: contexta, builder: (context) {
        return AlertDialog(
          content:Container(height: MediaQuery.of(context).size.height*0.1,child:SingleChildScrollView(child: Column(children: [
            Container(
              child: Directionality(
                  textDirection: TextDirection.rtl, child: Center(child: FittedBox(child: new Text(body["msg"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04),)))),
            ),
            InkWell(onTap: (){
              Navigator.of(context).pop("dialog");
            },child: Container(width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ), decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20)),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),))
          ],)),),
        );
      });
    }
  }
  getmessages2(message , id )async{
    var url = "https://azz.sla-request.com/api/messages";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    alertwait();
    var token = sharedPreferences.getString("token");
    var userid = sharedPreferences.getString("id");
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    if( body["status"] ==true){
      List messages =[];
      for(int g= 0 ; g<body["data"].length ;g++ ){
        // if(body["data"][g]["user_id"].toString().trim() == ){


        // }
      }
    }
    else{
      return showDialog(context: contexta, builder: (context) {
        return AlertDialog(
          content:Container(height: MediaQuery.of(context).size.height*0.1,child:SingleChildScrollView(child: Column(children: [
            Container(
              child: Directionality(
                  textDirection: TextDirection.rtl, child: Center(child: FittedBox(child: new Text(body["msg"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04),)))),
            ),
            InkWell(onTap: (){
              Navigator.of(context).pop("dialog");
            },child: Container(width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ), decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20)),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),))
          ],)),),
        );
      });
    }
  }
  sendmessage2(message , userid )async{
    var url = "https://azz.sla-request.com/api/messages";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    alertwait();
    var token = sharedPreferences.getString("token");
    var providerid = sharedPreferences.getString("id");
    print(providerid);
    print(userid);
    var data = {
      "msg": message.toString(),
      "user_id": userid.toString(),
      "provider_id": providerid.toString(),
    };
    var response = await http.post(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    }, body: data);
    var body = jsonDecode(response.body);
    Navigator.of(contexta).pop();
    if( body["status"] ==true){

    }
    else{
      return showDialog(context: contexta, builder: (context) {
        return AlertDialog(
          content:Container(height: MediaQuery.of(context).size.height*0.1,child:SingleChildScrollView(child: Column(children: [
            Container(
              child: Directionality(
                  textDirection: TextDirection.rtl, child: Center(child: FittedBox(child: new Text(body["msg"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04),)))),
            ),
            InkWell(onTap: (){
              Navigator.of(context).pop("dialog");
            },child: Container(width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ), decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20)),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),))
          ],)),),
        );
      });
    }
  }
}