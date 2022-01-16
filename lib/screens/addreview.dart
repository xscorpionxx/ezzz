import 'dart:convert';
import 'package:ezzproject/logic/addreview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class Addreview extends StatefulWidget{
  var name;
  var id;
  var photo;
  Addreview({this.id ,this.name,this.photo});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statereser(id:id,name: name,photo:photo);
  }
}
class Statereser extends State<Addreview>{
  Addreviewlogic addreviewlogic;
  var levelofstar =0 ;
  var id;
  var name;
  var photo;
  Statereser({this.id,this.name,this.photo});
  TextEditingController comment;
  GlobalKey<FormState> key;
  addstar(i){
    levelofstar = i+1;
    setState(() {

    });
  }
@override
  void initState() {
  comment = new TextEditingController();
  key = new GlobalKey();
  addreviewlogic = new Addreviewlogic(context);
    super.initState();
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: SingleChildScrollView(physics: ClampingScrollPhysics(),
      child: Form(key: key,
        child: Column(children: [
          Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03, left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.black,),onPressed: (){navigateback();},))),
            Expanded(flex: 7,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04) ,alignment: Alignment.center,child: Text("اضافة تقييم",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.04),))),
          ],),),
          Container(height: MediaQuery.of(context).size.height*0.1,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1,top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,child: Row(children: [
            Expanded(flex: 2,child: Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.16,alignment: Alignment.center,child:
          Column(children: [
            Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05) ,alignment: Alignment.centerRight,child: Text(name.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04),),),
            Directionality(textDirection: TextDirection.rtl,
              child: Container(width: MediaQuery.of(context).size.width*0.4,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),height: MediaQuery.of(context).size.width*0.08 ,alignment: Alignment.centerRight ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                if(levelofstar >i ){
                  return InkWell(onTap: ()=>addstar(i),child: Container(alignment: Alignment.centerRight ,child: Icon(Icons.star,color: Colors.yellow.withGreen(200),size: MediaQuery.of(context).size.width*0.08,)));
                }
                else{
                  return InkWell(onTap: ()=>addstar(i),child: Container(alignment: Alignment.centerRight ,child: Icon(Icons.star,color: Colors.black38,size: MediaQuery.of(context).size.width*0.08,)));
                }
              }),
              )),
            )
          ],),)),
            Expanded(child: Container( height: MediaQuery.of(context).size.height*0.1,child:
            Container(child:Image(image: NetworkImage(photo),fit: BoxFit.fill,))))],),),
          Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ),height: MediaQuery.of(context).size.height*0.06,
            child: Row(children: [ Expanded(flex: 1,child:Container(alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
              return Container(alignment: Alignment.center ,child: Icon(Icons.star,size: MediaQuery.of(context).size.height*0.04,));
            }),
            ))) ,Expanded(child:Container(alignment: Alignment.centerRight,child: Text("مستوى اللحوم ونضافتها",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),)),) ],),
          ),
          Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.035 ),height: MediaQuery.of(context).size.height*0.06,
            child: Row(children: [ Expanded(flex: 1,child:Container(alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
              return Container(alignment: Alignment.center ,child: Icon(Icons.star,size: MediaQuery.of(context).size.height*0.04));
            }),
            ))) ,Expanded(child:Container(alignment: Alignment.centerRight,child: Text("سرعة الاستجاية",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),)),) ],),
          ),
          Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.08 ),height: MediaQuery.of(context).size.height*0.06,
            child: Row(children: [ Expanded(flex: 1,child:Container(alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
              return Container(alignment: Alignment.center ,child: Icon(Icons.star,size: MediaQuery.of(context).size.height*0.04,));
            }),
            ))) ,Expanded(child:Container(alignment: Alignment.centerRight,child: Text("وقت الوصول",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),)),) ],),
          ),
    Container(padding:EdgeInsets.all(MediaQuery.of(context).size.width*0.01)  ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05)
        ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.black26)),height: MediaQuery.of(context).size.height*0.2,child: Directionality(textDirection: TextDirection.rtl,
          child: TextFormField(validator: validate,controller: comment,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26),maxLines: 5,minLines: 4,decoration: InputDecoration(hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26) ,hintText: "أضف تعليق",border: InputBorder.none),)),)
    ,InkWell(onTap: ()=>addreviewlogic.send(id.toString(), comment.text, key, levelofstar.toString()),child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.width*0.08,left:MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),
            child:Text("اضافة تقييمك", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045)) ,))
        ],),
      ),),);
  }
  String validate(String value){
    if (value.isEmpty) {
      return 'لا يمكن أن تبقي الحقل فارغ';
    }
    return null;
  }
}