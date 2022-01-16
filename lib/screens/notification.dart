import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Notifications extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return Statenotifi();
  }
}
class Statenotifi extends State<Notifications>{
  List notification =[];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: ListView(children: [
      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
        decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child:
        Container(child: Stack(
          children: [
            Positioned( bottom: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.2) , borderRadius: BorderRadius.circular(1000)),),)
            ,Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
              child: Row(children: [
                Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: Text("التنبيهات",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                Expanded(flex: 2,child: SvgPicture.asset("svg/Icon-alarm.svg",semanticsLabel: "wadca",)),
                Expanded(flex: 2,child:Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("svg/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",)) )
              ],),
            ),],
        )),
      ),

      Container(width: MediaQuery.of(context).size.width*0.2,alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.02,bottom: MediaQuery.of(context).size.height*0.02),child:true?Container(): Row(children: [
        Container(child: Text("حذف الكل",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.red,decoration:TextDecoration.underline),),)
      ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: Icon(Icons.delete,color: Colors.red,size: MediaQuery.of(context).size.width*0.05,),)],),)
      ,Container(height: MediaQuery.of(context).size.height*0.88 ,child: ListView.builder(itemCount: notification.length,itemBuilder: (context,i){
       return Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02),color: Colors.white,child:Row(children: [
         Expanded(flex: 4,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),alignment: Alignment.centerLeft,child: Text(notification[i]["date"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.lightBlueAccent.withOpacity(0.5))),))
        , Expanded(flex: 7,child: Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text(notification[i]["noti"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),)),)),
         Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),alignment: Alignment.centerRight,child: Container(height: MediaQuery.of(context).size.width*0.01,width: MediaQuery.of(context).size.width*0.01,decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(200)),), ))
       ],) ,);
      }),)
    ],),);

  }
  navigateback(){
    Navigator.of(context).pop();
  }
}