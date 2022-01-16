import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ezzproject/logic/detailpage.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/allreviews.dart';
import 'package:ezzproject/screens/location.dart';
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
class Cookersdetail extends StatefulWidget{
  var detaildata;
  Cookersdetail({this.detaildata});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statedetailpage(detaildata: detaildata);
  }
}
class Statedetailpage extends State<Cookersdetail>{
  var detaildata;
  Detailpagelogic detailpagelogic;
  Statedetailpage({this.detaildata});
  @override
  void initState() {
    print(detaildata);
    detailpagelogic = new Detailpagelogic(context);
    super.initState();
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
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:ListView(children: [
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
                  return Chat(id: detaildata["ID"],
                  );
                }));
              },child: Container( padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),color: Color.fromRGBO(69, 190, 0, 1),alignment: Alignment.center,child: FittedBox(child: Center(child: Text("دردشة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*14),))),)))]),
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
          Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01,top: MediaQuery.of(context).size.height*0.01),child: FittedBox(
            child: Row(children: [
              Container(child: InkWell(onTap: ()=>navigatetoallreview(detaildata["Rating"],detaildata["ID"]),child: Text("مشاهدة تقييم البائع",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.red),)),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.16),)
              , Container( child: Text(detaildata["Rating"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),),alignment: Alignment.centerRight,) ,
              Container( child: Icon(Icons.star,color: Colors.yellow.withRed(1000),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),)
              ,Container( child: Text("التقييم",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.1),)
            ],),
          ),),Container(height: MediaQuery.of(context).size.height*0.7 ,child:
            Column(children: [
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08,top: MediaQuery.of(context).size.height*0.01),child: Text("بيانات الطلب",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black,fontWeight: FontWeight.bold),),)
              ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("نوع المناسبة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black45),),)
              ,Container(color: Colors.black12.withOpacity(0.1),width: MediaQuery.of(context).size.width,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),
                child:  Directionality(textDirection: TextDirection.rtl,
                  child: DropdownButtonHideUnderline(
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
              Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Row(children: [
                Expanded(child: Container(child: Column(children: [Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Text("الساعة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
                  ,Directionality(textDirection: TextDirection.rtl,
                    child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),color: Colors.black12,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(hintText: "",border: InputBorder.none),),),
                  )],),)),
                Expanded(child: Container(child: Column(children: [Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Text("التاريخ",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
                  ,Directionality(textDirection: TextDirection.rtl,
                    child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),color: Colors.black12,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(hintText: "",border: InputBorder.none),),),
                  )],),))
              ],),),
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.05),child: Text("العنوان",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
              ,Directionality(textDirection: TextDirection.rtl,
                child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),color: Colors.black12,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(hintText: "",border: InputBorder.none),),),
              ),
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.05),child: Text("التفاصيل",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
              ,Directionality(textDirection: TextDirection.rtl,
                child: Container(color: Colors.black12,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(minLines: 2,maxLines: 3,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(hintText: "",border: InputBorder.none),),),
              ),Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
                child:Text("ارسال", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04)) ,)
         ],),
      )])));
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