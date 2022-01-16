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
class Addservice3logic {
  var contexta;

  Addservice3logic(BuildContext context) {
    contexta = context;
  }
  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يمكن أن تبقي الحقل فارغ';
    }
    return null;
  }
  getplaces()async{
    var url = "https://azz.sla-request.com/api/places";
    alertwait();
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
    print(region1);
    Navigator.of(contexta).pop("dialog");
    return {"1":region1 , "2": region2,"3":region3};
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
    Navigator.of(contexta).popUntil((route) => route.isFirst);
    Navigator.of(contexta).pushReplacement(
        MaterialPageRoute(builder: (contexta) {
          return Home2();
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
  addservice3(GlobalKey<FormState> key , placetype,name,re2,re3 ,address,masaha , numofroof,numofroom , fornum , wcs , ketchins,price, sale_price , desc,features  ,photos,photoa , accept,locationurl)async{
    if(key.currentState.validate()) {
      if(photoa ==null){
        alertmessage("يجب اختيار الصورة للمناسبة");
      }
      else {
        if (accept) {
          if (re2 != "المدينة" && re3 != "المنطقة" &&
              placetype != "نوع المكان") {
            var id2;
            var id3;
            print("here");
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
            SharedPreferences sharedPreferences = await SharedPreferences
                .getInstance();
            var url = "https://azz.sla-request.com/api/addPlace";
            var token = sharedPreferences.getString("token");
            print(token);
            alertwait();
            var request = new http.MultipartRequest("POST", Uri.parse(url));
            request.fields["desc"] = desc.toString();
            request.fields["type"] = placetype.toString();
            request.fields["city_id"] = id2.toString();
            request.fields["region_id"] = id3.toString();
            request.fields["address"] = address.toString();
            request.fields["address_link"] = locationurl.toString();
            request.fields["area"] = masaha.toString();
            request.fields["level_count"] = numofroof.toString();
            request.fields["room_count"] = numofroom.toString();
            request.fields["space_count"] = fornum.toString();
            request.fields["accept_rules"] = "1".toString();
            request.fields["bathroom_count"] = wcs.toString();
            request.fields["kitchen_room_count"] = ketchins.toString();
            request.fields["day_rental"] = price.toString();
            request.fields["weekly_rental"] = sale_price.toString();
            request.fields["name"] = name.toString();
            List photosa = [];
            photosa.add(photoa);
            for (int g = 0; g < photos.length; g++) {
              if(photos[g] !=null) {
                request.files.add(await http.MultipartFile.fromPath("photos",
                    photos[g].path));
              }
            }
            request.files.add(await http.MultipartFile.fromPath("photos",
                photoa.path));
            request.headers.addAll({
              'Authorization': 'Bearer $token',
            });
            request.files.add(await http.MultipartFile.fromPath("photo",
                photoa.path));
            request.headers.addAll({
              'Authorization': 'Bearer $token',
            });
            var response = await request.send().then((value) {
              value.stream.transform(utf8.decoder).listen((event) async {
                var body = jsonDecode(event);
                Navigator.of(contexta).pop("dialog");
                print(body);
                if (body["status"] == true) {
                  alertmessage("true");
                }
                else {
                  alertmessage(body["msg"]);
                }
              });
            });
          }
          else{
            alertmessage("يجب اختيار نوع المكان والمدينة والمنطقة بالطريقة المناسبة");
          }
        }else {
          alertmessage("يجب عليك أن توافق على الشروط المطلوية");
        }
      }

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
  editservice3( id,GlobalKey<FormState> key , placetype,name,re2,re3 ,address,masaha , numofroof,numofroom , fornum , wcs , ketchins,price, sale_price , desc,features  ,photos,photoa , accept,locationurl)async{
    print(re2);
    print(re3);
    print(placetype);
    print(photos);
    print(photoa);
    if(key.currentState.validate()) {
        if (accept) {
          if (re2 != "المدينة" && re3 != "المنطقة" &&
              placetype != "نوع المكان") {
            var id2;
            var id3;
            print("here");
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
            SharedPreferences sharedPreferences = await SharedPreferences
                .getInstance();
            var url = "https://azz.sla-request.com/api/updatePlace/"+id.toString();
            var token = sharedPreferences.getString("token");
            print(token);
            alertwait();
            var request = new http.MultipartRequest("POST", Uri.parse(url));
            request.fields["desc"] = desc.toString();
            request.fields["type"] = placetype.toString();
            request.fields["city_id"] = id2.toString();
            request.fields["region_id"] = id3.toString();
            request.fields["address"] = address.toString();
            request.fields["address_link"] = locationurl.toString();
            request.fields["area"] = masaha.toString();
            request.fields["accept_rules"] = "1".toString();
            request.fields["level_count"] = numofroof.toString();
            request.fields["room_count"] = numofroom.toString();
            request.fields["space_count"] = fornum.toString();
            request.fields["bathroom_count"] = wcs.toString();
            request.fields["kitchen_room_count"] = ketchins.toString();
            request.fields["day_rental"] = price.toString();
            request.fields["weekly_rental"] = sale_price.toString();
            request.fields["name"] = name.toString();
            List photosa = [];
            photosa.add(photoa);
            for (int g = 0; g < photos.length; g++) {
              if(photos[g] !=null) {
                request.files.add(await http.MultipartFile.fromPath("photos",
                    photos[g].path));
              }
            }
           // request.files.add(await http.MultipartFile.fromPath("photos",
             //   photoa.path));
            request.headers.addAll({
              'Authorization': 'Bearer $token',
            });
          //  request.files.add(await http.MultipartFile.fromPath("photo",
          //      photoa.path));
            request.headers.addAll({
              'Authorization': 'Bearer $token',
            });
            var response = await request.send().then((value) {
              value.stream.transform(utf8.decoder).listen((event) async {
                var body = jsonDecode(event);
                print(body);
                if (body["status"] == true) {
                  alertmessage2("true");
                }
                else {
                  alertmessage2(body["msg"]);
                }
              });
            });
          }
          else{
            alertmessage("يجب اختيار نوع المكان والمدينة والمنطقة بالطريقة المناسبة");
          }
        }else {
          alertmessage("يجب عليك أن توافق على الشروط المطلوية");
        }
    }
  }
}