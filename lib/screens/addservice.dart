import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ezzproject/logic/addservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddServices extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateaddservices();
  }
}
class Stateaddservices extends State<AddServices>{
  TextEditingController name ;
  TextEditingController detail ;
  TextEditingController price ;
  TextEditingController priceafter ;
  Addservicelogic addservicelogic;
  GlobalKey<FormState> key;
  @override
  void initState() {
    addservicelogic = new Addservicelogic(context);
    name = new TextEditingController();
    detail = new TextEditingController();
    key = new GlobalKey<FormState>();
    price = new TextEditingController();
    priceafter = new TextEditingController();
    super.initState();
  }
  File image ;
  chooseimage()async{
    var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image1 !=null){
      image =File( image1.path);
      setState(() {});
    }
  }
  List selectservice =[];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
        child: ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :Stack(children: [
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("اضافة خدمة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),))),
                Expanded(child: Container())
              ],),),
            Positioned( bottom: MediaQuery.of(context).size.height*0.04,left: MediaQuery.of(context).size.width*0.4 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
          ],) ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.height*0.05) ,child: Text("اضافة خدمة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),)
          , Container(height: MediaQuery.of(context).size.height*0.15 ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),child:image != null?Container(
            child: InkWell(onTap: ()=>chooseimage(), child: Image( fit: BoxFit.fill,image: FileImage(image),)),
          ) : DottedBorder(color: Colors.red.withOpacity(0.2),
            child: InkWell(onTap: ()=>chooseimage() ,
              child: Center(child: Column(children: [
                Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon( Icons.cloud_upload,size: MediaQuery.of(context).size.width*0.09,)),
                Container(child: Text("رفع صورة الخدمة"),)
              ],),),
            ),
          ) )
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              validator: addservicelogic.validate, controller: name,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),toolbarOptions: ToolbarOptions(
              copy: false,
              cut: false,
              paste: false,
              selectAll: false,
            ),inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_]*$')),],decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "اسم الخدمة "),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              validator: addservicelogic.validate, toolbarOptions: ToolbarOptions(
              copy: false,
              cut: false,
              paste: false,
              selectAll: false,
            ),controller: detail,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),minLines: 2,maxLines: 3 , keyboardType: TextInputType.text,inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_]*$')),],decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "تفاصيل "),
            )),
          ),
          Row(
            children:[ Expanded(
              child: Directionality(textDirection: TextDirection.rtl,
                child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
                  validator: addservicelogic.validate,keyboardType: TextInputType.number,controller: priceafter,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "السعر بعد الخصم"),
                )),
              ),
            ),
              Expanded(
                child: Directionality(textDirection: TextDirection.rtl,
                  child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
                    validator: addservicelogic.validate, keyboardType: TextInputType.number, controller: price,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "السعر"),
                  )),
                ),
              )],
          ),
          InkWell(onTap:()=> addservicelogic.addservicea(key,name.text, detail.text, price.text, priceafter.text, image),
            child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
              child:Text("اضافة", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.025)) ,),
          )

        ],),
      ),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}