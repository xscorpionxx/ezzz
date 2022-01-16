import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Confirmchef extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statecom();
  }
}
class Statecom extends State<Confirmchef>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: SingleChildScrollView(physics: ClampingScrollPhysics(),
      child: Column(children: [
        Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child: Row(children: [
          Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.black,),onPressed: (){},))),
          Expanded(flex: 5,child: Container()),
          Expanded(child: Container())
        ],),),
        Container(height:MediaQuery.of(context).size.height*0.3  ,width: MediaQuery.of(context).size.width*0.5 ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15) ,child: Image(fit: BoxFit.fill,image: AssetImage("images/chefsconfirm.png"),),)
        ,Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04) ,child: Text("تم ارسال الطلب بنجاح" ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),)),
        Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,child: Text("سيقوم الطاه بتواصل معك لاحقا",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017)),)),

      ],),),);
  }
}