import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/screens/home.dart';
import 'package:ezzproject/screens/home2.dart';
import 'package:ezzproject/screens/showimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Detailpagelogic {
  var contexta;
  Detailpagelogic(BuildContext context) {
    contexta = context;
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
  void navigatetomain(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta){
      return Showimages();
    }));
  }
  getdetailpage(id)async{
    var url = "https://azz.sla-request.com/api/provider/"+"$id";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //var token = sharedPreferences.getString("token");
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXp6LnNsYS1yZXF1ZXN0LmNvbVwvYXBpXC9yZWdpc3RlciIsImlhdCI6MTYzODgwNDkyNiwibmJmIjoxNjM4ODA0OTI2LCJqdGkiOiJPclN3djE1Rk84cTQxUW1FIiwic3ViIjoxMiwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.qdHAbp2lotGkxgNu9FcbF7cquG4RxL3v0D4_ywLI0c0";
    var response = await http.get(Uri.parse(url),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    return body["provider"];
  }
  addtocart(id , plus)async{
      alertwait();
      var url = "https://azz.sla-request.com/api/addToCart";
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      print(token);
      var data;
      if(plus){
         data = {
          "product_id":id.toString(),
          "product_qt": "+1"
        };
      }
      else{
        data = {
          "product_id":id.toString(),
          "product_qt": "-1"
        };
      }
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: data);
      Navigator.of(contexta).pop("dialog");
      var body = jsonDecode(response.body);
      print(body);
      if (body["status"].toString().trim() == "true") {
        return true;
      }
      else {
          alertmessage(body["msg"]);
         return false;
      }
    }

}