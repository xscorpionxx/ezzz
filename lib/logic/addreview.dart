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
class Addreviewlogic {
  var contexta;
  Addreviewlogic(BuildContext context) {
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
  alertmessage(trues,message) {
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
  send(id,comment,GlobalKey<FormState> key,star_num)async {
    if (key.currentState.validate()){
      var url = "https://azz.sla-request.com/api/addReview";
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var email =sharedPreferences.getString("email").toString();
      alertwait();
      var data = {
        "title": email.toString(),
        "desc": comment.toString(),
        "star_num": star_num.toString(),
        "product_id" : id.toString()
      };
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: data);
      var body = jsonDecode(response.body);
      Navigator.of(contexta).pop("dialog");
      if (body["status"] == true) {
        Provider.of<Notifires>(contexta,listen: false).getallreview(id);
        alertmessage("true",body["msg"]);
      }
      else {
        alertmessage( "false",body["msg"]);
      }
    }
  }
  cancelfav(id,Id){
  }
}