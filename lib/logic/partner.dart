import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/screens/home.dart';
import 'package:ezzproject/screens/home2.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Partenerlogic {
  var contexta;

  Partenerlogic(BuildContext context) {
    contexta = context;
  }
  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يمكن أن تبقي الحقل فارغ';
    }
    return null;
  }
  alertmessage(message) {
    if(message == "true") {
      return showDialog(context: contexta, builder: (context) {
        return AlertDialog(
          content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.2,child: SingleChildScrollView(
            child: Column(children: [
              Container(height: MediaQuery.of(context).size.height*0.05,
                child: Directionality(
                    textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text("تم الاضافة بنجاح",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
              ),
              Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                child: InkWell(onTap: (){
                  Navigator.of(context).pop("dialog");
                  navigatetomain();
                },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
              )
            ],),
          ),),
        );
      });
    }
    else{
      return showDialog(context: contexta, builder: (context) {
        return AlertDialog(
          content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.2,child: SingleChildScrollView(
            child: Column(children: [
              Container(height: MediaQuery.of(context).size.height*0.05,
                child: Directionality(
                    textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text(message,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
              ),
              Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                child: InkWell(onTap: (){
                  Navigator.of(context).pop("dialog");
                },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
              )
            ],),
          ),),
        );
      });
    }
  }
  alertmessage2(message) {
    if(message == "true") {
      return showDialog(context: contexta, builder: (context) {
        return AlertDialog(
          content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.2,child: SingleChildScrollView(
            child: Column(children: [
              Container(height: MediaQuery.of(context).size.height*0.05,
                child: Directionality(
                    textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text("تم تعديل بنجاح",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
              ),
              Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                child: InkWell(onTap: (){
                  Navigator.of(context).pop("dialog");
                  navigatetomain();
                },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
              )
            ],),
          ),),
        );
      });
    }
    else{
      return showDialog(context: contexta, builder: (context) {
        return AlertDialog(
          content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.2,child: SingleChildScrollView(
            child: Column(children: [
              Container(height: MediaQuery.of(context).size.height*0.05,
                child: Directionality(
                    textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text(message,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
              ),
              Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                child: InkWell(onTap: (){
                  Navigator.of(context).pop("dialog");
                },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
              )
            ],),
          ),),
        );
      });
    }
  }
  void navigatetomain() {
    Navigator.of(contexta).popUntil((route) => route.isFirst);
    Navigator.of(contexta).pushReplacement(
        MaterialPageRoute(builder: (contexta) {
          return Home2();
        }));
  }
  void navigatetosignup() {
    Navigator.of(contexta).push(
        MaterialPageRoute(builder: (contexta) {
          return Signup();
        }));
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(elevation: 0,backgroundColor: Colors.transparent,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  getpartners()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url2 = "https://azz.sla-request.com/api/partOfSuccess";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    Navigator.of(contexta).pop("dialog");
    var data = body2["users"];
    return  data;
  }
}