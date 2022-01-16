import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ezzproject/logic/detailpage.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/allreviews.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'notification.dart';
class Marasildetail2 extends StatefulWidget{
  var detaildata;
  var detailproduct;
  Marasildetail2({this.detaildata,this.detailproduct});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statemarasildetail(detaildata: detaildata,detailproduct: detailproduct);
  }
}
class Statemarasildetail extends State<Marasildetail2>{
  var detaildata;
  var detailproduct;
  Detailpagelogic detailpagelogic;
  Statemarasildetail({this.detaildata ,this.detailproduct});
  @override
  void initState() {
    print(detaildata);
    print(detailproduct);
    detailpagelogic = new Detailpagelogic(context);
    super.initState();
    getdata();
  }
  List housesimg = [5,3,2];
  int totalprice ;
  getdata()async{
    Provider.of<Notifires>(context,listen: false).getdatadetailpage(detaildata["Products"]);
  }
  navigatetoshopping(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  var value_type="";
  List value_types =[];
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
 // List details =["بائعين جملة","بائعين الذبائح" ,"اسر منتجة","الطهاة والمطابخ" ,"ملاحم الجزيرة","أماكن","مأكولات بحرية","مزارع بيع الطيور","مراسيل","مزاد"];
  //List datalist =[{"name" : "ahmad" , "price": "1500"},{"name" : "ahmad" , "price": "1500"},{"name" : "ahmad" , "price": "1500"},{"name" : "ahmad" , "price": "1500"}];
  @override
  Widget build(BuildContext context) {
    // datadetailpage = Provider.of<Notifires>(context).datadetailpage;
    // print(datadetailpage);
    //shoppinglist = Provider.of<Notifires>(context).shoppinglist;
    totalprice = Provider.of<Notifires>(context).totalprice;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
        child:
        Container(
          child:detaildata == null?Container(child: Center(child: CircularProgressIndicator(),),): ListView(children: [
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :Stack(children: [
              Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
                decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60))),child: Row(children: [
                  Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                  Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1) ,alignment: Alignment.center,child: Text(detaildata["Name"].toString(),style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),))),
                  Expanded(flex: 2,child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("svg/Icon-alarm.svg",semanticsLabel: "wadca",))),
                  Expanded(flex: 2,child:InkWell(onTap: ()=>navigatetoshopping(),child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("svg/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) )
                ],),),
              Positioned(bottom: MediaQuery.of(context).size.height*0.06,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
            ],) ),
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.3,child: Image(fit: BoxFit.fill,image:NetworkImage(detaildata["Photo"]) ,),)
            ,Container(child: Text(detaildata["Name"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),),
            Directionality(textDirection: TextDirection.rtl, child: Container(child: Text(detaildata["Description"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),)),
            Container(child: Row(children: [
              Expanded(flex: 3,child: Container( child: Text(detaildata["Location"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
              Expanded(child: Container(child: Text("الموقع",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
            ],),),
            Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,child: Row(children: [
              Expanded(child: Container(child: Text(detaildata["WorkTime"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.35 ,right: MediaQuery.of(context).size.width*0.01,top: MediaQuery.of(context).size.height*0.01),)),
              Expanded(child:  Container(child: Text("مواعيد العمل",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1 ,right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),))
            ],),),
            Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.02 ),child: FittedBox(
              child: Row(children: [
                Container(child: InkWell(onTap: ()=>navigatetoallreview(detaildata["Rating"],detaildata["ID"]),child: Text("مشاهدة تقييم البائع",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.red),)),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.16),)
                , Container( child: Text(detaildata["Rating"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black54),),alignment: Alignment.centerRight,) ,
                Container( child: Icon(Icons.star,color: Colors.yellow.withGreen(200),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),)
                ,Container( child: Text("التقييم",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.1),)
              ],),
            ),),
            Container(child: Divider(color: Colors.black38,),margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07,right:MediaQuery.of(context).size.width*0.07 ),)
            ,Container(
                child:Container(
                    child:Container(height: MediaQuery.of(context).size.height*0.5,
                      child: Column(children: [
                        Container(child: Text("بيانات السيارة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),)
                        ,Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child : Row(
                            children:[Expanded(
                              child: Container(child: FittedBox(child: Text(detailproduct["CarNumber"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),)),alignment: Alignment.centerRight,),
                              ),Expanded(child:     Container(child:FittedBox(child: Text("رقم السيارة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,fontWeight: FontWeight.bold,color: Colors.black),)),alignment: Alignment.centerRight))
                              ,Expanded(
                              child: Container( alignment: Alignment.center,child: Text(detailproduct["CarBrand"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),))
                            ) ,Expanded(child:  Container(child: Text("الماركة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,fontWeight: FontWeight.bold,color: Colors.black),)))]),
                        ),
                        Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child : Row(
                            children:[Expanded(
                              child:   Container(alignment: Alignment.centerRight ,child: Text(detailproduct["CarLicense"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),)),
                            ) ,Expanded(
                              child: Container(alignment: Alignment.center ,child: Text("رخصة القيادة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,fontWeight: FontWeight.bold,color: Colors.black),))
                            )]),
                        ),
                        Container(child: Text("بيانات السائق",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08,top: MediaQuery.of(context).size.height*0.03),)
                        ,Container(child: Row(children: [
                          Expanded(flex: 2,child: Container( child: Text(detailproduct["DriverName"],style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
                          Expanded(child: Container(child: Text("الاسم",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
                        ],),),
                        Container(child: Row(children: [
                          Expanded(flex: 2,child: Container( child: Text(detailproduct["DriverNationalNumber"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
                          Expanded(child: Container(child: Text("الهوية الوطنية",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
                        ],),),
                        Container(child: Row(children: [
                          Expanded(flex: 2,child: Container( child: Text(detailproduct["DriverLicense"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
                          Expanded(child: Container(child: Text("رخصة القيادة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
                        ],),),
                        //Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
                         // child:Text("اتصل الان ", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04)) ,)
                      ],),
                    )
                )),
          ]),
        )));
  }
  reservation(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Location();
    }));
  }
  navigatetoallreview(rat,id){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Allriviews(rating : rat , id:id,name: detaildata["Name"],photo: detaildata["Photo"],);
    }));
  }
  navigateback(){
    Navigator.of(context).pop();
  }

}