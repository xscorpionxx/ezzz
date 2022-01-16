import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/showpage.dart';
import 'package:ezzproject/screens/Loginpage.dart';
import 'package:ezzproject/screens/aboutapp.dart';
import 'package:ezzproject/screens/changepassword.dart';
import 'package:ezzproject/screens/chat.dart';
import 'package:ezzproject/screens/cookersdetail.dart';
import 'package:ezzproject/screens/detailpage.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/marasil_detail.dart';
import 'package:ezzproject/screens/partner.dart';
import 'package:ezzproject/screens/profile.dart';
import 'package:ezzproject/screens/recommend.dart';
import 'package:ezzproject/screens/shoppingcart.dart';
import 'package:ezzproject/screens/terms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification.dart';

class Showketchins extends StatefulWidget{
  var id;
  var name;
  var tabController;
  List subcategories;
  var cat;
  Showketchins({this.id ,this.name ,this.subcategories,this.cat,this.tabController});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateshowpage(id : id , name:name,subcategories: subcategories,cat:cat ,tabController: tabController);
  }
}
class Stateshowpage extends State<Showketchins> with SingleTickerProviderStateMixin{
  List titles = ["بائعين جملة","بائعين الذبائح" ,"اسر منتجة","الطهاة والمطابخ" ,"ملاحم الجزيرة","أماكن","مأكولات بحرية","مزارع بيع الطيور","مراسيل","مزاد"];
  List data =[{"title" : "بائعين جملة" , "desc": "جميع أنواع بهيمة الانواع" , "review" : "0.4"},
    {"title" : "بائعين جملة" , "desc": "جميع أنواع بهيمة الانواع" , "review" : "0.4"},
    {"title" : "بائعين جملة" , "desc": "جميع أنواع بهيمة الانواع" , "review" : "0.4"},
    {"title" : "بائعين جملة" , "desc": "جميع أنواع بهيمة الانواع" , "review" : "0.4"},
  ];
  List images = ["images/home1.jpg","images/home2.jpg","images/home3.jpg",
    "images/home4.jpg","images/home5.jpg","images/home6.jpg",
    "images/home7.jpg","images/home8.jpg","images/home9.jpg","images/home10.jpg"];
  var index =1;
  var index2;
  TextEditingController query ;
  var id;
  var name;
  var tabController;
  List ketchins =[];
  List cookers =[];
  List searchresult =[];
  List subcategories = [];
  var cat;
  Stateshowpage({this.id ,this.name ,this.subcategories ,this.cat,this.tabController});
  var section ;
  Showpagelogic showpagelogic;
  @override
  void initState() {
    showpagelogic = new Showpagelogic(context);
    print(subcategories);
    print(name);
    print(cat);
    query = new TextEditingController();
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    cookers = Provider.of<Notifires>(context).cookers;
    ketchins = Provider.of<Notifires>(context).ketchins;
    searchresult = Provider.of<Notifires>(context).searchresult2;
    section = Provider.of<Notifires>(context).sectionketchins;
    // TODO: implement build
    return Scaffold(body:  Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: ListView(children: [
        Directionality(textDirection: TextDirection.ltr,
          child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.182 ,child:
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.17,
            decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
            Container(child: Stack(
              children: [
                Positioned( bottom: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.2) , borderRadius: BorderRadius.circular(1000)),),)
                ,Container(
                  child:Column(children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    child: Row(children: [
                      Expanded(flex: 2,child: InkWell(onTap: ()=>navigateback(),child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child: Icon(Icons.arrow_back_ios,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,)))),
                      Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: AutoSizeText("الطهاة والطابخ",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*12),))),
                      Expanded(flex: 2,child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("svg/Icon-alarm.svg",semanticsLabel: "wadca",))),
                      Expanded(flex: 2,child:InkWell(onTap: ()=>navigatetoshopping(),child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("svg/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) )
                    ],),
                  ), Container(padding: EdgeInsets.only(right:  MediaQuery.of(context).size.width*0.01 ,left: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.028,left: MediaQuery.of(context).size.width*0.07,right:MediaQuery.of(context).size.width*0.07 ),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5))
                    ,child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: query,onChanged: (val){
                      if(section=="1"){
                        Provider.of<Notifires>(context ,listen: false).search2(cookers, val);
                      }
                      else{
                        Provider.of<Notifires>(context ,listen: false).search2(ketchins, val);
                      }
                    }, style:  TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black26),decoration: InputDecoration(hintText: "بحث",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26),border: InputBorder.none,suffixIcon: Icon(Icons.search,color: Colors.black26,)),)),)]),
                )],
            )),
          ),
          ),
        ),
        Container(
          child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01,top: MediaQuery.of(context).size.height*0.02)
            ,child: Row(children: [
              Expanded(child: section == "1"?Container(alignment: Alignment.center,child: Column(children:[
                Text("طهاة",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.width*0.035),),
                Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1 ) ,height: MediaQuery.of(context).size.height*0.005,color: Colors.blue,)]),): Container(
                  child: InkWell(onTap: (){
                    Provider.of<Notifires>(context,listen: false).ketchinssections("1");
                  },child: Container(alignment: Alignment.center ,child: Text("طهاة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),))),
              )
              , Expanded(child: section == "2"?Container(alignment: Alignment.center,child: Column(children:[
                Text("مطاعم",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.width*0.035),),
                Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1 ) ,height: MediaQuery.of(context).size.height*0.005,color: Colors.blue,)]),): Container(
                  child: InkWell(onTap: (){
                    Provider.of<Notifires>(context,listen: false).ketchinssections("2");
                  },child: Container(alignment: Alignment.center ,child: Text("مطاعم",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),))),
              )
            ],) ,),
        ),section =="2"?ketchinspage()
            :cookerspage(),Container(
          height: MediaQuery.of(context).size.height*0.046,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.white),child:
          Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:false?  Container(
              decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent])) ,
              child: FittedBox(
                child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: SvgPicture.asset("svg/Vector.svg",fit: BoxFit.scaleDown,)),
                  Container( height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("المزيد",style: TextStyle(color:Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
              ),
            ):Container(
              child: InkWell(onTap: ()async{
                await Provider.of<Notifires>(context,listen: false).getindex(tabController, "more", 3, context);
                await  Provider.of<Notifires>(context,listen: false).getprofile(context,false);
                Navigator.of(context).pop();
              },
                child: FittedBox(
                  child: Column(children:[
                    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: SvgPicture.asset("svg/Vector.svg",fit: BoxFit.scaleDown,)),
                    Container( height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("المزيد",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                ),
              ),
            ))),Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:false?  Container(
              decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent])) ,
              child: Container(
                child:FittedBox(child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image :AssetImage("images/bar31.png"),fit: BoxFit.scaleDown,)),
                  Container(height: MediaQuery.of(context).size.height*0.02,child : FittedBox(child: Text("طلباتي",style: TextStyle(color:Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*10),)))])),
              ),
            ) :Container(
              child: InkWell(onTap: ()async{
                await Provider.of<Notifires>(context,listen: false).getindex(tabController, "req", 2, context);
                await   Provider.of<Notifires>(context,listen: false).getmyorders( context);
                Navigator.of(context).pop();
              },
                child: Container(
                  child: FittedBox(
                    child: Column(children:[
                      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image :AssetImage("images/bar2.png"),fit: BoxFit.scaleDown,)),
                      Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("طلباتي",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                  ),
                ),
              ),
            )))
            ,Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:false?  Container(
              decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent])) ,
              child:FittedBox(child: Column(children:[
                Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image : AssetImage( "images/bar21.png"),fit: BoxFit.scaleDown)),
                Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("مفضلة",style: TextStyle(color:Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*10),)))])),
            ) :Container(
              child: InkWell(onTap: ()async{
                await Provider.of<Notifires>(context,listen: false).getindex(tabController, "favo", 1, context);
                await Provider.of<Notifires>(context,listen: false).getfav(context);
                Navigator.of(context).pop();
              }, child: FittedBox(
                child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image : AssetImage( "images/bar3.png"),fit: BoxFit.scaleDown)),
                  Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("مفضلة",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
              ),
              ),
            ))),
            Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:false?  Container(
              decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent])) ,
              child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                child:FittedBox(child: Column(children:[
                  Container(height: MediaQuery.of(context).size.height*0.025,child: SvgPicture.asset("images/home2azz.svg",fit: BoxFit.scaleDown,semanticsLabel: "dacasceqd",))
                  ,Container(height: MediaQuery.of(context).size.height*0.02 ,child: FittedBox(child: Text("الرئيسية",style: TextStyle(color:Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*10),)))])),
              ),
            ) :Container(
              child: InkWell(onTap: ()async{
                Navigator.of(context).pop();
                await Provider.of<Notifires>(context,listen: false).getindex(tabController, "home", 0, context);
              },child:Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                child: FittedBox(
                  child: Column(children:[
                    Container(height: MediaQuery.of(context).size.height*0.025,child: SvgPicture.asset("images/home1azz.svg",fit: BoxFit.scaleDown,semanticsLabel: "dacadadwsceqd",)),
                    Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("الرئيسية",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                ),
              ),
              ),
            ))),
          ],),),
      ]),
    ),);
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  navigatetoshopping(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  Widget ketchinspage(){
    return Directionality(textDirection: TextDirection.ltr,
      child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.685,child: ListView(children: [
        Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.0  ,top: MediaQuery.of(context).size.height*0.03 ,left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.66,width: MediaQuery.of(context).size.width,child:ketchins.length==0?Container(
          child: Center(child: Text("",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),
        ) : query.text==""? GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width*1.5/MediaQuery.of(context).size.height),),itemCount: ketchins.length,itemBuilder: (context,i){
          return InkWell(onTap: ()=>showdetail(i,false),
            child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black12) ,borderRadius: BorderRadius.circular(10),color: Colors.white//,boxShadow: [BoxShadow(
              //   color: Colors.black26,
              //  blurRadius: 1.0,
              //  spreadRadius: 0.0,
              //  offset: Offset(2.0, 2.0), // shadow direction: bottom right
              // )]
            ),child:Column(children: [
              Container(
                child:ketchins[i]["Status"].toString()=="1" ? Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(ketchins[i]["Photo"]),),),
                  Positioned(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.01,left:MediaQuery.of(context).size.width*0.01 ),
                    child: Row(children: [
                      Expanded(child: Container(child: ketchins[i]["UserFav"].toString()=="1"?
                      InkWell(onTap: ()=>showpagelogic.addtofav(ketchins[i]["ID"],id,subcategories,context),
                        child: Container(width: MediaQuery.of(context).size.width*0.09,
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,),),
                      ):InkWell(onTap: ()=>showpagelogic.addtofav(ketchins[i]["ID"],id,subcategories,context),
                        child: Container(width: MediaQuery.of(context).size.width*0.09,
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.white),child: Icon(Icons.favorite_border,color: Colors.black26,size: MediaQuery.of(context).size.width*0.07,),),
                      ),)),Expanded(flex: 2,child: Container()),
                      Expanded(flex: 2,child: Container(child:ketchins[i]["BestSeller"].toString()=="1"?
                      InkWell(onTap: ()=>null,
                        child: Container(width: MediaQuery.of(context).size.width*0.09,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(254, 254, 115, 1)),child:
                          FittedBox(child: Row(children:[ Text("بائع مميز",style: TextStyle(color: Colors.indigo),),Container(width: MediaQuery.of(context).size.width*0.05,height: MediaQuery.of(context).size.width*0.05,child: Image( image:AssetImage("images/like.jpg"),fit: BoxFit.fill)),])),),
                      ):Container()))
                    ],),
                  ))])):Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(ketchins[i]["Photo"]),),),
                  Positioned(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10) ,topLeft: Radius.circular(10)),color: Colors.black12,) ,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.16),child: Container(color: Colors.red ,child: Center(child: FittedBox(child: Text("غير متاح",style: TextStyle(color: Colors.white),)),)),) ) ])),
              ) ,
              Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.025 ),child:Row(children:[
                Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: FittedBox(child: AutoSizeText(ketchins[i]["Rating"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)),))
                ,Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon(Icons.star,color: Colors.yellow.withGreen(2000),)),),
                Expanded(flex: 6,child: Container(alignment: Alignment.centerRight ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: AutoSizeText(ketchins[i]["Name"],maxLines: 1,style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*15),)),)
              ]) ),
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(ketchins[i]["Description"].toString(),maxLines: 2,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),)),),
            ],)
              ,),
          );
        }): GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width*1.5/MediaQuery.of(context).size.height),),itemCount: searchresult.length,itemBuilder: (context,i){
          return InkWell(onTap: ()=>showdetail(i,true),
            child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black12) ,borderRadius: BorderRadius.circular(10),color: Colors.white//,boxShadow: [BoxShadow(
              //   color: Colors.black26,
              //  blurRadius: 1.0,
              //  spreadRadius: 0.0,
              //  offset: Offset(2.0, 2.0), // shadow direction: bottom right
              // )]
            ),child:Column(children: [
              Container(
                child:searchresult[i]["Status"].toString()=="1" ? Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(searchresult[i]["Photo"]),),),
                  Positioned(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.01,left:MediaQuery.of(context).size.width*0.01 ),
                    child: Row(children: [
                      Expanded(child: Container(child: searchresult[i]["UserFav"].toString()=="1"?
                      InkWell(onTap: ()=>showpagelogic.addtofav(searchresult[i]["ID"],id,subcategories,context),
                        child: Container(width: MediaQuery.of(context).size.width*0.09,
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,),),
                      ):InkWell(onTap: ()=>showpagelogic.addtofav(searchresult[i]["ID"],id,subcategories,context),
                        child: Container(width: MediaQuery.of(context).size.width*0.09,
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.white),child: Icon(Icons.favorite_border,color: Colors.black26,size: MediaQuery.of(context).size.width*0.07,),),
                      ),)),Expanded(flex: 2,child: Container()),
                      Expanded(flex: 2,child: Container(child:searchresult[i]["BestSeller"].toString()=="1"?
                      InkWell(onTap: ()=>null,
                        child: Container(width: MediaQuery.of(context).size.width*0.09,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(254, 254, 115, 1)),child:
                          FittedBox(child: Row(children:[ Text("بائع مميز",style: TextStyle(color: Colors.indigo),),Container(width: MediaQuery.of(context).size.width*0.05,height: MediaQuery.of(context).size.width*0.05,child: Image( image:AssetImage("images/like.jpg"),fit: BoxFit.fill)),])),),
                      ):Container()))
                    ],),
                  ))])):Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(searchresult[i]["Photo"]),),),
                  Positioned(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10) ,topLeft: Radius.circular(10)),color: Colors.black12,) ,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.16),child: Container(color: Colors.red ,child: Center(child: FittedBox(child: Text("غير متاح",style: TextStyle(color: Colors.white),)),)),) ) ])),
              ) ,
              Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.025 ),child:Row(children:[
                Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: FittedBox(child: AutoSizeText(searchresult[i]["Rating"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)),))
                ,Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon(Icons.star,color: Colors.yellow.withGreen(2000),)),),
                Expanded(flex: 6,child: Container(alignment: Alignment.centerRight ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: AutoSizeText(searchresult[i]["Name"],maxLines: 1,style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*15),)),)
              ]) ),
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(searchresult[i]["Description"].toString(),maxLines: 2,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),)),),
            ],)
              ,),
          );
        }),)
      ],),),
    );
  }
  Widget cookerspage(){
    return Directionality(textDirection: TextDirection.ltr,
      child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.685,child: ListView(children: [
        Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.0  ,top: MediaQuery.of(context).size.height*0.03 ,left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.66,width: MediaQuery.of(context).size.width,child:cookers.length==0?Container(
          child: Center(child: Text("",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),
        ) : query.text==""? GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width*1.5/MediaQuery.of(context).size.height),),itemCount: cookers.length,itemBuilder: (context,i){
          return InkWell(onTap: ()=>showdetail(i,false),
            child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black12) ,borderRadius: BorderRadius.circular(10),color: Colors.white//,boxShadow: [BoxShadow(
              //   color: Colors.black26,
              //  blurRadius: 1.0,
              //  spreadRadius: 0.0,
              //  offset: Offset(2.0, 2.0), // shadow direction: bottom right
              // )]
            ),child:Column(children: [
              Container(
                child:cookers[i]["Status"].toString()=="1"? Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(cookers[i]["Photo"]),),),
                  Positioned(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.01,left:MediaQuery.of(context).size.width*0.01 ),
                    child: Row(children: [
                      Expanded(child: Container(child: cookers[i]["UserFav"].toString()=="1"?
                      InkWell(onTap: ()=>showpagelogic.addtofav(cookers[i]["ID"],id,subcategories,context),
                        child: Container(width: MediaQuery.of(context).size.width*0.09,
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,),),
                      ):InkWell(onTap: ()=>showpagelogic.addtofav(cookers[i]["ID"],id,subcategories,context),
                        child: Container(width: MediaQuery.of(context).size.width*0.09,
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.white),child: Icon(Icons.favorite_border,color: Colors.black26,size: MediaQuery.of(context).size.width*0.07,),),
                      ),)),Expanded(flex: 2,child: Container()),
                      Expanded(flex: 2,child: Container(child:cookers[i]["BestSeller"].toString()=="1"?
                      InkWell(onTap: ()=>null,
                        child: Container(width: MediaQuery.of(context).size.width*0.09,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(254, 254, 115, 1)),child:
                          FittedBox(child: Row(children:[ Text("بائع مميز",style: TextStyle(color: Colors.indigo),),Container(width: MediaQuery.of(context).size.width*0.05,height: MediaQuery.of(context).size.width*0.05,child: Image( image:AssetImage("images/like.jpg"),fit: BoxFit.fill)),])),),
                      ):Container()))
                    ],),
                  ))])) : Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(cookers[i]["Photo"]),),),
                  Positioned(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10) ,topLeft: Radius.circular(10)),color: Colors.black12,) ,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.16),child: Container(color: Colors.red ,child: Center(child: FittedBox(child: Text("غير متاح",style: TextStyle(color: Colors.white),)),)),) ) ])),
              ),
              Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.025 ),child:Row(children:[
                Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: FittedBox(child: AutoSizeText(cookers[i]["Rating"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)),))
                ,Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon(Icons.star,color: Colors.yellow.withGreen(2000),)),),
                Expanded(flex: 6,child: Container(alignment: Alignment.centerRight ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: AutoSizeText(cookers[i]["Name"],maxLines: 1,style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*15),)),)
              ]) ),
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(cookers[i]["Description"].toString(),maxLines: 2,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),)),),
            ],)
              ,),
          );
        }): GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width*1.5/MediaQuery.of(context).size.height),),itemCount: searchresult.length,itemBuilder: (context,i){
          return InkWell(onTap: ()=>showdetail(i,true),
            child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black12) ,borderRadius: BorderRadius.circular(10),color: Colors.white//,boxShadow: [BoxShadow(
              //   color: Colors.black26,
              //  blurRadius: 1.0,
              //  spreadRadius: 0.0,
              //  offset: Offset(2.0, 2.0), // shadow direction: bottom right
              // )]
            ),child:Column(children: [
              Container(
                child:searchresult[i]["Status"].toString()=="1"? Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(searchresult[i]["Photo"]),),),
                  Positioned(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.01,left:MediaQuery.of(context).size.width*0.01 ),
                    child: Row(children: [
                      Expanded(child: Container(child: searchresult[i]["UserFav"].toString()=="1"?
                      InkWell(onTap: ()=>showpagelogic.addtofav(searchresult[i]["ID"],id,subcategories,context),
                        child: Container(width: MediaQuery.of(context).size.width*0.09,
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,),),
                      ):InkWell(onTap: ()=>showpagelogic.addtofav(searchresult[i]["ID"],id,subcategories,context),
                        child: Container(width: MediaQuery.of(context).size.width*0.09,
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.white),child: Icon(Icons.favorite_border,color: Colors.black26,size: MediaQuery.of(context).size.width*0.07,),),
                      ),)),Expanded(flex: 2,child: Container()),
                      Expanded(flex: 2,child: Container(child:searchresult[i]["BestSeller"].toString()=="1"?
                      InkWell(onTap: ()=>null,
                        child: Container(width: MediaQuery.of(context).size.width*0.09,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(254, 254, 115, 1)),child:
                          FittedBox(child: Row(children:[ Text("بائع مميز",style: TextStyle(color: Colors.indigo),),Container(width: MediaQuery.of(context).size.width*0.05,height: MediaQuery.of(context).size.width*0.05,child: Image( image:AssetImage("images/like.jpg"),fit: BoxFit.fill)),])),),
                      ):Container()))
                    ],),
                  ))])) : Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(searchresult[i]["Photo"]),),),
                  Positioned(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10) ,topLeft: Radius.circular(10)),color: Colors.black12,) ,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.16),child: Container(color: Colors.red ,child: Center(child: FittedBox(child: Text("غير متاح",style: TextStyle(color: Colors.white),)),)),) ) ])),
              ),
              Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.025 ),child:Row(children:[
                Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: FittedBox(child: AutoSizeText(searchresult[i]["Rating"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)),))
                ,Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon(Icons.star,color: Colors.yellow.withGreen(2000),)),),
                Expanded(flex: 6,child: Container(alignment: Alignment.centerRight ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: AutoSizeText(searchresult[i]["Name"],maxLines: 1,style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*15),)),)
              ]) ),
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(searchresult[i]["Description"].toString(),maxLines: 2,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),)),),
            ],)
              ,),
          );
        }),)
      ],),),
    );
  }
  Widget auctions(){



  }

  navigateback(){
    Navigator.of(context).pop();
  }
  getdata() async{
    Future.delayed(const Duration(milliseconds: 500), () {
      Provider.of<Notifires>(context,listen: false).getdatashowkechins(subcategories,context);
    });
  }
  showdetail(i,search){
    var kitchen;
    //if(section =="1"){
    //  kitchen =false;
    // }
    //  if(section=="2"){
    kitchen = false;
    // }
    if(section=="1"){
      if(search){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Cookersdetail(detaildata: searchresult[i],);
        }));
      }
      else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Cookersdetail(detaildata: cookers[i],);
        }));
      }
    }
    else {
      if(search){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Detailpage(detaildata: searchresult[i],);
        }));
      }
      else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Detailpage(detaildata: ketchins[i],);
        }));
      }
    }
  }
}