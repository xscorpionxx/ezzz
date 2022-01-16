import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ezzproject/logic/detailpage.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/allreviews.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/marasil_detail2.dart';
import 'package:ezzproject/screens/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'chat.dart';
import 'notification.dart';
class Marasildetail1 extends StatefulWidget{
  var detaildata;
  Marasildetail1({this.detaildata});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statemarasildetail1(detaildata: detaildata);
  }
}
class Statemarasildetail1 extends State<Marasildetail1>{
  var detaildata;
  Detailpagelogic detailpagelogic;
  Statemarasildetail1({this.detaildata});
  @override
  void initState() {
    print(detaildata);
    detailpagelogic = new Detailpagelogic(context);
    super.initState();
    getdata();
  }
  List housesimg = [5,3,2];
  int totalprice ;
  getdata()async{
    Provider.of<Notifires>(context,listen: false).getdatadetailpage(detaildata["Products"]);
  }
  navigatetoshopping(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  var value_type="";
  List value_types =[];
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  List details =["بائعين جملة","بائعين الذبائح" ,"اسر منتجة","الطهاة والمطابخ" ,"ملاحم الجزيرة","أماكن","مأكولات بحرية","مزارع بيع الطيور","مراسيل","مزاد"];
  var data = {"review": "0.4" ,"site": "السعودية-رياض","timework":"10صباحا-10مساءا","name" : "ذبائح السلطان", "detail" : "نقوم بتقديم الذبائح المرخصة التي تكون خالصة لهعملائنا الكرام الذين يقدمون بشراء حاجيات" , "url" : "https://images.ctfassets.net/hrltx12pl8hq/61DiwECVps74bWazF88Cy9/2cc9411d050b8ca50530cf97b3e51c96/Image_Cover.jpg"};
  List datalist =[{"name" : "ahmad" , "price": "1500"},{"name" : "ahmad" , "price": "1500"},{"name" : "ahmad" , "price": "1500"},{"name" : "ahmad" , "price": "1500"}];
  @override
  Widget build(BuildContext context) {
    // datadetailpage = Provider.of<Notifires>(context).datadetailpage;
    // print(datadetailpage);
    //shoppinglist = Provider.of<Notifires>(context).shoppinglist;
    totalprice = Provider.of<Notifires>(context).totalprice;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:
        Container(
          child:detaildata == null?Container(child: Center(child: CircularProgressIndicator(),),): ListView(children: [
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :Stack(children: [
              Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
                decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60))),child: Row(children: [
                  Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                  Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1) ,alignment: Alignment.center,child: Text(detaildata["Name"].toString(),style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),))),
                  Expanded(flex: 2,child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("svg/Icon-alarm.svg",semanticsLabel: "wadca",))),
                  Expanded(flex: 2,child:InkWell(onTap: ()=>navigatetoshopping(),child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("svg/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) )
                ],),),
              Positioned(bottom: MediaQuery.of(context).size.height*0.06,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
            ],) ),
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.3,child: Image(fit: BoxFit.fill,image:NetworkImage(detaildata["Photo"]) ,),)
            ,
            Directionality(textDirection: TextDirection.rtl,
                child: Container(width: MediaQuery.of(context).size.width,child: Row(children:[
                  Expanded(flex: 4,child: Container(child: Text(detaildata["Name"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),)),
                  Expanded(child:  InkWell(onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return Chat(id: detaildata["ID"],);
                    }));
                  },child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),color: Color.fromRGBO(69, 190, 0, 1),alignment: Alignment.center,child: FittedBox(child: Text("دردشة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*14),)),)))]),
                )),
            Directionality(textDirection: TextDirection.rtl, child: Container(child: Text(detaildata["Description"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),)),
            Container(child: Row(children: [
              Expanded(flex: 3,child: Container( child: Text(detaildata["Location"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
              Expanded(child: Container(child: Text("الموقع",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
            ],),),
            Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,child: Row(children: [
              Expanded(child: Container(child: Text(detaildata["WorkTime"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.35 ,right: MediaQuery.of(context).size.width*0.01,top: MediaQuery.of(context).size.height*0.01),)),
              Expanded(child:  Container(child: Text("مواعيد العمل",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1 ,right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),))
            ],),),
            Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.02 ),child: FittedBox(
              child: Row(children: [
                Container(child: InkWell(onTap: ()=>navigatetoallreview(detaildata["Rating"],detaildata["ID"]),child: Text("مشاهدة تقييم البائع",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.red),)),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.16),)
                , Container( child: Text(detaildata["Rating"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),),alignment: Alignment.centerRight,) ,
                Container( child: Icon(Icons.star,color: Colors.yellow.withGreen(200),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),)
                ,Container( child: Text("التقييم",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.1),)
              ],),
            ),),
          Container(child: Divider(color: Colors.black38,),margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07,right:MediaQuery.of(context).size.width*0.07 ),)
          ,Container(
              child: detaildata["Products"].length==0?Container(height: MediaQuery.of(context).size.height*0.6,width: MediaQuery.of(context).size.width,child: Center(child: Text("لا يوجد عناصر في المتجر"),),) :Container(height: MediaQuery.of(context).size.height*0.6,width: MediaQuery.of(context).size.width,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01 ,top: MediaQuery.of(context).size.height*0.02),child: GridView.builder(scrollDirection: Axis.horizontal,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: (MediaQuery.of(context).size.height*0.8/MediaQuery.of(context).size.width*0.9),),itemCount: detaildata["Products"].length,itemBuilder: (context,i){
                print(detaildata["Products"][i]);
                return Container(child: detaildata["Products"][i]["Status"].toString().trim()!= "متاح"?
                Container(
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.15,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),child:Stack(
                  children:[ Container(
                    child: Column(children: [
                      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.19,child: Image(fit: BoxFit.fill,image: NetworkImage(detaildata["Products"][i]["Photo"]),),),
                    Spacer()
                    ,Container( margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01),child : Row(children:[ Expanded(child: Container( alignment:Alignment.centerLeft ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child: Directionality(textDirection: TextDirection.rtl,child: Text(detaildata["Products"][i]["Price"].toString(),style: TextStyle(color: Colors.red,fontSize: MediaQuery.of(context).size.width*0.03),)),)),
                        Expanded(child: Container(alignment:Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: Text(detaildata["Products"][i]["Name"].toString(),style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.035),)))])),
                    ],),
                  ),Container( decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.black54.withOpacity(0.1),),height: MediaQuery.of(context).size.height*0.2,child: Center(child: Text("غير متاح"),),)],
                ),
                ) : InkWell( child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.15,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),child:
                  Column(children: [
                    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.19,child: Image(fit: BoxFit.fill,image: NetworkImage(detaildata["Products"][i]["Photo"]),),),
                    Container( margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01),child :
                    Row(children:[ Expanded(child: Container( alignment:Alignment.centerLeft ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child: FittedBox(child: Directionality(textDirection: TextDirection.rtl,child: Text(detaildata["Products"][i]["Price"].toString(),style: TextStyle(color: Colors.red,fontSize: MediaQuery.of(context).size.width*0.03),))),)),
                      Expanded(child: Container(alignment:Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03,bottom: MediaQuery.of(context).size.height*0.015),child:FittedBox(child: Text(detaildata["Products"][i]["Name"].toString(),style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.035),)),))]),
                    ),
                    InkWell(onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return Marasildetail2(detaildata: detaildata ,detailproduct: detaildata["Products"][i],);
                      }));
                    },child: Container( height: MediaQuery.of(context).size.height*0.04,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color.fromRGBO(69, 190, 0, 1)) ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right:MediaQuery.of(context).size.width*0.01) ,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,child: FittedBox(child: Center(child: Text("رؤية التفاصيل",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*8,color: Colors.white),),)),)),
                  ],)
                    ,),
                ),
                );
              }),),
            ),
      ]),
    )));
  }
  reservation(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Location();
    }));
  }
  navigatetoallreview(rat,id){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Allriviews(rating : rat , id:id,name: detaildata["Name"],photo: detaildata["Photo"],);
    }));
  }
  navigateback(){
    Navigator.of(context).pop();
  }

}