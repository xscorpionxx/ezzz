import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'notification.dart';

class Reservation extends StatefulWidget{
  var price;
  var id;
  Reservation({this.price,this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statereser(price: price,id: id);
  }
}
class Statereser extends State<Reservation>{
  TextEditingController babiesnum;
  TextEditingController adultnum;
  TextEditingController discount;
  var price;
  var id;
  Statereser({this.price,this.id});
  var dateable1 = false;
  Shoppingcartlogic shoppingcartlogic;
  var dateable2 = false;
  var date1 ;
  var date2;
  var discountre;
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  @override
  void initState() {
    print(price);
    shoppingcartlogic = new Shoppingcartlogic(context);
    babiesnum = new TextEditingController();
    adultnum = new TextEditingController();
    discount = new TextEditingController();
    super.initState();
  }
  var value = false;
  @override
  Widget build(BuildContext context) {
    discountre = Provider.of<Notifires>(context).discointres;
    // TODO: implement build
    return Scaffold(body: SingleChildScrollView(physics: ClampingScrollPhysics(),
    child: Column(children: [
      Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child: Row(children: [
        Expanded(child: Container(alignment: Alignment.centerLeft ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.black,),onPressed: (){Navigator.of(context).pop();},))),
        Expanded(flex: 2,child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),child: Text("طلب الحجز ",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.04),))),
      ],),),
      Container( child:!dateable1?Container():  Container(width: MediaQuery.of(context).size.width,child: CalendarDatePicker(firstDate: DateTime.now().subtract(Duration(days: 365)) ,lastDate:DateTime.now().add(Duration(days: 356))  ,currentDate: DateTime.now(),initialDate:DateTime.now(), onDateChanged: (val){
        setState(() {
          date1 = val.toString().substring(0,10);
        });
      },),)),
      Container( child:!dateable2?Container():  Container(width: MediaQuery.of(context).size.width,child: CalendarDatePicker(firstDate: DateTime.now().subtract(Duration(days: 365)) ,lastDate:DateTime.now().add(Duration(days: 356))  ,currentDate: DateTime.now(),initialDate:DateTime.now(), onDateChanged: (val){
        setState(() {
          date2 = val.toString().substring(0,10);
        });
      },),)),
      Container(child:dateable2||dateable1? Container( margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.2,right:MediaQuery.of(context).size.width*0.2 ),child:InkWell( onTap: (){
        dateable1 = false;
        dateable2 =false ;
        setState(() {});
      },child: Container( padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),color: Color.fromRGBO(69, 190, 0, 1) ,child: Center(child: Text("تم" ,style: TextStyle(color: Colors.white),)))),):Container())
      ,Container(
        child:dateable1||dateable2?Container(): Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,child: Row(children: [Expanded(child: Container( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.08,alignment: Alignment.center,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black12.withOpacity(0.1)),child:
          InkWell(onTap: (){
            setState(() {
              dateable2 = true;
            });
          },
            child: ListTile(trailing:Transform.translate(
              offset: Offset(-8, 0),
              child: Container(width: MediaQuery.of(context).size.width*0.06,height: MediaQuery.of(context).size.height*0.07 ,child : Image(image: AssetImage("images/calendarazz.png"),fit: BoxFit.scaleDown,)),
            ) ,title:  Text(date2 ==null? 'تاريخ المغادرة':date2,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38))),
          ),)),
          Expanded(child: Container( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.08,alignment: Alignment.center,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black12.withOpacity(0.1)),child:
          InkWell(onTap: (){
            setState(() {
              dateable1 = true;
            });
          },
            child: ListTile(trailing:Transform.translate(
              offset: Offset(-8, 0),
              child: Container(width: MediaQuery.of(context).size.width*0.06,height: MediaQuery.of(context).size.height*0.07 ,child : Image(image: AssetImage("images/calendarazz.png"),fit: BoxFit.scaleDown,)),
            ) ,title:  Text(date1==null? 'تاريخ الوصول':date1.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38))),
          ),))],),),
      ),
      Container(
        child:dateable1||dateable2?Container(): Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,child: Row(children: [Expanded(child:Container( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.08,alignment: Alignment.center,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black12.withOpacity(0.1)),child:
        ListTile(trailing:Transform.translate(
          offset: Offset(-8, 0),
          child: Container(width: MediaQuery.of(context).size.width*0.06,height: MediaQuery.of(context).size.height*0.07 ,child : Image(image: AssetImage("images/babyazz.png"),fit: BoxFit.scaleDown,)),
        ) ,title:TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.blue),keyboardType: TextInputType.number,controller: babiesnum,decoration: InputDecoration(border: InputBorder.none,hintText: "عدد الأطفال",hintStyle:TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38) ),)),)),
          Expanded(child: Container( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.08,alignment: Alignment.center,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black12.withOpacity(0.1)),child:
          ListTile(trailing:Transform.translate(
            offset: Offset(-8, 0),
            child: Container( child : Icon(Icons.people_alt,color: Colors.black12,)),
          ) ,title:  TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.blue),keyboardType: TextInputType.number,controller: adultnum,decoration: InputDecoration(border: InputBorder.none,hintText: "عدد البالغين",hintStyle:TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38) ),)),))],),),
      ),
      Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.05) ,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black26,width: 2) ,color: Colors.white,borderRadius: BorderRadius.circular(20)),child: Row(children: [
        Expanded(child: InkWell(onTap: ()=>shoppingcartlogic.addpromocodere(discount.text.toString(), price.toString()),child: Container(height: MediaQuery.of(context).size.height*0.06,width: MediaQuery.of(context).size.width*0.25,alignment: Alignment.center,child: Text("تطبيق",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),),decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20)),)))
        ,Expanded(flex: 3,child: Container(child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: discount,decoration: InputDecoration( hintText: "قسيمة الخصم",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),border: InputBorder.none),))))]),),
      Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05 ,right: MediaQuery.of(context).size.width*0.1,left: MediaQuery.of(context).size.width*0.1) ,child: Text("الدفع",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05),),),
      Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1)
        ,child: Row(children: [ Expanded(child:Container(child: Text(price.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
          Expanded(child:Container(alignment: Alignment.centerRight ,child: Text("سعر الليلة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),],),)
      ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1)
        ,child: Row(children: [ Expanded(child:Container(child: Text(discountre.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
          Expanded(child:Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerRight ,child: Text("خصم",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),],),),
     // Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1)
       // ,child: Row(children: [ Expanded(child:Container(child: Text("200",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
       //   Expanded(child:Container(alignment: Alignment.centerRight ,child: Text("ضريبة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),],),),
      Container(margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.01 ,right: MediaQuery.of(context).size.width*0.1,left: MediaQuery.of(context).size.width*0.4),child: Divider(thickness: 1.1,color: Colors.black,),),
      Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1)
        ,child: Row(children: [ Expanded(child:Container(child: Text((int.parse(price.toString()) - int.parse(discountre.toString())).toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
          Expanded(child:Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) ,alignment: Alignment.centerRight ,child: Text("الاجمالي",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black),))),],),),
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03 ,right: MediaQuery.of(context).size.width*0.05),child: CheckboxListTile(activeColor: Colors.green ,value: value,onChanged: (val){setState(() {
        value = val;
      });},title:Transform.translate(
    offset: const Offset(150, 0),
    child: Container(alignment: Alignment.centerRight ,child:Row(children:[ Text(" الشروط والأحكام" , style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.red,decoration: TextDecoration.underline),),Text("أوافق على",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,),),])),
    ) ),),
      InkWell(onTap: (){
        shoppingcartlogic.reservation(date1, date2, value, discount.text, id, babiesnum.text, adultnum.text);
      },
        child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
        child:Text("ارسال الطلب", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04)) ,),
      )
    ],),),);
  }
}
