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
import 'package:ezzproject/screens/placedetail.dart';
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

class Places extends StatefulWidget{
  List places =[];
  var name;
  Places({this.places,this.name});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateplaces(places :places,name:name);
  }
}
class Stateplaces extends State<Places> with SingleTickerProviderStateMixin{
  List places =[];
  var name;
  List placessearch =[];
  Stateplaces({this.places,this.name});
  TextEditingController query ;
  Showpagelogic showpagelogic;
  @override
  void initState() {
    print(places);
    showpagelogic = new Showpagelogic(context);
    query = new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
     placessearch = Provider.of<Notifires>(context).searchplaces;
     print(placessearch);
    // TODO: implement build
    return Scaffold(body:  Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:ListView(children: [
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
                    Expanded(flex: 2,child:InkWell(onTap: ()=>navigatetoshopping(),child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("svg/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) )
                  ],),
                ), Container(padding: EdgeInsets.only(right:  MediaQuery.of(context).size.width*0.01 ,left: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.width*0.07,right:MediaQuery.of(context).size.width*0.07 ),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5))
                  ,child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: query,onChanged: (val){
                      Provider.of<Notifires>(context, listen: false)
                          .searchplace(places, val);
                  }, style:  TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black26),decoration: InputDecoration(hintText: "بحث",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26),border: InputBorder.none,suffixIcon: Icon(Icons.search,color: Colors.black26,)),)),)]),
              )],
          )),
        ),Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03 ,left: MediaQuery.of(context).size.width*0.04,right: MediaQuery.of(context).size.width*0.04),height: MediaQuery.of(context).size.height*0.75,width: MediaQuery.of(context).size.width,child:places.length==0?Container(
          child: Center(child: Text("لا توجد أية عناصر",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),
        ): query.text==""? GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width*1.5/MediaQuery.of(context).size.height*0.95),
        ),itemCount: places.length,itemBuilder: (context,i){
          return InkWell(onTap: ()=>showdetail(i,false),
            child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.025),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white,boxShadow: [BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              blurRadius: 1.0,
              spreadRadius: 3.0,
              offset: Offset(0.0, 0.0), // shadow direction: bottom right
            )]),child:Column(children: [
              Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(places[i]["Photos"][0]),),),
                Positioned(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.02 ,child:false?
                InkWell(onTap: ()=>null,
                  child: Container(width: MediaQuery.of(context).size.width*0.09,
                    height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,),),
                ):InkWell(onTap: ()=>null,
                  child: Container(width: MediaQuery.of(context).size.width*0.09,
                    height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.white),child: Icon(Icons.favorite_border,color: Colors.black54,size: MediaQuery.of(context).size.width*0.07,),),
                )) ])),
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.025) ,child: AutoSizeText(places[i]["Name"],maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(5, 131, 127, 1),fontSize: MediaQuery.of(context).textScaleFactor*13),),)
              ,Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child:Row(children:[
                Expanded(flex: 20,child: Directionality(textDirection: TextDirection.rtl,
                  child: Container(height: MediaQuery.of(context).size.height*0.03,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.0 ),
                    child:  ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                      return Container(alignment: Alignment.center ,child: Icon(Icons.star,color: Colors.black38,size: MediaQuery.of(context).size.width*0.05,));
                    }),
                  ),
                )),Expanded(child: Container(alignment: Alignment.center,child: FittedBox(child: Text("1",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),))),),
              ]) ),
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Directionality(textDirection: TextDirection.rtl,child:   FittedBox(child: AutoSizeText( "ابتداء من "+places[i]["WeeklyRental"].toString() + " ريال",maxLines: 1,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),)))),
            ],)
              ,),
          );
        }):GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width*1.5/MediaQuery.of(context).size.height*0.95),
        ),itemCount: placessearch.length,itemBuilder: (context,i){
          return InkWell(onTap: ()=>showdetail(i,false),
            child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.025),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white,boxShadow: [BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              blurRadius: 1.0,
              spreadRadius: 3.0,
              offset: Offset(0.0, 0.0), // shadow direction: bottom right
            )]),child:Column(children: [
              Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(placessearch[i]["Photos"][0]),),),
                Positioned(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.02 ,child:false?
                InkWell(onTap: ()=>null,
                  child: Container(width: MediaQuery.of(context).size.width*0.09,
                    height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,),),
                ):InkWell(onTap: ()=>null,
                  child: Container(width: MediaQuery.of(context).size.width*0.09,
                    height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.white),child: Icon(Icons.favorite_border,color: Colors.black54,size: MediaQuery.of(context).size.width*0.07,),),
                )) ])),
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.025) ,child: AutoSizeText(placessearch[i]["Name"],maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(5, 131, 127, 1),fontSize: MediaQuery.of(context).textScaleFactor*13),),)
              ,Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child:Row(children:[
                Expanded(flex: 20,child: Directionality(textDirection: TextDirection.rtl,
                  child: Container(height: MediaQuery.of(context).size.height*0.03,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.0 ),
                    child:  ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                      return Container(alignment: Alignment.center ,child: Icon(Icons.star,color: Colors.black38,size: MediaQuery.of(context).size.width*0.05,));
                    }),
                  ),
                )),Expanded(child: Container(alignment: Alignment.center,child: FittedBox(child: Text("1",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),))),),
              ]) ),
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Directionality(textDirection: TextDirection.rtl,child:   FittedBox(child: AutoSizeText( "ابتداء من "+placessearch[i]["WeeklyRental"].toString() + " ريال",maxLines: 1,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),)))),
            ],)
              ,),
          );
        }))
            ],),),
          );
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
  Widget auctions(){



  }

  navigateback(){
    Navigator.of(context).pop();
  }
  getdata(index) async{
   // print(subcategories);
    Future.delayed(const Duration(milliseconds: 500), () {
     // Provider.of<Notifires>(context,listen: false).getdatashowpage(index,subcategories,context);
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
    print(places[i]);
    if(search){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Placedetail(detaildata: placessearch[i],);
      }));
    }
    else{
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Placedetail(detaildata: places[i],);
      }));
    }
  }
}