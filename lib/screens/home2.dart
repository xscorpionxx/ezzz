import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/home.dart';
import 'package:ezzproject/logic/home2.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/Editauction.dart';
import 'package:ezzproject/screens/addauction.dart';
import 'package:ezzproject/screens/addcoupons.dart';
import 'package:ezzproject/screens/addservice.dart';
import 'package:ezzproject/screens/addservice2.dart';
import 'package:ezzproject/screens/addservice3.dart';
import 'package:ezzproject/screens/editcupon.dart';
import 'package:ezzproject/screens/editservice.dart';
import 'package:ezzproject/screens/editservice2.dart';
import 'package:ezzproject/screens/editservice3.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/notification.dart';
import 'package:ezzproject/screens/orderdata.dart';
import 'package:ezzproject/screens/partner.dart';
import 'package:ezzproject/screens/profile.dart';
import 'package:ezzproject/screens/profile2.dart';
import 'package:ezzproject/screens/providerchat.dart';
import 'package:ezzproject/screens/providertransport.dart';
import 'package:ezzproject/screens/recommend.dart';
import 'package:ezzproject/screens/shareapp.dart';
import 'package:ezzproject/screens/terms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Loginpage.dart';
import 'aboutapp.dart';
import 'changepassword.dart';
import 'chat.dart';

