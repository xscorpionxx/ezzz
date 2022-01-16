import 'package:ezzproject/logic/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Loginpage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statelogin();
  }
}
class Statelogin extends State<Loginpage>{
  bool showpass =false;
  Loginlogic loginlogic;
  TextEditingController email ;
  TextEditingController password ;
  GlobalKey<FormState> key ;
  @override
  void initState() {
    loginlogic = new Loginlogic(context);
    email = new TextEditingController();
    password = new TextEditingController();
    key = new GlobalKey<FormState>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(color: Colors.greenAccent.withOpacity(0.6),width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
    child:  Stack(children: [
        Positioned(bottom: MediaQuery.of(context).size.height*0.6,left: MediaQuery.of(context).size.width*0.4,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(300),color: Colors.blueAccent.withOpacity(0.4)),width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.width,)),
        Positioned(top: MediaQuery.of(context).size.height*0.1,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(200),topLeft: Radius.circular(200)),color: Colors.white.withOpacity(0.95)),height: MediaQuery.of(context).size.height*0.9,width: MediaQuery.of(context).size.width,
        child:  Form(key: key,
          child: SingleChildScrollView(
            child: Column(children: [
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.07),width: MediaQuery.of(context).size.width*0.2,height:MediaQuery.of(context).size.height*0.15 ,child: Image(image: AssetImage("images/logoaz.png"),),)
,         Container(margin:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Text("تسجيل الدخول",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.blueAccent.withOpacity(0.5)),),)
                  , Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.015),margin:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05)  ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue.shade50),child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: email,validator: loginlogic.validate,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),decoration: InputDecoration(border: InputBorder.none,hintText: "البريد الالكتروني"),)),)
                  , Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.015),margin:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05)  ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue.shade50),child: Directionality(textDirection: TextDirection.rtl,child: TextFormField( controller: password,validator: loginlogic.validate,obscureText: showpass?false:true,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),decoration: InputDecoration(border: InputBorder.none,hintText: "كلمة السر",prefixIcon:showpass ==false? Container(child: IconButton(icon: Icon(Icons.remove_red_eye,color: Colors.black45,), onPressed: () {
                setState(() {
                  showpass=true;
                });
              },))
              :Container(child: InkWell( child: Container(width: MediaQuery.of(context).size.width*0.05,height: MediaQuery.of(context).size.width*0.05,child: SvgPicture.asset("svg/eye.svg",fit: BoxFit.scaleDown,)), onTap: () {
                setState(() {
                  showpass=false;
                });
              },))),)),),
                  InkWell(onTap: ()=>loginlogic.login(key,email.text , password.text),
                    child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.025),decoration: BoxDecoration(boxShadow: [  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )],color: Color.fromRGBO(69, 190, 0, 1),),height: MediaQuery.of(context).size.height*0.07,width: MediaQuery.of(context).size.width*0.85,child: Center(child: Text("دخول",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),),),),
                  ),
                  Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.07),alignment: Alignment.centerRight,child: Text("نسيت كلمة السر الخاصة بك ؟",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.018),),))
                  ,Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.025),alignment: Alignment.center,child: Text("أو يمكنك الدخول",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.016),),)),
                  Container(margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height * 0.01 ,top: MediaQuery.of(context).size.height * 0.01),child: Row(children: [Expanded(child: Container()),Container(decoration: BoxDecoration( boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],color: Colors.white,borderRadius: BorderRadius.circular(200)),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01,left: MediaQuery.of(context).size.width*0.01),width: MediaQuery.of(context).size.width*0.12,height:MediaQuery.of(context).size.width*0.12 ,child :InkWell(onTap: null,child: Center(child: Image(width: 15,height: 25,image: AssetImage("images/facebook2.png") ,)))),Container(decoration: BoxDecoration( boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],color: Colors.white,borderRadius: BorderRadius.circular(200)),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01,left: MediaQuery.of(context).size.width*0.01),width: MediaQuery.of(context).size.width*0.12,height:MediaQuery.of(context).size.width*0.12 ,child :InkWell(onTap: null,child: Center(child: Image(width: 25,height: 25,image: AssetImage("images/googleplus.png") ,)))), Container(decoration: BoxDecoration( boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],color: Colors.white,borderRadius: BorderRadius.circular(200)),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01,left: MediaQuery.of(context).size.width*0.01),width: MediaQuery.of(context).size.width*0.12,height:MediaQuery.of(context).size.width*0.12,child :InkWell(onTap: null,child: Center(child: Image(width: 25,height: 25,image: AssetImage("images/twitt.png") ,)))),Expanded(child: Container()),]),)
              ,  Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Row(children:[ Expanded(child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05,top: MediaQuery.of(context).size.height*0.01),alignment: Alignment.centerLeft,child: Text("أليس لديك حساب؟",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)),Expanded(child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05,top: MediaQuery.of(context).size.height*0.01),alignment: Alignment.centerRight,child: InkWell(onTap: (){loginlogic.navigatetosignup();},child :Text("اشترك معنا",style: TextStyle(color: Colors.red,fontSize: MediaQuery.of(context).size.height*0.017),)),))]))),
              ],),
          ),
        ),
        )),
      ],
    ),),);
  }
}