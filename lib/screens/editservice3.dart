import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ezzproject/logic/addservice3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class AddServices3 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateaddservices3();
  }
}
class Stateaddservices3 extends State<AddServices3>{
  TextEditingController name ;
  TextEditingController detail ;
  TextEditingController price1 ;
  TextEditingController licence ;
  TextEditingController price2 ;
  TextEditingController id ;
  TextEditingController locationurl ;
  TextEditingController wcs ;
  TextEditingController numofroom ;
  TextEditingController fornum ;
  TextEditingController phone ;
  TextEditingController masaha ;
  TextEditingController name2 ;
  TextEditingController address ;
  TextEditingController ketchins ;
  TextEditingController numofroof ;
  GlobalKey<FormState> key ;
  var region1 = "المحافظة" ;
  var region2 = "المدينة" ;
  var region3 ="المنطقة";
  var type ="نوع المكان";
  List types =["نوع المكان"];
  List region1list =["المحافظة"];
  List region2list =["المدينة"];
  List region3list =["المنطقة"];
  List region1back =[];
  List region2back =[];
  List region3back =[];
  Addservice3logic addservice3logic;
  getdata()async{
    Future.delayed(Duration(seconds: 1) , ()async{
      var dataa = await addservice3logic.getplaces();
      print("gere");
      print(dataa);
      region1back = dataa["1"];
      region2back = dataa["2"];
      region3back = dataa["3"];
      for(int i =0 ; i<region1back.length ; i++){
        region1list.add(region1back[i]["name"].toString());
      }
      for(int a =0 ; a<region2back.length ; a++){
        region2list.add(region2back[a]["name"].toString());
      }
      for(int d =0 ; d<region3back.length ; d++){
        region3list.add(region3back[d]["name"].toString());
      }
      types.add("فيلا");
      setState(() {});
    });
  }
  @override
  void initState() {
    addservice3logic = new Addservice3logic(context);
    key = new GlobalKey<FormState>();
    name = new TextEditingController();
    detail = new TextEditingController();
    locationurl = new TextEditingController();
    numofroof = new TextEditingController();
    price1 = new TextEditingController();
    price2 = new TextEditingController();
    licence= new TextEditingController();
    id = new TextEditingController();
    phone = new TextEditingController();
    masaha = new TextEditingController();
    address= new TextEditingController();
    wcs = new TextEditingController();
    numofroom = new TextEditingController();
    fornum= new TextEditingController();
    ketchins= new TextEditingController();
    super.initState();
    getdata();
  }
  File image ;
  List images =[null,null,null,null,null];
  chooseimage(i)async{
    if(i == null) {
      var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image1 != null) {
        image = File(image1.path);
        setState(() {});
      }
    }
    else{
      var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image1 != null) {
        images[i] = File(image1.path);
        setState(() {});
      }
    }
  }
  List features =[
    false,false,false,false,false,false,false,false
  ];
  List selectservice =[];
  List data= ["dadwa","WDad"];
  var daa = "dadwa";
  var accept=false;
  navigateback(){
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
        child: ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,child :Stack(children: [
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(90),bottomLeft: Radius.circular(90))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("اضافة خدمة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*18),))),
                Expanded(child: Container())
              ],),),
            Positioned( bottom: MediaQuery.of(context).size.height*0.04,left: MediaQuery.of(context).size.width*0.4 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
          ],) ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container( decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.05 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1)
                ,child:ListTile(
                  title: DropdownButtonHideUnderline(
                      child: DropdownButton(hint: Text("نوع المكان",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),
                        style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13,color: Colors.black),
                        value: type
                        ,items: types.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                        onChanged: (_) {
                          type =_;
                          setState(() {});
                        },
                      )),
                )),
          )
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),child: TextFormField(
              validator: addservice3logic.validate,toolbarOptions: ToolbarOptions(
              copy: false,
              cut: false,
              paste: false,
              selectAll: false,
            ),controller: name,inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_]*$')),],style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "اسم المكان "),
            )),
          ),
          Container(child: Row(children: [
            Expanded(child: Directionality(textDirection: TextDirection.rtl,
              child: Container(height: MediaQuery.of(context).size.height*0.075, decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.05)
                  ,child:ListTile(
                    title: DropdownButtonHideUnderline(
                        child: Container(height: MediaQuery.of(context).size.height*0.1,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01),
                          child: DropdownButton(hint: Text("المنطقة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),),
                            style:TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black) ,
                            value: region2
                            ,items: region2list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                            onChanged: (_) {
                              region2 =_;
                              setState(() {});
                            },
                          ),
                        )),
                  )),
            )),Expanded(child: Directionality(textDirection: TextDirection.rtl,
              child: Container(height: MediaQuery.of(context).size.height*0.075, decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.1)
                  ,child:ListTile(
                    title: DropdownButtonHideUnderline(
                        child: Container(height: MediaQuery.of(context).size.height*0.1,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01),
                          child: DropdownButton(hint: Text("المدينة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),),
                            style:TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15,color: Colors.black) ,
                            value: region3
                            ,items: region3list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                            onChanged: (_) {
                              region3 =_;
                              setState(() {});
                            },
                          ),
                        )),
                  )),
            ))
          ],),),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),child: TextFormField(
              validator: addservice3logic.validate,controller: address,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),maxLines: 2,minLines: 2 ,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "العنوان بالتفصيل "),
            )),
          ),
          Container(child: Row(children: [
            Expanded(child: Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.05)
                  ,child:TextFormField(
                    validator: addservice3logic.validate,controller: numofroof,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "عدد الادوار"),
                  )),
            ))
            ,Expanded(child: Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.1)
                  ,child:TextFormField(
                    validator: addservice3logic.validate, controller: masaha,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "المساحة"),
                  )),
            )),
          ],),),
          Container(child: Row(children: [
            Expanded(child: Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.05)
                  ,child:TextFormField(
                    validator: addservice3logic.validate,controller: fornum,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "متاح لعدد"),
                  )),
            ))
            ,Expanded(child: Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.1)
                  ,child:TextFormField(
                    validator: addservice3logic.validate, controller: numofroom,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "عدد الغرف"),
                  )),
            )),
          ],),),
          Container(child: Row(children: [
            Expanded(child: Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) , decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.05)
                  ,child:TextFormField(
                    validator: addservice3logic.validate, controller: ketchins,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "عدد المطابخ"),
                  )),
            ) )
            ,Expanded(child:Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) , decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.1)
                  ,child:TextFormField(
                    validator: addservice3logic.validate,controller: wcs,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "عدد دورات المياه"),
                  )),
            )),
          ],),)
          ,Container(child: Divider(color: Colors.black54,),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,left:MediaQuery.of(context).size.width*0.1)),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.14,top:MediaQuery.of(context).size.height*0.001) ,child: Text("مميزات أخرى",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.022),),)
          ,Container(height: MediaQuery.of(context).size.height*0.05,child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[0]=val;});} ,value:features[0] ,title:Container( alignment: Alignment.centerRight,child: Text("يوجد حاجز",style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
            ,Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[1]=val;});} ,value:features[1] ,title:Container( alignment: Alignment.centerRight,child: Text("مسبح مفلتر",style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
          ],),),
          Container(height: MediaQuery.of(context).size.height*0.05,child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[2]=val;});} ,value:features[2] ,title:Container( alignment: Alignment.centerRight,child: Text("متاح للعوائل",style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
            ,Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[3]=val;});} ,value:features[3] ,title:Container( alignment: Alignment.centerRight,child: Text("متاح للشاب",style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
          ],),),
          Container(height: MediaQuery.of(context).size.height*0.05,child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[4]=val;});} ,value:features[4] ,title:Container( alignment: Alignment.centerRight,child: Text("توفر منطقة العاب",style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
            ,Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[5]=val;});} ,value:features[5] ,title:Container(alignment: Alignment.centerRight,child: Text("امكانية اقامة حفلات",style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
          ],),),
          Container(height: MediaQuery.of(context).size.height*0.05,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02),child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[6]=val;});} ,value:features[6] ,title:Container( alignment: Alignment.centerRight,child: Text("مساحات خضراء",style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
            ,Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[7]=val;});} ,value:features[7] ,title:Container( alignment: Alignment.centerRight,child: Text("خدمة فندقية",style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
          ],),)
          ,Container(child: Divider(color: Colors.black54,),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,left:MediaQuery.of(context).size.width*0.1))
          ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.height*0.01) ,child: Text("الأسعار",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.022),),)
          ,Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),child:Row(children: [
            Expanded(child: Container(alignment: Alignment.centerRight,child: Text("ريال",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)),
            Expanded(flex: 4,child: Directionality(textDirection: TextDirection.rtl,
              child: Container( padding:EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03,bottom:MediaQuery.of(context).size.height*0.015 ),decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(50)),margin: EdgeInsets.only( right: MediaQuery.of(context).size.width*0.03,left: MediaQuery.of(context).size.width*0.05 ),child: Center(
                child: TextFormField(
                  keyboardType: TextInputType.number,controller: price1,textDirection: TextDirection.ltr,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.blue),decoration: InputDecoration(border: InputBorder.none),
                ),
              )),
            ))
            ,Expanded(flex: 5,child: Container(alignment: Alignment.centerRight,child: Text("سعر التأجير في الأيام العادية",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*11),),))
          ],)),
          Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,right: MediaQuery.of(context).size.width*0.1),child:Row(children: [
            Expanded(child: Container(alignment: Alignment.centerRight,child: Text("ريال",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)),
            Expanded(flex: 4,child: Directionality(textDirection: TextDirection.rtl,
              child: Container( padding:EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03,bottom:MediaQuery.of(context).size.height*0.015 ),decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(50)),margin: EdgeInsets.only( right: MediaQuery.of(context).size.width*0.03,left: MediaQuery.of(context).size.width*0.05 ),child: Center(
                child: TextFormField(
                  keyboardType: TextInputType.number,controller: price2,textDirection: TextDirection.ltr,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.blue),decoration: InputDecoration(border: InputBorder.none),
                ),
              )),
            ))
            ,Expanded(flex: 5,child: Container(alignment: Alignment.centerRight,child: Text("سعر التأجير في نهاية الاسبوع",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*11),),))
          ],))

          ,Container(child: Divider(color: Colors.black54,),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,left:MediaQuery.of(context).size.width*0.1))
          ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.12,top:MediaQuery.of(context).size.height*0.001) ,child: Text("وصف المكان",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).textScaleFactor*15),),),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.1),child: TextFormField(
              validator: addservice3logic.validate,controller: detail,toolbarOptions: ToolbarOptions(
              copy: false,
              cut: false,
              paste: false,
              selectAll: false,
            ),inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_]*$')),],textInputAction: TextInputAction.send,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),minLines: 2,maxLines: 3 ,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),hintText: "وصف المكان "),
            )),
          )
          ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.height*0.01) ,child: Text("رفع صور للمكان",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).textScaleFactor*15),),)
          , InkWell(onTap: ()=>chooseimage(null),
            child: Container(height: MediaQuery.of(context).size.height*0.18 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.09,top: MediaQuery.of(context).size.height*0.02,right:MediaQuery.of(context).size.width*0.09 ),child:image != null?Container(
              child: Image( fit: BoxFit.fill,image: FileImage(image),),
            ) : DottedBorder(color: Colors.black.withOpacity(0.2),
              child: Center(child: Column(children: [
                Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon( Icons.cloud_upload,size: MediaQuery.of(context).size.height*0.07,)),
                Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Text("اضافة الصورة الرئيسية للمكان"),)
              ],),),
            ) ),
          ),
          Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01 ,left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),height: MediaQuery.of(context).size.height*0.09,child: Row(children: [
           Expanded(child:InkWell(onTap: ()=>chooseimage(0),
             child: Container(margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.01 ),child: images[0] != null?Container(
                child: Image( fit: BoxFit.fill,image: FileImage(images[0]),),
              ) : DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child: Icon(Icons.add,color: Colors.blue,)),),
              ) ),
            )),
            Expanded(child:InkWell(onTap: ()=>chooseimage(1),
              child: Container(margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.01 ),child: images[1] != null?Container(
                child: Image( fit: BoxFit.fill,image: FileImage(images[1]),),
              ) : DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,)),),
              ) ),
            )),
            Expanded(child:InkWell(onTap: ()=>chooseimage(2),
              child: Container(margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.01 ),child: images[2] != null?Container(
                child: Image( fit: BoxFit.fill,image: FileImage(images[2]),),
              ) : DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,),),),
              ) ),
            )),
            Expanded(child:InkWell(onTap: ()=>chooseimage(3),
              child: Container(margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.01 ),child: images[3] != null?Container(
                child: Image( fit: BoxFit.fill,image: FileImage(images[3]),),
             ) : DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child: Icon(Icons.add,color: Colors.blue,),),),
              ) ),
           )),
            Expanded(child:InkWell(onTap: ()=>chooseimage(4),
              child: Container(margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.01 ),child: images[4] != null?Container(
                child: Image( fit: BoxFit.fill,image: FileImage(images[4]),),
              ) : DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,),),),
              ) ),
           ))
          ],),),
         Container( margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child:Row(children:[ Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.12,top:MediaQuery.of(context).size.height*0.01) ,child: InkWell( onTap: ()async{
           if (await canLaunch("https://www.google.com/maps/")) {
           await launch("https://www.google.com/maps/");
           } else {
           throw 'Could not launch ';
           }
         },child: Text("للحصول علر رابط خاص",style: TextStyle(decoration: TextDecoration.underline,color: Colors.red,fontSize: MediaQuery.of(context).textScaleFactor*12),)),)) ,
           Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.12,top:MediaQuery.of(context).size.height*0.01) ,child: Text("رابط موقع المكان",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).textScaleFactor*15),),)) ])),
          Directionality(textDirection: TextDirection.rtl,
    child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.1),child: TextFormField(
    validator: addservice3logic.validate,controller: locationurl,textInputAction: TextInputAction.send,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),minLines: 2,maxLines: 3 ,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),hintText: "رابط المكان "),
    )),
    ),
          Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {accept=val;});} ,value:accept ,title:Container( alignment: Alignment.centerRight,child: Text("اقبل جميع الشروط والاحكام في هذا التطبيق",style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).textScaleFactor*12),)),),)
          ,InkWell(onTap:(){
            addservice3logic.addservice3(key, type.toString(), name.text, region2, region3, address.text, masaha.text, numofroof.text
                , numofroom.text, fornum.text, wcs.text, ketchins.text, price1.text, price2.text, detail.text, features, images, image, accept ,locationurl.text);},
            child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
              child:Text("اضافة", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.025)) ,),
          )

        ],),
      ),
    ),);
  }
}