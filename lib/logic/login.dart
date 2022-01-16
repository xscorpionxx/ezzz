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
  void login(GlobalKey<FormState> key, email, password) async {
    if (key.currentState.validate()) {
      var data = {
        "email": email.toString(),
        "password": password.toString(),
        "fb_token" : "dwad"
      };
      var url = "https://azz.sla-request.com/api/login";
      alertwait();
      var response = await http.post(Uri.parse(url), body: data);
      var body = jsonDecode(response.body);
      print(body);
      Navigator.of(contexta).pop("dialog");
       if (body["status"] == true) {
         await savedata(body["data"]["API_Key"],body["data"]["Name"],body["data"]["PhoneNumber"].toString(),password,email , body["data"]["Governorate"].toString(),body["data"]["City"].toString(),body["data"]["Region"].toString());
         if(body["data"]["Type"]== "تاجر"){
           SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
           sharedPreferences.setString("servicetype", body["data"]["StoreCat"]);
           sharedPreferences.setString("id", body["data"]["ID"].toString());
           Navigator.of(contexta).pushReplacement(
               MaterialPageRoute(builder: (contexta) {
                 return Home2();
               }));
         }
         else{
           SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
           sharedPreferences.setString("id", body["data"]["ID"].toString());
           navigatetomain();
         }
       }
        else {
      alertmessage(body["msg"]);
        }
    }
  }
}