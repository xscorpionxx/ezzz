import 'package:ezzproject/screens/Loginpage.dart';
import 'package:ezzproject/screens/aboutapp.dart';
import 'package:ezzproject/screens/changepassword.dart';
import 'package:ezzproject/screens/chat.dart';
import 'package:ezzproject/screens/detailpage.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/marasilshow.dart';
import 'package:ezzproject/screens/partner.dart';
import 'package:ezzproject/screens/profile.dart';
import 'package:ezzproject/screens/recommend.dart';
import 'package:ezzproject/screens/shoppingcart.dart';
import 'package:ezzproject/screens/showpage.dart';
import 'package:ezzproject/screens/terms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification.dart';

class Marasil extends StatefulWidget{
  List data ;
  Marasil({this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statemarasil(data: data);
  }
}
class Statemarasil extends State<Marasil> with SingleTickerProviderStateMixin {
  List data;
  Statemarasil({this.data});
  @override
  void initState() {
    super.initState();
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width: MediaQuery
        .of(context)
        .size
        .width, height: MediaQuery
        .of(context)
        .size
        .height,
      child: ListView(children: [
        Directionality(textDirection: TextDirection.rtl,
          child: Container(width: MediaQuery
              .of(context)
              .size
              .width, height: MediaQuery
              .of(context)
              .size
              .height, child:
          ListView(children: [
            Directionality(textDirection: TextDirection.rtl,
              child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height ,child:
              Directionality(textDirection: TextDirection.ltr,
                child: Container(child: ListView(children: [
                  Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.1,
                    decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
                    Container(child: Stack(
                      children: [
                        Positioned( bottom: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.2) , borderRadius: BorderRadius.circular(1000)),),)
                        ,Container(
                          child:Column(children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                            child: Row(children: [
                              Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                              Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.2),alignment: Alignment.center,child: Text("مراسيل".toString(),style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                              Expanded(flex: 2,child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("svg/Icon-alarm.svg",semanticsLabel: "wadca",))),
                              Expanded(flex: 2,child:InkWell(onTap: ()=>navigatetostore(),child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("svg/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) )
                            ],),
                          )]),
                        )],
                    )),
                  ),
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,height: MediaQuery.of(context).size.height*0.85,child: ListView.builder(itemCount:data.length ,itemBuilder: (context,i){
                    return InkWell(onTap: ()=>navigatetoshowpage(i),child: Container(color: Colors.black12.withOpacity(0.1),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,child: Directionality(textDirection: TextDirection.rtl,child: ListTile(trailing: Icon(Icons.arrow_forward_ios_outlined,size: MediaQuery.of(context).size.width*0.05),title: Text(data[i]["Name"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),),)),));
                  }),)
                ],),),
              )
              ),
            ),
          ])
          ),
        ),
      ]),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  navigatetoshowpage(i){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return Showpage(id: data[i]["ID"] , subcategories: data,name: data[i]["Name"],cat : "مراسيل");
    }));
  }
}








