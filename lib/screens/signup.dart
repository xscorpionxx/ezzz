import 'dart:io';

import 'package:ezzproject/logic/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statesign();
  }
}
class Statesign extends State<Signup>{
  var type ;
  TextEditingController name ;
  TextEditingController storename ;
  TextEditingController id ;
  TextEditingController phone ;
  TextEditingController email ;
  TextEditingController password ;
  TextEditingController repassword ;
  GlobalKey<FormState> key;
  Signuplogic signuplogic;
  var region1 = "المحافظة" ;
  var region2 = "المدينة" ;
  var region3 ="المنطقة";
  List region1list =["المحافظة"];
  List region2list =["المدينة"];
  var cat  ;
  var subcat;
  List cats  =[];
  List subcats =[];
  List region3list =["المنطقة"];
  List region1back =[];
  List region2back =[];
  List region3back =[];
  File photo;
  List subtypevalues = [];
  List subtypelist =[];
  var subtypevalue;
  chooseimage()async{
    var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image1 !=null){
      photo =File( image1.path);
      setState(() {});
    }
  }
  changevaluetype(ind){
    print(subtypevalues);
    setState(() {
      subtypelist = subtypevalues[ind][(ind + 1).toString()];
    });
  }
  getdata()async{
    var dataa = await signuplogic.getplaces();
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
    cats = dataa["cat"];
    subtypevalues = dataa["subcats"];
    print(subtypevalues);
    print("awda");
    print(cats);
    setState(() {});
    }
  @override
  void initState() {
    signuplogic = new Signuplogic(context);
    getdata();
    key = new GlobalKey<FormState>();
    name = new TextEditingController();
    storename = new TextEditingController();
    id = new TextEditingController();
    phone = new TextEditingController();
    email = new TextEditingController();
    password = new TextEditingController();
    repassword = new TextEditingController();
    type =false;
    print(type);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Form(key: key,
      child: Container(color: Colors.greenAccent.withOpacity(0.5),width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
        child:  Stack(children: [
          Positioned(bottom: MediaQuery.of(context).size.height*0.6,left: MediaQuery.of(context).size.width*0.4,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(300),color: Colors.blueAccent.withOpacity(0.3)),width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.width,)),
          Positioned(top: MediaQuery.of(context).size.height*0.03,child: Container(child: IconButton(onPressed:(){
            signuplogic.navigate();
          },icon: Icon(Icons.chevron_left_outlined,size: MediaQuery.of(context).size.height*0.05,),),))
          ,Positioned(top: MediaQuery.of(context).size.height*0.05,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(200),topLeft: Radius.circular(200)),color: Colors.white.withOpacity(0.95)),height: MediaQuery.of(context).size.height*0.4,width: MediaQuery.of(context).size.width,
            child:  Column(children: [
              Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),width: MediaQuery.of(context).size.width*0.15,height:MediaQuery.of(context).size.height*0.1 ,child: Image(image: AssetImage("images/logoaz.png"),),),
              Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Text("اشتراك جديد",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),),)
            ],)
          )),
          Positioned(top: MediaQuery.of(context).size.height*0.3,child: Container(decoration: BoxDecoration( boxShadow: [ BoxShadow(
            color: Colors.black,
            blurRadius: 1.0,
            spreadRadius: 0.0,
            offset: Offset(0.5, 0.5), // shadow direction: bottom right
          )],borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),height: MediaQuery.of(context).size.height*0.7,width: MediaQuery.of(context).size.width,
              child:  SingleChildScrollView(
                child: Column(children: [
                  Container(child: Row(children: [Expanded(child:type?  Container(decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))),height: MediaQuery.of(context).size.height*0.07,child:Center(child: Text("تاجر",style: TextStyle(color: Colors.black),)),):InkWell(onTap: (){type= true ; setState(() {});},child: Container(decoration:BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))),height: MediaQuery.of(context).size.height*0.07,child:Center(child: Text("تاجر",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),)),)))
                    ,Expanded(child:!type?Container(decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20))),height: MediaQuery.of(context).size.height*0.07 ,child:Center(child: Text("مستخدم",style: TextStyle(color: Colors.black))),): InkWell(onTap: (){type = false; setState(() {});},child: Container(decoration:BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20))),height: MediaQuery.of(context).size.height*0.07 ,child:Center(child: Text("مستخدم",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),)),) ))],),)
                  ,Directionality(textDirection: TextDirection.rtl, child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                    color: Colors.black38,
                    blurRadius: 1.0,
                    spreadRadius: 0.0,
                    offset: Offset(0.5, 0.5), // shadow direction: bottom right
                  )]),width: MediaQuery.of(context).size.width*0.9,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(controller: name,validator: signuplogic.validatename ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),decoration: InputDecoration(hintText: "اسم المستخدم",border: InputBorder.none),),)),
                  Directionality(textDirection: TextDirection.rtl, child:!type? Container():  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                        color: Colors.black38,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.5, 0.5), // shadow direction: bottom right
                      )]),width: MediaQuery.of(context).size.width*0.9,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(controller: storename,validator: signuplogic.validatename ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),decoration: InputDecoration(hintText: "اسم المتجر",border: InputBorder.none),),),
                  ),
                  Directionality(textDirection: TextDirection.rtl, child:!type?Container(): Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                      color: Colors.black38,
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.5, 0.5), // shadow direction: bottom right
                    )]),width: MediaQuery.of(context).size.width*0.9,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(keyboardType: TextInputType.number,controller: id,validator: signuplogic.validatename ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),decoration: InputDecoration(hintText: "الهوية الوطنية",border: InputBorder.none),),)),
                  Directionality(textDirection: TextDirection.ltr, child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                        color: Colors.black38,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.5, 0.5), // shadow direction: bottom right
                      )]),width: MediaQuery.of(context).size.width*0.9,
                    child: Row(
                      children:[Expanded(child: Container(height: MediaQuery.of(context).size.height*0.085,decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:Radius.circular(10) )) ,child: Row(children: [
                        Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01) ,width:MediaQuery.of(context).size.width*0.08,height: MediaQuery.of(context).size.height*0.03,child: Image(fit: BoxFit.fill,image: AssetImage("images/flagicon.jpg"),),),
                        Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),child: Text("+966",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),)
                      ]),)) ,Expanded(flex: 3,
                        child: Directionality(textDirection: TextDirection.rtl,
                          child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),keyboardType: TextInputType.phone,controller: phone,validator: signuplogic.validateMobile ,decoration: InputDecoration(hintText: "رقم الجوال",border: InputBorder.none),),),
                        ),
                      )],
                    ),
                  ))
                  ,Directionality(textDirection: TextDirection.rtl, child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                      color: Colors.black38,
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.5, 0.5), // shadow direction: bottom right
                    )]),width: MediaQuery.of(context).size.width*0.9,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),controller: email,validator: signuplogic.validateemail ,decoration: InputDecoration(hintText: "البريد الالكتروني",border: InputBorder.none),),)),
                  Container(
                    child:!type?Container(): Container(width: MediaQuery.of(context).size.width*0.9,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                        color: Colors.black38,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.5, 0.5), // shadow direction: bottom right
                      )]),child: Column(children: [
                        InkWell(onTap: () =>chooseimage()
                        ,child: Container(child: Center(child:photo == null? Image(image: AssetImage("images/emptyphoto.png"),):Image(image: FileImage(photo)) ,),)),
                        Container(child: Center(child: Text("صورة المتجر",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02)),),)
                      ],),),
                  )
                  ,Directionality(textDirection: TextDirection.rtl, child: InkWell(
                    child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                        color: Colors.black38,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.5, 0.5), // shadow direction: bottom right
                      )]),width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                        ListTile(
                          title: DropdownButtonHideUnderline(
                              child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017,color: Colors.black),
                                 value: region1
                                 ,items: region1list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                                onChanged: (_) {
                                   region1 =_;
                                  setState(() {});
                                },
                              )),
                        )),
                  )),
                  Directionality(textDirection: TextDirection.rtl, child: InkWell(
                    child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                        color: Colors.black38,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.5, 0.5), // shadow direction: bottom right
                      )]),width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                      ListTile(
                        title: DropdownButtonHideUnderline(
                            child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017,color: Colors.black),
                              value: region2
                              ,items: region2list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                              onChanged: (_) {
                                 region2 =_;
                                setState(() {});
                              },
                            )),
                      ),),
                  )),
                  Directionality(textDirection: TextDirection.rtl, child: InkWell(
                    child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                        color: Colors.black38,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.5, 0.5), // shadow direction: bottom right
                      )]),width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                        ListTile(
                          title: DropdownButtonHideUnderline(
                              child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017,color: Colors.black),
                                 value: region3
                                ,items: region3list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                                onChanged: (_) {
                                   region3 =_;
                                  setState(() {});
                                },
                              )),
                        )),
                  )),
                  Container(
                    child:!type? Container(): Directionality(textDirection: TextDirection.rtl, child: InkWell(
                      child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                          color: Colors.black38,
                          blurRadius: 1.0,
                          spreadRadius: 0.0,
                          offset: Offset(0.5, 0.5), // shadow direction: bottom right
                        )]),width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                        ListTile(
                          title: DropdownButtonHideUnderline(
                              child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017,color: Colors.black),
                                hint: Text("الفئة")
                                ,value: cat
                                ,items: cats.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                                onChanged: (_) {
                                  cat =_;
                                  changevaluetype(cats.indexOf(cat));
                                  setState(() {});
                                },
                              )),
                        ),),
                    )),
                  ),
                  Container(
                    child:subtypelist.length ==0 ?Container(): Directionality(textDirection: TextDirection.rtl, child: InkWell(
                      child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                            color: Colors.black38,
                            blurRadius: 1.0,
                            spreadRadius: 0.0,
                            offset: Offset(0.5, 0.5), // shadow direction: bottom right
                          )]),width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                          ListTile(
                            title: DropdownButtonHideUnderline(
                                child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017,color: Colors.black),
                                  hint: Text("الفئة المخصصة"),
                                  value: subtypevalue
                                  ,items: subtypelist.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                                  onChanged: (_) {
                                    subtypevalue =_;
                                    setState(() {});
                                  },
                                )),
                          )),
                    )),
                  )
                  ,Directionality(textDirection: TextDirection.rtl, child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                      color: Colors.black38,
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.5, 0.5), // shadow direction: bottom right
                    )]),width: MediaQuery.of(context).size.width*0.9,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(obscureText: true,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),controller: password,validator: signuplogic.validatepassword ,decoration: InputDecoration(hintText: "كلمة السر",border: InputBorder.none),),))
                  ,Directionality(textDirection: TextDirection.rtl, child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                      color: Colors.black38,
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(0.5, 0.5), // shadow direction: bottom right
                    )]),width: MediaQuery.of(context).size.width*0.9,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(obscureText: true,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),controller: repassword,validator: signuplogic.validatepasswordre ,decoration: InputDecoration(hintText: "تأكيد كلمة السر",border: InputBorder.none),),))
                  ,InkWell(onTap: ()=> signuplogic.signup(type,key, email.text.toString(), password.text.toString(), repassword.text.toString(), name.text.toString(), phone.text.toString(), region1, region2, region3,  storename.text ,id.text, photo, "ji" , cat,subtypevalue),
                    child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,top: MediaQuery.of(context).size.height*0.05),decoration: BoxDecoration(boxShadow: [  BoxShadow(
                      color: Color.fromRGBO(69, 190, 0, 1),
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )],color: Color.fromRGBO(69, 190, 0, 1),borderRadius: BorderRadius.circular(5)),height: MediaQuery.of(context).size.height*0.07,width: MediaQuery.of(context).size.width*0.9,child: Center(child: Text("اشتراك",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.025),),),),
                  ),
                  Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1,),child: Row(children:[ Expanded(flex: 4,child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05,top: MediaQuery.of(context).size.height*0.01),alignment: Alignment.centerLeft,child: Text("لديك حساب بالفعل؟",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height*0.02),),)),Expanded(flex: 3,child: InkWell(child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05,top: MediaQuery.of(context).size.height*0.01),alignment: Alignment.centerRight,child: InkWell(onTap: ()=>signuplogic.navigate(),child: Text("سجل الدخول",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: MediaQuery.of(context).size.height*0.02),)),)))]))),
                ],),
              )
          ))
        ],
        ),),
    ),);
  }
}