import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/screens/home.dart';
import 'package:ezzproject/screens/home2.dart';
import 'package:ezzproject/screens/showimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Signuplogic {
  var contexta;

  Signuplogic(BuildContext context) {
    contexta = context;
  }
  List subcategoreis = [];
  List categories = [];
  List region1 =[];
  List region2 =[];
  List region3 =[];
  var stringa;
  // هدول الدوال مشان التأكد من الاسم وكلمة السر وباقي المعلومات
  String validateemail(String value) {
   // RegExp exp = new RegExp(
  //      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value.length>8) {
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
                  Navigator.of(context).pop();
                },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
              )
            ],),
        ),),
      );
    });
  }
  alertswearing(pledge,email ,password ,region11 ,region21,region31,type ,cat,subcat,idsubcat,phone,name
      ,id,stroename,photo){
      var checkvalue = false;
      var text = false;
      print(text);
      return showDialog(context: contexta, builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Container(padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.02), height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.33, child: SingleChildScrollView(
                child: Column(children: [ Container(
                  child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: CheckboxListTile(activeColor: Colors.green,title: Container(
                          child: Directionality(textDirection: TextDirection.rtl,
                            child: Text(
                                pledge,maxLines: 8,
                                style: TextStyle(fontSize: MediaQuery
                                    .of(context)
                                    .textScaleFactor * 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                      ),
                        value: checkvalue,
                        onChanged: (val) {
                          setState(() {
                            checkvalue = val;
                          });
                        },)),
                ),
                 Container(child: text?Container(child: FittedBox(child: Text("لا يمكنك الاكمال دون التعهد ",style: TextStyle(color: Colors.red,fontSize: MediaQuery.of(context).textScaleFactor*13),)),):Container(),),
                  Container(margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05),
                    child: InkWell(onTap: ()async {
                      if(checkvalue ==true){
                      Navigator.of(context).pop("dialog");
                      alertwait();
                      var url = "https://azz.sla-request.com/api/register";
                      var request = new http.MultipartRequest("POST", Uri.parse(url));
                      request.fields["email"] = email.toString();
                      request.fields["password"] = password.toString();
                      request.fields["password_confirmation"] = password.toString();
                      request.fields["governorate_id"] = region11.toString();
                      request.fields["city_id"] = region21.toString();
                      request.fields["region_id"] = region31.toString();
                      request.fields["type"] = type.toString();
                      request.fields["cat_id"] = cat.toString();
                      if(subcat.toString() !="null"){
                        request.fields["subcat_id"] = idsubcat.toString();
                      }
                      request.fields["fb_token"] =
                      "cjewojfoiewrvnvcew84fvrwvrec54s4dcd4cs4cd4csdcs4c4d5c4sdcs4dc4sdc4sd4c84src4d5c1s";
                      request.fields["phone"] = phone.toString();
                      request.fields["name"] = name.toString();
                      request.fields["national_number"] = id.toString();
                      request.fields["store_name"] = stroename.toString();
                      request.files.add(await http.MultipartFile.fromPath("store_photo",
                          photo.path));
                      await request.send().then((value) async {
                      value.stream.transform(utf8.decoder).listen((event) async {
                      Navigator.of(contexta).pop("dialog");
                      print("here");
                      var body = jsonDecode(event);
                      print(body);
                      if (body["status"] == true) {
                      await savedata(
                      body["data"]["API_Key"].toString(),
                      name,
                      phone,
                      password,
                      email,
                      body["data"]["Governorate"],
                      body["data"]["City"],
                      body["data"]["Region"]);
                      if (body["data"]["Type"] == "تاجر") {
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.setString("servicetype", body["data"]["StoreCat"]);
                      sharedPreferences.setString("id", body["data"]["ID"].toString());
                      Navigator.of(contexta).popUntil((route) => route.isFirst);
                      Navigator.of(contexta).pushReplacement(
                      MaterialPageRoute(builder: (contexta) {
                      return Home2();
                      }));
                      }
                      else {
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.setString("id", body["data"]["ID"].toString());
                      navigatetomain();
                      }
                      //alertmessagereg(true, body["msg"]);
                      }
                      else {
                      alertmessage( body["msg"]);
                      }
                      });
                      });}
                      else{
                        setState((){
                          text =true;
                        });
                      }
                    }, child: Container(width: MediaQuery
                        .of(context)
                        .size
                        .width,
                      padding: EdgeInsets.all(MediaQuery
                          .of(context)
                          .size
                          .width * 0.02),
                      decoration: BoxDecoration(color: Colors.green),
                      child: Center(child: Text("تم", style: TextStyle(
                          color: Colors.white, fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.03),),),)),
                  )
                ],),
              ),),
            );
          },
        );
      });
  }
  alertmessagereg(able,message) {
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
                if(able){
                 SystemNavigator.pop();
                }
                else {
                  Navigator.of(context).pop();
                }       },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
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
  void navigatetomain(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta){
      return Showimages();
    }));
  }
  List subcatego = [
    {"1": []},
    {"2": []},
    {"3": []},
    {"4": []},
    {"5": []},
    {"6": []},
    {"7": []},
    {"8": []},
    {"9": []},
    {"10": []}
  ];
  getplaces()async{
    var url = "https://azz.sla-request.com/api/places";
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    print("mybody");
    print(body);
    for(int f =0 ; f<body["data"].length ; f++){
      region1.add({"name" :body["data"][f]["Name"],"ID" : body["data"][f]["ID"].toString()});
      for(int g=0 ; g<body["data"].length ; g++){
        region2.add({"name" :body["data"][f]["Cities"][g]["Name"],"ID" : body["data"][f]["Cities"][g]["ID"].toString()});
        for(int k=0 ; k<body["data"].length ; k++){
          region3.add({"name" :body["data"][f]["Cities"][g]["Regions"][k]["Name"],"ID" : body["data"][f]["Cities"][g]["Regions"][k]["ID"].toString()});
        }
      }
    }
    var url2 = "https://azz.sla-request.com/api/home";
    var response2 = await http.get(Uri.parse(url2));
    var body2 = jsonDecode(response2.body);
    List cats = [];
    List subcats = [
      {"1": []},
      {"2": []},
      {"3": []},
      {"4": []},
      {"5": []},
      {"6": []},
      {"7": []},
      {"8": []},
      {"9": []},
      {"10": []}
    ];
    categories = body2["categories"]["cats"];
    for(int g = 0 ; g< categories.length ; g++){
      cats.add(categories[g]["Name"]);
      if (categories[g]["SubCategories"].toString() != "null") {
        for (int s = 0; s < categories[g]["SubCategories"].length; s++) {
          subcatego[g][(g + 1).toString()].add(
              categories[g]["SubCategories"][s]);
          subcats[g][(g + 1).toString()].add(
              categories[g]["SubCategories"][s]["Name"]);
        }
      }
    }
    print(region1);
    print(subcatego);
    return {"1":region1 , "2": region2,"3":region3 , "cat" :cats,"subcats" : subcats};
  }
  parsephoto(photo) {
    String base = base64Encode(photo.readAsBytesSync());
    return base;
  }
  void signup(type,GlobalKey<FormState> key, email, password, repassword, name,
      phone, region11, region21, region31, stroename, id,File photo, fptoken , cat,subcat )async{
     if (key.currentState.validate()) {
       print(region11 + region21 + region31);
       if (region11 != "المحافظة" && region21 != "المدينة" &&
           region31 != "المنطقة") {
         print(region3);
         for (int f = 0; f < region1.length; f++) {
           if (region1[f]["name"].toString() == region11) {
             region11 = region1[f]["ID"].toString();
           }
         }
         for (int s = 0; s < region2.length; s++) {
           if (region2[s]["name"].toString() == region21) {
             region21 = region2[s]["ID"].toString();
           }
         }
         for (int f = 0; f < region3.length; f++) {
           if (region3[f]["name"].toString() == region31) {
             region31 = region3[f]["ID"].toString();
           }
         }
         var idsubcat;
         for (int f = 0; f < categories.length; f++) {
           if (categories[f]["Name"].toString() == cat) {
             cat = categories[f]["ID"].toString();
             if (subcat.toString() != "null") {
               for (int s = 0; s < categories[f]["SubCategories"].length; s++) {
                 if (categories[f]["SubCategories"][s]["Name"].toString() ==
                     subcat.toString()) {
                   idsubcat = categories[f]["SubCategories"][s]["ID"].toString();
                 }
               }
             }
           }
         }
         var type = "1";
         if (stroename == "" && id == "" && photo == null) {
           type = "0";
         }
         var data;
         if (type == "1") {
           var url2 = "https://azz.sla-request.com/api/appInfo";
           var response2 = await http.get(Uri.parse(url2));
           var body2 = jsonDecode(response2.body);
           alertswearing(body2["categories"]["pledge"] ,email, password, region11, region21, region31, type, cat, subcat, idsubcat, phone, name, id, stroename, photo);
         }
         else {
           data = {
             "email": email.toString(),
             "password": password.toString(),
             "password_confirmation": password.toString(),
             "name": name.toString(),
             "phone": phone.toString(),
             "governorate_id": region11.toString(),
             "city_id": region21.toString(),
             "region_id": region31.toString(),
             "type": type.toString(),
             "fb_token": "cjewojfoiewrvnvcew84fvrwvrec54s4dcd4cs4cd4csdcs4c4d5c4sdcs4dc4sdc4sd4c84src4d5c1s",
           };
           var url = "https://azz.sla-request.com/api/register";
           var response = await http.post(Uri.parse(url), body: data);
           var body = jsonDecode(response.body);
           Navigator.of(contexta).pop("dialog");
           if (body["status"] == true) {
               await savedata(
                   body["data"]["API_Key"].toString(),
                   name,
                   phone,
                   password,
                  email,
                  body["data"]["Governorate"],
                   body["data"]["City"],
                 body["data"]["Region"]);
               if (body["data"]["Type"] == "تاجر") {
                 SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                 sharedPreferences.setString("servicetype", body["data"]["StoreCat"]);
                 sharedPreferences.setString("id", body["data"]["ID"].toString());
                 Navigator.of(contexta).pushReplacement(
                     MaterialPageRoute(builder: (contexta) {
                       return Home2();
                     }));
               }
                else {
                 SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                 sharedPreferences.setString("id", body["data"]["ID"].toString());
                  navigatetomain();
                }
            // alertmessage(body["msg"]);
           }
           else {
             alertmessage(body["msg"]);
           }
         }
       }
       else {
         alertmessage("يجب اختيار المحافظة والمدينة والمنطقة بالشكل الملائم");
       }
   }
  }
}