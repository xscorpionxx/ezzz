import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezzproject/logic/home.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/showpage.dart';
import 'package:ezzproject/screens/Loginpage.dart';
import 'package:ezzproject/screens/aboutapp.dart';
import 'package:ezzproject/screens/changepassword.dart';
import 'package:ezzproject/screens/chat.dart';
import 'package:ezzproject/screens/ketchins.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/marasil.dart';
import 'package:ezzproject/screens/mazadat.dart';
import 'package:ezzproject/screens/mazadshow.dart';
import 'package:ezzproject/screens/orderdata.dart';
import 'package:ezzproject/screens/partner.dart';
import 'package:ezzproject/screens/places.dart';
import 'package:ezzproject/screens/profile.dart';
import 'package:ezzproject/screens/recommend.dart';
import 'package:ezzproject/screens/shareapp.dart';
import 'package:ezzproject/screens/shoppingcart.dart';
import 'package:ezzproject/screens/showpage.dart';
import 'package:ezzproject/screens/terms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'notification.dart';
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statehome();
  }
}
class Statehome extends State<Home> with TickerProviderStateMixin{
  List homedata =[];
  List banner =[];
  TextEditingController query ;
  getdata1()async{
     homelogic = await new Homelogic(context);
     Future.delayed(const Duration(milliseconds: 1), ()async {
      await Provider.of<Notifires>(context,listen: false).reset();
       await Provider.of<Notifires>(context, listen: false).getdatahomecats(context);
      if(go){
        showadd();
      }
     });
  }
  var go ;
  var timer;
  double valuea =0;
  Showpagelogic showpagelogic;
  AnimationController controller;
  brogress(setState,adtime,video){
    double time = (1/double.parse(adtime.toString()));
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(mounted) {
        setState(() {
          valuea = valuea + time;
          if (valuea == 1) {
            timer.cancel();
            Future.delayed(Duration(seconds: 1), () {
              if (video) {
                _controller.pause();
              }
              Navigator.of(context).pop("dialog");
            });
          }
        });
      }
    });
  }
  showadd(){
    Future.delayed(Duration(seconds: 4) , (){
      Provider.of<Notifires>(context,listen: false).setads();
      if(banner.length ==0){
        return null;
      }
      var type = banner[0]["type"].toString();
      if(type=="2"){
        try {
          return showDialog(
            barrierDismissible: false, context: context, builder: (context) {
            return StatefulBuilder(
                builder: (contexta, setState) {
                  brogress(setState, adtime, false);
                  return AlertDialog(      insetPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    content: Container(
                      child: SingleChildScrollView(child:
                      Column(
                        children: [ Container(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.35, width: MediaQuery
                            .of(context)
                            .size
                            .width,
                          child:Container(
                            child: Container(height: MediaQuery.of(context).size.height*0.25,child: banner[0]["photos"].length==0? Container():
                            CarouselSlider.builder(options: CarouselOptions(height: MediaQuery.of(context).size.height*0.43,viewportFraction: 1,
                                onPageChanged: (ind,reason){
                                }
                                ,autoPlay: false),
                              itemBuilder: (context,index , real){
                               return FadeInImage(placeholder:AssetImage("images/emptyphoto.png") ,
                                    image:NetworkImage(banner[0]["photos"][index]));
                              },itemCount: banner[0]["photos"].length,)
                              ,),
                          ) ),
                          Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child: LinearProgressIndicator(
                            value: valuea * 1,
                            semanticsLabel: 'Linear progress indicator',),),
                          Container(alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              child: Text("تخطي"), onPressed: () {
                              Navigator.of(context).pop("dialog");
                            },),)
                        ],
                      )),
                    ),
                  );
                });},
          );
        }
        catch(e){
          print(e);
        }
      }
      if(type=="3"){
        return showDialog(barrierDismissible: false,context: context, builder: (context) {
          return StatefulBuilder(
              builder:(contexta,setState){
                brogress(setState,adtime,false);
                return AlertDialog(
                  content:Container(
                    child:SingleChildScrollView(child:
                    Column(
                      children:[ Container(height: MediaQuery.of(context).size.height*0.2,width:MediaQuery.of(context).size.width,
                        child:Center(
                          child: Row(children:[ Expanded(
                            child: Container(alignment: Alignment.centerRight ,child:InkWell(onTap: ()async{
                              if (await canLaunch(banner[0]["url"])) {
                                await launch(banner[0]["url"]);
                              } else {
                                throw 'Could not launch';
                              }
                            },child: Text("هنا",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),))),
                          ),Expanded(flex: 3 ,child:  Container( alignment: Alignment.centerRight,child: Text("اضغط للذهاب للرابط الاتي ",style: TextStyle(color: Colors.blue),)))
                      ]),
                        )),
                        Container(child:LinearProgressIndicator(value: valuea*1,semanticsLabel: 'Linear progress indicator',),),
                        Container(alignment: Alignment.centerRight ,child: ElevatedButton(child: Text("تخطي"),onPressed: (){
                          Navigator.of(context).pop("dialog");
                        },),)],
                    )),
                  ),
                );
              });
        },
        );
      }
      if(type=="4"){
        return showDialog(barrierDismissible: false,context: context, builder: (context) {
          return StatefulBuilder(
              builder:(contexta,setState){
                brogress(setState,adtime,false);
                return AlertDialog(
                  content:Container(
                    child:SingleChildScrollView(child:
                    Column(
                      children:[ Container(height: MediaQuery.of(context).size.height*0.2,width:MediaQuery.of(context).size.width,
                          child:Center(
                            child: FittedBox(
                              child: Row(children:[ Container(child:InkWell(onTap: (){
                                adsgotocats(banner[0]["cat_id"].toString());
                              },child: Text("هنا",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),))),Container(child: Text("للذهاب للقسم اضغط ",style: TextStyle(color: Colors.blue),))
                              ]),
                            ),
                          )),
                        Container(child:LinearProgressIndicator(value: valuea*1,semanticsLabel: 'Linear progress indicator',),),
                        Container(alignment: Alignment.centerRight ,child: ElevatedButton(child: Text("تخطي"),onPressed: (){
                          Navigator.of(context).pop("dialog");
                        },),)],
                    )),
                  ),
                );
              });
        },
        );
      }
      if(type=="5"){
        return showDialog(barrierDismissible: false,context: context, builder: (context) {
          return StatefulBuilder(
              builder:(contexta,setState){
                brogress(setState,adtime,false);
                return AlertDialog(
                  content:Container(
                    child:SingleChildScrollView(child:
                    Column(
                      children:[ Container(height: MediaQuery.of(context).size.height*0.2,width:MediaQuery.of(context).size.width,
                          child:Center(
                            child: FittedBox(
                              child: Row(children:[ Container(child:InkWell(onTap: (){
                                adsgotosubcats(banner[0]["cat_id"].toString(),banner[0]["subcat_id"].toString());
                              },child: Text("هنا",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),))),Container(child: Text("للذهاب للقسم اضغط ",style: TextStyle(color: Colors.blue),))
                              ]),
                            ),
                          )),
                        Container(child:LinearProgressIndicator(value: valuea*1,semanticsLabel: 'Linear progress indicator',),),
                        Container(alignment: Alignment.centerRight ,child: ElevatedButton(child: Text("تخطي"),onPressed: (){
                          Navigator.of(context).pop("dialog");
                        },),)],
                    )),
                  ),
                );
              });
        },
        );
      }
      if(type=="1"){
        _controller = VideoPlayerController.network(banner[0]["video"])
          ..initialize().then((_) {
             viewvideo(adtime);
            _controller.play();});
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      }
    });
  }
  adsgotosubcats(cat,subcat){
    if(cat.toString() == "10") {
      for(int i =0 ; i<homedata[1]["SubCategories"].length ; i++){
        if(homedata[1]["SubCategories"][i]["ID"] == subcat){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Showpage(
              id: homedata[1]["SubCategories"][i]["ID"],
              subcategories: homedata[1]["SubCategories"],
              name: homedata[1]["SubCategories"][i]["Name"],
              cat: "مراسيل");
          }));
        }
      }
    }
  }
  adsgotocats(cat_id){
    Navigator.of(context).pop("dialog");
    if(cat_id.toString() =="10"){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Marasil(data: homedata[1]["SubCategories"]);
      }));
    }
    else{
      if(cat_id.toString() == "9"){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Mazadshow(mazads: homedata[0]["Auctions"],);
        }));
      }
      else{
          for(int i =0 ; i<homedata.length;i++){
            if(homedata[i]["ID"].toString() ==cat_id.toString()){
              print(homedata[i]["Name"]);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Showpage(
                  id: homedata[i]["ID"], name: homedata[i]["Name"], subcategories:homedata[i]["SubCategories"] ,);
              }));
            }
        }
      }
    }
  }
  VideoPlayerController _controller;
  viewvideo(adtime){
    return showDialog(barrierDismissible: false,context: context, builder: (context) {
      return StatefulBuilder(
          builder:(contexta,setState){
            brogress(setState,adtime,true);
            return AlertDialog(
              content:Container(height: MediaQuery.of(context).size.height*0.45,
                child:Column(children:[
                Container(height: MediaQuery.of(context).size.height*0.3,width:MediaQuery.of(context).size.width,
                  child: FittedBox(child: VideoPlayer(_controller)),
                ), Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),child:LinearProgressIndicator(value: valuea*1,semanticsLabel: 'Linear progress indicator',),),
            Container(alignment: Alignment.centerRight ,child: ElevatedButton(child: Text("تخطي"),onPressed: (){
            Navigator.of(context).pop("dialog");
            },),) ],
              ),
            ));
          });
    },
    );
  }
  List data =[{"title" : "بائعين جملة" , "desc": "جميع أنواع بهيمة الانواع"},
    {"title" : "بائعين الذبائح" , "desc": "ذبيحتك لباب بيتك-بلدي ومستورد"},
    {"title" : "اسر منتجة" , "desc": "لأطعمة والحلويات وكافة ماتقوم بانتاجه الاسرة"},
    {"title" : "الطهاة والمطابخ" , "desc": "توصيل ذبيحتك مطبوخة أو اطلب طاهي الى منزلك"},
    {"title" : "ملاحم الجزيرة" , "desc": "جميع أنواع اللحوم الطازجة"},
    {"title" : "أماكن" , "desc": "الشاليهات والمخيمات وقاعات الأفراح"},
    {"title" : "مأكولات بحرية" , "desc": "جميع المنتجات البحرية"},
    {"title" : "مزارع بيع الطيور" , "desc": "الدجاج البلدي والحمام الفرنسي وغيرها"},
    {"title" : "مراسيل" , "desc": "شاحنات-معدات ثقيلة-دينات-دبابات-سيارات صغيرة"},
    {"title" : "مزاد" , "desc": "حراج حي لكل بهائم الانعام كل يوم منطقة"}
  ];
  List images = ["images/home1.jpg","images/home2.jpg","images/home3.jpg",
    "images/home4.jpg","images/home5.jpg","images/home6.jpg",
    "images/home7.jpg","images/home8.jpg","images/home9.jpg","images/home10.jpg"];
  List data2 =[{"title" : "بائعين جملة" , "desc": "جميع أنواع بهيمة الانواع" , "review" : "0.4"},
    {"title" : "بائعين جملة" , "desc": "جميع أنواع بهيمة الانواع" , "review" : "0.4"},
    {"title" : "بائعين جملة" , "desc": "جميع أنواع بهيمة الانواع" , "review" : "0.4"},
    {"title" : "بائعين جملة" , "desc": "جميع أنواع بهيمة الانواع" , "review" : "0.4"},
  ];
  List data3 =[{"code":"123" , "type":"wadad" , "date":"12/21/2001" , "name":"ahmad","status":"wada","price":"123"}];
  var active ;
  List fav=[];
  TabController tabController;
  Homelogic homelogic;
  var profiledata;
  List myorders =[];
  var adtime;
  List ads =[];
  @override
  void initState() {
    tabController = new TabController(vsync: this, length:4);
    query = new TextEditingController();
    controller = new AnimationController(vsync: this);
    showpagelogic = new Showpagelogic(context);
    super.initState();
    getdata1();
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  navigatetoshopping(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  List searchresult = [];
  var searchable ;
  @override
  Widget build(BuildContext context) {
    homedata =  Provider.of<Notifires>(context).homedata;
    banner = Provider.of<Notifires>(context).banner;
    fav = Provider.of<Notifires>(context).favdata;
    active = Provider.of<Notifires>(context).active;
    profiledata = Provider.of<Notifires>(context).profiledata;
    myorders = Provider.of<Notifires>(context).myorders;
    searchresult = Provider.of<Notifires>(context).searchresult;
    adtime = Provider.of<Notifires>(context).adtime;
    searchable = Provider.of<Notifires>(context).searchable;
    ads=  Provider.of<Notifires>(context).ads;
    go = Provider.of<Notifires>(context).adsable;
    // TODO: implement build
    return Scaffold(body:  Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:  SingleChildScrollView(physics: ClampingScrollPhysics(),
        child: Column(children: [
         // Container(width: 100,height: 100,child: VideoPlayer(_controller)),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.954 ,child: TabBarView(physics: NeverScrollableScrollPhysics(),controller: tabController,children:[
              Homescreen1(),
              favourite(),
              requests(),
              more()
            ])),
          ),
            Container(height: MediaQuery.of(context).size.height*0.046,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.white),child:
               Row(children: [
                 Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:active=="more"?  Container(
                   decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent])) ,
                   child: FittedBox(
                     child: Column(children:[
                        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: SvgPicture.asset("svg/Vector.svg",fit: BoxFit.scaleDown,)),
                       Container( height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("المزيد",style: TextStyle(color:Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                   ),
                 ):Container(
                   child: InkWell(onTap: (){
                     Provider.of<Notifires>(context,listen: false).getindex(tabController, "more", 3, context);
                     Future.delayed(const Duration(milliseconds: 500), () {
                     Provider.of<Notifires>(context,listen: false).getprofile(context,false);
                   });},
                     child: FittedBox(
                       child: Column(children:[
                         Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: SvgPicture.asset("svg/Vector.svg",fit: BoxFit.scaleDown,)),
                         Container( height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("المزيد",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                     ),
                   ),
                 ))),Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:active=="req"?  Container(
                   decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent])) ,
                   child: Container(
                     child:FittedBox(child: Column(children:[
                       Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image :AssetImage("images/bar31.png"),fit: BoxFit.scaleDown,)),
                       Container(height: MediaQuery.of(context).size.height*0.02,child : FittedBox(child: Text("طلباتي",style: TextStyle(color:Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*10),)))])),
                   ),
                 ) :Container(
                   child: InkWell(onTap: (){
                     Provider.of<Notifires>(context,listen: false).getindex(tabController, "req", 2, context);
                     Future.delayed(const Duration(milliseconds: 500), () {
                     Provider.of<Notifires>(context,listen: false).getmyorders( context);
                   });},
                     child: Container(
                       child: FittedBox(
                         child: Column(children:[
                           Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image :AssetImage("images/bar2.png"),fit: BoxFit.scaleDown,)),
                           Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("طلباتي",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                       ),
                     ),
                   ),
                 )))
                 ,Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:active=="favo"?  Container(
                   decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent])) ,
                   child:FittedBox(child: Column(children:[
                     Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image : AssetImage( "images/bar21.png"),fit: BoxFit.scaleDown)),
                    Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("مفضلة",style: TextStyle(color:Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*10),)))])),
                 ) :Container(
                   child: InkWell(onTap: (){
                     print(MediaQuery.of(context).size.width*2/MediaQuery.of(context).size.height);
                     Provider.of<Notifires>(context,listen: false).getindex(tabController, "favo", 1, context);
                     Provider.of<Notifires>(context,listen: false).getfav(context);
                   },
                     child: FittedBox(
                       child: Column(children:[
                         Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image : AssetImage( "images/bar3.png"),fit: BoxFit.scaleDown)),
                         Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("مفضلة",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                     ),
                   ),
                 ))),
                 Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:active=="home"?  Container(
                   decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent])) ,
                   child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                     child:FittedBox(child: Column(children:[
                       Container(height: MediaQuery.of(context).size.height*0.025,child: SvgPicture.asset("images/home2azz.svg",fit: BoxFit.scaleDown,semanticsLabel: "dacasceqd",))
                       ,Container(height: MediaQuery.of(context).size.height*0.02 ,child: FittedBox(child: Text("الرئيسية",style: TextStyle(color:Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*10),)))])),
                   ),
                 ) :Container(
                   child: InkWell(onTap: (){
                     Provider.of<Notifires>(context,listen: false).getindex(tabController, "home", 0, context);
                   },child:Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                     child: FittedBox(
                       child: Column(children:[
                         Container(height: MediaQuery.of(context).size.height*0.025,child: SvgPicture.asset("images/home1azz.svg",fit: BoxFit.scaleDown,semanticsLabel: "dacadadwsceqd",)),
                       Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("الرئيسية",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                     ),
                   ),
                   ),
                 ))),
          ],),)]),
      ),
    ),);
  }
  List databannerimages =[];
  Widget Homescreen1(){
    return Directionality(textDirection: TextDirection.ltr,
      child: Container(child: ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.11,
          decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(40),bottomLeft: Radius.circular(40))),child:
          Container(child: Stack(
            children: [
              Positioned( bottom: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.2) , borderRadius: BorderRadius.circular(1000)),),)
              ,Container(
                child:Column(children:[ Container(
                  child:searchable?Container(): Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,bottom: MediaQuery.of(context).size.height*0.0),
                    child: Row(children: [
                      Expanded(flex: 4,child:InkWell(onTap: (){Provider.of<Notifires>(context,listen: false).setsearch();},child: Container( alignment: Alignment.center,margin: EdgeInsets.only(left: MediaQuery.of(context).textScaleFactor*20),child: Icon(Icons.search,color: Colors.white,size: MediaQuery.of(context).size.width*0.06,))) ),
                      Expanded(flex: 14,child: Container(alignment: Alignment.center,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),height: MediaQuery.of(context).size.height*0.05,width: MediaQuery.of(context).size.width*0.05,child:Image(image: AssetImage("images/logoaz.png"),fit: BoxFit.fill,) //Text("الرئيسية",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor * 13),)
                      )),
                      Expanded(flex:3 ,child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("svg/Icon-alarm.svg",semanticsLabel: "wadca",))),
                      Expanded(flex: 3,child:InkWell(onTap: ()=>navigatetoshopping(),child: Container(child: SvgPicture.asset("svg/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) ),
                      Expanded(flex:3 ,child: InkWell(onTap: ()=>navigatetolocation(),child: Icon(Icons.settings,color: Colors.white,))),
                    ],),
                  ),
                ), Container(
                  child:!searchable?Container(): Container(padding: EdgeInsets.only(right:  MediaQuery.of(context).size.width*0.01 ,left: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.15,right:MediaQuery.of(context).size.width*0.15 ),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5))
                    ,child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: query,onChanged: (val){
                      Provider.of<Notifires>(context ,listen: false).search(homedata, val);
                    }, style:  TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black26),decoration: InputDecoration(hintText: "بحث",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26),border: InputBorder.none,suffixIcon: InkWell( onTap: (){
                      Provider.of<Notifires>(context,listen: false).setsearch();
                    },child: Icon(Icons.close,color: Colors.black26,))),)),),
                )
                ]),
              )],
          )),
        )
        ,Container(
          child: Container( margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),height: MediaQuery.of(context).size.height*0.15,child: ads.length==0? Container():
          CarouselSlider.builder(options: CarouselOptions(height: MediaQuery.of(context).size.height*0.43,viewportFraction: 1,
              onPageChanged: (ind,reason){
              }
              ,autoPlay: false),
            itemBuilder: (context,index , real){
            print(ads[index]);
            print(ads[index]["Photo"].toString());
            print(ads[index]["Photo"].toString().substring(ads[index]["Photo"].toString().length-3,ads[index]["Photo"].toString().length));
              return Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,child:ads[index]["Photo"].toString().substring(ads[index]["Photo"].toString().length-3,ads[index]["Photo"].toString().length)=="svg"?
              SvgPicture.network(ads[index]["Photo"],fit: BoxFit.fill,)
                  :Image(fit:BoxFit.fill,image:NetworkImage(ads[index]["Photo"])
                ,));
            },itemCount: databannerimages.length,)
            ,),
        ),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05) ,alignment: Alignment.centerRight,child: Text("خدماتنا",style: TextStyle(color: Color.fromRGBO(8, 67, 143, 1),fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*14)),)
        ,Container(
          child:true? Container(height: MediaQuery.of(context).size.height*0.6,width: MediaQuery.of(context).size.width,child:homedata.length==0?Container(
            child: Center(child: Text("",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14),)),
          ):query.text == ""||!searchable?GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            childAspectRatio: (MediaQuery.of(context).size.width*1.5/MediaQuery.of(context).size.height*1.62),),itemCount: homedata.length,itemBuilder: (context,i){
            return InkWell(onTap: ()=>showtoshowpage(i,homedata[i]["Name"] , homedata[i]["SubCategories"]),
              child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                color: Colors.black12.withOpacity(0.2),
                blurRadius: 1.0,
                spreadRadius: 3.0,
                offset: Offset(0,0), // shadow direction: bottom right
              )]),child: Column(children: [
                  Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child: Image(fit: BoxFit.fill,image: NetworkImage(homedata[i]["Photo"]),),),
                  Container( height: MediaQuery.of(context).size.height*0.017,alignment: Alignment.center,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child:Center(child:  FittedBox(
                    child: AutoSizeText(homedata[i]["Name"],//,maxFontSize: MediaQuery.of(context).textScaleFactor*9,minFontSize:MediaQuery.of(context).textScaleFactor*9,
                      style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold),),
                  ))),
                  Container(height: MediaQuery.of(context).size.height*0.017,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),child: Directionality(textDirection: TextDirection.rtl,child: Center(child: FittedBox(child: AutoSizeText(homedata[i]["Description"], style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*8,color: Colors.black54),)))),),
                ],)
                ,),
            );
          }) :GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            childAspectRatio: (MediaQuery.of(context).size.width*1.5 /MediaQuery.of(context).size.height*1.62),),itemCount: searchresult.length,itemBuilder: (context,i){
            return InkWell(onTap: ()=>showtoshowpage(i,searchresult[i]["Name"] , searchresult[i]["SubCategories"]),
              child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                color: Colors.black12.withOpacity(0.2),
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )]),child: Column(children: [
                  Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child: Image(fit: BoxFit.fill,image: NetworkImage(searchresult[i]["Photo"]),),),
                  Container(height: MediaQuery.of(context).size.height*0.015,alignment: Alignment.center,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child:Center(child:  FittedBox(
                    child: AutoSizeText(searchresult[i]["Name"]
                        //,maxFontSize: MediaQuery.of(context).textScaleFactor*10,minFontSize:MediaQuery.of(context).textScaleFactor*10
                        ,style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold)),
                  )),),
                  Container(height: MediaQuery.of(context).size.height*0.015,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),child: Directionality(textDirection: TextDirection.rtl,child: Center(child:FittedBox(child: AutoSizeText(searchresult[i]["Description"],style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),)))),),
                ],)
                ,),
            );
          }) ,) :Container() ,
        ),
        //Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.02) ,alignment: Alignment.centerRight,child: Text("مراسيل",style: TextStyle(color: Color.fromRGBO(8, 67, 143, 1),fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*14)),),
        Container(
          child:true?Container(): Container( height: MediaQuery.of(context).size.height*0.2,child:GridView.builder(scrollDirection: Axis.horizontal,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,
            childAspectRatio: (MediaQuery.of(context).size.width*1.32/MediaQuery.of(context).size.height*1.35),),itemCount: homedata[9]["SubCategories"].length,itemBuilder: (context,i){
            return  Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
                child:InkWell(onTap: ()=> null//showtoshowpage(i,homedata[i]["Name"] , homedata[i]["SubCategories"]),
            ,child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )]),child: Column(children: [
                  Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child: Image(fit: BoxFit.fill,image: NetworkImage(homedata[9]["SubCategories"][i]["Photo"]),),),
                  Container( height: MediaQuery.of(context).size.height*0.015,alignment: Alignment.center,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child:Center(child:  FittedBox(
                    child: AutoSizeText(homedata[9]["SubCategories"][i]["Name"],//,maxFontSize: MediaQuery.of(context).textScaleFactor*9,minFontSize:MediaQuery.of(context).textScaleFactor*9,
                      style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold),),
                  ))),
                  Container(height: MediaQuery.of(context).size.height*0.015,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),child: Directionality(textDirection: TextDirection.rtl,child: Center(child: FittedBox(child: AutoSizeText(homedata[9]["SubCategories"][i]["Description"], style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*8,color: Colors.black54),)))),),
                ],)
                  ,)),
              );
          } ,)
          ),
        )],),),
    );}
  Widget favourite(){
    return Directionality(textDirection: TextDirection.ltr,
      child: Container(child: ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
          decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child:
          Container(child: Stack(
            children: [
              Positioned( bottom: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.2) , borderRadius: BorderRadius.circular(1000)),),)
              ,Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Row(children: [
                    Expanded(flex: 5,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.3),alignment: Alignment.center,child: Text("المفضلة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                    Expanded(child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("svg/Icon-alarm.svg",semanticsLabel: "wadca",))),
                    Expanded(child:InkWell(onTap: ()=>navigatetoshopping(),child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),child: SvgPicture.asset("svg/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca",))) )
                  ],),
                ),],
          )),
        ),Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),height: MediaQuery.of(context).size.height*0.75,width: MediaQuery.of(context).size.width,child:fav.length==0?Container(
          child: Center(child: Text("لا توجد أية عناصر في المفضلة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),
        ):GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width*1.5/MediaQuery.of(context).size.height),),itemCount: fav.length,itemBuilder: (context,i){
          return InkWell(onTap: ()=> null,//showdetail(i,false),
            child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black12) ,borderRadius: BorderRadius.circular(10),color: Colors.white//,boxShadow: [BoxShadow(
              //   color: Colors.black26,
              //  blurRadius: 1.0,
              //  spreadRadius: 0.0,
              //  offset: Offset(2.0, 2.0), // shadow direction: bottom right
              // )]
            ),child:Column(children: [
              Container(
                child:fav[i]["Status"].toString()=="1" ?Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(fav[i]["Photo"]),),),
                  Positioned(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.01,left:MediaQuery.of(context).size.width*0.01 ),
                    child: Row(children: [
                      Expanded(child: Container(child: fav[i]["UserFav"].toString()=="1"?
                      InkWell(onTap: ()=>showpagelogic.cancelfav(fav[i]["ID"],context),
                        child: Container(width: MediaQuery.of(context).size.width*0.09,
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,),),
                      ):InkWell(onTap: ()=> null//showpagelogic.addtofav(fa[i]["ID"],id,subcategories,context),
                        ,child: Container(width: MediaQuery.of(context).size.width*0.09,
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.white),child: Icon(Icons.favorite_border,color: Colors.black26,size: MediaQuery.of(context).size.width*0.07,),),
                      ),)),Expanded(flex: 2,child: Container()),
                      Expanded(flex: 2,child: Container(child:fav[i]["BestSeller"].toString()=="1"?
                      InkWell(onTap: ()=>null,
                        child: Container(width: MediaQuery.of(context).size.width*0.09,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          height: MediaQuery.of(context).size.width*0.09,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(254, 254, 115, 1)),child:
                          FittedBox(child: Row(children:[ Text("بائع مميز",style: TextStyle(color: Colors.indigo),),Container(width: MediaQuery.of(context).size.width*0.05,height: MediaQuery.of(context).size.width*0.05,child: Image( image:AssetImage("images/like.jpg"),fit: BoxFit.fill)),])),),
                      ):Container()))
                    ],),
                  ))])):Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,child: Image(fit: BoxFit.fill,image: NetworkImage(fav[i]["Photo"]),),),
                  Positioned(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10) ,topLeft: Radius.circular(10)),color: Colors.black12,) ,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.2,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.16),child: Container(color: Colors.red ,child: Center(child: FittedBox(child: Text("غير متاح",style: TextStyle(color: Colors.white),)),)),) ) ])),
              ),
              Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.025 ),child:Row(children:[
                Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: FittedBox(child: AutoSizeText(fav[i]["Rating"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)),))
                ,Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon(Icons.star,color: Colors.yellow.withGreen(2000),)),),
                Expanded(flex: 6,child: Container(alignment: Alignment.centerRight ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: AutoSizeText(fav[i]["Name"],maxLines: 1,style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*15),)),)
              ]) ),
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(fav[i]["Description"].toString(),maxLines: 2,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black54),)),),
            ],)
              ,),
          );
        }),)

      ],),),
    );
  }
  Widget requests(){
    return
      Directionality(textDirection: TextDirection.ltr, child:
      Container(
      child: ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :Stack(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
            decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
              Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("طلباتي",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
            ],),),
          Positioned( bottom: MediaQuery.of(context).size.height*0.04,left: MediaQuery.of(context).size.width*0.35 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
        ],) ),
        Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.02) ,child: Text("جميع الطلبات",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,fontWeight: FontWeight.bold),),)
        ,Directionality(textDirection: TextDirection.rtl,
          child: Container(
            child: myorders.length ==0?Container(height: MediaQuery.of(context).size.height*0.7,child: Center(child: Text("لا توجد طلبات مسبقة")),) : Container(
              height: MediaQuery.of(context).size.height*0.7,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child: ListView.builder(itemCount: myorders.length,itemBuilder: (context,i){
                return Container(decoration: BoxDecoration(color: Colors.white,boxShadow:[ BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                  offset: Offset(22.0, 2.0), // shadow direction: bottom right
                )]),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.01 ),
                  child:Column(
                    children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,bottom: MediaQuery.of(context).size.height*0.02),
                      child: Row(children: [
                        Expanded(flex: 1,child: Container( padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                          child: Column(children:[Container(child:Row(children :[
                            Expanded(child: Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),padding: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.02 ,left: MediaQuery.of(context).size.width*0.02),child: FittedBox(child: AutoSizeText("رقم الطلب :"  ,maxFontSize: MediaQuery.of(context).textScaleFactor*10,minFontSize: MediaQuery.of(context).textScaleFactor*10, style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*10),)),)),
                           Expanded(child:  Container(alignment: Alignment.centerRight,child:FittedBox(child: AutoSizeText(myorders[i]["OrderCode"].toString(), style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*10 ,color: Color.fromRGBO(41, 45, 43, 1)),))))
                          ])) ,
                            Container( alignment: Alignment.centerLeft,child:Row(children :[
                              Expanded(child: Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),padding: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.02 ,left: MediaQuery.of(context).size.width*0.02),child: FittedBox(child: AutoSizeText("نوع الخدمة :" ,maxFontSize: MediaQuery.of(context).textScaleFactor*10,minFontSize: MediaQuery.of(context).textScaleFactor*10, style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*10),)),)),
                             Expanded(child:  Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.ltr,child:FittedBox(child: AutoSizeText(myorders[i]["Type"], style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*10 ),)))))
                            ])) ,Container(
                              child:myorders[i]["Amount"]==null?Container(): Container( alignment: Alignment.centerLeft,child:Row(children :[
                                Expanded(child: Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),padding: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.02 ,left: MediaQuery.of(context).size.width*0.02),child: FittedBox(child: AutoSizeText("قيمة الطلب :" ,maxFontSize: MediaQuery.of(context).textScaleFactor*10,minFontSize: MediaQuery.of(context).textScaleFactor*10,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*10),)),)),
                               Expanded(child: Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.ltr,child:FittedBox(child: AutoSizeText(myorders[i]["Amount"].toString(), style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*10 ),)))))
                              ])),
                            ) ]),),),
                        Expanded(flex: 1,child: Container( padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,
                            child: Column(children:[Container(child:Row(children :[
                              Expanded(child: Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0),padding: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.02 ,left: MediaQuery.of(context).size.width*0.02),child: Directionality(textDirection: TextDirection.rtl,child: FittedBox(child: AutoSizeText("تاريخ الطلب :"  ,maxFontSize: MediaQuery.of(context).textScaleFactor*10,minFontSize: MediaQuery.of(context).textScaleFactor*10, style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*10),))),)),
                             Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.ltr,child:FittedBox(child: AutoSizeText(myorders[i]["OrderDate"],style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*10),))))),
                            ])),
                              Container(child:Row(children :[
                                Expanded(child: Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0),padding: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.02 ,left: MediaQuery.of(context).size.width*0.02),child: Directionality(textDirection: TextDirection.rtl,child: FittedBox(child: AutoSizeText("اسم التاجر : "  ,maxFontSize: MediaQuery.of(context).textScaleFactor*10,minFontSize: MediaQuery.of(context).textScaleFactor*10, style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*10),))),)),
                               Expanded(child:  Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.ltr,child:FittedBox(child: AutoSizeText(myorders[i]["StoreName"],style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*10),))))),
                              ])),Container(child:Row(children :[  Expanded(child: Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0),padding: EdgeInsets.only( right:MediaQuery.of(context).size.width*0.02 ,left: MediaQuery.of(context).size.width*0.02),child:  AutoSizeText("الحالة :"  , style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),)),
                               Expanded(child:  Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0),alignment: Alignment.centerRight,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: FittedBox(child: AutoSizeText(myorders[i]["OrderStatus"],style: TextStyle(color: Color.fromRGBO(244, 121, 27, 1) ,fontSize: MediaQuery.of(context).textScaleFactor*10),))))
                              ]),)
                            ],)))]),
                    ),
                      Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01),child: Row(children: [
                        InkWell( onTap: ()=>gotodetail(myorders[i]["ID"] , myorders[i]) ,child: Container( width: MediaQuery.of(context).size.width*0.3,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right:MediaQuery.of(context).size.width*0.01 ),height: MediaQuery.of(context).size.height*0.05,decoration: BoxDecoration(color: Color.fromRGBO(12, 145, 190, 1),borderRadius: BorderRadius.circular(5)),child:FittedBox(child: Row(children:[Icon(Icons.info,color: Colors.white,),Container(padding: EdgeInsets.all( MediaQuery.of(context).size.width*0.02) ,child:  FittedBox(child: AutoSizeText("تفاصيل",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*10,color: Colors.white)))),] )),))
                        ,Container( child:myorders[i]["OrderStatus"] =="جاري المراجعه"?   InkWell( onTap: ()=>null ,child: Container( width: MediaQuery.of(context).size.width*0.3,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right:MediaQuery.of(context).size.width*0.01 ),height: MediaQuery.of(context).size.height*0.05,decoration: BoxDecoration(color: Color.fromRGBO(246, 7, 7, 1),borderRadius: BorderRadius.circular(5)),child: FittedBox(child: Row(children:[Icon(Icons.delete,color: Colors.white,),Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,child: FittedBox(child: AutoSizeText("الغاء الطلب",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*10,color: Colors.white),))),] )),))
                            :InkWell(child: Container( width: MediaQuery.of(context).size.width*0.3,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.01 ) ,height: MediaQuery.of(context).size.height*0.05,alignment: Alignment.center ,decoration: BoxDecoration(color: Color.fromRGBO(244, 194, 27, 1),borderRadius: BorderRadius.circular(5)),child:FittedBox(child: AutoSizeText("قيم الطلب" ,maxFontSize: MediaQuery.of(context).textScaleFactor*10,minFontSize: MediaQuery.of(context).textScaleFactor*10,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13,color: Colors.white),)),) ))]))
                    ],
                  ) ,
                );
              }),
            ),
          ),
        )
      ],),
    ));
  }
  gotodetail(id ,data){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Orderdata(id : id ,data: data,);
    }));
  }
  Widget more(){
    return Directionality(textDirection: TextDirection.rtl,
      child: Container(child: ListView(children: [
        Directionality(textDirection: TextDirection.ltr,
          child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05) ,alignment: Alignment.center ,child: Row(children: [
            Expanded(flex: 3,
              child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Column(children: [
                Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07) ,alignment: Alignment.centerRight ,child: AutoSizeText(profiledata.toString()=="null"?"" :profiledata["Name"].toString(),maxLines: 1,style: TextStyle(color: Color.fromRGBO(11, 12, 58, 1),fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*17),),),
                Container(alignment: Alignment.centerRight,child: AutoSizeText(profiledata.toString()=="null"?"" :profiledata["Email"].toString(),maxLines: 1,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),),)
              ],)),
            )
            ,Expanded(child:  Container( width: MediaQuery.of(context).size.width*0.2,height: MediaQuery.of(context).size.width*0.2,child: ClipRRect(borderRadius: BorderRadius.circular(10),child:profiledata==null?Container(): Image( fit: BoxFit.fill,image: NetworkImage(profiledata["ProfilePhoto"]),)),)),
          ],),),
        ),
         InkWell(onTap: ()=>navigatetolocation(),child: Container(height: MediaQuery.of(context).size.height*0.06,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05) ,child: ListTile(trailing: Icon(Icons.arrow_forward_ios_outlined),title:Text("الموقع",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading:  Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more1.png")),)),))
,InkWell(onTap: (){
          Provider.of<Notifires>(context,listen: false).getindex(tabController, "req", 2, context);
          Future.delayed(const Duration(milliseconds: 500), () {
          Provider.of<Notifires>(context,listen: false).getmyorders( context);
        });}
        ,child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined) ,title:Text("طلباتي",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more2.png")),), ),),)
        ,InkWell(onTap: ()=>navigatetoprofile() ,child: Container(height: MediaQuery.of(context).size.height*0.06,margin: EdgeInsets.zero,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("الملف الشخصي",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11,child: SvgPicture.asset("svg/editprofile.svg",fit: BoxFit.fill,), )),)
        ),InkWell(onTap: ()=>navigatetopassword(),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("تغيير كلمة المرور",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more3.png")),), ),))
        ,InkWell(onTap: ()=>navigatetopchat(),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("محادثة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: SvgPicture.asset( "svg/chat.svg",fit: BoxFit.fill,)),),)
        ),InkWell(onTap: ()=>navigatetoppartner(),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined) ,title:Text("شركاء النجاح",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more4.png")),),))),
         InkWell(onTap: ()=>navigatetoshareapp(),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("شارك التطبيق",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: SvgPicture.asset( "images/chare.svg",fit: BoxFit.fill,)),),),
         ),InkWell(onTap: ()=>navigatetopcomplaints(),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("الاقتراحات والشكاوى",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more6.png")),),),)),
        InkWell(onTap: ()=>navigatetopaboutapp(),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined) ,title:Text("عن التطبيق",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more7.png")),),),),
        ),InkWell(onTap: ()=>navigatetoterms(),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined) ,title:Text("الشروط والأحكام",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,child: Image(fit: BoxFit.fill,image:AssetImage( "images/more8.png")),),),))
        ,InkWell(onTap: ()=>signout(),child: Container(height: MediaQuery.of(context).size.height*0.06,child: ListTile(trailing:Icon(Icons.arrow_forward_ios_outlined)  ,title:Text("تسجيل الخروج",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),leading: Container(width: MediaQuery.of(context).size.width*0.11,height: MediaQuery.of(context).size.width*0.11 ,decoration: BoxDecoration(gradient:LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent]) ),child: Icon(Icons.logout,color: Colors.white,)),),)
        )],)),
    );
  }
  navigatetolocation(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Location();
    }));
  }
  navigatetoshareapp(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shareapp();
    }));
  }
  signout()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    await Provider.of<Notifires>(context,listen: false).resetdata();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return Loginpage();
    }));
  }
  navigatetoterms(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Terms();
    }));
  }
  navigatetoprofile(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Profile();
    }));
  }
  navigatetopassword(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Changepass();
    }));
  }
  navigatetopchat(){
  //  Navigator.of(context).push(MaterialPageRoute(builder: (context){
  //    return Chat(id: profiledata["ID"],type: profiledata["Type"],);
   // }));
  }
  navigatetoppartner(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Partner(sharelink : profiledata["ShareLink"]);
    }));
  }
  navigatetopcomplaints(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Recommend();
    }));
  }
  navigatetopaboutapp(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Aboutapp();
    }));
  }
  showdetail(i){
    print(fav[i]);
  }
  showtoshowpage(i,name,sub){
   // if(i == 8){
  //    Navigator.of(context).push(MaterialPageRoute(builder: (context){
  //      return Marasil(index: i,);
   //   }));
  //  }
  //  else{
   //   if(i ==9){
    //    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //      return Mazad();
    //    }));
    //  }
     // else{
    if(false//name =="اماكن"
    ){
   //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
   //     return Places(
   //       places: homedata[i]["Places"],);
   //   }));
    }
    else {
      if(name == "مزاد"){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Mazadshow(mazads: homedata[i]["Auctions"],);
        }));
      }
      else {
        if(name == "مراسيل"){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Marasil(data: homedata[i]["SubCategories"]);
          }));
        }
        else {
          if (name == "الطهاة والمطابخ") {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Showketchins(subcategories: homedata[i]["SubCategories"],tabController: tabController,);
            }));
          }
          else {
            print(homedata[i]["ID"]);
            print(name);
            print(sub);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Showpage(
                id: homedata[i]["ID"], name: name, subcategories: sub,tabcontroller: tabController,);
            }));
          }
        }
      }
    }
    //  }
   // }
  }
}