class Home2 extends StatefulWidget{
  var servicetype ;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statehome2();
  }
}
class Statehome2 extends State<Home2> with TickerProviderStateMixin{
  Map<dynamic,dynamic> home2_data;
  var profiledata;
  TabController tabController2;
  TextEditingController cuponname ;
  TextEditingController cuponprice ;
  TextEditingController transportcollection;
  TextEditingController transportingnote;
  var transportingdate;
  var dateable = false;
  var download_service ;
  Home2logic home2logic;
  var active ;
  TabController tabController;
  var servicetype;
  gettype()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    servicetype = sharedPreferences.getString("servicetype");
  }
  @override
  void initState() {
    transportcollection = new TextEditingController();
    transportingnote= new TextEditingController();
    getdata2();
    gettype();
    home2logic = new Home2logic(context);
    tabController2 = new TabController(vsync: this, length:4);
    tabController = new TabController(vsync: this, length:6);
    tabController2.addListener(() {
      setState(() {
      });
    });
    cuponname = new TextEditingController();
    cuponprice = new TextEditingController();
    super.initState();
  }
  getdata2()async{
    Future.delayed(const Duration(milliseconds: 500), () {
      Provider.of<Notifires>(context,listen: false).reset();
      Provider.of<Notifires>(context, listen: false).gethome_provider(context);
    });
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  //List data =[1];
  var newrequest = true;
  var able = false;
  List servicess =[];
  List cupons =[];
  var value;
  List values =["يومي"];
  @override
  Widget build(BuildContext context) {
    value = Provider.of<Notifires>(context).valuehome2;
    download_service =Provider.of<Notifires>(context).downloadservice;
    active = Provider.of<Notifires>(context).active2;
    servicess = Provider.of<Notifires>(context).services;
    cupons = Provider.of<Notifires>(context).cupons;
    home2_data = Provider.of<Notifires>(context).home_provider;
    profiledata = Provider.of<Notifires>(context).profiledata;
    // TODO: implement build
    return Scaffold(body:  Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:  SingleChildScrollView(physics: ClampingScrollPhysics(),
        child: Column(children: [
          Directionality(textDirection: TextDirection.rtl,
            child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.94 ,child: TabBarView(physics: NeverScrollableScrollPhysics(),controller: tabController,children:[
              Homescreen(),
              services(),
              req(),
              coupon(),
              more(),
              commision()
            ])),
          ),
          Container(decoration: BoxDecoration(color: Colors.white),child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(left: 10,right: 10),height: MediaQuery.of(context).size.height*0.06,child:active=="more"?  Container(
              decoration: BoxDecoration() ,
              child: FittedBox(
                child: Column(children:[
                   Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.005),child: SvgPicture.asset("svg/Vector.svg",fit: BoxFit.scaleDown,)),
                  FittedBox(child: Text("المزيد",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
              ),
            ) :Container(
              child: InkWell(onTap: (){
                Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "more", 4, context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  Provider.of<Notifires>(context,listen: false).getprofile(context,false);
                });
              },
                child:FittedBox(child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.005 ),child: SvgPicture.asset("svg/Vector.svg",fit: BoxFit.scaleDown,)),
                  FittedBox(child: Text("المزيد",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))])),
              ),
            )))
            ,Expanded(child: Container(margin: EdgeInsets.only(left: 10,right: 10),height: MediaQuery.of(context).size.height*0.06,child:active=="cop"?  Container(
              decoration: BoxDecoration() ,
              child: FittedBox(
                child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.03,child: Image(image :AssetImage("images/icona41.png"),fit: BoxFit.scaleDown,)),
                 FittedBox(child: Text("كوبونات",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
              ),
            ) :Container(
              child: InkWell(onTap: (){
                Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "cop", 3, context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  if(!download_service){
                    Provider.of<Notifires>(context,listen: false).getservices(context);
                  }
                  Provider.of<Notifires>(context,listen: false).getcupon(context);
                });
              },
                child:FittedBox(child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.03,child: Image(image :AssetImage("images/copon.png"),fit: BoxFit.scaleDown,)),
                 FittedBox(child: Text("كوبونات",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))])),
              ),
            ))),
            Expanded(child: Container(margin: EdgeInsets.only(left: 1,right: 1),height: MediaQuery.of(context).size.height*0.06,child:active=="com"?  Container(
              decoration: BoxDecoration() ,
              child: FittedBox(
                child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.005),child:  Icon(Icons.monetization_on_outlined,color: Colors.blue,size: MediaQuery.of(context).textScaleFactor*23,)),
                  Text("تحويل عمولة",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),)]),
              ),
            ) :Container(
              child: InkWell(onTap: (){
                Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "com", 5, context);
              },
                child:FittedBox(child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.005 ),child: Icon(Icons.monetization_on_outlined,color: Colors.black54,size: MediaQuery.of(context).textScaleFactor*23)),
                  Text("تحويل عمولة",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),)])),
              ),
            ))),
            Expanded(child: Container(margin: EdgeInsets.only(left: 10,right: 10),height: MediaQuery.of(context).size.height*0.06,child:active=="req"?  Container(
              decoration: BoxDecoration() ,
              child: FittedBox(
                child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.03,child: Image(image: AssetImage("images/icon31.png"),)),
                  FittedBox(child: Text("الطلبات",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
              ),
            ) :Container(
              child: InkWell(onTap: (){
                Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "req", 2, context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  //Provider.of<Notifires>(context,listen: false).getprofile(context);
                });
              },
                child:FittedBox(child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.03,child:  Image(image: AssetImage("images/icona30.png"),)),
                 FittedBox(child: Text("الطلبات",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))])),
              ),
            )))
            ,Expanded(child: Container(margin: EdgeInsets.only(left: 10,right: 10),height: MediaQuery.of(context).size.height*0.06,child:active=="ser"?  Container(
              decoration: BoxDecoration() ,
              child: FittedBox(
                child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.03,child: Image(image :AssetImage("images/icona21.png"),fit: BoxFit.scaleDown,)),
                 FittedBox(child: Text("الخدمات",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
              ),
            ) :Container(
              child: InkWell(onTap: (){
                Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "ser", 1, context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  Provider.of<Notifires>(context,listen: false).getservices(context);
                });
              },
                child: FittedBox(
                  child: Column(children:[
                    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.03,child: Image(image :AssetImage("images/services.png"),fit: BoxFit.scaleDown,)),
                    FittedBox(child: Text("الخدمات",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
                ),
              ),
            ))),
            Expanded(child: Container(margin: EdgeInsets.only(left: 10,right: 10),height: MediaQuery.of(context).size.height*0.06,child:active=="home"?  Container(
              decoration: BoxDecoration() ,
              child: FittedBox(
                child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,width: MediaQuery.of(context).size.width*0.05 ,child: Image(image: AssetImage("images/icona12.png"),fit: BoxFit.fill,)),
                 FittedBox(child: Text("الرئيسية",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
              ),
            ) :Container(
              child: InkWell(onTap: (){
                Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "home", 0, context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  //Provider.of<Notifires>(context,listen: false).getprofile(context);
                });
              },child:FittedBox(
                child: Column(children:[
                    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,width: MediaQuery.of(context).size.width*0.05 ,child: Image(image: AssetImage("images/icona10.png"),fit: BoxFit.fill,)),
                 FittedBox(child: Text("الرئيسية",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
              ),
              ),
            ))),
          ],),)]),
      ),
    ),);
  }
  Widget Homescreen(){
    return  Directionality(textDirection: TextDirection.ltr,
      child: Container(child: Directionality(textDirection: TextDirection.ltr,
        child: ListView(children: [
             Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :Stack(children: [
                Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
                  decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
                    Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الرئيسة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),))),
                  ],),),
                Positioned( bottom: MediaQuery.of(context).size.height*0.04,left: MediaQuery.of(context).size.width*0.4 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
              ],) ,
            ),
            Container(child: !newrequest? Container():Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.025) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.01 ) ,color: Colors.green.withOpacity(0.9) ,child: Row(children: [
                Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,left:MediaQuery.of(context).size.width*0.02 ) ,child: Icon(Icons.notifications_none,color: Colors.white,size: MediaQuery.of(context).size.height*0.05,),)
                ,Container(height: MediaQuery.of(context).size.height*0.05 ,child: VerticalDivider(color: Colors.white,thickness: 1,),),
                Container(child: Text("لديك طلبات جيدة تابع طلباتك",style: TextStyle( color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),),),
                Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01 ),child: InkWell(onTap: (){},child: Text("هنا",style: TextStyle(decoration: TextDecoration.underline ,color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),)),)
              ],)),
            ),),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child: Row(children: [
              Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),child: Row(children: [
                InkWell( onTap: (){
                },child: Container(width: MediaQuery.of(context).size.width*0.22,height: MediaQuery.of(context).size.height*0.06,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:home2_data["ProviderStatus"].toString() =="1"? Colors.black26:Colors.red ),child:Center(child: Text("غير متاح",style: TextStyle(color:home2_data["ProviderStatus"].toString() =="1"? Colors.black38:Colors.white),)),)),
                InkWell(onTap: (){
                  if(able ==false){
                  //  print("false");
                  //  setState(() {
                  //    able =true;
                  //  });
                  }
                },child: Container(width: MediaQuery.of(context).size.width*0.22,height: MediaQuery.of(context).size.height*0.06,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:home2_data["ProviderStatus"].toString() =="1"? Colors.green:Colors.black26.withOpacity(0.1) ),child: Center(child: Text("متاح",style: TextStyle(color:home2_data["ProviderStatus"].toString() =="1"? Colors.white:Colors.black38),)),))
              ],),)),
              Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),alignment: Alignment.centerRight ,child: Text("الحالة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),),))
            ],),),
            Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08,top: MediaQuery.of(context).size.height*0.02) ,child: Text("احصائيات",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),),)
            , Container(child: Row(children: [Expanded(child: Container(height: MediaQuery.of(context).size.height*0.09 ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.yellow.withOpacity(0.2)),child:
             Center(child: FittedBox(
                child: Column(children: [
                  Container(child: Text(home2_data["ProviderInOrder"].toString() ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),),
                  Container(child: Text("طلب قيد التنفيذ",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)
                ],),
              )),)),
              Expanded(child: Container(height: MediaQuery.of(context).size.height*0.09 ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.lightBlue.withOpacity(0.2)),child: Center(
                child: FittedBox(
                  child: Column(children: [
                    Container(child: Text(home2_data["ProviderNewOrder"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),),
                    Container(child: Text("طلب جديد",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)
                  ],),
                ),
              ),))],),),
            Container(child: Row(children: [Expanded(child: Container(height: MediaQuery.of(context).size.height*0.09 ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.red.withOpacity(0.2)),child: Center(
              child: FittedBox(
                child: Column(children: [
                  Container(child: Text(home2_data["ProviderCancelOrder"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),),
                  Container(child: Text("طلب ملغي",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)
                ],),
              ),
            ),)),
              Expanded(child: Container(height: MediaQuery.of(context).size.height*0.09 ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.green.withOpacity(0.6)),child: Center(
                child: FittedBox(
                  child: Column(children: [
                    Container(child: Text(home2_data["ProviderCompleteOrder"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),),
                    Container(child: Text("طلب تم تنفيذه",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)
                  ],),
                ),
              ),))],),),
            Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08,top: MediaQuery.of(context).size.height*0.01) ,child: Text("العائدات",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),),),
            Container(height: MediaQuery.of(context).size.height*0.05,alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08,left: MediaQuery.of(context).size.width*0.08 ,top: MediaQuery.of(context).size.height*0.01) ,child: Row(children: [Expanded(child:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black26),borderRadius: BorderRadius.circular(5)),child:
             DropdownButtonHideUnderline(
                  child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017,color: Colors.black),
                    value: value
                    ,items: values.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                    onChanged: (_) {
                      Provider.of<Notifires>(context,listen: false).setvalue(_);
                      value =_;
                      setState(() {});
                    },
                  )),
            )) ,
              Expanded(child:Container(alignment: Alignment.centerRight,child: Text("حدد تاريخ ",style: TextStyle(color: Colors.black38 ,fontSize: MediaQuery.of(context).size.height*0.02),)) )]),)
            ,Container(decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)),height: MediaQuery.of(context).size.height*0.21,margin: EdgeInsets.only( top: MediaQuery.of(context).size.height*0.015,right: MediaQuery.of(context).size.width*0.07,left: MediaQuery.of(context).size.width*0.07) ,child:Column(
              children:[ Container(child: Row(children: [
                Expanded(flex: 2,child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: Directionality(textDirection: TextDirection.rtl,child: FittedBox(child: Text(" ريال"+home2_data["ProviderTotalSales"].toString(),style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*12),)))) )
                ,Expanded(flex: 3 ,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),alignment: Alignment.centerRight,child: Text("اجمالي المبيعات",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),)))
                ,Expanded(child: Container(child: Image(image: AssetImage("images/cash.png"))))
              ],)),
                Container(child: Row(children: [
                  Expanded(flex: 2,child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: Directionality(textDirection: TextDirection.rtl,child: FittedBox(child: Text(" ريال"+home2_data["ProviderCommission"].toString(),style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*12),)))) )
                  ,Expanded(flex: 3 ,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),alignment: Alignment.centerRight,child: Text("اجمالي العمولة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                  Expanded(child: Container())
                ],)),Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child: Row(children: [
                  Expanded(flex: 2,child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: Directionality(textDirection: TextDirection.ltr,child: FittedBox(child:InkWell(onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return Providertransport(transports: home2_data["ProviderTransport"],);
                    }));
                  },child: Icon(Icons.arrow_back,color: Colors.white,))))) )
                  ,Expanded(flex: 3 ,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),alignment: Alignment.centerRight,child: Text("التحصيلات",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                  Expanded(child: Container())
                ],)) ,Container( height: MediaQuery.of(context).size.height*0.04,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,left: MediaQuery.of(context).size.width*0.07),child: Directionality(textDirection: TextDirection.rtl,child: FittedBox(child:Text(home2_data["ProviderCancelHint"],style: TextStyle(color: Colors.white),) )),)],))
          ]
          ),
      ),
      ),
    );
  }
  deletecupon(i){
    return showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (Context, setState) {
        return AlertDialog(
            content: Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.2,
              child: Column(children: [
                Container(child: Text("حذف الكوبون"),)
                , Container(child: Text("هل تريد حذف الكويون"),),
                Container(margin: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05),
                  child: Row(
                      children: [ Expanded(flex: 3,
                        child: InkWell(onTap: () {
                          Navigator.of(context).pop();
                        },
                          child: Container(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.07,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.black26,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text("رفض", style: TextStyle(
                                color: Colors.white, fontSize: MediaQuery
                                .of(context)
                                .textScaleFactor * 12)),),
                        ),
                      ), Expanded(child: Container()),
                        Expanded(flex: 3, child: InkWell(onTap: () {
                          Navigator.of(context).pop();
                          home2logic.deletecupon(cupons[i]["CouponID"]);
                        },
                          child: Container(height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.07,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.green,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text("موافق", style: TextStyle(
                                color: Colors.white, fontSize: MediaQuery
                                .of(context)
                                .textScaleFactor * 12)),),
                        )),
                      ]),
                )
              ],),
            )
        );
      },
      );
    });
  }
  editcupon(i)async{
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Editcoupons(services: servicess,data: cupons[i],);
      }));
  }
  addservice() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var servicetype = sharedPreferences.getString("servicetype");
    print(servicetype);
    if(servicetype == "مراسيل") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return AddServices2();
      }));
    }
    if(servicetype != "اماكن" && servicetype!="مزاد" && servicetype!="مراسيل" ){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return AddServices();
      }));
    }
    if(servicetype == "اماكن"){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return AddServices3();
      }));
    }
    if(servicetype == "مزاد"){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Addauction();
      }));
    }
  }
  editservice(i) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var servicetype = sharedPreferences.getString("servicetype");
    print(servicetype);
    if(servicetype == "مراسيل") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return EditServices2(service : servicess[i]);
      }));
    }
    if(servicetype != "اماكن" && servicetype!="مزاد" && servicetype!="مراسيل" ){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Editservice(service : servicess[i]);
      }));
    }
    if(servicetype == "اماكن"){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return EditServices3(service : servicess[i]);
      }));
    }
    if(servicetype == "مزاد"){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Editauction(service : servicess[i]);
      }));
    }
  }
  deleteservice(int i)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var servicetype = sharedPreferences.getString("servicetype");
      return showDialog(context: context, builder: (context) {
        return StatefulBuilder(builder: (Context, setState) {
          return AlertDialog(
              content: Container(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.2,
                child: Column(children: [
                  Container(child: Text("حذف الخدمة"),)
                  , Container(child: Text("هل تريد حذف الخدمة"),),
                  Container(margin: EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05),
                    child: Row(
                        children: [ Expanded(flex: 3,
                          child: InkWell(onTap: () {
                            Navigator.of(context).pop();
                          },
                            child: Container(height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.07,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.black26,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text("رفض", style: TextStyle(
                                  color: Colors.white, fontSize: MediaQuery
                                  .of(context)
                                  .textScaleFactor * 12)),),
                          ),
                        ), Expanded(child: Container()),
                          Expanded(flex: 3, child: InkWell(onTap: () {
                            Navigator.of(context).pop();
                            home2logic.deleteservice(servicess[i]["ID"]);
                          },
                            child: Container(height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.07,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text("موافق", style: TextStyle(
                                  color: Colors.white, fontSize: MediaQuery
                                  .of(context)
                                  .textScaleFactor * 12)),),
                          )),
                        ]),
                  )
                ],),
              )
          );
        },
        );
      });
  }
  Widget services(){
    return Container(child: Directionality(textDirection: TextDirection.ltr,
      child: ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :Stack(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
              Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الخدمات",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
            ],),),
          Positioned( bottom: MediaQuery.of(context).size.height*0.04,left: MediaQuery.of(context).size.width*0.4 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
        ],) ),Container(child
            :Column(
          children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child: Row(children: [Expanded(child: InkWell(onTap: ()=>addservice(),child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,height: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),borderRadius: BorderRadius.circular(5)) ,child: Center(child: Text("اضافة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.white)),),))),Expanded(child: Column(children: [
            Container(child: Text("الخدمات",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),),
            Container(child: Directionality(textDirection: TextDirection.rtl,child: Text(" عدد"+servicess.length.toString()+"من الخدمات " ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),)),)
          ],))],),),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04) ,height: MediaQuery.of(context).size.height*0.65 ,child:
            servicess.length==0? Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),alignment: Alignment.topCenter ,child: Text("لا توجد خدمات مضافة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15),),) :ListView.builder(itemCount: servicess.length,itemBuilder: (context,i){
              return Container(decoration: BoxDecoration(border: Border.all(color: Colors.black12.withOpacity(0.1))),height: MediaQuery.of(context).size.height*0.21,width: MediaQuery.of(context).size.width,
                  child:servicetype == "اماكن" ? Column(
                    children:[
                      Container(child: Row(children: [
                        Expanded(flex: 2,child: Container(alignment: Alignment.centerRight ,child: Column(children: [
                          Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("اسم الخدمة : "),Text(servicess[i]["Name"] ==null ?"": servicess[i]["Name"].toString(),style: TextStyle(color: Colors.black54),)]),))
                          ,Directionality(textDirection: TextDirection.rtl,child: Container(alignment: Alignment.centerRight,child: FittedBox(child: Row(children: [Text("تفاصيل المنتج : "),FittedBox(child: Text(servicess[i]["Description"] ==null ?servicess[i]["Desc"]:servicess[i]["Description"]  ,style: TextStyle(color: Colors.black54)))])),))
                          ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("السعر : "),Text(servicess[i]["Price"] ==null ?servicess[i]["WeeklyRental"] == null ?"":servicess[i]["WeeklyRental"].toString() : servicess[i]["Price"].toString(),style: TextStyle(color: Colors.black54))]),))
                        ],),))
                        ,Expanded(child: Container(height: MediaQuery.of(context).size.width*0.2 ,width: MediaQuery.of(context).size.width*0.1,child: Image(fit: BoxFit.fill,image: NetworkImage(servicess[i]["Photos"][0])),))
                      ],),),
                      Container(
                        child:Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,color: Colors.black12.withOpacity(0.05),child: Row(children: [
                          Container(margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child:InkWell(onTap: ()=>deleteservice(i),child: Icon(Icons.delete,color: Colors.red,))),
                          InkWell(onTap: ()=>editservice(i),child: Container(child:SvgPicture.asset("svg/Icon feather-edit.svg" ,fit: BoxFit.fill,)))
                          ,InkWell( onTap: (){

                          },child:false ? Container(): Container(width: MediaQuery.of(context).size.width*0.15 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.4),decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:true ? Colors.black12.withOpacity(0.15):Colors.red ),child:Center(child: Text("غير متاح",style: TextStyle(color:true ? Colors.black38:Colors.white),)),)),
                          InkWell(onTap: (){

                          },child:false ? Container(): Container(width: MediaQuery.of(context).size.width*0.15 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:true? Color.fromRGBO(11, 168, 11, 1):Colors.black26.withOpacity(0.1) ),child: Center(child: Text("متاح",style: TextStyle(color:true ? Colors.white:Colors.black38),)),)),
                        ],),),
                      )
                    ],) :servicetype=="مراسيل"?Column(
                    children:[
                      Container(child: Row(children: [
                        Expanded(flex: 2,child: Container(alignment: Alignment.centerRight ,child: Column(children: [
                          Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("اسم الخدمة : "),Text(servicess[i]["Name"] ==null ?"": servicess[i]["Name"].toString(),style: TextStyle(color: Colors.black54),)]),))
                          ,Directionality(textDirection: TextDirection.rtl,child: Container(alignment: Alignment.centerRight,child: FittedBox(child: Row(children: [Text("تفاصيل المنتج : "),FittedBox(child: Text(servicess[i]["Description"] ==null ?servicess[i]["Desc"]:servicess[i]["Description"]  ,style: TextStyle(color: Colors.black54)))])),))
                          ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("السعر : "),Text(servicess[i]["Price"] ==null ?servicess[i]["WeeklyRental"] == null ?"":servicess[i]["WeeklyRental"].toString() : servicess[i]["Price"].toString(),style: TextStyle(color: Colors.black54))]),))
                        ],),))
                        ,Expanded(child: Container(height: MediaQuery.of(context).size.width*0.2 ,width: MediaQuery.of(context).size.width*0.1,child: Image(fit: BoxFit.fill,image: NetworkImage(servicess[i]["Photo"])),))
                      ],),),
                      Container(
                        child:Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,color: Colors.black12.withOpacity(0.05),child: Row(children: [
                          Container(margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child:InkWell(onTap: ()=>deleteservice(i),child: Icon(Icons.delete,color: Colors.red,))),
                          InkWell(onTap: ()=>editservice(i),child: Container(child:SvgPicture.asset("svg/Icon feather-edit.svg" ,fit: BoxFit.fill,)))
                          ,InkWell( onTap: (){

                          },child:false ? Container(): Container(width: MediaQuery.of(context).size.width*0.15 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.4),decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:true ? Colors.black12.withOpacity(0.15):Colors.red ),child:Center(child: Text("غير متاح",style: TextStyle(color:true ? Colors.black38:Colors.white),)),)),
                          InkWell(onTap: (){

                          },child:false ? Container(): Container(width: MediaQuery.of(context).size.width*0.15 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:true? Color.fromRGBO(11, 168, 11, 1):Colors.black26.withOpacity(0.1) ),child: Center(child: Text("متاح",style: TextStyle(color:true ? Colors.white:Colors.black38),)),)),
                        ],),),
                      )
                    ],):servicetype == "مزاد"? Column(
                    children:[
                      Container(child: Row(children: [
                        Expanded(flex: 2,child: Container(alignment: Alignment.centerRight ,child: Column(children: [
                          Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("اسم الخدمة : "),Text("__",style: TextStyle(color: Colors.black54),)]),))
                          ,Directionality(textDirection: TextDirection.rtl,child: Container(alignment: Alignment.centerRight,child: FittedBox(child: Row(children: [Text("تفاصيل المنتج : "),FittedBox(child: Text(servicess[i]["Description"] ,style: TextStyle(color: Colors.black54)))])),))
                          ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("السعر : "),Text("__",style: TextStyle(color: Colors.black54))]),))
                        ],),))
                        ,Expanded(child: Container(height: MediaQuery.of(context).size.width*0.2 ,width: MediaQuery.of(context).size.width*0.1,child: Image(fit: BoxFit.fill,image: NetworkImage(servicess[i]["Photo"])),))
                      ],),),
                      Container(
                        child:Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,color: Colors.black12.withOpacity(0.05),child: Row(children: [
                          Container(margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child:InkWell(onTap: ()=>deleteservice(i),child: Icon(Icons.delete,color: Colors.red,))),
                          InkWell(onTap: ()=>editservice(i),child: Container(child:SvgPicture.asset("svg/Icon feather-edit.svg" ,fit: BoxFit.fill,)))
                          ,InkWell( onTap: (){

                          },child:false ? Container(): Container(width: MediaQuery.of(context).size.width*0.15 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.4),decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:true ? Colors.black12.withOpacity(0.15):Colors.red ),child:Center(child: Text("غير متاح",style: TextStyle(color:true ? Colors.black38:Colors.white),)),)),
                          InkWell(onTap: (){

                          },child:false ? Container(): Container(width: MediaQuery.of(context).size.width*0.15 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:true? Color.fromRGBO(11, 168, 11, 1):Colors.black26.withOpacity(0.1) ),child: Center(child: Text("متاح",style: TextStyle(color:true ? Colors.white:Colors.black38),)),)),
                        ],),),
                      )
                    ],) : servicetype != "اماكن"&& servicetype != "مراسيل"&&servicetype != "مزاد" ?Column(
                    children:[
                      Container(child: Row(children: [
                        Expanded(flex: 2,child: Container(alignment: Alignment.centerRight ,child: Column(children: [
                          Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("اسم الخدمة : "),Text(servicess[i]["Name"] ,style: TextStyle(color: Colors.black54),)]),))
                          ,Directionality(textDirection: TextDirection.rtl,child: Container(alignment: Alignment.centerRight,child: FittedBox(child: Row(children: [Text("تفاصيل المنتج : "),FittedBox(child: Text(servicess[i]["Description"] ,style: TextStyle(color: Colors.black54)))])),))
                          ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("السعر : "),Text(servicess[i]["Price"].toString(),style: TextStyle(color: Colors.black54))]),))
                        ],),))
                        ,Expanded(child: Container(height: MediaQuery.of(context).size.width*0.2 ,width: MediaQuery.of(context).size.width*0.1,child: Image(fit: BoxFit.fill,image: NetworkImage(servicess[i]["Photo"])),))
                      ],),),
                      Container(
                        child:Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,color: Colors.black12.withOpacity(0.05),child: Row(children: [
                          Container(margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child:InkWell(onTap: ()=>deleteservice(i),child: Icon(Icons.delete,color: Colors.red,))),
                          InkWell(onTap: ()=>editservice(i),child: Container(child:SvgPicture.asset("svg/Icon feather-edit.svg" ,fit: BoxFit.fill,)))
                          ,InkWell( onTap: (){

                          },child:false ? Container(): Container(width: MediaQuery.of(context).size.width*0.15 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.4),decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:true ? Colors.black12.withOpacity(0.15):Colors.red ),child:Center(child: Text("غير متاح",style: TextStyle(color:true ? Colors.black38:Colors.white),)),)),
                          InkWell(onTap: (){

                          },child:false ? Container(): Container(width: MediaQuery.of(context).size.width*0.15 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:true? Color.fromRGBO(11, 168, 11, 1):Colors.black26.withOpacity(0.1) ),child: Center(child: Text("متاح",style: TextStyle(color:true ? Colors.white:Colors.black38),)),)),
                        ],),),
                      )
                    ],)  :Container() );
            }),)
          ],
        ))
      ],),
    ),);
  }
  List newrequestlist =[];
  List onworklist =[];
  List donelist =[];
  List canceldlist =[];
  orderdetail(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Orderdata();
    }));
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
          child: Row(children: [Expanded(child: InkWell(onTap: ()=>orderdetail(),child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),))),
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
  Widget req(){
    return Container(child: Directionality(textDirection: TextDirection.ltr,child: ListView(children: [
      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :Stack(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
          decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
            Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الطلب",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.03),))),
          ],),),
        Positioned( bottom: MediaQuery.of(context).size.height*0.04,left: MediaQuery.of(context).size.width*0.4 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
      ],) ),
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,color: Colors.white ,child: Row(children: [
        Expanded(child: Container(child: Column(children:[ Container(child: tabController2.index ==3?Text("("+canceldlist.length.toString()+")"+"ملغي ") :Text("ملغي",style: TextStyle(),))
          ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.08,right: MediaQuery.of(context).size.width*0.06),child:tabController2.index ==3? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
        Expanded(child: Container(child: Column(children:[ Container(child: tabController2.index ==2?Text("("+donelist.length.toString()+")"+"تم التنفيذ") :Text("تم التنفيذ",style: TextStyle(),))
          ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.06),child:tabController2.index ==2? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
        Expanded(child: Container(child: Column(children:[ Container(child: tabController2.index ==1?Text("("+onworklist.length.toString()+")"+"جاري العمل ") :Text("جاري العمل",style: TextStyle(),))
          ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.03),child:tabController2.index ==1? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
        Expanded(child: Container(child: Column(children:[ Container(child: tabController2.index ==0?Text("("+newrequestlist.length.toString()+")"+"طلب جديد ") :Text("طلب جديد",style: TextStyle(),))
          ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.03),child:tabController2.index ==0? Divider(color: Colors.blue,thickness: 3,):Container(),)])))],),)
      ,Directionality(textDirection: TextDirection.rtl,
        child: Container(height: MediaQuery.of(context).size.height*0.7 ,child: TabBarView(controller: tabController2,children:[
          newRequest(),
          onwork(),
          done(),
          canceld()
        ]),),
      )
      ,
    ],),),);
  }
  Widget coupon(){
    return Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,child: Directionality(
      textDirection: TextDirection.ltr,
      child: ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :Stack(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
              Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text(" كوبونات خصم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
            ],),),
          Positioned( bottom: MediaQuery.of(context).size.height*0.04,left: MediaQuery.of(context).size.width*0.4 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
        ],) ),
        Container(child
            :Column(
        children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child: Row(children: [Expanded(child: InkWell(onTap: ()async{

          Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return Addcoupons(services: servicess,servicetype: servicetype,);
            }));
        },child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,height: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),borderRadius: BorderRadius.circular(5)) ,child: Center(child: Text("اضافة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.white)),),))),Expanded(child: Column(children: [
    Container(child: Text("كوبونات",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),),
    Container(child: Directionality(textDirection: TextDirection.rtl,child: Text(" عدد"+cupons.length.toString()+"من الكوبونات " ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),)),)
    ],))],),),
    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04) ,height: MediaQuery.of(context).size.height*0.65 ,child:
    cupons.length==0? Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),alignment: Alignment.topCenter ,child: Text("لا توجد كوبونات مضافة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15),),) :ListView.builder(itemCount: cupons.length,itemBuilder: (context,i){
    return Container(decoration: BoxDecoration(border: Border.all(color: Colors.black12.withOpacity(0.1))),height: MediaQuery.of(context).size.height*0.21,width: MediaQuery.of(context).size.width,
    child:Column(
    children:[
    Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.035,top: MediaQuery.of(context).size.height*0.02) ,child:  Container(alignment: Alignment.centerRight ,child: Column(children: [
    Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("رقم الكوبون : "),Text( cupons[i]["CouponID"].toString(),style: TextStyle(color: Colors.black54),)]),))
    ,Directionality(textDirection: TextDirection.rtl,child: Container(alignment: Alignment.centerRight,child: FittedBox(child: Row(children: [Text("كود الكوبون : "),Text(cupons[i]["CouponCode"].toString() ,style: TextStyle(color: Colors.black54))])),))
    ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("قيمة الكوبون : "),Text(cupons[i]["CouponValue"].toString() ,style: TextStyle(color: Colors.black54))]),))
    ],),)),
   // ,Expanded(child: Container(height: MediaQuery.of(context).size.width*0.2 ,width: MediaQuery.of(context).size.width*0.1,child: Text("")))),),
    Container(
    child:Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,color: Colors.black12.withOpacity(0.05),child: Row(children: [
    Container(margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child:InkWell(onTap: ()=>deletecupon(i),child: Icon(Icons.delete,color: Colors.red,))),
    InkWell(onTap: ()=>editcupon(i),child: Container(child:SvgPicture.asset("svg/Icon feather-edit.svg" ,fit: BoxFit.fill,)))
    ,InkWell( onTap: (){
    },child:false ? Container(): Container(width: MediaQuery.of(context).size.width*0.15 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.4),decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:true ? Colors.black12.withOpacity(0.15):Colors.red ),child:Center(child: Text("غير متاح",style: TextStyle(color:true ? Colors.black38:Colors.white),)),)),
    InkWell(onTap: (){
    },child:false ? Container(): Container(width: MediaQuery.of(context).size.width*0.15 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:true? Color.fromRGBO(11, 168, 11, 1):Colors.black26.withOpacity(0.1) ),child: Center(child: Text("متاح",style: TextStyle(color:true ? Colors.white:Colors.black38),)),)),
    ],),),
    )
    ],) );
    }),)
    ],
    ))
      ],),
    ),);
  }
  List servicesa = [1,2,3];
  List checks = [false , false , false];
  showdialog(){
    return showDialog( context: context, builder: (context) {
      return StatefulBuilder(builder: (Context , setState){
        return AlertDialog(
            content:Container(height: MediaQuery.of(context).size.height*0.45,
              child: Column(children: [
                Container(alignment: Alignment.centerRight,child: Text("المنتجات التي يطبق عليها الكوبون",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),)
                ,Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.22 ,child: ListView.builder(itemCount: servicesa.length,itemBuilder: (context,i){
                  return CheckboxListTile(activeColor: Colors.green,title: Directionality(textDirection: TextDirection.rtl,child: Text("خدمة-"+servicesa[i].toString())),value: checks[i], onChanged: (val){ setState((){checks[i] = val;});});;
                }),),
                Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.green),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
                  child: Text("اضافة ", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.025)) ,)
              ],),
            )
        );},
      );
    });
  }
  Widget more(){
    return Directionality(textDirection: TextDirection.rtl,
      child: Container(child: ListView(children: [
        Directionality(textDirection: TextDirection.ltr,
          child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,bottom: MediaQuery.of(context).size.height*0.025) ,alignment: Alignment.center ,child: Row(children: [
            Expanded(flex: 3,
              child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Column(children: [
                Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07) ,alignment: Alignment.centerRight ,child: AutoSizeText(profiledata.toString()=="null"?"" :profiledata["Name"].toString(),maxLines: 1,style: TextStyle(color: Color.fromRGBO(11, 12, 58, 1),fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*17),),),
                Container(alignment: Alignment.centerRight,child: AutoSizeText(profiledata.toString()=="null"?"" :profiledata["Email"].toString(),maxLines: 1,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),),)
              ],)),
            )
            ,Expanded(child:  Container( width: MediaQuery.of(context).size.width*0.2,height: MediaQuery.of(context).size.width*0.15,child: ClipRRect(borderRadius: BorderRadius.circular(10),child:profiledata==null?Container(): Image( fit: BoxFit.fill,image: NetworkImage(profiledata["ProfilePhoto"]),)),)),
          ],),),
        )
        ,InkWell(onTap: ()=>navigatetoprofile() ,child: Container(height: MediaQuery.of(context).size.height*0.07,margin: EdgeInsets.zero,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("الملف الشخصي"),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11,child: SvgPicture.asset("svg/editprofile.svg",fit: BoxFit.fill,), )),)
        ),InkWell(onTap: ()=>navigatetopassword(),child: Container(height: MediaQuery.of(context).size.height*0.07,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("تغيير كلمة المرور"),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more3.png")),), ),))
        ,InkWell(onTap: ()=>navigatetopchat(),child: Container(height: MediaQuery.of(context).size.height*0.07,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("محادثة"),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: SvgPicture.asset( "svg/chat.svg",fit: BoxFit.fill,)),),),
        ),InkWell(onTap: ()=>navigatetoppartner(),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined) ,title:Text("شركاء النجاح",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more4.png")),),))),
        InkWell(onTap: ()=>navigatetoshareapp(),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("شارك التطبيق",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: SvgPicture.asset( "images/chare.svg",fit: BoxFit.fill,)),),),
        ),InkWell(onTap: ()=>navigatetopcomplaints(),child: Container(height: MediaQuery.of(context).size.height*0.07,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("الاقتراحات والشكاوى"),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more6.png")),),),)),
        InkWell(onTap: ()=>navigatetopaboutapp(),child: Container(height: MediaQuery.of(context).size.height*0.07,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined) ,title:Text("عن التطبيق"),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more7.png")),),),),
        ),InkWell(onTap: ()=>signout(),child: Container(height: MediaQuery.of(context).size.height*0.07,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("تسجيل الخروج"),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,decoration: BoxDecoration(gradient:LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent]) ),child: Icon(Icons.logout,color: Colors.white,)),),)
        )],)),
    );
  }
  File photo;
  chooseimage()async{
    var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image1 !=null){
      photo =File( image1.path);
      setState(() {});
    }
  }
  Widget commision(){
    return Container(child: ListView(children: [
      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :Stack(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.11,
          decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child: Row(children: [
            Expanded(child: Container(alignment: Alignment.center,child: Text("عمولة التطبيق",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
          ],),),
        Positioned( bottom: MediaQuery.of(context).size.height*0.04,left: MediaQuery.of(context).size.width*0.4 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
      ],) ),
       Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.05) ,child: Directionality(textDirection: TextDirection.rtl,child:  Text("حسابات البنكية الخاصة للتطبيق :",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*15),)),)
      , Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01) ,child: Directionality(textDirection: TextDirection.rtl,child:  Text(home2_data["BankAccounts"]==null?" ":home2_data["BankAccounts"],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*15),)),)
      ,Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.02) ,child: Directionality(textDirection: TextDirection.rtl,child:  Text("ارفاق وصل التحويل :",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*15),)),)
      ,Directionality(textDirection: TextDirection.rtl,
        child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.02 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
          style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015), controller: transportcollection,validator: home2logic.validate,keyboardType: TextInputType.number,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "قيمة التحويل"),
        )),
      ),
      Directionality(textDirection: TextDirection.ltr,
        child: Container(
          child:Container(padding: EdgeInsets.only(right: 10),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02
              ,right:MediaQuery.of(context).size.width * 0.05,left: MediaQuery.of(context).size.width * 0.05 ),
            decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05))
            ,child: Center(
              child: InkWell( onTap: (){
                setState(() {
                  if(!dateable) {
                    dateable = true;
                  }
                  else{
                    dateable = false;
                  }
                });
              },child: ListTile(leading:dateable?InkWell(child: FittedBox(child: Text("تم",style: TextStyle(color: Color.fromRGBO(69, 190, 0, 1)),)),onTap: (){
                setState(() {
                  dateable = false;
                });
              },) :Icon(Icons.arrow_drop_down),title: Container(alignment: Alignment.centerRight,child:transportingdate !=null?Text(transportingdate.toString()): Text("الموعد المطلوب للصيانة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015))),trailing: Icon(Icons.date_range,color: Color.fromRGBO(69, 190, 0, 1),),),),
            ),),
        ),
      ),
      Container( child:!dateable?Container():  Container(width: MediaQuery.of(context).size.width,child: CalendarDatePicker(firstDate: DateTime.now().subtract(Duration(days: 365)) ,lastDate:DateTime.now().add(Duration(days: 356))  ,currentDate: DateTime.now(),initialDate:DateTime.now(), onDateChanged: (val){
        setState(() {
          transportingdate = val.toString().substring(0,10);
        });
      },),)),
      Container(width: MediaQuery.of(context).size.width*0.9,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ),
        decoration: BoxDecoration(color: Colors.white),child: Column(children: [
          InkWell(onTap: () =>chooseimage()
              ,child: Container(child: Center(child:photo == null? Image(image: AssetImage("images/emptyphoto.png"),):Image(image: FileImage(photo)) ,),)),
          Container(child: Center(child: Text("صورة وصل التحويل",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02)),),)
        ],),),
      Directionality(textDirection: TextDirection.rtl,
        child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.03,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
           controller: transportingnote,textInputAction: TextInputAction.send,keyboardType: TextInputType.number,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "رقم التحويل"),
        )),
      ),
      InkWell(onTap: ()=>home2logic.sendinfocommesion( photo, transportcollection.text, transportingdate, transportingnote.text),
        child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
          child:Text("ارسال المعلومات", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*15)) ,),
      )

    ],),);


  }
  navigatetolocation(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Location();
    }));
  }
  navigatetoshareapp(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shareapp();
    }));
  }
  signout()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    await Provider.of<Notifires>(context,listen: false).resetdata();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return Loginpage();
    }));
  }
  navigatetoterms(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Terms();
    }));
  }
  navigatetoprofile(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Profile2(dataprofile: profiledata,);
    }));
  }
  navigatetopassword(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Changepass();
    }));
  }
  navigatetopchat(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Providerchat();
    }));
  }
  navigatetoppartner(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Partner(sharelink: profiledata["ShareLink"],);
    }));
  }
  navigatetopcomplaints(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Recommend();
    }));
  }
  navigatetopaboutapp(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Aboutapp();
    }));
  }
}