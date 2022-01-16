import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/profile.dart';
import 'package:ezzproject/screens/changepassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile2 extends StatefulWidget{
  var dataprofile;
  Profile2({this.dataprofile});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateprofile2(dataprofile:dataprofile);
  }
}
class Stateprofile2 extends State<Profile2>{
  TextEditingController name;
  TextEditingController id;
  GlobalKey<FormState> key ;
  var dataprofile;
  Stateprofile2({this.dataprofile});
  TextEditingController storename;
  TextEditingController phone;
  TextEditingController email;
  TextEditingController timeedit1;
  TextEditingController timeedit2;
  TextEditingController password;
  Profilelogic profilelogic;
  List region1list =[];
  List region2list =[];
  List region3list =[];
  List region1back =[];
  List region2back =[];
  List region3back =[];
  var value1 = "";
  var value2 ="";
  var value3 = "";
  var valuetime1 = "صباحا";
  var valuetime2 = "مساءا";
  List times1 =["مساءا" ,"صباحا"];
  List times2 =["مساءا" ,"صباحا"];
  var typevalue;
  List typelist =[];
  List subtypelist = [];
  List subtypevalues=[];
  var subtypevalue ;
  var photostroe;
  var photoprofile;
  changevaluetype(ind){
    print(subtypevalues);
    setState(() {
      subtypelist = subtypevalues[ind][(ind + 1).toString()];
    });
  }
  getdata()async{
    var data = await profilelogic.getdata22();
    print(data);
    region1back = data["listre1"];
    region2back = data["listre2"];
    region3back = data["listre3"];
    for(int i =0 ; i<region1back.length ; i++){
      region1list.add(region1back[i]["name"].toString());
    }
    for(int a =0 ; a<region2back.length ; a++){
      region2list.add(region2back[a]["name"].toString());
    }
    for(int d =0 ; d<region3back.length ; d++){
      region3list.add(region3back[d]["name"].toString());
    }
    typelist = data["cat"];

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    value1  =dataprofile["Governorate"];
    value2 = dataprofile["City"];
    value3 = dataprofile["Region"];
    name.text = dataprofile["Name"];
    phone.text = dataprofile["PhoneNumber"];
    email.text = dataprofile["Email"];
    password.text = sharedPreferences.getString("password");
    id.text = dataprofile["StoreNationalNumber"];
    photoprofile = dataprofile["ProfilePhoto"];
    photostroe = dataprofile["StorePhoto"];
    typevalue = dataprofile["StoreCat"];
    subtypevalue = dataprofile["StoreSubCat"];
    subtypevalues = data["subcats"];
    changevaluetype(typelist.indexOf(typevalue));
    storename.text = dataprofile["Store"];
    setState(() {});
  }
  @override
  void initState() {
    key = new GlobalKey<FormState>();
    print(dataprofile);
    profilelogic = new Profilelogic(context);
    getdata();
    name = new TextEditingController();
    id = new TextEditingController();
    storename = new TextEditingController();
    phone = new TextEditingController();
    email = new TextEditingController();
    password = new TextEditingController();
    timeedit1 = new TextEditingController();
    timeedit2 = new TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Form(key: key,
      child: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
        child: ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
            decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child:
            Container(child: Stack(
              children: [
                Positioned( bottom: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.2) , borderRadius: BorderRadius.circular(1000)),),)
                ,Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Row(children: [
                    Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                    Expanded(flex: 5,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.15),alignment: Alignment.center,child: Text("الملف الشخصي",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                    ],),
                ),],
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,right: MediaQuery.of(context).size.width*0.05),child: Text("اسم المستخدم",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
                BoxShadow(
                color: Colors.black26,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0))// shadow direction: bottom right
                ]),margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              controller: name,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "اسم المستخدم"),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("اسم المتجر",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              controller: storename,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "اسم المتجر"),
            )),
          ),
         // Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("الهوية الوطنية",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
         // ,Directionality(textDirection: TextDirection.rtl,
         //   child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
          //    BoxShadow(
            //      color: Colors.black26,
              //    blurRadius: 1.0,
                //  spreadRadius: 0.0,
                  //offset: Offset(2.0, 2.0))// shadow direction: bottom right
        //    ]),margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
            //  controller: id,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "الهوية الوطنية"),
          //  )),
          //),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.07),child: Text("رقم الجوال",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),),
          Directionality(textDirection: TextDirection.ltr, child: Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
              color: Colors.black26,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )]),width: MediaQuery.of(context).size.width*0.7,
            child: Row(
              children:[Expanded(child: FittedBox(
                child: Container(height: MediaQuery.of(context).size.height*0.068,decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:Radius.circular(10) )) ,child: Row(children: [
                  Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03) ,width:MediaQuery.of(context).size.width*0.08,height: MediaQuery.of(context).size.height*0.035,child: Image(fit: BoxFit.fill,image: AssetImage("images/flagicon.jpg"),),),
                  Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),child: Text("+966",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.015),),)
                ]),),
              )) ,Expanded(flex: 3,
                child: Directionality(textDirection: TextDirection.rtl,
                  child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),keyboardType: TextInputType.phone,controller: phone ,decoration: InputDecoration(hintText: "رقم الجوال",border: InputBorder.none),),),
                ),
              )],
            ),
          )),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08,top: MediaQuery.of(context).size.height*0.01),child: Text("البريد الالكتروني",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              controller: email,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "البريد الالكتروني"),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("صورة المتجر",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),),
          Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ),height: MediaQuery.of(context).size.height*0.2 ,child:newphoto ==null?
             photostroe ==null?Container(): InkWell(onTap: (){chooseimage();},child: Image(fit: BoxFit.fill,image: NetworkImage(photostroe),)) :  InkWell(onTap: (){chooseimage();},child: Image(fit: BoxFit.fill,image: FileImage(newphoto),)) ,),
          //Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("تصنيف المتجر",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          Container(
            child:true?Container(): Directionality(textDirection: TextDirection.rtl,
              child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0))// shadow direction: bottom right
                ]),margin: EdgeInsets.only( right: MediaQuery.of(context).size.width*0.05,left : MediaQuery.of(context).size.width*0.05),child: ListTile(
                title: DropdownButtonHideUnderline(
                    child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),
                      value: typevalue
                      ,items: typelist.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                      onChanged: (_) {
                        typevalue =_;
                        changevaluetype(typelist.indexOf(typevalue));
                        subtypevalue = null;
                        setState(() {});
                      },
                    )),
              )),
            ),
          ),  //Container(child:subtypelist.length==0?Container(): Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("تصنيف المخصص",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)),
          Container(
            child:true?Container(): Container(
              child:subtypelist.length ==0?Container(): Directionality(textDirection: TextDirection.rtl,
                child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0))// shadow direction: bottom right
                ]),margin: EdgeInsets.only( right: MediaQuery.of(context).size.width*0.05,left : MediaQuery.of(context).size.width*0.05),child: ListTile(
                  title: DropdownButtonHideUnderline(
                      child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),
                        hint: Text("اختر التصنيف تحت الفئة")
                        ,value: subtypevalue
                        ,items: subtypelist.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                        onChanged: (_) {
                          subtypevalue =_;
                          setState(() {});
                        },
                      )),
                )),
              ),
            ),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),child: Text("مواعيد العمل",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
           ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right:MediaQuery.of(context).size.width*0.01 ) ,child: Row(children: [
           Expanded(child:  Directionality(textDirection: TextDirection.ltr, child: Container(
             margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03,left:MediaQuery.of(context).size.width*0.03),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
            color: Colors.black26,
            blurRadius: 1.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )]),width: MediaQuery.of(context).size.width*0.4,
             child: Row(
               children:[Expanded(flex: 2,child:  Directionality(textDirection: TextDirection.rtl,
            child: Container(
              child: FittedBox(child: DropdownButtonHideUnderline(
                  child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),
                    value: valuetime2
                    ,items: times2.map((e) => DropdownMenuItem(child: FittedBox(child: AutoSizeText('$e',maxLines: 1,)),value: e,)).toList(),
                    onChanged: (_) {
                       valuetime2 =_;
                      setState(() {});
                    },
                  ))),
            ),
          )),Expanded(child: Container(child: VerticalDivider(thickness: 2,),width: 20,height: MediaQuery.of(context).size.height*0.05,)),Expanded(flex: 3,
                 child: Directionality(textDirection: TextDirection.rtl,
                   child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField( maxLength: 2,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),validator: profilelogic.validate,keyboardType: TextInputType.number,controller: timeedit2 ,decoration: InputDecoration(hintText: "انتهاءا ب",border: InputBorder.none),),),
                 ),
               )],
             ),
           ))), Expanded(child:  Directionality(textDirection: TextDirection.ltr, child: Container(
              margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03,left:MediaQuery.of(context).size.width*0.03),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                color: Colors.black26,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )]),width: MediaQuery.of(context).size.width*0.4,
              child: Row(
                children:[ Expanded(flex: 2,child:  Directionality(textDirection: TextDirection.rtl,
                    child: Container(
                      child:  FittedBox(
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),
                              value: valuetime1
                              ,items: times1.map((e) => DropdownMenuItem(child:FittedBox(child: AutoSizeText('$e',maxLines: 1,)),value: e,)).toList(),
                              onChanged: (_) {
                                valuetime1 =_;
                                setState(() {});
                              },
                            )),
                      ),
                    ),
                  )),
                Expanded(child: Container(child: VerticalDivider(thickness: 2,),width: 20,height: MediaQuery.of(context).size.height*0.05,)),Expanded(flex: 3,
                  child: Directionality(textDirection: TextDirection.rtl,
                    child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(maxLength: 2,validator: profilelogic.validate,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),keyboardType: TextInputType.number,controller: timeedit1 ,decoration: InputDecoration(hintText: "ابتداء من",border: InputBorder.none),),),
                  ),
                )],
              ),
            )))
          ],),)
          ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("المحافظة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.05 ,left : MediaQuery.of(context).size.width*0.05),child: ListTile(
              title: DropdownButtonHideUnderline(
                  child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),
                    value: value1
                    ,items: region1list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                    onChanged: (_) {
                       value1 =_;
                      setState(() {});
                    },
                  )),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("المدينة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.05 ,left : MediaQuery.of(context).size.width*0.05),child: ListTile(
              title: DropdownButtonHideUnderline(
                  child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),
                    value: value2
                    ,items: region2list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                    onChanged: (_) {
                       value2 =_;
                      setState(() {});
                    },
                  )),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("المنطقة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),)
         , Directionality(textDirection: TextDirection.rtl,
            child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5),boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0))// shadow direction: bottom right
            ]),margin: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.05 ,left : MediaQuery.of(context).size.width*0.05),child: ListTile(
              title: DropdownButtonHideUnderline(
                  child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),
                    value: value3
                    ,items: region3list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                    onChanged: (_) {
                       value3 =_;
                      setState(() {});
                    },
                  )),
            )),
          ),
         // Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),child: Text("كلمة المرور",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black45),),),
          Container(
            child:true?Container(): Directionality(textDirection: TextDirection.ltr, child: Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                color: Colors.black26,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )]),width: MediaQuery.of(context).size.width*0.7,
              child: Row(
                children:[Expanded(child: InkWell(onTap: changepass,child: Container(height: MediaQuery.of(context).size.height*0.08,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:Radius.circular(10) )) ,child: Center(child: Text("تغيير",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.white),),),))) ,Expanded(flex: 3,
                  child: Directionality(textDirection: TextDirection.rtl,
                    child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),controller: password ,obscureText: true,decoration: InputDecoration(hintText: "",border: InputBorder.none),),),
                  ),
                )],
              ),
            )),
          ),InkWell(onTap: (){profilelogic.update2(id.text,key,name.text, phone.text, email.text,
              storename.text, typevalue, subtypevalue, value1, value2, value3,newphoto , valuetime1.toString() , timeedit1.text,valuetime2.toString() , timeedit2.text.toString());
          },child:
          Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
            child:Text("حفظ ", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045)) ,))
        ],),
      ),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  deleteimage(){

  }
  var newphoto;
  chooseimage()async{
    var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image1 !=null){
      newphoto =File( image1.path);
      setState(() {});
    }
  }
  changepass(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Changepass();
    }));
  }
}