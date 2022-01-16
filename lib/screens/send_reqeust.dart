import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sendrequest extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statesendrequest();
  }
}
class Statesendrequest extends State<Sendrequest>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: SingleChildScrollView(physics: ClampingScrollPhysics(),
      child: Column(children: [
        Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child: Row(children: [
          Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.clear,size: MediaQuery.of(context).size.height*0.04,color: Colors.black,),onPressed: (){},))),
          Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("ارسال الطلب",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.025),))),
          Expanded(child: Container())
          ],),),
          Container(height:MediaQuery.of(context).size.height*0.3  ,width: MediaQuery.of(context).size.width*0.5 ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15) ,child: Image(fit: BoxFit.fill,image: AssetImage("images/sendrequest.png"),),)
          ,Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04) ,child: Text("نشكرك...تم ارسال طلبك بنجاح" ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),)),
        Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,child: Text("سيتم ارسال قيمة الطلب الخاص بك لاحقا",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017)),)),
        Container(margin:EdgeInsets.only(left: MediaQuery.of(context).size.width*0.27) ,child: Row(children:[ Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.001) ,child: Text("طلباتي",style: TextStyle(color: Colors.green,fontSize: MediaQuery.of(context).size.height*0.017)),)),Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.001) ,child: Text("يمكنك رفض أو قبول الطلب في ",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017)),))]))

         ],),),);
  }
}