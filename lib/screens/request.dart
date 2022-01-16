import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Request extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Staterequest();
  }
}
class Staterequest extends State<Request> with SingleTickerProviderStateMixin{
  TabController tabController;
  @override
  void initState() {
    tabController = new TabController(vsync: this, length:4);
    super.initState();
  }

  List newrequestlist =[{"date":"2001","code":"200"},{"date":"2001","code":"200"}];
  List onworklist =[{"date":"2001","code":"200"},{"date":"2002","code":"300"},{"date":"2001","code":"200"}];
  List donelist =[{"date":"2001","code":"200","review": "0.5"},{"date":"2001","code":"200" ,"review":"0.4"}];
  List canceldlist =[{"date":"2001","code":"200"},{"date":"2001","code":"200"}];
  @override
  Widget build(BuildContext context) {
    tabController.addListener(() {
      setState(() {
      });
    });
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,child :Stack(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.only(bottomRight: Radius.circular(90),bottomLeft: Radius.circular(90))),child: Row(children: [
              Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){},))),
              Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الطلب",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.03),))),
              Expanded(child: Container())
            ],),),
          Positioned( bottom: MediaQuery.of(context).size.height*0.04,left: MediaQuery.of(context).size.width*0.4 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
        ],) ),
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,color: Colors.white ,child: Row(children: [
          Expanded(child: Container(child: Column(children:[ Container(child: tabController.index ==3?Text("("+canceldlist.length.toString()+")"+"ملغي ") :Text("ملغي",style: TextStyle(),))
            ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.08,right: MediaQuery.of(context).size.width*0.06),child:tabController.index ==3? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
          Expanded(child: Container(child: Column(children:[ Container(child: tabController.index ==2?Text("("+donelist.length.toString()+")"+"تم التنفيذ") :Text("تم التنفيذ",style: TextStyle(),))
            ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.06),child:tabController.index ==2? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
          Expanded(child: Container(child: Column(children:[ Container(child: tabController.index ==1?Text("("+onworklist.length.toString()+")"+"جاري العمل ") :Text("جاري العمل",style: TextStyle(),))
            ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.03),child:tabController.index ==1? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
          Expanded(child: Container(child: Column(children:[ Container(child: tabController.index ==0?Text("("+newrequestlist.length.toString()+")"+"طلب جديد ") :Text("طلب جديد",style: TextStyle(),))
            ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.03),child:tabController.index ==0? Divider(color: Colors.blue,thickness: 3,):Container(),)])))],),)
         ,Directionality(textDirection: TextDirection.rtl,
           child: Container(height: MediaQuery.of(context).size.height*0.7 ,child: TabBarView(controller: tabController,children:[
           newRequest(),
           onwork(),
           done(),
             canceld()
           ]),),
         )
         ,
      ],),
    ),);
  }
  Widget newRequest(){
    return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),height: MediaQuery.of(context).size.height*0.7 ,child: ListView.builder(itemCount: newrequestlist.length,itemBuilder: (context,i){
    return Container(decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 1.0,
        spreadRadius: 7.0,
        offset: Offset(3.0, 3.0), // shadow direction: bottom right
      )
    ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "رقم الطلب :  "+newrequestlist[i]["code"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),)),),
      Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "تاريخ الطلب :  "+newrequestlist[i]["date"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),)),),
      Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.03,right:MediaQuery.of(context).size.width*0.03 ),
        child: Row(children: [Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),)),
          Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.green),borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.check,color: Colors.green,)),Text("قبول الطلب",style: TextStyle(color: Colors.green),) ],),)),
          Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.red),borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.clear,color: Colors.red,)),Text("رفض الطلب",style: TextStyle(color: Colors.red),) ],),)),
        ]),
      ))
    ],),);
    })) ;
  }
  Widget onwork(){
    return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),height: MediaQuery.of(context).size.height*0.7 ,child: ListView.builder(itemCount: onworklist.length,itemBuilder: (context,i){
      return Container(decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 1.0,
          spreadRadius: 7.0,
          offset: Offset(3.0, 3.0), // shadow direction: bottom right
        )
      ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "رقم الطلب :  "+onworklist[i]["code"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),)),),
        Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "تاريخ الطلب :  "+onworklist[i]["date"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),)),),
        Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.6) ,width: MediaQuery.of(context).size.width*0.25,height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),))
      ],),);
    })) ;
  }
  Widget done(){
    return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),height: MediaQuery.of(context).size.height*0.7 ,child: ListView.builder(itemCount: donelist.length,itemBuilder: (context,i){
      return Container(decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 1.0,
          spreadRadius: 7.0,
          offset: Offset(3.0, 3.0), // shadow direction: bottom right
        )
      ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "رقم الطلب :  "+donelist[i]["code"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),)),),
        Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "تاريخ الطلب :  "+donelist[i]["date"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),)),),
        Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.03,right:MediaQuery.of(context).size.width*0.03 ),
          child: Row(children: [Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),)),
            Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Text("التقيم:",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017,color: Colors.yellowAccent.withGreen(1000)),)),Icon(Icons.star,color: Colors.yellowAccent.withGreen(1000),size: MediaQuery.of(context).size.height*0.02,),Text(donelist[i]["review"]) ],),)),
            Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white) ,child:  InkWell(onTap: ()=>showreview(i),child: Text("مشاهدة التقييم",style: TextStyle(color: Colors.blue),)),)),
          ]),
        ))
      ],),);
    })) ;
  }
  Widget canceld(){
    return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),height: MediaQuery.of(context).size.height*0.7 ,child: ListView.builder(itemCount: canceldlist.length,itemBuilder: (context,i){
      return Container(decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 1.0,
          spreadRadius: 7.0,
          offset: Offset(3.0, 3.0), // shadow direction: bottom right
        )
      ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "رقم الطلب :  "+canceldlist[i]["code"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),)),),
        Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "تاريخ الطلب :  "+canceldlist[i]["date"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),)),),
        Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.6) ,width: MediaQuery.of(context).size.width*0.25,height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),))
      ],),);
    })) ;
  }
  showreview(i){
    return showDialog( context: context, builder: (context) {
      return StatefulBuilder(builder: (Context , setState){
        return AlertDialog(
            content:Container(height: MediaQuery.of(context).size.height*0.4,width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03) ,child: Row(children: [
                  Expanded(child: Container(alignment: Alignment.centerLeft,child: IconButton(icon: Icon(Icons.clear,size: MediaQuery.of(context).size.height*0.03,color: Colors.black,),onPressed: (){},))),
                  Expanded(child: Container(alignment: Alignment.centerLeft,child: Text("تقييم الطلب",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.025),))),
                ],),),
                Container(height: MediaQuery.of(context).size.height*0.06,
                  child: Row(children: [ Expanded(flex: 1,child:Container(alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                      return Container(alignment: Alignment.center ,child: Icon(Icons.star,size: MediaQuery.of(context).size.height*0.04,));
                    }),
                  ))) ,Expanded(child:Container(alignment: Alignment.centerRight,child: Text("سرعة الاستجاية",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),) ],),
            ),
                Container(height: MediaQuery.of(context).size.height*0.06,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),
                  child: Row(children: [ Expanded(flex: 1,child:Container(alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                    return Container(alignment: Alignment.center ,child: Icon(Icons.star,size: MediaQuery.of(context).size.height*0.04,color: Colors.yellow.withGreen(1000),));
                  }),
                  ))) ,Expanded(child:Container(alignment: Alignment.centerRight,child: Text("وقت الوصول",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),) ],),
                ),
                Container(height: MediaQuery.of(context).size.height*0.06,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),
                  child: Row(children: [ Expanded(flex: 1,child:Container(alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                    return Container(alignment: Alignment.center ,child: Icon(Icons.star,size: MediaQuery.of(context).size.height*0.04,));
                  }),
                  ))) ,Expanded(child:Container(alignment: Alignment.centerRight,child: Text("مستوى اللحوم ونضافتها",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),) ],),
                ),
               Container(width: MediaQuery.of(context).size.width,alignment: Alignment.topRight,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,margin:EdgeInsets.all(MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.1 ,child: Text("وصل بالوقت",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),decoration: BoxDecoration(border: Border.all(color: Colors.lightBlueAccent),borderRadius: BorderRadius.circular(5)),)

              ])));
        },
      );
    });
  }
}