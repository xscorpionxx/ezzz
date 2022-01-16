import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/home.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Profilelogic {
  var contexta;
  Profilelogic(BuildContext context) {
    contexta = context;
  }
  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يمكن أن تبقي الحقل فارغ';
    }
    return null;
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
              child: InkWell(onTap: ()async{
                if(trues =="true"){
                  await Provider.of<Notifires>(context,listen: false).getprofile(contexta,true);
                  Navigator.of(context).pop("dialog");
                  Navigator.of(contexta).pop();
                }
                else{
                  Navigator.of(context).pop("dialog");
                }
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
  List region1 = [];
  List region2 = [];
  List region3 = [];
  void update(name ,phone,  email,re1,re2,re3,photo)async{
    var id1;
    var id2;
    var id3;
    print("here");
    for(int f = 0 ; region1.length> f;f++){
      if(region1[f]["name"].toString() == re1){
        id1 = region1[f]["ID"];
      }
    }
    for(int f = 0 ; region2.length> f;f++){
      if(region2[f]["name"].toString() == re2){
        id2 = region2[f]["ID"];
      }
    }
    for(int f = 0 ; region3.length> f;f++){
      if(region3[f]["name"].toString() == re3){
        id3 = region3[f]["ID"];
      }
    }
    alertwait();
    print(id1+id2+id3);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = "https://azz.sla-request.com/api/Edit-Profile";
    var token = sharedPreferences.getString("token");
    print(token);
    var data;
    print(photo);
    if(photo !=null) {
      var request  = new http.MultipartRequest("POST",Uri.parse(url));
      request.fields["Email"] = email.toString();
      request.fields["Governorate"] = id1.toString();
      request.fields["City"] = id2.toString();
      request.fields["Region"] = id3.toString();
      request.fields["PhoneNumber"] = phone.toString();
      request.fields["Name"] = name.toString();
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      request.files.add(await http.MultipartFile.fromPath("ProfilePhoto",
          photo.path));
      await request.send().then((value)async {
        value.stream.transform(utf8.decoder).listen(( event) async{
          Navigator.of(contexta).pop("dialog");
          print("here");
          var body =jsonDecode( event);
         // Navigator.of(contexta).pop("dialog");
          if(body["status"] == true){
            alertmessage("true",body["msg"]);
            sharedPreferences.setString("name", name);
            sharedPreferences.setString("phone", phone);
            sharedPreferences.setString("email", email);
            sharedPreferences.setString("region1", re1);
            sharedPreferences.setString("region2", re2);
            sharedPreferences.setString("region3", re3);
          }
          else{
            alertmessage("false",body["msg"]);
          }
        });
      });

    }
    else{
      data = {
        "Name": name.toString(),
        "Email": email.toString(),
        "PhoneNumber": phone.toString(),
        "Governorate": id1,
        "City": id2,
        "Region": id3,
      };
      print(data);
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      },body: data);
      var body =jsonDecode(response.body);
      print(body);
      Navigator.of(contexta).pop("dialog");
      if(body["status"] == true){
        alertmessage("true",body["msg"]);
        sharedPreferences.setString("name", name);
        sharedPreferences.setString("phone", phone);
        sharedPreferences.setString("email", email);
        sharedPreferences.setString("region1", re1);
        sharedPreferences.setString("region2", re2);
        sharedPreferences.setString("region3", re3);
      }
      else{
        alertmessage("false",body["msg"]);
      }

    }
  }
  void update2(nationid,GlobalKey<FormState> key ,name ,phone,  email,storename,storecat,storesubcat,re1,re2,re3,photo,time11,time12,time21,time22)async{
    if(key.currentState.validate()) {
      var id1;
      var id2;
      var id3;
      var idcat;
      var idsubcat;
      var workfrom;
      var workto;
      print("here");
      if (time11.toString() == "مساءا") {
        workfrom = (int.parse(time12.toString()) + 12).toString() + ":00:00";
      } else {
        workfrom = (int.parse(time12.toString()) + 0).toString() + ":00:00";
      }
      if (time21.toString() == "مساءا") {
        if( int.parse(time22.toString()) + 12 ==24){
          workto = "00"+ ":00:00";
        }
        else{
          workto = (int.parse(time22.toString()) + 12).toString() + ":00:00";
        }
      } else {
        workto = (int.parse(time22.toString()) + 0).toString() + ":00:00";
      }
      print(workfrom);
      print(workto);
      for (int f = 0; region1.length > f; f++) {
        if (region1[f]["name"].toString() == re1) {
          id1 = region1[f]["ID"];
        }
      }
      for (int f = 0; region2.length > f; f++) {
        if (region2[f]["name"].toString() == re2) {
          id2 = region2[f]["ID"];
        }
      }
      for (int f = 0; region3.length > f; f++) {
        if (region3[f]["name"].toString() == re3) {
          id3 = region3[f]["ID"];
        }
      }
      for (int f = 0; categories.length > f; f++) {
        if (categories[f]["Name"].toString() == storecat.toString()) {
          idcat = categories[f]["ID"].toString();
          if (storesubcat.toString() != "null") {
            for (int s = 0; s < categories[f]["SubCategories"].length; s++) {
              if (categories[f]["SubCategories"][s]["Name"].toString() ==
                  storesubcat.toString()) {
                idsubcat = categories[f]["SubCategories"][s]["ID"].toString();
              }
            }
          }
        }
      }
      alertwait();
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var url = "https://azz.sla-request.com/api/Edit-Profile";
      var token = sharedPreferences.getString("token");
      print(token);
      var request = new http.MultipartRequest("POST", Uri.parse(url));
      request.fields["Email"] = email.toString();
      request.fields["Governorate"] = id1.toString();
      request.fields["City"] = id2.toString();
      request.fields["Region"] = id3.toString();
      if (photo != null) {
        request.files.add(await http.MultipartFile.fromPath("StorePhoto",
            photo.path));
      }
      request.fields["StoreCat"] = idcat.toString();
      if (storesubcat.toString() != "null") {
        request.fields["StoreSubCat"] = idsubcat.toString();
      }
      request.fields["PhoneNumber"] = phone.toString();
      request.fields["Name"] = name.toString();
      request.fields["StoreName"] = storename.toString();
      request.fields["StoreWorkTo"] = workto.toString();
      request.fields["StoreWorkFrom"] = workfrom.toString();
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      await request.send().then((value) async {
        value.stream.transform(utf8.decoder).listen((event) async {
          Navigator.of(contexta).pop("dialog");
          print("here");
          var body = jsonDecode(event);
          if (body["status"] == true) {
            alertmessage("true", body["msg"]);
            sharedPreferences.setString("servicetype", storecat);
            sharedPreferences.setString("name", name);
            sharedPreferences.setString("phone", phone);
            sharedPreferences.setString("email", email);
            sharedPreferences.setString("region1", re1);
            sharedPreferences.setString("region2", re2);
            sharedPreferences.setString("region3", re3);
          }
          else {
            alertmessage("false", body["msg"]);
          }
        });
      });
    }
    }
  getdata()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    alertwait();
    var url = "https://azz.sla-request.com/api/places";
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
    var url2 = "https://azz.sla-request.com/api/Data-Edit-User";
   var token = sharedPreferences.getString("token");
   print(token);
    var response2 = await http.get(Uri.parse(url2), headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 =jsonDecode(response2.body);
    Navigator.of(contexta).pop("dialog");
    return {"photo": body2["data"]["ProfilePhoto"],"name" : body2["data"]["Name"] , "phone" :  body2["data"]["PhoneNumber"]  , "email" : body2["data"]["Email"], "re1" : body2["data"]["Governorate"] , "re2" : body2["data"]["City"] , "re3" : body2["data"]["Region"] , "listre1" : region1 , "listre2" : region2 , "listre3" : region3 };
  }
  List categories =[];
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
  getdata22()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = "https://azz.sla-request.com/api/places";
    alertwait();
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    for (int f = 0; f < body["data"].length; f++) {
      region1.add({
        "name": body["data"][f]["Name"],
        "ID": body["data"][f]["ID"].toString()
      });
      for (int g = 0; g < body["data"].length; g++) {
        region2.add({
          "name": body["data"][f]["Cities"][g]["Name"],
          "ID": body["data"][f]["Cities"][g]["ID"].toString()
        });
        for (int k = 0; k < body["data"].length; k++) {
          region3.add({
            "name": body["data"][f]["Cities"][g]["Regions"][k]["Name"],
            "ID": body["data"][f]["Cities"][g]["Regions"][k]["ID"].toString()
          });
        }
      }
    }
    var url2 = "https://azz.sla-request.com/api/home";
    var response2 = await http.get(Uri.parse(url2));
    var body2 = jsonDecode(response2.body);
    List subcats =[
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
    List cats = [];
    categories = body2["categories"]["cats"];
    for (int g = 0; g < categories.length; g++) {
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
   Navigator.of(contexta).pop();
      return {
        "cat": cats,
        "subcats" : subcats,
        "listre1": region1,
        "listre2": region2,
        "listre3": region3
      };

  }
  getdata2()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = "https://azz.sla-request.com/api/places";
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
    var url2 = "https://azz.sla-request.com/api/Data-Edit-User";
    var token = sharedPreferences.getString("token");
    print(token);
    var response2 = await http.get(Uri.parse(url2), headers: {
      'Authorization': 'Bearer $token',
    });
    var body2 =jsonDecode(response2.body);
    return {"photo": body2["data"]["ProfilePhoto"],"name" : body2["data"]["Name"] , "phone" :  body2["data"]["PhoneNumber"]  , "email" : body2["data"]["Email"], "re1" : body2["data"]["Governorate"] , "re2" : body2["data"]["City"] , "re3" : body2["data"]["Region"] , "listre1" : region1 , "listre2" : region2 , "listre3" : region3 };
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
}