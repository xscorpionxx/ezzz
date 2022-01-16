import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/showpage.dart';
import 'package:ezzproject/screens/Loginpage.dart';
import 'package:ezzproject/screens/aboutapp.dart';
import 'package:ezzproject/screens/changepassword.dart';
import 'package:ezzproject/screens/chat.dart';
import 'package:ezzproject/screens/detailpage.dart';
import 'package:ezzproject/screens/location.dart';
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
class MarasilShow extends StatefulWidget{
  var id;
  var name;
  MarasilShow({this.id ,this.name });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateshowpage(id : id , name:name);
  }
}
class Stateshowpage extends State<MarasilShow> with SingleTickerProviderStateMixin{
  TextEditingController query ;
  var id;
  var name;
  List providers =[{"Photo" : "" ,"Review" : "0.4","Description":"dwadadawda", "Name" : "dadawdawdad"}];
  List searchresult =[];
  Stateshowpage({this.id ,this.name });
  var section ="1";
  Showpagelogic showpagelogic;
  @override
  void initState() {
    showpagelogic = new Showpagelogic(context);
    print(name);
    print(id);
    print(providers);
    print(providers.length);
    query = new TextEditingController();
    super.initState();
    //getdata(id);
  }
  @override
  Widget build(BuildContext context) {
    providers = Provider.of<Notifires>(context).providers;
    searchresult = Provider.of<Notifires>(context).searchresult2;
    // TODO: implement build
    return Scaffold(body:  Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:false?ListView(children: [
        Directionality(textDirection: TextDirection.rtl,
          child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height ,child:
          marasil(),
          ),
        ),
      ]) : ListView(children: [
        Directionality(textDirection: TextDirection.rtl,
          child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height ,child:
          marasil()
          ),
        ),
      ]),
    ),);
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
  navigateback(){
    Navigator.of(context).pop();
  }
  List denats =["دينات الصندوق","دينات ونش" ,"شاحنات التحميل"];
  Widget marasil(){
    return Directionality(textDirection: TextDirection.ltr,
      child: Container(child: ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.17,
          decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60))),child:
          Container(child: Stack(
            children: [
              Positioned( bottom: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.2) , borderRadius: BorderRadius.circular(1000)),),)
              ,Container(
                child:Column(children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                  child: Row(children: [
                    Expanded(flex: 2,child: InkWell(onTap: ()=>navigateback(),child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child: Icon(Icons.arrow_back_ios,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,)))),
                    Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: AutoSizeText(name.toString(),style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*12),))),
                    Expanded(flex: 2,child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("svg/Icon-alarm.svg",semanticsLabel: "wadca",))),
                    Expanded(flex: 2,child:InkWell(onTap: ()=>navigatetostore(),child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("svg/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) )
                  ],),
                ), Container(padding: EdgeInsets.only(right:  MediaQuery.of(context).size.width*0.01 ,left: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.15,right:MediaQuery.of(context).size.width*0.15 ),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5))
                  ,child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: query,onChanged: (val){
                    Provider.of<Notifires>(context ,listen: false).search2(providers, val);
                  }, style:  TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black26),decoration: InputDecoration(hintText: "بحث",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26),border: InputBorder.none,suffixIcon: Icon(Icons.search,color: Colors.black26,)),)),)]),
              )],
          )),
        ),Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04 ,left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.8,width: MediaQuery.of(context).size.width,child:
        providers.length==0?Container(
          child: Center(child: Text("لا توجد أية عناصر",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),
        ):query.text ==""? GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width*1.5/MediaQuery.of(context).size.height),),itemCount: providers.length,itemBuilder: (context,i){
          return InkWell(onTap: ()=>showdetail(i),
            child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
              color: Colors.black26,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )]),child:Column(children: [
              Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.17,child: Image(fit: BoxFit.fill,image: NetworkImage(providers[i]["Photo"]),),),
              Container(child:Row(children:[
                Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Text(providers[i]["Review"].toString(),style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.015),),))
                ,Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon(Icons.star,color: Colors.yellow.withGreen(2000),)),),
                Expanded(flex: 6,child: Container(alignment: Alignment.centerRight ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Text(providers[i]["Name"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.02),)),)
              ]) ),
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),child: Directionality(textDirection: TextDirection.rtl,child: Center(child: Text(providers[i]["Description"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),))),),
            ],)
              ,),
          );
        }) : GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width*1.5/MediaQuery.of(context).size.height),),itemCount: searchresult.length,itemBuilder: (context,i){
          return InkWell(onTap: ()=>showdetail(i),
            child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
              color: Colors.black26,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )]),child:Column(children: [
              Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.17,child: Image(fit: BoxFit.fill,image: NetworkImage(searchresult[i]["Photo"]),),),
              Container(child:Row(children:[
                Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Text(searchresult[i]["Review"].toString(),style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.015),),))
                ,Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon(Icons.star,color: Colors.yellow.withGreen(2000),)),),
                Expanded(flex: 6,child: Container(alignment: Alignment.centerRight ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Text(searchresult[i]["Name"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.02),)),)
              ]) ),
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),child: Directionality(textDirection: TextDirection.rtl,child: Center(child: Text(searchresult[i]["Description"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),))),),
            ],)
              ,),
          );
        })
        )
      ],),),
    );
  }
  showdetail(i){
    var kitchen;
    //if(section =="1"){
    //  kitchen =false;
    // }
    //  if(section=="2"){
    kitchen = false;
    // }
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Detailpage(detaildata: providers[i],);
    }));
  }
}