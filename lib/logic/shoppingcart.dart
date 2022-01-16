import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/confirmation.dart';
import 'package:ezzproject/screens/home.dart';
import 'package:ezzproject/screens/home2.dart';
import 'package:ezzproject/screens/showimages.dart';
import 'package:ezzproject/screens/sucess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Shoppingcartlogic {
  var contexta;
  Shoppingcartlogic(BuildContext context) {
    contexta = context;
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
                  Navigator.of(context).pop();
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
                  Navigator.of(context).pop();
                },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
              )
            ],),
          ),),
        );
      });
    }
  }
  alertmessagec(trues,message) {
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
                if(trues == "true"){
                  Navigator.of(context).pop("dialog");
                  Navigator.of(context).pop();
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
      var email ="ahmad@gmail.com";
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
        alertmessage("true",body["msg"]);
      }
      else {
        alertmessage( "false",body["msg"]);
      }
    }
  }
  getcart()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    alertwait();
    var url = "https://azz.sla-request.com/api/myCart";
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    },);
    Navigator.of(contexta).pop("dialog");
    var body = jsonDecode(response.body);
    return body;
  }
  List region1 = [];
  List region2 = [];
  List region3 = [];
  delteproduct(shoppingbasket ,i)async{
    List basket =[];
    print(shoppingbasket);
    for(int g =0 ; g<shoppingbasket.length;g++){
      if(shoppingbasket[g]["num"]>0){
        basket.add(shoppingbasket[g]);
      }
    }
    alertwait();
    var url = "https://azz.sla-request.com/api/removeFromCart";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    var token = sharedPreferences.getString("token");
    print(token);
    var data = {
        "product_id":shoppingbasket[i]["id"].toString(),
      };
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
      showDialog(context: contexta, builder: (context) {
        return AlertDialog(title: new Text("خطأ"),
            content: Directionality(
                textDirection: TextDirection.rtl,
                child: new Text(body["msg"])),
            actions: [
              new ElevatedButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: Text("نعم")),
            ]);
      });
      return false;
    }
  }
  bool promoable =false;
  addpromocode(promocode , totalprice)async{
    if(promocode ==""){
      alertmessage("false", "لم يتم كتابة قسيمة الخصم");
    }
    else {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      alertwait();
      var token = sharedPreferences.getString("token");
      var urle = "https://azz.sla-request.com/api/promocode";
      var responsee = await http.post(Uri.parse(urle), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "promocode": promocode.toString(),
        "total_price": totalprice.toString()
      });
      Navigator.of(contexta).pop();
      var bodye = jsonDecode(responsee.body);
      if (bodye["status"] == true) {
        promoable = true;
        print(bodye["data"]["promo_value"]);
        Provider.of<Notifires>(contexta,listen: false).discountget(int.parse(bodye["data"]["promo_value"].toString()));
        if(false) {
          return showDialog(context: contexta, builder: (context) {
            return AlertDialog(
              content: Container(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.2, child: Column(children: [
                Container(
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(child: FittedBox(child: new Text(
                        bodye["msg"].toString(),
                        style: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.04),)))),
                ),
                Container(
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(child: FittedBox(child: new Text(
                        "قيمة قسيمة الخصم هي :" +
                            bodye["data"]["promo_value"].toString(),
                        style: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.04),)))),
                ),
                Container(
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(child: FittedBox(child: new Text(
                        "القيمة الاجمالي أصبحت :" +
                            bodye["data"]["total_price"].toString(),
                        style: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.04),)))),
                ),
                InkWell(onTap: () {
                  Navigator.of(context).pop("dialog");
                }, child: Container(width: MediaQuery
                    .of(context)
                    .size
                    .width,
                  padding: EdgeInsets.all(MediaQuery
                      .of(context)
                      .size
                      .width * 0.02),
                  margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01, left: MediaQuery
                      .of(context)
                      .size
                      .width * 0.1, right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.1),
                  decoration: BoxDecoration(
                      color: Colors.green, borderRadius: BorderRadius.circular(
                      20)),
                  child: Center(child: Text("نعم",
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery
                        .of(context)
                        .size
                        .width * 0.03),),),))
              ],),),
            );
          });
        }
      }
      else {
        alertmessagec("false", bodye["msg"]);
      }
    }
  }
  var promoable1 = false;
  addpromocodere(promocode , totalprice)async{
    if(promocode ==""){
      alertmessage("false", "لم يتم كتابة قسيمة الخصم");
    }
    else {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      alertwait();
      var token = sharedPreferences.getString("token");
      var urle = "https://azz.sla-request.com/api/promocode";
      var responsee = await http.post(Uri.parse(urle), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "promocode": promocode.toString(),
        "total_price": totalprice.toString()
      });
      Navigator.of(contexta).pop();
      var bodye = jsonDecode(responsee.body);
      if (bodye["status"] == true) {
        promoable1 = true;
        print(bodye["data"]["promo_value"]);
        Provider.of<Notifires>(contexta,listen: false).discountgetres(int.parse(bodye["data"]["promo_value"].toString()));
        if(false) {
          return showDialog(context: contexta, builder: (context) {
            return AlertDialog(
              content: Container(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.2, child: Column(children: [
                Container(
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(child: FittedBox(child: new Text(
                        bodye["msg"].toString(),
                        style: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.04),)))),
                ),
                Container(
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(child: FittedBox(child: new Text(
                        "قيمة قسيمة الخصم هي :" +
                            bodye["data"]["promo_value"].toString(),
                        style: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.04),)))),
                ),
                Container(
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Center(child: FittedBox(child: new Text(
                        "القيمة الاجمالي أصبحت :" +
                            bodye["data"]["total_price"].toString(),
                        style: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.04),)))),
                ),
                InkWell(onTap: () {
                  Navigator.of(context).pop("dialog");
                }, child: Container(width: MediaQuery
                    .of(context)
                    .size
                    .width,
                  padding: EdgeInsets.all(MediaQuery
                      .of(context)
                      .size
                      .width * 0.02),
                  margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01, left: MediaQuery
                      .of(context)
                      .size
                      .width * 0.1, right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.1),
                  decoration: BoxDecoration(
                      color: Colors.green, borderRadius: BorderRadius.circular(
                      20)),
                  child: Center(child: Text("نعم",
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery
                        .of(context)
                        .size
                        .width * 0.03),),),))
              ],),),
            );
          });
        }
      }
      else {
        alertmessagec("false", bodye["msg"]);
      }
    }
  }
  reservation(date1,date2,accept,code,id,children,adult){
    if(date1 !=null&&date2 !=null) {
      if(accept) {
        return showDialog(context: contexta, builder: (context) {
          return AlertDialog(
            content: Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.1, child: Column(children: [
              Container(
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(child: FittedBox(child: new Text(
                      "هل أنت متأكد من اتمام الطلب".toString(),
                      style: TextStyle(fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.04),)))),
              ),
              Row(
                children: [ Expanded(
                  child: InkWell(onTap: () async {
                    Navigator.of(context).pop("dialog");
                    var url = "https://azz.sla-request.com/api/reservation";
                    SharedPreferences sharedPreferences = await SharedPreferences
                        .getInstance();
                    alertwait();
                    var token = sharedPreferences.getString("token");
                    var data;
                    if (code == "" || !promoable1) {
                      data = {
                        "place_id" : id.toString(),
                        "children": children,
                        "start_date" : date1.toString(),
                        "end_date" : date2.toString(),
                        "adult": adult.toString(),
                      };
                    }
                    else {
                      data = {
                        "promocode": code.toString(),
                        "place_id" : id.toString(),
                        "children": children,
                        "start_date" : date1.toString(),
                        "end_date" : date2.toString(),
                        "adult": adult.toString(),
                      };
                    }
                    var response = await http.post(Uri.parse(url), headers: {
                      'Authorization': 'Bearer $token',
                    }, body: data);
                    var body = jsonDecode(response.body);
                    print(body);
                    print(data);
                    Navigator.of(contexta).pop("dialog");
                    if (body["status"] == true) {
                      Navigator.of(contexta).push(
                          MaterialPageRoute(builder: (contexta) {
                            return Confirmation();
                          }));
                    }
                    else {
                      alertmessagec("false", body["msg"]);
                    }
                  }, child: Container(width: MediaQuery
                      .of(context)
                      .size
                      .width,
                    padding: EdgeInsets.all(MediaQuery
                        .of(context)
                        .size
                        .width * 0.02),
                    margin: EdgeInsets.only(top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.01),
                    decoration: BoxDecoration(color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text("نعم",
                      style: TextStyle(color: Colors.white, fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.03),),),)),
                ),
                  Expanded(child: InkWell(onTap: () {
                    Navigator.of(context).pop("dialog");
                  }, child: Container(width: MediaQuery
                      .of(context)
                      .size
                      .width,
                    padding: EdgeInsets.all(MediaQuery
                        .of(context)
                        .size
                        .width * 0.02),
                    margin: EdgeInsets.only(top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.01),
                    decoration: BoxDecoration(color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text("لا",
                      style: TextStyle(color: Colors.white, fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.03),),),)),
                  )
                ],)
            ],),),
          );
        });
      }else{
        alertmessage("", "يجب الموافقة على الشروط والاحكام");
      }
    }
    else{
      alertmessage("", "يجب اختيار تاريخ الوصول والمغادرة");
    }
  }
  makeorder(address ,phone,region1,region2,region3,region1back,region2back,region3back ,code,totalprice)async{
    print(code);
    if(address.toString() !="" && phone.toString() !=""&& region1 !=null&&region2!=null&&region3!=null) {
      return showDialog(context: contexta, builder: (context) {
        return AlertDialog(
          content: Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.1, child: Column(children: [
            Container(
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(child: FittedBox(child: new Text(
                    "هل أنت متأكد من اتمام الطلب".toString(),
                    style: TextStyle(fontSize: MediaQuery
                        .of(context)
                        .size
                        .width * 0.04),)))),
            ),
            Row(
              children: [ Expanded(
                child: InkWell(onTap: () async {
                  Navigator.of(context).pop("dialog");
                  var url = "https://azz.sla-request.com/api/MakeOrder";
                  SharedPreferences sharedPreferences = await SharedPreferences
                      .getInstance();
                  alertwait();
                  var token = sharedPreferences.getString("token");
                  var id1;
                  var id2;
                  var id3;
                  for (int f = 0; region1back.length > f; f++) {
                    if (region1back[f]["name"].toString() ==
                         region1.toString()) {
                      id1 = region1back[f]["ID"];
                    }
                  }
                  for (int f = 0; region2back.length > f; f++) {
                    if (region2back[f]["name"].toString() ==
                        region2.toString()) {
                      id2 = region2back[f]["ID"];
                    }
                  }
                  for (int f = 0; region3back.length > f; f++) {
                    if (region3back[f]["name"].toString() ==
                        region3.toString()) {
                      id3 = region3back[f]["ID"];
                    }
                  }
                  var data;
                  if (code == "" || !promoable) {
                    data = {
                      "address": address.toString(),
                      "phone": phone.toString(),
                      "governorate_id": id1.toString(),
                      "city_id": id2.toString(),
                      "region_id": id3.toString(),
                      "total_price": totalprice.toString()
                    };
                  }
                  else {
                    data = {
                      "address": address.toString(),
                      "promocode": code.toString(),
                      "phone": phone.toString(),
                      "governorate_id": id1.toString(),
                      "city_id": id2.toString(),
                      "region_id": id3.toString(),
                      "total_price": totalprice.toString()
                    };
                  }
                  var response = await http.post(Uri.parse(url), headers: {
                    'Authorization': 'Bearer $token',
                  }, body: data);
                  var body = jsonDecode(response.body);
                  print(body);
                  print(data);
                  Navigator.of(contexta).pop("dialog");
                  if (body["status"] == true) {
                    Navigator.of(contexta).popUntil((route) => route.isFirst);
                    Navigator.of(contexta).pushReplacement(
                        MaterialPageRoute(builder: (contexta) {
                          return Success(order :body["data"]);
                        }));
                  }
                  else {
                    alertmessagec("false", body["msg"]);
                  }
                }, child: Container(width: MediaQuery
                    .of(context)
                    .size
                    .width,
                  padding: EdgeInsets.all(MediaQuery
                      .of(context)
                      .size
                      .width * 0.02),
                  margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01),
                  decoration: BoxDecoration(color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(child: Text("نعم",
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery
                        .of(context)
                        .size
                        .width * 0.03),),),)),
              ),
                Expanded(child: InkWell(onTap: () {
                  Navigator.of(context).pop("dialog");
                }, child: Container(width: MediaQuery
                    .of(context)
                    .size
                    .width,
                  padding: EdgeInsets.all(MediaQuery
                      .of(context)
                      .size
                      .width * 0.02),
                  margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01),
                  decoration: BoxDecoration(color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(child: Text("لا",
                    style: TextStyle(color: Colors.white, fontSize: MediaQuery
                        .of(context)
                        .size
                        .width * 0.03),),),)),
                )
              ],)
          ],),),
        );
      });
    }
    else{
      alertmessage("", "يجب اكمال المعلومات بشكل كامل");
    }
  }
  cancelfav(id,Id){

  }
}