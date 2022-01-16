import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/screens/home.dart';
import 'package:ezzproject/screens/home2.dart';
import 'package:ezzproject/screens/showimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainlogic.dart';
class Home2logic {
  var contexta;
  Home2logic(BuildContext context) {
    contexta = context;
  }
  var stringa;
  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يمكن أن تبقي الحقل فارغ';
    }
    return null;
  }
  String validatemobile(String value) {
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
  deleteservice(id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var servicetype = sharedPreferences.getString("servicetype");
    var url ;
    if(servicetype == "مراسيل") {
      url = "https://azz.sla-request.com/api/deleteCar/"+id.toString();
    }
    if(servicetype != "اماكن" && servicetype!="مزاد" && servicetype!="مراسيل" ){
      url = "https://azz.sla-request.com/api/deleteService/"+id.toString();
    }
    if(servicetype == "اماكن"){
      url = "https://azz.sla-request.com/api/deletePlace/"+id.toString();
    }
    if(servicetype == "مزاد"){
      url = "https://azz.sla-request.com/api/deleteAuction/"+id.toString();
    }
    var token =sharedPreferences.getString("token");
    alertwait();
    var response= await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    if(body2["status"] == true){
      //alertmessage("true");
      Provider.of<Notifires>(contexta,listen: false).getservices(contexta);
    }
    else{

    }
  }
  deletecupon(id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = "https://azz.sla-request.com/api/deleteCoupon/"+id.toString();
    var token =sharedPreferences.getString("token");
    alertwait();
    var response= await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    if(body2["status"] == true){
      alertmessagedelete(body2["msg"].toString());
    }
    else{

    }
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  alertmessagedelete(message){
    return showDialog(context: contexta, builder: (context) {
      return AlertDialog(
        content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.2,child: SingleChildScrollView(
          child: Column(children: [
            Container(height: MediaQuery.of(context).size.height*0.05,
              child: Directionality(
                  textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text("تم الامر بنجاح",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
            ),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
              child: InkWell(onTap: (){
                Navigator.of(context).pop("dialog");
                Provider.of<Notifires>(context,listen: false).getcupon(contexta);
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
  alertmessage(message) {
    if(message == "true") {
      return showDialog(context: contexta, builder: (context) {
        return AlertDialog(
          content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.2,child: SingleChildScrollView(
            child: Column(children: [
              Container(height: MediaQuery.of(context).size.height*0.05,
                child: Directionality(
                    textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text("تم الامر بنجاح",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
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
  alertmessagego(message){
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
                Navigator.of(contexta).popUntil((route) => route.isFirst);
                Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
                  return Home2();
                }));
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
  parsephoto(photo) {
    String base = base64Encode(photo.readAsBytesSync());
    return base;
  }
  void navigatetomain(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta){
      return Showimages();
    }));
  }
  sendinfocommesion( photo ,collection,date,note) async{
      if(photo ==null){
        alertmessage("يجب اختيار صورة التحويل للمناسبة");
      }
      else {
        if(collection.toString() !=""){
          if(date !=null){
            if(note.toString() != "") {
              SharedPreferences sharedPreferences = await SharedPreferences
                  .getInstance();
              var url = "https://azz.sla-request.com/api/add_collect";
              var token = sharedPreferences.getString("token");
              print(token);
              alertwait();
              var request = new http.MultipartRequest("POST", Uri.parse(url));
              request.fields["collection"] = collection.toString();
              request.fields["date"] = date.toString();
              request.fields["note"] = note.toString();
              request.files.add(await http.MultipartFile.fromPath("photo",
                  photo.path));
              request.headers.addAll({
                'Authorization': 'Bearer $token',
              });
              var response = await request.send().then((value) {
                value.stream.transform(utf8.decoder).listen((event) async {
                  var body = jsonDecode(event);
                  print(body);
                  Navigator.of(contexta).pop("dialog");
                  if (body["status"] == true) {
                    alertmessagego(body["msg"]);
                  }
                  else {
                    alertmessage(body["msg"]);
                  }
                });
              });
            }
            else{
              alertmessage("يجب كتابة رقم التحويل");
            }
  }else{alertmessage("يجب اختيار تاريخ التحويل");}
        }else{
            alertmessage("يجب كتابة قيمة التحويل");
    }
      }

  }
  addpromocode()async{
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
  }
  getdata()async{
    var url = "https://azz.sla-request.com/api/home";
    alertwait();
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    var categories = body["categories"]["cats"];
    var banner = body["categories"]["banners"];
    Navigator.of(contexta).pop("dialog");
    return {"categories":categories, "banner":banner};
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
  getservices()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url;
    var servicetype = sharedPreferences.getString("servicetype");
    if(servicetype == "مراسيل") {
     url = "https://azz.sla-request.com/api/getCars";
    }
    if(servicetype != "اماكن" && servicetype!="مزاد" && servicetype!="مراسيل" ){
      url = "https://azz.sla-request.com/api/getServices";
    }
    if(servicetype == "اماكن"){
      url = "https://azz.sla-request.com/api/getPlaces";
    }
    if(servicetype == "مزاد"){
      url = "https://azz.sla-request.com/api/getAuctions";
    }
    var response = await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    var services = body["data"];
    print(services.toString());
    return  services;
  }
  getcupons()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url = "https://azz.sla-request.com/api/getCoupons";
    var response = await http.get(Uri.parse(url) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    Navigator.of(contexta).pop("dialog");
    var cupons = body["data"];
    return  cupons;
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
  gethomeprovider()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token =sharedPreferences.getString("token");
    alertwait();
    var url2 = "https://azz.sla-request.com/api/provider_home";
    var response2 = await http.get(Uri.parse(url2) ,headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 = jsonDecode(response2.body);
    Navigator.of(contexta).pop("dialog");
    var data = body2["data"];
    return  data;
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
    print('g');
    print(body);
    return body["fav"];
  }
}