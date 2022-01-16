import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ezzproject/logic/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Chat2 extends StatefulWidget{
  var user_id;
  List messags = [];
  var type;
  Chat2({this.user_id, this.type ,this.messags});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateaddservices(user_id: user_id , messages: messags);
  }
}
class Stateaddservices extends State<Chat2>{
  var user_id;
  var type;
  var providerid;
  List messages =[];
  Stateaddservices({this.user_id ,this.type ,this.messages});
  TextEditingController message ;
  Chatlogic chatlogic;
  List messages1 =[];
  Future<void> initPusher() async {
    final PusherOptions options = PusherOptions(
        auth: PusherAuth(
          "https://azz.sla-request.com/api/broadcasting/auth",
        ),
        encrypted: true,
        cluster: 'mt1');
    FlutterPusher pusher;
    pusher = FlutterPusher("3abdf681e6e326e0e93c", options, enableLogging: true,
        onConnectionStateChange: (ConnectionStateChange state) async {
          print('stateChange ${state.toJson()}');
          if (pusher != null && state.currentState == 'CONNECTED') {
            final String socketId = pusher.getSocketId();
            print('pusher socket id: $socketId');
// Laravel echo will subscribe the channel with full namespace.
            // Ex: App\Events
            final Echo echo = Echo(<String, dynamic>{
              'broadcaster': 'pusher',
              'client': pusher,
            });
            echo.channel('azz-800').listen('ChatRecieved',
                    (Map<String, dynamic> message) {
                  setState(() {
                    messages.add({"user_id" : message["message"]["user_id"] ,
                    "provider_id" : message["message"]["provider_id"],
                      "message" : message["message"]["message"],
                      "sender" : message["message"]["sender"],
                      //"ReciveName" : message["message"]["ReciveName"],
                     "RecivePhoto" : message["message"]["RecivePhoto"].toString(),
                      "SenderPhoto" : message["message"]["SenderPhoto"].toString(),
                    //  "SenderName" : message["message"]["SenderName"],
                      "created_at" : message["message"]["created_at"]});
                  });
                });
          }
        });
  }
  setid()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    providerid= sharedPreferences.getString("id");
    providerid = "5";
  }
  @override
  void initState() {
    setid();
    print(user_id);
    print(providerid);
    chatlogic = new Chatlogic(context);
    initPusher();
    message = new TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
          child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.black,),onPressed: (){navigateback();},))),
            Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("محادثة",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.045),))),
            Expanded(child: Container())
          ],),),
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.7,child: ListView.builder(itemCount: messages.length
            ,itemBuilder: (context,i){
             // if(messages[i]["sender"].toString() =="Provider"){
            //    return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),true,"");
           //   }else{
           //     return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(), false,"");
           //  }
              if(messages[i]["sender"].toString() =="Provider"){
                if(messages[i]["user_id"].toString() ==messages[i]["SenderID"].toString() ){
                  return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),true,messages[i]["SenderPhoto"], messages[i]["SenderName"]);
                }
                else{
                  return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),true,messages[i]["RecivePhoto"] ,messages[i]["ReciveName"] );
                }
              }else{
                if(messages[i]["provider_id"].toString() ==messages[i]["SenderID"].toString() ){
                  return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),false,messages[i]["SenderPhoto"], messages[i]["SenderName"]);
                }
                else{
                  return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),false,messages[i]["RecivePhoto"] ,messages[i]["ReciveName"] );
                }
              }
            }),),
        Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05) ,
          decoration: BoxDecoration( color: Colors.black12,border: Border.all(color: Colors.black26,width: 1.5),borderRadius: BorderRadius.circular(10)), child: Directionality(textDirection: TextDirection.rtl,child:
          Row(children: [Expanded(child:  InkWell(onTap: (){chatlogic.sendmessage2(message.text, user_id);
          message.text ="";
          },child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.05,decoration: BoxDecoration( borderRadius: BorderRadius.circular(5),color: Colors.black),child: Directionality(textDirection: TextDirection.ltr,child: Icon(Icons.send,color: Colors.white,)),)))
            ,Expanded(flex: 8 ,child: TextFormField(controller: message,decoration: InputDecoration(hintText: "اكتب هنا",hintStyle: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.035,),border: InputBorder.none),)),
          ]),),)

      ],),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }

    messagebuilder(msg,time,isme,photo ,name){
     DateTime dt = DateTime.parse(time.trim().substring(0,10));
      if(dt.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))){
        time = time.toString().trim().substring(0,10);
      }
      else{
        time = time.toString().trim().substring(11,19);
      }
      if(isme){
        return Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerRight ,child: Container( constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.5) ,alignment: Alignment.centerRight,decoration: BoxDecoration(color: Colors.black12.withOpacity(0.1) ,borderRadius: BorderRadius.circular(10)),child:
        Column(children: [
          Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text(msg,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),))),
          Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerLeft ,child: Text(time,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.025),),)
        ],),),);
      }
      else{
        return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Row(
          children: [Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02) ,child: Image(fit: BoxFit.fill,image: NetworkImage(photo),))),Expanded(flex: 6,
            child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02) ,constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft ,child: Container( constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.5) ,alignment: Alignment.centerRight,decoration: BoxDecoration(color: Colors.black26.withOpacity(0.2) ,borderRadius: BorderRadius.circular(10)),child:
            Column(children: [
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text(msg,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
              Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerLeft ,child: Text(time,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.025,color: Colors.black38),),)
            ],),),),
          ) ],
        ));
      }
    }
}