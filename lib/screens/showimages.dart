import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezzproject/logic/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class Showimages extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statemain();
  }
}
class Statemain extends State<Showimages>with SingleTickerProviderStateMixin{
  var active = 0;
  TabController tabController;
  Loginlogic loginlogic;
  @override
  void initState() {
    tabController = new TabController(vsync: this, length:4);
    loginlogic = new Loginlogic(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(body: Container(child: TabBarView(physics: NeverScrollableScrollPhysics(),controller: tabController,
     children:[ Stack(children: [
       Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
       child: Image(fit: BoxFit.fill,image: AssetImage("images/images1.png"),))
       ,Positioned(top: MediaQuery.of(context).size.height*0.65,child: Container(
         child:  Container( decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: Colors.white.withOpacity(0.2),),width:MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.35
               ,child: Column(children: [
                   Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1) ,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText("تبحث عن ذبائح وطهاة لعزائمك أو حتى طيور وأسماك نوفرها لك",maxLines: 3,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*18),)),)
                   ,Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                     child: Row(children:[ Expanded(flex: 3,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: AnimatedSmoothIndicator(effect: WormEffect(),count: 4,activeIndex: 0,),)),Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),color: Colors.white,alignment: Alignment.center,child: FittedBox(
                       child: TextButton(child: Text("تخطي", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),),onPressed: (){
                         tabController.animateTo(1);
                       },),
                     ),))]),
                   )
                 ] ,),
           ),
       ) )
     ],),
       Stack(children: [
         Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
             child: Image(fit: BoxFit.fill,image: AssetImage("images/images2.png"),)),
         Positioned(top: MediaQuery.of(context).size.height*0.02,child: IconButton(icon:Icon( Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){
           tabController.animateTo(0);
         },))
         ,Positioned(top: MediaQuery.of(context).size.height*0.65,child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: Colors.white.withOpacity(0.2)),width:MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.35
           ,child:Column(children: [
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child : Center(child:FittedBox(child: Text("نوفر خدمات الشاحنات والمعدات الثقيلة والدينات",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15,color: Colors.white),)),)),
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child : Center(child: FittedBox(child: Text("بين مدن المملكة والخليج",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15 ,color: Colors.white),)),)),
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child : Center(child:FittedBox(child: Text("وسيارات الطلبات والمشاوير الخفيفة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor *15,color: Colors.white),)),)),
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04),
               child: Row(children:[ Expanded(flex: 3,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: AnimatedSmoothIndicator(effect: WormEffect(),count: 4,activeIndex: 1,),)),Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),color: Colors.white,alignment: Alignment.center,child: FittedBox(
                 child: TextButton(child: Text("تخطي", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),),onPressed: (){
                   tabController.animateTo(2);
                 },),
               ),))]),
             )
           ],) ,) )
       ],),
       Stack(children: [
         Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
             child: Image(fit: BoxFit.fill,image: AssetImage("images/images3.png"),)),
         Positioned(top: MediaQuery.of(context).size.height*0.02,child: IconButton(icon:Icon( Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){
           tabController.animateTo(1);
         },))
         ,Positioned(top: MediaQuery.of(context).size.height*0.65,child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: Colors.white.withOpacity(0.2)),width:MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.35
           ,child:Column(children: [
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child : Center(child: FittedBox(child: Text("سهلنا لك الوصول ألى الأسر المنتجة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*16,color: Colors.white),)),)),
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child : Center(child:FittedBox(child: Text("والتعرف على منتجاتهم",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*16,color: Colors.white),)),)),
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
               child: Row(children:[ Expanded(flex: 3,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: AnimatedSmoothIndicator(effect: WormEffect(),count: 4,activeIndex: 2,),)),Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),color: Colors.white,alignment: Alignment.center,child: FittedBox(
                 child: TextButton(child: Text("تخطي", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),),onPressed: (){
                   tabController.animateTo(3);
                 },),
               ),))]),
             )
           ],) ,) )
       ],),
       Stack(children: [
         Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
             child: Image(fit: BoxFit.fill,image: AssetImage("images/images4.png"),)),
         Positioned(top: MediaQuery.of(context).size.height*0.02,child: IconButton(icon:Icon( Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){
           tabController.animateTo(2);
         },))
         ,Positioned(top: MediaQuery.of(context).size.height*0.65,child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: Colors.white.withOpacity(0.2)),width:MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.35
           ,child:Column(children: [
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child : Center(child: FittedBox(child: Text("احصل على خدماتنا وقيم البائعين والسائقين",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15,color: Colors.white),)),)),
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child : Center(child:FittedBox(child: Text("في جميع مدن ومحافظات",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15,color: Colors.white),)),)),
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child : Center(child: FittedBox(child: Text("المملكة العربية اسعودية",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15,color: Colors.white),)),)),
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
               child: Row(children:[ Expanded(flex: 3,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: AnimatedSmoothIndicator(effect: WormEffect(),count: 4,activeIndex: 3,),)),Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),color: Colors.white,alignment: Alignment.center,child: FittedBox(
                 child: TextButton(child: Text("ابدأ", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),),onPressed: (){
                 loginlogic.navigatetomain();
                 },),
               ),))]),
             )
           ],) ,) )
       ],)],
   ),),);
  }
}