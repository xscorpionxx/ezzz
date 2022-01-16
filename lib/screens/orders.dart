import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Orders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateorders();
  }
}
class Stateorders extends State<Orders> {
  List data =[{"code":"123" , "type":"wadad" , "date":"12/21/2001" , "name":"ahmad","status":"wada","price":"123"}];
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement buildr;
    return  Scaffold(body:
        ListView(
          children:[
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,child :Stack(children: [
              Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
                decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
                  Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){},))),
                  Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("طلباتي",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.03),))),
                  Expanded(child: Container())
                ],),),
              Positioned( bottom: MediaQuery.of(context).size.height*0.04,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
            ],) ),
            Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.05) ,child: Text("جميع الطلبات"),)
            ,Directionality(textDirection: TextDirection.rtl,
              child: Container(height: MediaQuery.of(context).size.height*0.6,child:data.length==0?Container(child: Center(child: Text("لا يوجد أية طلب مسبق"),),): Container(height: MediaQuery.of(context).size.height*0.6,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child: ListView.builder(itemCount: data.length,itemBuilder: (context,i){
              return Container( decoration: BoxDecoration(color: Colors.white,boxShadow:[ BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                spreadRadius: 2.0,
                offset: Offset(22.0, 2.0), // shadow direction: bottom right
              )]),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.01 ),
                child:Column(
                  children:[ Row(children: [
                    Expanded(flex: 1,child: Container( padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                      child: Column(children:[Container(child:Row(children :[
                        Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),child: Text("رقم الطلب :" , style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),),),
                        Container(alignment: Alignment.centerRight,child: Text(data[i]["code"], style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015 ),))
                      ])) ,
                        Container( alignment: Alignment.centerLeft,child:Row(children :[
                          Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),child: Text("نوع الخدمة :" , style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),),),
                          Container(alignment: Alignment.centerLeft,child: Directionality(textDirection: TextDirection.ltr,child: Text(data[i]["type"], style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015 ),)))
                        ])) ,Container(
                          child:data[i]["price"]==null?Container(): Container( alignment: Alignment.centerLeft,child:Row(children :[
                            Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),child: Text("قيمة الطلب :" , style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),),),
                            Container(alignment: Alignment.centerLeft,child: Directionality(textDirection: TextDirection.ltr,child: Text(data[i]["price"], style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015 ),)))
                          ])),
                        ) ]),),),
                    Expanded(flex: 1,child: Container( padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,
                        child: Column(children:[Container(child:Row(children :[
                          Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0),child: Directionality(textDirection: TextDirection.rtl,child: Text("تاريخ الطلب :" , style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),)),),
                          Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.ltr,child: Text(data[i]["date"],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),))),
                        ])),
                          Container(child:Row(children :[
                            Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0),child: Directionality(textDirection: TextDirection.rtl,child: Text("اسم التاجر :" , style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),)),),
                            Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.ltr,child: Text(data[i]["name"],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),))),
                          ])),Container(child:Row(children :[  Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0),child: Text("حالة الطلب :" , style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),),),
                          Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0),alignment: Alignment.centerRight,child: Text(data[i]["status"],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),))
                        ]),)
                        ],)))]),
                    Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01),child: Row(children: [
                      InkWell(child: Container( width: MediaQuery.of(context).size.width*0.3,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right:MediaQuery.of(context).size.width*0.01 ),height: MediaQuery.of(context).size.height*0.05,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),child: Row(children:[Icon(Icons.info,color: Colors.white,),Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05) ,child: Text("تفاصيل",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015,color: Colors.white),)),] ),))
                      ,InkWell(child:Container( width: MediaQuery.of(context).size.width*0.3,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.01 ) ,height: MediaQuery.of(context).size.height*0.05,alignment: Alignment.center ,decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(10)),child: Text("قيم الطلب",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015,color: Colors.white),),) )]))
                  ],
                ) ,
              );
          }),
          )),
            )],
        ));
  }
}