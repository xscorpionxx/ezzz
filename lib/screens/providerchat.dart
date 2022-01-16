import 'dart:convert';

import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/caht2.dart';
import 'package:ezzproject/screens/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class Providerchat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateproviderchat();
  }
}
class Stateproviderchat extends State<Providerchat> {
  TextEditingController query;

  @override
  void initState() {
    query = new TextEditingController();
    getdata();
    super.initState();
  }
  List messages =[];
  List searhcresult =[];
  @override
  Widget build(BuildContext context) {
    //searhcresult = Provider.of<Notifires>(context,listen: false).searchresultchat;
    // TODO: implement build
    return Scaffold(body: ListView(children: [
      Container(width: MediaQuery
          .of(context)
          .size
          .width, height: MediaQuery
          .of(context)
          .size
          .height * 0.167,
        decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))), child:
        Container(child: Stack(
          children: [
            Positioned(bottom: MediaQuery
                .of(context)
                .size
                .height * 0.05, left: MediaQuery
                .of(context)
                .size
                .width * 0.35, child: Container(width: MediaQuery
                .of(context)
                .size
                .height * 0.5,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(1000)),),)
            , Container(
              child: Column(
                  children: [ Container(margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01),
                    child: Row(children: [
                      Expanded(flex: 2,
                          child: Container(
                              margin: EdgeInsets.only(left: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back, size: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.06, color: Colors.white,),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },))),
                      Expanded(flex: 9,
                          child: Container(
                              margin: EdgeInsets.only(left: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.25),
                              alignment: Alignment.centerLeft,
                              child: Text("محادثات".toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.04),))),
                    ],),
                  ), Container(padding: EdgeInsets.only(right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.01, left: MediaQuery
                      .of(context)
                      .size
                      .width * 0.01), margin: EdgeInsets.only(left: MediaQuery
                      .of(context)
                      .size
                      .width * 0.07, right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.07,top: MediaQuery.of(context).size.height*0.015), decoration: BoxDecoration(color: Colors
                      .white, borderRadius: BorderRadius.circular(5))
                    , child: Directionality(textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: query,
                          onChanged: (val) {
                            // Provider.of<Notifires>(context ,listen: false).search(homedata, val);
                          },
                          style: TextStyle(fontSize: MediaQuery
                              .of(context)
                              .textScaleFactor * 12, color: Colors.black26),
                          decoration: InputDecoration(hintText: "بحث",
                              hintStyle: TextStyle(fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.035, color: Colors.black26),
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.search, color: Colors.black26,)),)),)
                  ]),
            )
          ],
        )),
      ),
      Container(margin: EdgeInsets.only(top: MediaQuery
          .of(context)
          .size
          .height * 0.05),
        height: MediaQuery
            .of(context)
            .size
            .height * 0.8,
        child:query.text=="" ?ListView.builder(
            itemCount: lastmessages.length, itemBuilder: (context, i) {
              if(lastmessages[i]["user_id"].toString()==lastmessages[i]["SenderID"].toString() ){
                return message(lastmessages[i]["created_at"] , lastmessages[i]["message"],lastmessages[i]["SenderName"],lastmessages[i]["SenderPhoto"] , lastmessages[i]["user_id"],
                    sub[i][ids[i]]);
              }else{
                return message(lastmessages[i]["created_at"] , lastmessages[i]["message"],lastmessages[i]["ReciveName"],lastmessages[i]["RecivePhoto"]  , lastmessages[i]["user_id"],
                    sub[i][ids[i]]);
              }
        }) : ListView.builder(
    itemCount: searhcresult.length, itemBuilder: (context, i) {
    if(searhcresult[i]["user_id"].toString()==searhcresult[i]["SenderID"].toString() ){
    return message(searhcresult[i]["created_at"] , searhcresult[i]["message"],searhcresult[i]["SenderName"],searhcresult[i]["SenderPhoto"] , searhcresult[i]["user_id"],
    sub[i][ids[i]]);
    }else{
    return message(searhcresult[i]["created_at"] , searhcresult[i]["message"],searhcresult[i]["ReciveName"],searhcresult[i]["RecivePhoto"]  , searhcresult[i]["user_id"],
    sub[i][ids[i]]);
    }
    }),)


    ],),);
  }
  message(time , message , name , photo ,user_id ,sub){
    print(sub);
    DateTime dt = DateTime.parse(time.trim().substring(0,10));
    if(dt.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))){
      time = time.toString().trim().substring(0,10);
    }
    else{
      time = time.toString().trim().substring(11,19);
    }
    return InkWell(onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Chat2(user_id:user_id ,messags: sub);
      }));
    }
    ,child: Container( margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.white,boxShadow: [  BoxShadow(
      color: Colors.black12
      ,blurRadius: 1.0,
      spreadRadius: 0.0,
      offset: Offset(2.0, 2.0), // shadow direction: bottom right
    )],borderRadius: BorderRadius.circular(10)),child: Row(children: [
      Expanded(child:Container( child: Text(time,style: TextStyle(color: Colors.grey,fontSize: MediaQuery.of(context).textScaleFactor*11),),) ),
      Expanded(flex: 5,child: Column(children: [
        Container(child: Text(name,style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*13,fontWeight: FontWeight.bold),),),
        Container(child: FittedBox(child: Text(message,style: TextStyle(color: Colors.grey,fontSize: MediaQuery.of(context).textScaleFactor*13),)),),
      ],)),
      Expanded(child: Container(height: MediaQuery.of(context).size.height*0.08,child: ClipRRect(borderRadius: BorderRadius.circular(100),child: Image(image: NetworkImage(photo),fit: BoxFit.fill,)),))
    ],),));
  }
  alertwait() {
    showDialog(
        barrierDismissible: false, context: context, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,
        content: Container(width: 30, height: 30,
            child: Center(child: SizedBox(
                width: 30, height: 30, child: CircularProgressIndicator()))),
      );
    });
  }
  List lastmessages = [];
  List sub =[];
  List ids = [];
  getdata() async {
    var url = "https://azz.sla-request.com/api/messages";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    alertwait();
    var token = sharedPreferences.getString("token");
   // token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXp6LnNsYS1yZXF1ZXN0LmNvbVwvYXBpXC9sb2dpbiIsImlhdCI6MTYzODk3MjQzMCwibmJmIjoxNjM4OTcyNDMwLCJqdGkiOiJ1WHc1eVRwZUQzZWpuRW9oIiwic3ViIjo4LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.Xzr06ntGltBFGtls5rxF_jpfWaHKffEYsKBQl0JlB6k";
    var provderid = sharedPreferences.getString("id");
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    Navigator.of(context).pop("dialog");
    var body = jsonDecode(response.body);
    if (body["status"] == true) {
      for (int g = 0; g < body["data"].length; g++) {
        if (body["data"][g]["provider_id"].toString().trim() == provderid.toString()) {
        messages.add(body["data"][g]);
      }
      }
      messages.forEach((element) {
       ids.add(element["user_id"].toString());
      });
      ids = ids.toSet().toList();
      ids.forEach((element) {
        sub.add({element.toString() : []});
      });
        for(int g = 0 ; g<ids.length ; g++){
          for(int f = 0 ;f< messages.length ; f++) {
            if(messages[f]["user_id"].toString() == ids[g]) {
              sub[g][ids[g]].add(messages[f]);
            }
          }
        }
        for(int d = 0 ;d<sub.length ; d++){
          print(sub.length);
          print(sub[d][ids[d]].length);
          var last_message = sub[d][ids[d]][0] ;
          DateTime dt = DateTime.now();// DateTime.parse(sub[d][ids[d]][0]["created_at"].toString().trim().substring(0,10) +" "+
               //sub[d][ids[d]][0]["created_at"].toString().trim().substring(11,19));
          for(int f =0 ; f<sub[d][ids[d]].length ; f++){
            DateTime da = DateTime.now();  //DateTime.parse(sub[d][ids[d]][f]["created_at"].toString().trim().substring(0,10) +" "+
                //sub[d][ids[d]][f]["created_at"].toString().trim().substring(11,19));
            if(da.isAfter(dt)){
              dt =da;
              last_message = sub[d][ids[d]][f];
            }
          }
          lastmessages.add(last_message);
        }
    }
    print(lastmessages);
    print(sub);
    setState(() {});
  }
}