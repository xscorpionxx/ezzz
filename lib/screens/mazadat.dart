import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mazadlogic.dart';
import 'package:ezzproject/logic/profile.dart';
import 'package:ezzproject/screens/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'notification.dart';

class Mazad extends StatefulWidget{
  var mazad;
  Mazad({this.mazad});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statemazad(mazad: mazad);
  }
}
class Statemazad extends State<Mazad>{
  var mazad;
  Statemazad({this.mazad});
  TextEditingController message;
  Mazadlogic mazadlogic;
  GlobalKey<FormState> key;
  List comments =[];
  @override
  void initState() {
    print(mazad);
    key = new GlobalKey<FormState>();
    mazadlogic = new Mazadlogic(context);
    message = new TextEditingController();
    getdata1();
    super.initState();
  }
  getdata1()async{
    comments = await mazadlogic.getcomments(mazad["ID"]);
   setState(() {
   });
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  navigatetostore(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  var data = "عدد 200 من هذه الاغنام الكبيرة التي لا تغني ولا تسمن من جوع";
  List msgs = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
        child: ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
            decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
            Container(child: Stack(
              children: [
                Positioned( bottom: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.2) , borderRadius: BorderRadius.circular(1000)),),)
                ,Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Row(children: [
                    Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                    Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: Text("مزادات",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                    Expanded(flex: 2,child: InkWell(onTap: navigatetonotification,child: SvgPicture.asset("svg/Icon-alarm.svg",semanticsLabel: "wadca",))),
                    Expanded(flex: 2,child:InkWell(onTap: ()=>navigatetostore(),child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("svg/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) )
                  ],),
                ),],
            )),
          ),
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.25,child: Image(fit: BoxFit.fill,image:NetworkImage(mazad["Photo"]) ,),),
          Container(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),  color: Colors.black12,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(mazad["Description"].toString(),maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*15,color: Colors.black38),)),),
          Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ),height: MediaQuery.of(context).size.height*0.4,child: ListView.builder(itemCount: comments.length,itemBuilder: (context,i){
return Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:Row(children: [
  Expanded(flex: 7,child: Container(alignment: Alignment.centerRight,child: Column(children: [
    Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text(comments[i]["User"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),)),),
    Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text("منذ" +"",style: TextStyle(color: Colors.black26,fontSize: MediaQuery.of(context).size.width*0.025),)),),
    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,child: Directionality(textDirection: TextDirection.rtl,child: Text(comments[i]["Comment"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),)),),
    Container(child: Divider(color: Colors.black12.withOpacity(0.1),thickness: 1,),)
  ],),)),
  Expanded(child: Container(height: MediaQuery.of(context).size.height*0.1,alignment: Alignment.topCenter,child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image(image: NetworkImage(comments[i]["UserPhoto"]),fit: BoxFit.fill,)),))

],) ,);
          }),),
          Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05) ,
            decoration: BoxDecoration( color: Colors.black12,border: Border.all(color: Colors.black26,width: 1.5),borderRadius: BorderRadius.circular(10)), child: Directionality(textDirection: TextDirection.rtl,child:
            Row(children: [Expanded(child:  InkWell(onTap: ()async{
              await mazadlogic.addcomm(key, message.text,mazad["ID"]);
              getdata1();
              },child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.05,decoration: BoxDecoration( borderRadius: BorderRadius.circular(5),color: Colors.black),child: Directionality(textDirection: TextDirection.ltr,child: Icon(Icons.send,color: Colors.white,)),)))
              ,Expanded(flex: 8 ,child: TextFormField( validator: mazadlogic.validate,keyboardType: TextInputType.number,controller: message,textInputAction: TextInputAction.send,decoration: InputDecoration(hintText: " اكتب هنا قيمة عرضك على المزاد",hintStyle: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.035,),border: InputBorder.none),)),
            ]),),)
        ],),
      ),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}