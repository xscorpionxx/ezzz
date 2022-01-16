import 'dart:convert';

import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/shoppingcart.dart';
import 'package:ezzproject/logic/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification.dart';
class Shoppingcard extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateShopping();
  }
}
class StateShopping extends State<Shoppingcard>{
  List products = [];
  int totalprice;
  List shoppinglist =[];
  var region2 ;
  var region1;
  var region3;
  int discountprice ;
  List region2list =[];
  List region2back =[];
  List region1list =[];
  List region1back =[];
  List region3list =[];
  List region3back =[];
  GlobalKey<FormState> key ;
  var location;
  Shoppingcartlogic shoppingcartlogic;
  TextEditingController discount ;
  TextEditingController address ;
  TextEditingController phone ;
  @override
  void initState() {
    shoppingcartlogic = new Shoppingcartlogic(context);
    discount = new TextEditingController();
    address = new TextEditingController();
    phone = new TextEditingController();
    key =new GlobalKey<FormState>() ;
    getdata();
    super.initState();
  }
  var change = false;
  getdata()async{
    await Provider.of<Notifires>(context,listen: false).getcart(context);
    List region1 =[];
    List region2 =[];
    List region3 =[];
    var url = "https://azz.sla-request.com/api/places";
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    for(int f =0 ; f<body["data"].length ; f++){
      region1.add({"name" :body["data"][f]["Name"],"ID" : body["data"][f]["ID"].toString()});
      for(int g=0 ; g<body["data"].length ; g++){
        region2.add({"name" :body["data"][f]["Cities"][g]["Name"],"ID" : body["data"][f]["Cities"][g]["ID"].toString()});
        for(int k=0 ; k<body["data"].length ; k++){
          region3.add({"name" :body["data"][f]["Cities"][g]["Regions"][k]["Name"],"ID" : body["data"][f]["Cities"][g]["Regions"][k]["ID"].toString()});
        }
      }
    }
    region2back = region2;
    region1back = region1;
    region3back = region3;
    for(int a =0 ; a<region2back.length ; a++){
      region2list.add(region2back[a]["name"].toString());
    }
    for(int a =0 ; a<region1back.length ; a++){
      region1list.add(region1back[a]["name"].toString());
    }
    for(int a =0 ; a<region3back.length ; a++){
      region3list.add(region3back[a]["name"].toString());
    }
    setState(() {});
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  @override
  Widget build(BuildContext context) {
    location =Provider.of<Notifires>(context).location;
    products = Provider.of<Notifires>(context).shoppingcart;
    totalprice = Provider.of<Notifires>(context).totalpricecart;
    shoppinglist = Provider.of<Notifires>(context).shoppinglist;
    discountprice= Provider.of<Notifires>(context).discountprice;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:  Form(key: key,
        child: ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :Stack(children: [
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1) ,alignment: Alignment.center,child: Text("عربة التسوق",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),))),
                Expanded(child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("svg/Icon-alarm.svg",semanticsLabel: "wadca",))),
                Expanded(child:InkWell(onTap: ()=>null,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07))) )
              ],),),
            Positioned(bottom: MediaQuery.of(context).size.height*0.06,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
          ],) ),
           Container(height:MediaQuery.of(context).size.height *0.85 ,child:products.length==0 ?Container(child: Center(child: Text("لا يوجد أي منتج في عربة التسوق "),),) : ListView(children: [
             Directionality(textDirection: TextDirection.rtl, child:  Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.01,top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),child: Row(children: [Expanded(child: Container(alignment: Alignment.centerRight,child: Text("لديك"+shoppinglist.length.toString() +" عنصر في السلة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),)),
               Expanded(child: Container(alignment: Alignment.centerLeft,child: InkWell(onTap: ()=>null,child:true?Container(): Text("حذف الكل",style: TextStyle(decoration: TextDecoration.underline,color: Colors.redAccent,fontSize: MediaQuery.of(context).size.width*0.035),)),))],),)),
             Container(
               child:products.length==0?Container() :Container(height: MediaQuery.of(context).size.height*0.3,width: MediaQuery.of(context).size.width,child: ListView.builder(itemCount: products.length,itemBuilder: (context,i){
                 return Container( height: MediaQuery.of(context).size.height*0.1,padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),child:Row(children: [
                   Expanded(child: Container(width: MediaQuery.of(context).size.width*0.1,child: Column(children: [
                     Directionality(textDirection: TextDirection.rtl,child: Text(products[i]["SalePrice"].toString()+"ريال",style: TextStyle(color: Colors.red,fontSize: MediaQuery.of(context).size.width*0.04))),IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){ Provider.of<Notifires>(context,listen: false).delete(i, products[i]["SalePrice"], context);
                        })
                   ],),)),Expanded(flex: 2,child: Container(width: MediaQuery.of(context).size.width*0.1,child: Column(children: [
                     Container(alignment: Alignment.center,child: FittedBox(child: Text(products[i]["Name"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.04)))),Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,child: Row(children: [
                       Expanded(child: InkWell(onTap: ()=>Provider.of<Notifires>(context,listen: false).minus2(products[i]["ID"].toString(),i ,shoppinglist[i]["num"],int.parse(products[i]["SalePrice"].toString()) , context)
                 ,child: Container(decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(5)) ,alignment:Alignment.centerRight,padding:EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.015 ) ,child: Center(child: Icon(Icons.minimize,color: Colors.white,)),))),
                       Expanded(flex: 2,child: Container(alignment: Alignment.center,child: Text(products[i]["Qt"].toString()))),
                       Expanded(child: InkWell(onTap: ()=>Provider.of<Notifires>(context,listen: false).plus2( products[i]["ID"].toString(),i ,shoppinglist[i]["num"],int.parse(products[i]["SalePrice"].toString()),context)
                 ,child: Container(decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(5)) ,alignment:Alignment.centerRight,height: MediaQuery.of(context).size.height*0.04,child: Center(child: Icon(Icons.add,color: Colors.white,)),)))
                     ],),)
                   ],),)),
                   Expanded(child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),child: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image(image: NetworkImage(products[i]["Photo"]),fit: BoxFit.fill,)),))
                 ],)
                   ,);
               }),),
             ),
             Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right: MediaQuery.of(context).size.width*0.02) ,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black26,width: 2) ,color: Colors.white,borderRadius: BorderRadius.circular(20)),child: Row(children: [
               Expanded(child: InkWell(onTap: ()=>shoppingcartlogic.addpromocode(discount.text.toString(), totalprice.toString()),child: Container(height: MediaQuery.of(context).size.height*0.06,width: MediaQuery.of(context).size.width*0.25,alignment: Alignment.center,child: Text("تطبيق",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),),decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),borderRadius: BorderRadius.circular(20)),)))
               ,Expanded(flex: 3,child: Container(child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: discount,decoration: InputDecoration( hintText: "قسيمة الخصم",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),border: InputBorder.none),))))]),),
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),color: Colors.white,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.23,child: Column(children: [
               Container(child: Text("تفاصيل الطلب",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),),
               Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),child: Row(children: [Expanded(child: Text("0 ريال",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03)))
                 ,Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) ,alignment: Alignment.centerRight,child: Text("خدمة التوصيل",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03))))],),)
               , Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),child: Row(children: [Expanded(child: Text(" ريال"+totalprice.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03)))
                 ,Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerRight,child: Text("التكلفة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03))))],),),
               Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),child: Row(children: [Expanded(child: Text("ريال" +discountprice.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03)))
                 ,Expanded(child: Container(alignment: Alignment.centerRight,child: Text("قسيمة الخصم",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03))))],),)
               ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),child: Divider(thickness: 1,),),
               Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),child: Row(children: [Expanded(child: Text(" ريال"+(int.parse(totalprice.toString()) - discountprice).toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03)))
                 ,Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03) ,alignment: Alignment.centerRight,child: Text("الاجمالي",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.03))))],),)
             ],),),
             Container(
               child: change? Container(): Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,),color: Colors.white,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.08,child: Column(children: [
                 Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.02,right:MediaQuery.of(context).size.width*0.1 ) ,child : Row(children: [Expanded(child:Container(child: InkWell(onTap: (){
                   change = true;
                   setState(() {});
                 },child: Text("اكمال البيانات",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.red))),)),Expanded(child:Container(alignment: Alignment.centerRight,child: Text("معلومات الاكمال",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold)),))],)),
                 //Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ) ,child : Row(children: [Expanded(child:Container(child: Text("",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.red)),)),Expanded(child:Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text(location.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035))),))],)),
                 //Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.4,right:MediaQuery.of(context).size.width*0.1 ) ,child : Row(children: [Container(child: Text("",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.red)),),Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text("حدد العنوان على الخريطة",style: TextStyle(color: Colors.red,fontSize: MediaQuery.of(context).size.width*0.03))),), Icon(Icons.location_on_rounded,color: Colors.red,size: MediaQuery.of(context).size.height*0.03,)],)),
               ],),),
             ),
             Container(
               child: !change? Container(): Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),color: Colors.white,width: MediaQuery.of(context).size.width,child: Column(children: [
                Directionality(textDirection: TextDirection.rtl, child:  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                   child: Row(children:[ Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ) ,child : Container(alignment: Alignment.centerRight,child: Text("اكمال المعلومات",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold)),))) ,
                    Expanded(child:InkWell(child: Container( margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),alignment: Alignment.centerLeft,child: Text("تم",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold,color: Colors.red)),),onTap: (){
                      setState(() {
                        change = false;
                      });
                    },))
                   ]),
                 )),
                 Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.01 ,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,child : Row(children: [ Expanded(child: Directionality(textDirection: TextDirection.rtl, child:
                 Container(
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,border: Border.all(color: Colors.black12,width: 2)),width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                 ListTile(
                   title: DropdownButtonHideUnderline(
                       child: DropdownButton(
                         hint: Text("المحافظة" , style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),)
                         ,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),
                         value: region1
                         ,items: region1list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                         onChanged: (_) {
                           region1 =_;
                           setState(() {});
                         },
                       )),
                 ),),
                 )),Expanded(child:Directionality(textDirection: TextDirection.rtl, child:
                 Container(
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,border: Border.all(color: Colors.black12,width: 2)),width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                 ListTile(
                   title: DropdownButtonHideUnderline(
                       child: DropdownButton(
                         hint: Text("المدينة" , style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),)
                       ,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),
                         value: region2
                         ,items: region2list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                         onChanged: (_) {
                           region2 =_;
                           setState(() {});
                         },
                       )),
                 ),),
                 )),Expanded(child:Directionality(textDirection: TextDirection.rtl, child:
                 Container(
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,border: Border.all(color: Colors.black12,width: 2)),width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                 ListTile(
                   title: DropdownButtonHideUnderline(
                       child: DropdownButton(
                         hint: Text("المنطقة" , style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),)
                       ,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),
                         value: region3
                         ,items: region3list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                         onChanged: (_) {
                           region3 =_;
                           setState(() {});
                         },
                       )),
                 ),),
                 ))],)),
                   Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,left: MediaQuery.of(context).size.width*0.05),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(keyboardType: TextInputType.phone,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),textDirection: TextDirection.ltr, controller: phone,decoration: InputDecoration( hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),hintText: "رقم الجوال",border: InputBorder.none),),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black12,width: 2)),)
                 ,Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.01,top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,child : Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: address , textInputAction: TextInputAction.send,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),maxLines: 2,decoration: InputDecoration(hintText: "العنوان بالتفصيل",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),border: InputBorder.none),)),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black12,width: 2)),)),
               ],),),
             ),
             InkWell(onTap:(){
           shoppingcartlogic.makeorder(address.text ,phone.text,region1,region2,region3,region1back,region2back,region3back ,discount.text,totalprice);
               },
               child: Container( height: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft:Radius.circular(20) ),color:Color.fromRGBO(42, 171, 227, 1),),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child: Row(children: [
                 Expanded( flex: 2,child:InkWell(child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.1),borderRadius: BorderRadius.circular(20)),height: MediaQuery.of(context).size.height*0.1 ,child: Row(children:[ Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01,left:MediaQuery.of(context).size.width*0.02 ),child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: Text("اتمام الطلب",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),)))]),)) ),
                 Expanded(flex: 3,child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.01),child: FittedBox(
                   child: Column(children: [Text("المجموع",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*12),),
                       Directionality(textDirection: TextDirection.rtl,child: Text("ريال"+(int.parse(totalprice.toString()) - discountprice).toString(),style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*11),))
                     ]),
                 )))]),),
             )

           ],),)
              ],),
      ),
    ),);
  }
  plus(i ,num){
  //  data[i]["num"] = data[i]["num"]+1;
  //  computetotal(int.parse(data[i]["price"]) , true);
    setState(() {});
  }
  minus(i , num){
    if(num !=1){
     // data[i]["num"] = data[i]["num"]-1;
     // computetotal(int.parse(data[i]["price"]) , false);
      setState(() {});
    }
  }
  deleteall(){
  //  data.clear();
    setState(() {});
  }
  deleteindex(index){
  //  data.removeAt(index);
    setState(() {});
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  computetotal(price , plus){
    if(plus){
   //   total = total + price;
    }
    else{
    //  total = total - price;
    }
  }
}