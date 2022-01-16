import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/screens/home.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Loginlogic {
  var contexta;

  Loginlogic(BuildContext context) {
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
                    textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text("تمت الاضافة بنجاح",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
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
  List region1 = [];
  List region2 = [];
  List region3 = [];
  getdata()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = "https://azz.sla-request.com/api/places";
    alertwait();
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    for(int f =0 ; f<body["data"].length ; f++){
      region1.add({"name" :body["data"][f]["Name"],"ID" : body["data"][f]["ID"].toString()});
      for(int g=0 ; g<body["data"].length ; g++){
        region2.add({"name" :body["data"][f]["Cities"][g]["Name"],"ID" : body["data"][f]["Cities"][g]["ID"].toString()});
        for(int k=0 ; k<body["data"].length ; k++){
          region3.add({"name" :body["data"][f]["Cities"][g]["Regions"][k]["Name"],"ID" : body["data"][f]["Cities"][g]["Regions"][k]["ID"].toString()});
        }
      }
    }
    var re1 = sharedPreferences.getString("region1");
    var re2 = sharedPreferences.getString("region2");
    var re3 = sharedPreferences.getString("region3");
    Navigator.of(contexta).pop("dialog");
    return {"re1" :re1 , "re2" : re2 , "re3" :re3 , "listre1" : region1 , "listre2" : region2 , "listre3" : region3};
  }
  void navigatetomain() {
    Navigator.of(contexta).pushReplacement(
        MaterialPageRoute(builder: (contexta) {
          return Home();
        }));
  }
  void navigatetosignup() {
    print("go");
    Navigator.of(contexta).push(
        MaterialPageRoute(builder: (contexta) {
          return Signup();
        }));
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  setlocation(re1a,re2a,re3a)async{
    var id1;
    var id2;
    var id3;
    for(int f = 0 ; region1.length> f;f++){
      if(region1[f]["name"].toString().trim() == re1a){
        id1 = region1[f]["ID"];
      }
    }
    for(int f = 0 ; region2.length> f;f++){
      if(region2[f]["name"].toString().trim() == re2a){
        id2 = region2[f]["ID"];
      }
    }
    for(int f = 0 ; region3.length> f;f++){
      if(region3[f]["name"].toString().trim() == re3a){
        id3 = region3[f]["ID"];
      }
    }
    alertwait();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = "https://azz.sla-request.com/api/editLocation";
    var token = sharedPreferences.getString("token");
     var data = {
        "Governorate": id1.toString(),
        "City": id2.toString(),
        "Region": id3.toString()
      };
    var response = await http.post(Uri.parse(url),body: data, headers: {
      'Authorization': 'Bearer $token',
    });
    var body =jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    if(body["status"] == true){
      alertmessage("true");
      sharedPreferences.setString("region1", re1a);
      sharedPreferences.setString("region2", re2a);
      sharedPreferences.setString("region3", re3a);
    }
    else{
      alertmessage(body["msg"]);
    }
  }
}