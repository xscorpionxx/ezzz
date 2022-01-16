import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/home.dart';
import 'package:ezzproject/screens/home2.dart';
import 'package:ezzproject/screens/showimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class Applogic {
  var contexta;
  Applogic(BuildContext context) {
    contexta = context;
  }
  String validateemail(String value) {
    RegExp exp = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (exp.hasMatch(value)) {
      return null;
    }
    else {
      return "لا يمكن لايميل أن يكون هكذا!";
    }
  }
  String validate(String value){
    if (value.isEmpty) {
      return 'لا يمكن أن تبقي الحقل فارغ';
    }
    return null;
  }
  void navigate() {
    Navigator.of(contexta).pop();
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  alertmessage(trues,message) {
    if(trues =="true") {
      return showDialog(context: contexta, builder: (context) {
        return AlertDialog(title: new Text("تم الامر"),
            content: Directionality(
                textDirection: TextDirection.rtl, child: new Text(message)),
            actions: [
              new ElevatedButton(onPressed: () {
                Navigator.of(context).pop("dialog");
                Navigator.of(context).pop();
              }, child: Text("نعم")),
            ]);
      });
    }
    else{
      return showDialog(context: contexta, builder: (context) {
        return AlertDialog(title: new Text("خطأ"),
            content: Directionality(
                textDirection: TextDirection.rtl, child: new Text(message)),
            actions: [
              new ElevatedButton(onPressed: () {
                Navigator.of(context).pop("dialog");
                Navigator.of(context).pop();
              }, child: Text("نعم")),
            ]);
      });
    }
  }
  void navigatetomain(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta){
      return Showimages();
    }));
  }
  void gotofacebook(url)async{
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }
  void gotogoogle(url)async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void gototwiter(url)async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void gotoin(url)async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  getdata()async {
      var url = "https://azz.sla-request.com/api/about";
      var response = await http.get(Uri.parse(url));
      var body = jsonDecode(response.body);
      return body["about"];
  }
  cancelfav(id,Id){

  }
}