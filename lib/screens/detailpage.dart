import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ezzproject/logic/detailpage.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/allreviews.dart';
import 'package:ezzproject/screens/chat.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'notification.dart';
class Detailpage extends StatefulWidget{
  var index;
  var title;
  var kitchen;
  var id;
  var detaildata;
  Detailpage({this.detaildata});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statedetailpage(detaildata: detaildata);
  }
}
class Statedetailpage extends State<Detailpage>{
  var index = 1;
  var title;
  List titles = ["بائعين جملة","بائعين الذبائح" ,"اسر منتجة","الطهاة والمطابخ" ,"ملاحم الجزيرة","أماكن","مأكولات بحرية","مزارع بيع الطيور","مراسيل","مزاد"];
  var section = "1";
  List shoppinglist =[];
  var kitchens = false;
  var id;
  var datadetailpage;
  var detaildata;
  Detailpagelogic detailpagelogic;
  Statedetailpage({this.detaildata});
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
     shoppinglist = Provider.of<Notifires>(context).shoppinglist;
     totalprice = Provider.of<Notifires>(context).totalprice;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:false?ListView(children: [
       Container(child:Stack(children:[Container(height: MediaQuery.of(context).size.height*0.5,width: MediaQuery.of(context).size.width,child: Image(image: AssetImage("images/home6.jpg"),fit: BoxFit.fill,),)
        ,Positioned(top: MediaQuery.of(context).size.height*0.32,child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.16 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.black38.withOpacity(0.5)),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
        Column(children: [
             Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.08,right:MediaQuery.of(context).size.width*0.08 ),child: Row(children: [
               Expanded(child: Container(height: MediaQuery.of(context).size.height*0.05,decoration: BoxDecoration(color: Colors.grey.withOpacity(0.8) ,borderRadius: BorderRadius.circular(50)),child: Icon(Icons.favorite_border,color: Colors.white,size: MediaQuery.of(context).size.width*0.07,),))
               ,Expanded(flex: 7,child: Container(alignment: Alignment.centerRight,child: Text("استراحة فاخرة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.06,color: Colors.white),)))
             ],),)
           ,Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.width*0.08,right:MediaQuery.of(context).size.width*0.08 ),child: Row(children: [
      Expanded(flex: 3,child: InkWell(onTap: ()=>null,child: Container(decoration: BoxDecoration(color: Colors.grey.withOpacity(0.8) ,borderRadius: BorderRadius.circular(20) ),alignment: Alignment.center,child: Center(child: Text("مشاهدة تقييم البائع",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),)),))),
            Expanded(flex: 4,child: Directionality(textDirection: TextDirection.rtl,child: Container(width: MediaQuery.of(context).size.width*0.05,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),decoration: BoxDecoration(),alignment: Alignment.center,child: Row(children:[ Icon(Icons.star,color: Colors.yellow.withGreen(200),size: MediaQuery.of(context).size.width*0.05),Text("0.4",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),)]),)),)
             , Expanded(child: Container(alignment: Alignment.centerRight,child: Center(child: Text("التقييم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),)),))
          ],),)],)
           ,)),Positioned(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.05,child: IconButton(icon:Icon( Icons.arrow_back_ios),color: Colors.white,iconSize: MediaQuery.of(context).size.width*0.07,onPressed: (){
             navigateback();
         },))] )),
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.1,child: ListView.builder(itemCount: housesimg.length,scrollDirection: Axis.horizontal ,itemBuilder:(context,i){
          return Container(width: MediaQuery.of(context).size.width*0.3,height:MediaQuery.of(context).size.width*0.1,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image(image: AssetImage("images/home6.jpg"),fit: BoxFit.fill,)),);
        }),),
        Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: Row(children: [
          Expanded(child:InkWell(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(),child: Center(child: Directionality(textDirection: TextDirection.rtl,
              child: Column(children:[ Container(child: Text("200 ريال",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05),)),Container(child: Text("لليلة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03)))]))),))),
          Expanded(child:InkWell(onTap: ()=>reservation(),child: Container(height: MediaQuery.of(context).size.height*0.06,margin: EdgeInsets.only(),color: Colors.green.withOpacity(0.8),child: Center(child: Text("احجز الان",style: TextStyle(color: Colors.white),)),)))
        ],),),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: Directionality(textDirection: TextDirection.rtl,
          child: Row(children: [
            Container(child: Icon(Icons.location_on_rounded,color: Colors.red,size: MediaQuery.of(context).size.width*0.06,),),
            Container(child: Text("الرياض-شارع فيهد",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black26),),)
          ],),
        ),),
        Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.07),child:Text("وصف الاستراحة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight.bold),) ,),
        Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child:Text("وصف الاستراحةوصف الاستراحةوصف الاستراحةوصف الاستراحةوصف الاستراحةوصف الاستراحة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black38),) ,)),
        Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.07),child:Text("التفاصيل",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight.bold),) ,),
        Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),height: MediaQuery.of(context).size.height*0.2,child: GridView.builder( gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio: 3),scrollDirection: Axis.vertical,itemCount:details.length ,itemBuilder: (context,i){
         return Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,decoration:BoxDecoration(border: Border.all(color: Colors.black26),borderRadius: BorderRadius.circular(20)),child: Center(child: Text(details[0],style: TextStyle(color: Colors.black26,fontSize: MediaQuery.of(context).size.width*0.03),)),);
        }),),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl,child: Text("م 2500")),)),
          Expanded(child: Container(alignment: Alignment.centerRight,child: Text("المساحة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold),),)),
        ],),),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl,child: Text("م 2500")),)),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),alignment: Alignment.centerRight,child: Text("عدد الاشخاص",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold),),)),
        ],),),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl,child: Text("م 2500")),)),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),alignment: Alignment.centerRight,child: Text("عدد الادوار",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold),),)),
        ],),),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl,child: Text("م 2500")),)),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),alignment: Alignment.centerRight,child: Text("عدد الغرف",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold),),)),
        ],),),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl,child: Text("م 2500")),)),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),alignment: Alignment.centerRight,child: Text("عدد دورات المياه",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold),),)),
        ],),),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl,child: Text("م 2500")),)),
          Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),alignment: Alignment.centerRight,child: Text("المطبخ",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold),),)),
        ],),),
        Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),child: Divider(color: Colors.black26,thickness: 2,),)
        ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.07),child:Text("الأسعار",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight.bold),) ,),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.center,child:Directionality(textDirection: TextDirection.rtl,child: Text("م 2500")),)),
          Expanded(child: Container(alignment: Alignment.centerRight,child: Text("سعر تأجيره الأيام العادية",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold),),)),
        ],),),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.center,child:Directionality(textDirection: TextDirection.rtl,child: Text("م 2500")),)),
          Expanded(child: Container(alignment: Alignment.centerRight,child: Text("سعر تأجيره نهاية اللأسبوع",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold),),)),
        ],),),
        Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),child: Divider(color: Colors.black26,thickness: 2,),),
        Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.07),child:Text("الموقع على الخريطة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold),) ,)
      ],): Container(
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
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(width: MediaQuery.of(context).size.width,child: Row(children:[
                Expanded(flex: 4,child: Container(child: Text(detaildata["Name"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),)),
          Expanded(child:  InkWell(onTap: (){
            print(detaildata["ID"]);
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
          Container(color: Colors.black12,child: Row(children: [
             Container(child: InkWell(onTap: ()=>navigatetoallreview(detaildata["Rating"],detaildata["ID"]),child: Text("مشاهدة تقييم البائع",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.red),)),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.16),)
            , Container( child: Text(detaildata["Rating"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),),alignment: Alignment.centerRight,) ,
            Container( child: Icon(Icons.star,color: Colors.yellow.withRed(1000),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),)
             ,Container( child: Text("التقييم",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.1),)
          ],),),
          Container(
            child:true ?Container():Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01)
              ,child: Row(children: [
                Expanded(child: section == "1"?Container(alignment: Alignment.center,child: Column(children:[
                  Text("وجبات",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.width*0.035),),
                Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1 ) ,height: MediaQuery.of(context).size.height*0.005,color: Colors.blue,)]),): Container(
                  child: InkWell(onTap: (){
                    setState(() {
                      section ="1";
                    });
                  },child: Container(alignment: Alignment.center ,child: Text("وجبات",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),))),
                )
               , Expanded(child: section == "2"?Container(alignment: Alignment.center,child: Column(children:[
                  Text("مأكولات البحرية",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.width*0.035),),
                  Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1 ) ,height: MediaQuery.of(context).size.height*0.005,color: Colors.blue,)]),): Container(
                    child: InkWell(onTap: (){
                      setState(() {
                        section ="2";
                      });
                    },child: Container(alignment: Alignment.center ,child: Text("مأكولات بحرية",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),))),
                )
              ],) ,),
          )
          ,Container(
            child:false?Container(height: MediaQuery.of(context).size.height*0.5,
              child: Column(children: [
                Container(child: Text("بيانات السيارة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),)
                ,Container(child : Row(
                  children:[Expanded(
                    child: Container(child: Row(children: [
                      Container(child: Text(data["timework"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),),alignment: Alignment.centerRight,),
                      Container(child: Text("رقم السيارة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold,color: Colors.black),),alignment: Alignment.centerRight)
                    ],),),
                  ) ,Expanded(
                    child: Container(alignment: Alignment.centerRight,child: Row(children: [
                      Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: Text(data["timework"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),)),
                      Container(child: Text("الماركة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold,color: Colors.black),))
                    ],),),
                  )]),
                ),
                Container(child : Row(
                    children:[Expanded(
                      child: Container(),
                    ) ,Expanded(
                      child: Container(child: Row(children: [
                        Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.14) ,child: Text("0303",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),)),
                        Container(child: Text("رخصة القيادة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold,color: Colors.black),))
                      ],),),
                    )]),
                ),
                Container(child: Text("بيانات السائق",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08,top: MediaQuery.of(context).size.height*0.03),)
            ,Container(child: Row(children: [
                  Expanded(flex: 3,child: Container( child: Text(data["site"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
                  Expanded(child: Container(child: Text("الاسم",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
                ],),),
                Container(child: Row(children: [
                  Expanded(flex: 2,child: Container( child: Text(data["site"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
                  Expanded(child: Container(child: Text("الهوية الوطنية",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
                ],),),
                Container(child: Row(children: [
                  Expanded(flex: 2,child: Container( child: Text(data["site"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
                  Expanded(child: Container(child: Text("رخصة القيادة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
                ],),),
                Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.green),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
                  child:Text("اتصل الان ", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04)) ,)
              ],),
            ):false?
              Container(height: MediaQuery.of(context).size.height*0.7 ,child:
                Column(children: [
                  Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08,top: MediaQuery.of(context).size.height*0.01),child: Text("بيانات الطلب",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black,fontWeight: FontWeight.bold),),)
                  ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),child: Text("نوع المناسبة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
                  ,Container(color: Colors.black12,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),
                    child:  Directionality(textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: DropdownButtonHideUnderline(
                            child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),
                              hint: Text("حدد")
                              ,value: value_type
                              ,items: value_types.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                              onChanged: (_) {
                                value_type =_;
                                setState(() {});
                              },
                            )),
                      ),
                    ),
                  ),
                  Container(child: Row(children: [
                    Expanded(child: Container(child: Column(children: [Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Text("الساعة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
                      ,Directionality(textDirection: TextDirection.rtl,
                        child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),color: Colors.black12,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(hintText: "",border: InputBorder.none),),),
                      )],),)),
                    Expanded(child: Container(child: Column(children: [Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Text("التاريخ",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
                      ,Directionality(textDirection: TextDirection.rtl,
                        child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),color: Colors.black12,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(hintText: "",border: InputBorder.none),),),
                      )],),))
                  ],),),
                  Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Text("العنوان",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
                  ,Directionality(textDirection: TextDirection.rtl,
                    child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),color: Colors.black12,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(hintText: "",border: InputBorder.none),),),
                  ),
                  Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Text("التفاصيل",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
                  ,Directionality(textDirection: TextDirection.rtl,
                    child: Container(color: Colors.black12,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(minLines: 2,maxLines: 3,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(hintText: "",border: InputBorder.none),),),
                  ),
                  Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.green),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
                    child:Text("ارسال", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04)) ,)],),)
            :Container(
              child: detaildata["Products"].length==0?Container(height: MediaQuery.of(context).size.height*0.6,width: MediaQuery.of(context).size.width,child: Center(child: Text("لا يوجد عناصر في المتجر"),),) :Container(height: MediaQuery.of(context).size.height*0.6,width: MediaQuery.of(context).size.width,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01 ,top: MediaQuery.of(context).size.height*0.02),child: GridView.builder(scrollDirection: Axis.horizontal,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: (MediaQuery.of(context).size.height*0.8/MediaQuery.of(context).size.width*0.9),),itemCount: detaildata["Products"].length,itemBuilder: (context,i){
                print(detaildata["Products"][i]);
                return Container(child: detaildata["Products"][i]["Status"].toString().trim()!= "متاح"
                    ?Container(
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.15,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),child:Stack(
                  children:[ Container(
                    child: Column(children: [
                      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.19,child: Image(fit: BoxFit.fill,image: NetworkImage(detaildata["Products"][i]["Photo"]),),),
                      Spacer()  
                    ,Container( margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01),child : Row(children:[ Expanded(child: Container( alignment:Alignment.centerLeft ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child: Directionality(textDirection: TextDirection.rtl,child: Text(detaildata["Products"][i]["Price"].toString(),style: TextStyle(color: Colors.red,fontSize: MediaQuery.of(context).size.width*0.03),)),)),
                        Expanded(child: Container(alignment:Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: FittedBox(child: Text(detaildata["Products"][i]["Name"].toString(),style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.035),)),))])),
                    ],),
                  ),Container( decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: Colors.black54.withOpacity(0.1),),height: MediaQuery.of(context).size.height*0.2,child: Center(child: Text("غير متاح"),),)],
                ),
                ):Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.15,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),child:
                       Column(children: [
                  Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.19,child: Image(fit: BoxFit.fill,image: NetworkImage(detaildata["Products"][i]["Photo"]),),),
                   Container( margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01),child :
                      Row(children:[ Expanded(child: Container( alignment:Alignment.centerLeft ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child: FittedBox(child: Directionality(textDirection: TextDirection.rtl,child: Text(detaildata["Products"][i]["Price"].toString(),style: TextStyle(color: Colors.red,fontSize: MediaQuery.of(context).size.width*0.03),))),)),
                          Expanded(child: Container(alignment:Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03,bottom: MediaQuery.of(context).size.height*0.015),child:FittedBox(child: Text(detaildata["Products"][i]["Name"].toString(),style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.035),)),))]),
                  ),
                  InkWell(onTap: ()=>Provider.of<Notifires>(context,listen: false).plus(detaildata["Products"][i]["ID"] ,i, num,detaildata["Products"][i]["Price"] , context) ,child: Container( height: MediaQuery.of(context).size.height*0.04,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color.fromRGBO(69, 190, 0, 1)) ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right:MediaQuery.of(context).size.width*0.01) ,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,child: FittedBox(child: Center(child: Text("اضافة للعربة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*8,color: Colors.white),),)),)),
                ],)
                  ,),
                );
              }),),
            ),
          )
          ,Container(
            child:index==8  ?Container(): Container(
              child:true?  Container(): Container( height: MediaQuery.of(context).size.height*0.08,decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft:Radius.circular(20) ),color : Color.fromRGBO(42, 171, 227, 1)),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child: Row(children: [
                Expanded(flex: 2,child: Container())
                ,Expanded(child:Container(alignment: Alignment.center,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015,right: MediaQuery.of(context).size.width*0.1),child: Container(height: MediaQuery.of(context).size.height*0.08,
                  child: Column(children: [Text("المجموع",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),
                    Directionality(textDirection: TextDirection.rtl,child: Text("ريال"+totalprice.toString(),style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),))
                  ]),
                ),) ) ],),),
            ),
          )
        ],),
      ),
    ),);
  }
  reservation(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Location();
    }));
  }
  navigatetoallreview(rat,id){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Allriviews(rating : rat , id:id ,name: detaildata["Name"],photo: detaildata["Photo"],);
    }));
  }
  navigateback(){
     Navigator.of(context).pop();
  }

}