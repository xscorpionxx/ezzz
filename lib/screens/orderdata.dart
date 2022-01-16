import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Orderdata extends StatefulWidget {
  var id;
  var data ;
  Orderdata({this.id ,this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateorderdata(id: id ,data :data);
  }
}
class Stateorderdata extends State<Orderdata> {
  var id;
  var data ;
  List details = [];
  Stateorderdata({this.id , this.data});
  getdata(id)async{
    var url = "https://azz.sla-request.com/api/order_details/"+id.toString();
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    var token = sharedPreferences.getString("token");
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    var body = jsonDecode(response.body);
    if( body["status"] ==true){
      print(body["details"]);
      details = body["details"];
      setState(() {});
    }
  }
   @override
  void initState() {
    print(data);
     getdata(id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement buildr;
    return  Scaffold(body:
    Container(
      child:ListView(
        children:[
          Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Row(children: [
            Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.clear,size: MediaQuery.of(context).size.height*0.03,color: Colors.black,),onPressed: (){Navigator.of(context).pop();},))),
            Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),child: Text("بيانات الطلب ",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.025),))),
          ],),),
          Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ,right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.02) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Text(data["OrderCode"].toString(),style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.02)))),
          Expanded(child:Container(alignment: Alignment.centerRight ,child: Text("رقم الطلب",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),))),]),),
          Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ,right: MediaQuery.of(context).size.width*0.08) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Text(data["Type"],style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.02)))),
            Expanded(child:Container(alignment: Alignment.centerRight ,child: Text("نوع الخدمة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),))),]),),
          Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ,right: MediaQuery.of(context).size.width*0.09) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Text(data["StoreName"],style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.02)))),
            Expanded(child:Container(alignment: Alignment.centerRight ,child: Text("اسم التاجر",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),))),]),),
          Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ,right: MediaQuery.of(context).size.width*0.09) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Text(data["OrderDate"].toString(),style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.02)))),
            Expanded(child:Container(alignment: Alignment.centerRight ,child: Text("تاريخ الطلب",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),))),]),),
          Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ,right: MediaQuery.of(context).size.width*0.09) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Text("",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.02)))),
            Expanded(child:Container(alignment: Alignment.centerRight ,child: Text("كوبون الخصم",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),))),]),)
          ,Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.025) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.07,right:MediaQuery.of(context).size.width*0.07 ) ,decoration: BoxDecoration(border: Border.all(color: Colors.black54)),child: Row(children: [
            Expanded(child: Container(alignment: Alignment.center ,child: Text(data["Address"],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015)),)),
            Expanded(child: Container(alignment: Alignment.centerRight ,child: Text("العنوان",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.blue)),)),
          ],),),
          Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03) ,child: Directionality(textDirection: TextDirection.rtl,child: ListTile(leading: Icon(Icons.location_on_rounded,color: Colors.blue,) ,title: Text("مشاهدة الخريطة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02)),)),),
          Container(height: MediaQuery.of(context).size.height*0.25,child: ListView.builder(itemCount: details.length ,itemBuilder: (context,i){
            return Container(decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
             margin: EdgeInsets.only( top: MediaQuery.of(context).size.height*0.01,left:MediaQuery.of(context).size.width*0.05 ,right: MediaQuery.of(context).size.width*0.05) ,child: Row(children: [
              Expanded(child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02),child: Directionality(textDirection: TextDirection.rtl,child: Text(details[i]["SalePrice"].toString() + 'ريال',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.blue))),) ),
              Expanded(flex: 2,child:Container(alignment: Alignment.centerRight,child: Column(children: [
                Container(child: Text(details[i]["Name"],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02)),),
                Directionality(textDirection: TextDirection.rtl,child: Container(child: Text("العدد :" +"-",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.02)),))
              ],),) ),
              Expanded(child:Container(width: MediaQuery.of(context).size.width*0.1,height: MediaQuery.of(context).size.height*0.1,child: Image(fit: BoxFit.fill,image: NetworkImage(details[i]["Photo"]),),) )
            ],),);
          }),),
           Container( height: MediaQuery.of(context).size.height*0.32,decoration: BoxDecoration(border: Border.all(color: Colors.black54)),margin: EdgeInsets.only( bottom:MediaQuery.of(context).size.height*0.1 ,top: MediaQuery.of(context).size.height*0.01,left:MediaQuery.of(context).size.width*0.05 ,right: MediaQuery.of(context).size.width*0.05)
           ,child: Column(children: [
               Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.1),child: Text("بيانات الطلب ",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.022),))
               ,Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Row(children: [
                 Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child:Text(data["Amount"].toString()+"ريال",style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.height*0.022),))),
                 Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),child: Text("بيانات الطلب ",style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.height*0.022),))),
               ],),),
               Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Row(children: [
                 Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child:Text("-",style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.height*0.022),) )),
                 Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08),child: Text("كوبون الخصم",style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.height*0.022),))),
               ],),),
               Divider(color: Colors.black54,),
               Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Row(children: [
                 Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: Text(data["Amount"].toString()+"ريال",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.022),))),
                 Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),child: Text("الاجمالي ",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.022),))),
               ],),)
             ],),)

          ,],
      ),
    ));
  }
}