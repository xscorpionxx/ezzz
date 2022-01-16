import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Services extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateservices();
  }
}
class Stateservices extends State<Services>{
  @override
  void initState() {
    super.initState();
  }
  deleteservice(int i){
      return showDialog( context: context, builder: (context) {
        return StatefulBuilder(builder: (Context , setState){
          return AlertDialog(
              content:Container(height: MediaQuery.of(context).size.height*0.25,
                child: Column(children: [
                  Container(child: Text("حذف الخدمة"),)
                  ,Container (child: Text("هل تريد حذف الخدمة"),),
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                    child: Row(
                      children:[ Expanded(flex: 3,
                        child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.black26 ,borderRadius: BorderRadius.circular(5)),
                          child: Text("رفض", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.025)) ,),
                      ),Expanded(child: Container()),
                 Expanded(flex: 3,child:  Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(5)),
                    child: Text("موافق", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.025)) ,)),
                    ]),
                  )
                ],),
              )
          );},
        );
      });
  }
  List services =[];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,child :Stack(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.only(bottomRight: Radius.circular(90),bottomLeft: Radius.circular(90))),child: Row(children: [
              Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){},))),
              Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الخدمات",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.03),))),
              Expanded(child: Container())
            ],),),
          Positioned( bottom: MediaQuery.of(context).size.height*0.04,left: MediaQuery.of(context).size.width*0.4 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
        ],) ),Container(child
          :Column(
            children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child: Row(children: [Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,height: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),borderRadius: BorderRadius.circular(5)) ,child: Center(child: Text("اضافة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.white)),),)),Expanded(child: Column(children: [
              Container(child: Text("الخدمات",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),),
            Container(child: Directionality(textDirection: TextDirection.rtl,child: Text(" عدد"+services.length.toString()+"من الخدمات " ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),)),)
        ],))],),),
            Container(
              child:services.length==0?Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),alignment: Alignment.center ,child: Text("لا توجد خدمات مضافة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),),) : Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04) ,height: MediaQuery.of(context).size.height*0.4 ,child: ListView.builder(itemCount: services.length,itemBuilder: (context,i){
                return Container(decoration: BoxDecoration(border: Border.all(color: Colors.black54)),height: MediaQuery.of(context).size.height*0.21,width: MediaQuery.of(context).size.width,
                     child: Column(
                      children:[
                        Container(child: Row(children: [
                          Expanded(flex: 2,child: Container(alignment: Alignment.centerRight ,child: Column(children: [
                            Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("اسم الخدمة : "),Text(services[i]["name"],style: TextStyle(color: Colors.black54),)]),))
                            ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("تفاصيل المنتج : "),Text(services[i]["detail"],style: TextStyle(color: Colors.black54))]),))
                            ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("السعر : "),Text(services[i]["price"].toString(),style: TextStyle(color: Colors.black54))]),))
                          ],),))
                          ,Expanded(child: Container(height: MediaQuery.of(context).size.width*0.2 ,width: MediaQuery.of(context).size.width*0.1,child: Image(fit: BoxFit.fill,image: AssetImage("images/chefsconfirm.png"),),))
                        ],),),
                        Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,color: Colors.black12.withOpacity(0.05),child: Row(children: [
                          Container(margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child:IconButton(icon:Icon( Icons.delete,color: Colors.red,),onPressed: ()=>deleteservice(i),)),
                          Container(child:Icon(Icons.edit,color: Colors.green,))
                          ,InkWell( onTap: (){
                            if(services[i]["able"] ==true){
                              print("true");
                              setState(() {
                                services[i]["able"] =false;
                              });
                            }
                          },child: Container(width: MediaQuery.of(context).size.width*0.15 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.4),decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:services[i]["able"]? Colors.black26:Colors.red ),child:Center(child: Text("غير متاح",style: TextStyle(color:services[i]["able"]? Colors.black38:Colors.white),)),)),
                          InkWell(onTap: (){
                            if(services[i]["able"] ==false){
                            print("false");
                              setState(() {
                                services[i]["able"] =true;
                              });
                            }
                          },child: Container(width: MediaQuery.of(context).size.width*0.15 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:services[i]["able"]? Colors.green:Colors.black26.withOpacity(0.1) ),child: Center(child: Text("متاح",style: TextStyle(color:services[i]["able"]? Colors.white:Colors.black38),)),)),
                        ],),)
                      ],));
              }),),
            )
            ],
          ))
       ],),
    ),);
  }
}