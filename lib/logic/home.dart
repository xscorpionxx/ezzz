import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/screens/home.dart';
import 'package:ezzproject/screens/home2.dart';
import 'package:ezzproject/screens/showimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import 'mainlogic.dart';
class Homelogic {
  var contexta;
  Homelogic(BuildContext context) {
    contexta = context;
  }
  List region1 =[];
  List region2 =[];
  List region3 =[];
  var stringa;

  // هدول الدوال مشان التأكد من الاسم وكلمة السر وباقي المعلومات
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

  String validatepassword(String value) {
    stringa = value;
    if (value.length < 6) {
      return 'كلمة السر يجب أن تكون أكثر من 6 خانات على الاقل!';
    }
    if (value.isEmpty) {
      return 'لا يمكن أن تكون كلمة السر فارغة';
    }
    return null;
  }

  String validatepasswordre(String value) {
    if (value != stringa) {
      return 'لا يوجد تطابق بين كلمتي السر';
    }
    return null;
  }

  String validatename(String value) {
    if (value.isEmpty) {
      return 'لا يمكن أن تبقي الاسم فارغ';
    }
    return null;
  }
  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'لا يمكنك ترك الرقم فارغ!';
    }
    else if (!regExp.hasMatch(value)) {
      return 'هذا الرقم غير صالح!';
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
  parsephoto(photo) {
    String base = base64Encode(photo.readAsBytesSync());
    return base;
  }
  void savedata(token ,name ,phone, password, email,re1,re2,re3)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("name", name);
    sharedPreferences.setString("phone", phone);
    sharedPreferences.setString("password", password);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("region1", re1);
    sharedPreferences.setString("region2", re2);
    sharedPreferences.setString("region3", re3);
  }
  void navigatetomain(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta){
      return Showimages();
    }));
  }
  getdata()async{
    var url = "https://azz.sla-request.com/api/home";
    alertwait();
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    var url1 = "https://azz.sla-request.com/api/appInfo";
    var response1 = await http.get(Uri.parse(url1));
    var body1 = jsonDecode(response1.body);
    var categories = body["categories"]["cats"];
    var ad = body["categories"]["ads"];
    var banner = body["categories"]["banners"];
    Navigator.of(contexta).pop("dialog");
    //showadd(banner, body1["categories"]["ads_time"].toString());
    return {"categories":categories,"ad" : ad ,"banner" :banner , "adtime" : body1["categories"]["ads_time"].toString() };
  }
  getprofiledata()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url2 = "https://azz.sla-request.com/api/Data-Edit-User";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    Navigator.of(contexta).pop("dialog");
    var profiledata = body2["data"];
    return {"profiledata" : profiledata};
  }
  getmyorders()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url2 = "https://azz.sla-request.com/api/myOrder";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    Navigator.of(contexta).pop("dialog");
    var profiledata = body2["data"];
    return  profiledata;
  }
  alertmessage(message) {
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
  getfav(context)async{
    var url = "https://azz.sla-request.com/api/fav";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    alertwait();
    var token = sharedPreferences.getString("token");
    var response = await http.get(Uri.parse(url),headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
    });
    Navigator.of(context).pop("dialog");
    var body = jsonDecode(response.body);
    return body["fav"];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  // TODO: implement context
  BuildContext get context => throw UnimplementedError();

  @override
  void deactivate() {
    // TODO: implement deactivate
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  // TODO: implement mounted
  bool get mounted => throw UnimplementedError();

  @override
  void reassemble() {
    // TODO: implement reassemble
  }

  @override
  void setState(fn) {
    // TODO: implement setState
  }

  @override
  DiagnosticsNode toDiagnosticsNode({String name, DiagnosticsTreeStyle style}) {
    // TODO: implement toDiagnosticsNode
    throw UnimplementedError();
  }

  @override
  String toStringShort() {
    // TODO: implement toStringShort
    throw UnimplementedError();
  }

  @override
  // TODO: implement widget
  StatefulWidget get widget => throw UnimplementedError();
}