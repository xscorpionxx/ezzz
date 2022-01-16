import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/detailpage.dart';
import 'package:ezzproject/logic/home.dart';
import 'package:ezzproject/logic/home2.dart';
import 'package:ezzproject/logic/shoppingcart.dart';
import 'package:ezzproject/logic/showpage.dart';
import 'package:ezzproject/screens/home.dart';
import 'package:ezzproject/screens/home2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ezzproject/logic/reviews.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Mainlogic{
 // final FirebaseMessaging fire = FirebaseMessaging.instance;
  var message ;
  var data;
  var token ;
  var type;
 // Future<String> gettoken(){
  //  fire.getToken().then((value){
  //    token = value;
 //     return value;
 //   });
  //}
  Future login(email ,password)async{
    var data = {"email": email, "password": password , "fb_token" :"wdaadaw"};
    //put here the url to add account
    var url = "https://azz.sla-request.com/api/login";
    var response = await http.post(Uri.parse(url), body: data);
    var body = jsonDecode(response.body);
    if(body["status"]==true) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      sharedPreferences.setString("token", body["data"]["API_Key"]);
    }
    message = body["msg"];
    type = body["data"]["Type"];
    return body["msg"];
  }
  Future getdata() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("basket", "null");
    var email =   sharedPreferences.getString("email");
    var password = sharedPreferences.getString("password");
    data ={
      "email" :email , "password" : password
    };
    return data ;
  }
}
class Notifires extends ChangeNotifier{
  List homedata =[];
  List banner =[] ;
  var adtime ;
  List ads =[];
  void getdatahomecats(context)async{
    if(homedata.length>=1){
      homedata.clear();
      notifyListeners();
    }
    Homelogic homelogic = Homelogic(context);
    var dats = await homelogic.getdata();
    homedata = dats["categories"];
    List homedatas =[null,null,null,null,null,null,null,null,null,null];
    for(int f =0 ; f<homedata.length ; f++){
      if(homedata[f]["Name"] == "مزاد"){
        homedatas[0] = homedata[f];
      }else{
        if(homedata[f]["Name"] =="مراسيل"){
          homedatas[1] = homedata[f];
        }else{
          if(homedata[f]["Name"] == "بائعين ذبائح"){
           homedatas[2] = homedata[f];
          }
          else{
            if(homedata[f]["Name"] == "بائعين جمله"){
                 homedatas[3] = homedata[f];
            }else{
              if(homedata[f]["Name"] =="الطهاة والمطابخ"){
                homedatas[4] = homedata[f];
              }else{
                if(homedata[f]["Name"] == "اسر منتجة"){
                  homedatas[5] = homedata[f];
                }
                else{
                  if(homedata[f]["Name"] == "اماكن"){
                    homedatas[6] = homedata[f];
                  }else{
                    if(homedata[f]["Name"] == "ملاحم الجزارة"){
                      homedatas[7] = homedata[f];
                    }else{
                      if(homedata[f]["Name"] == "مزارع بيع الطيور"){
                        homedatas[8] = homedata[f];
                      }
                      else{
                        if(homedata[f]["Name"] == "ماكولات بحرية"){
                          homedatas[9] = homedata[f];
                        }
                      }
                    }
                  }
                }
          }
        }
      }
    }}}
    homedata = homedatas;
    adtime = dats["adtime"];
    banner = dats["banner"];
    ads = dats["ad"];
    print(ads);
    print(homedata);
    notifyListeners();
  }
  var adsable = true;
  setads(){
   adsable = false;
   notifyListeners();
  }
  var searchable = false;
  setsearch(){
    if(searchable){
      searchable= false;
    }
    else{
      searchable = true;
    }
    notifyListeners();
  }
  var profiledata;
  void getprofile(context,update)async{
    print(profiledata);
    if(profiledata ==null || update) {
      Homelogic homelogic = Homelogic(context);
      var dats = await homelogic.getprofiledata();
      print("gere");
      print(dats);
      profiledata = dats["profiledata"];
      notifyListeners();
    }
  }
  resetdata(){
    profiledata = null;
    services = [];
  }
  List providers = [];
  void getdatashowpage(id,subcategories,context)async{
    if(providers.length>=1){
      providers.clear();
      notifyListeners();
    }
    Showpagelogic showpagelogic = new Showpagelogic(context);
    var dats = await showpagelogic.getshowpage(id ,subcategories);
    if(dats ==null){
      providers =[];
    }
    else{
      providers =dats;
    }
    print(providers);
    notifyListeners();
  }
  List ketchins =[];
  List cookers =[];
  void getdatashowkechins(subcategories,context)async{
    if( ketchins.length>1){
      ketchins.clear();
      if(cookers.length>=1 ) {
        cookers.clear();
      }
      notifyListeners();
    }
    Showpagelogic showpagelogic = new Showpagelogic(context);
    var dats = await showpagelogic.getshowketchins(subcategories);
    if(dats ==null){
      ketchins =[];
      cookers=[];
    }
    else{
      cookers =dats["1"];
      ketchins =dats["2"];
    }
    notifyListeners();
  }
  Map<dynamic,dynamic> home_provider = {"ProviderCancelHint":" " ,"ProviderCommission":"0",
    "ProviderTransport":"0" ,"ProviderInOrder":"0" , "ProviderNewOrder" : "0" , "ProviderCancelOrder":"0" , "ProviderCompleteOrder" : "0","ProviderStatus" : "1" ,"ProviderTotalSales" :"0"};
  void gethome_provider(context)async{
    Home2logic home2 = new Home2logic(context);
    var dats = await home2.gethomeprovider();
    print(dats);
    home_provider = null;
    home_provider =dats;
    notifyListeners();
  }
  List myorders =[];
  void getmyorders(context)async{
        Homelogic homelogic = Homelogic(context);
        var dats = await homelogic.getmyorders();
        print(dats);
        if (dats.length == 0) {
          myorders = [];
        }
        else {
          myorders = dats;
        }
        notifyListeners();
  }
  List shoppinglist = [];
  void getdatadetailpage(products)async{
    shoppinglist.clear();
    totalprice = 0;
    for(int i = 0 ; i<products.length ; i++){
      shoppinglist.add({"id" : products[i]["ID"] , "num" : 0});
    }
    print("done");
    print(shoppinglist);
    notifyListeners();
  }
  int totalprice =0;
  plus(id,i,num,price,context)async{
    Detailpagelogic detailpagelogic = new Detailpagelogic(context);
    //shoppinglist[i]["num"] = shoppinglist[i]["num"]+1;
   // totalprice = totalprice + price;
    var trues = await detailpagelogic.addtocart(id.toString() , true);
    if(trues) {
       showDialog(context: context, builder: (context) {
        return AlertDialog(
          content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.2,child: SingleChildScrollView(
            child: Column(children: [
              Container(height: MediaQuery.of(context).size.height*0.05,
                child: Directionality(
                    textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text("تمت الاضافة بنجاح",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
              ),
              Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                child: InkWell(onTap: (){
                  Navigator.of(context).pop("dialog");
                },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
              )
            ],),
          ),),
        );
      });
      notifyListeners();
    }
    else{
      shoppinglist[i]["num"] = shoppinglist[i]["num"]-1;
      totalprice = totalprice - price;
      notifyListeners();
    }
  }
  var valuehome2 = "يومي";
  setvalue(_){
    valuehome2 = _;
    notifyListeners();
  }
  minus(id,i , num , price,context)async{
    if(num !=0){
      Detailpagelogic detailpagelogic = new Detailpagelogic(context);
      shoppinglist[i]["num"] = shoppinglist[i]["num"]-1;
      totalprice = totalprice - price;
      var trues = await detailpagelogic.addtocart(id.toString() , false);
      if(trues) {
        notifyListeners();
      }
      else{
        shoppinglist[i]["num"] = shoppinglist[i]["num"]+1;
        totalprice = totalprice + price;
        notifyListeners();
      }
    }
  }
  List shoppingcart =[];
  int totalpricecart = 0;
  plus2(id,i,num,price,context)async{
    Detailpagelogic detailpagelogic = new Detailpagelogic(context);
    //shoppinglist[i]["num"] = shoppinglist[i]["num"]+1;
    //totalpricecart = totalpricecart + price;
    var trues = await detailpagelogic.addtocart(id.toString() , true);
    if(trues) {
      Shoppingcartlogic shoppingcartlogic = Shoppingcartlogic(context);
      var dats = await shoppingcartlogic.getcart();
      if(dats["data"]["products"].toString().trim() =="null"){
      }
      else {
        shoppingcart = dats["data"]["products"];
        totalpricecart = 0;
        for(int f= 0; f<dats["data"]["products"].length ; f++){
          print(totalpricecart.toString());
          print(int.parse(totalpricecart.toString()));
          totalpricecart = int.parse(dats["data"]["products"][f]["Total"].toString()) +int.parse(totalpricecart.toString());
        }
      }
      notifyListeners();
    }
    else{
      shoppinglist[i]["num"] = shoppinglist[i]["num"]-1;
      totalprice = totalprice - price;
      notifyListeners();
    }
  }
  minus2(id,i , num , price,context)async{
    if(num !=1){
      Detailpagelogic detailpagelogic = new Detailpagelogic(context);
      //shoppinglist[i]["num"] = shoppinglist[i]["num"]-1;
      //totalpricecart = totalpricecart - price;
      var trues = await detailpagelogic.addtocart(id.toString() , false);
      if(trues) {
        Shoppingcartlogic shoppingcartlogic = Shoppingcartlogic(context);
        var dats = await shoppingcartlogic.getcart();
        if(dats["data"]["products"].toString().trim() =="null"){
        }
        else {
          shoppingcart = dats["data"]["products"];
          totalpricecart = 0;
          for(int f= 0; f<dats["data"]["products"].length ; f++){
            print(totalpricecart.toString());
            print(int.parse(totalpricecart.toString()));
            totalpricecart = int.parse(dats["data"]["products"][f]["Total"].toString()) +int.parse(totalpricecart.toString());
          }
        }
          notifyListeners();
      }
      else{
       shoppinglist[i]["num"] = shoppinglist[i]["num"]+1;
        totalprice = totalprice + price;
        notifyListeners();
      }
    }
  }
  delete(i ,  price,context)async{
      Shoppingcartlogic shoppingcartlogic = new Shoppingcartlogic(context);
      var trues = await shoppingcartlogic.delteproduct(shoppinglist,i);
      if(trues) {
        var totalsprice= int.parse(price.toString()) * int.parse(shoppinglist[i]["num"].toString());
        totalprice = totalprice - totalsprice;
        shoppinglist.removeAt(i);
        shoppingcart.removeAt(i);
        print(totalsprice);
        notifyListeners();
      }
      else{
    }
  }
   List favdata =[];
  void getfav(context) async{
      Homelogic homelogic = Homelogic(context);
      var dats = await homelogic.getfav(context);
      print(dats);
      print("here");
      if(dats == null){
      }
      else {
        favdata = dats;
        print("favo");
        print(favdata);
        notifyListeners();
      }
  }
  List searchresult =[];
  search(List data, var query)async{
    var newlist =[];
    for(int r =0; r< data.length ; r++){
      newlist.add(data[r]["Name"]);
    }
    newlist = query.isEmpty ? newlist : newlist.where((p) => p.contains(query)).toList();
    List newlistsuggest =[];
    for(int e =0; e<data.length ;e++){
      for(int s =0 ; s<newlist.length ; s++){
        if(data[e]["Name"].toString().trim() == newlist[s]){
          newlistsuggest.add(data[e]);
        }
      }
    }
    searchresult = newlistsuggest;
    print(searchresult);
    notifyListeners();
  }
  List searchplaces =[];
  List searchresult2 =[];
  search2(List data, var query)async{
    var newlist =[];
    for(int r =0; r< data.length ; r++){
      newlist.add(data[r]["Name"]);
    }
    newlist = query.isEmpty ? newlist : newlist.where((p) => p.contains(query)).toList();
    List newlistsuggest =[];
    for(int e =0; e<data.length ;e++){
      for(int s =0 ; s<newlist.length ; s++){
        if(data[e]["Name"].toString().trim() == newlist[s]){
          newlistsuggest.add(data[e]);
        }
      }
    }
    searchresult2 = newlistsuggest;
    print(searchresult);
    notifyListeners();
  }
  searchplace(List data, var query)async{
    var newlist =[];
    for(int r =0; r< data.length ; r++){
      newlist.add(data[r]["Name"]);
    }
    newlist = query.isEmpty ? newlist : newlist.where((p) => p.contains(query)).toList();
    List newlistsuggest =[];
    for(int e =0; e<data.length ;e++){
      for(int s =0 ; s<newlist.length ; s++){
        if(data[e]["Name"].toString().trim() == newlist[s]){
          newlistsuggest.add(data[e]);
        }
      }
    }
    searchplaces = newlistsuggest;
    for(int g= 0 ; g<searchplaces.length ; g++){
      print(searchplaces[g]["Name"]);
    }
    notifyListeners();
  }
  alertmessage(message ,context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        content:Container(height: MediaQuery.of(context).size.height*0.1,child: Column(children: [
          Container(
            child: Directionality(
                textDirection: TextDirection.rtl, child: Center(child: new FittedBox(child: Text(message,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04),)))),
          ),
          InkWell(onTap: (){
            Navigator.of(context).pop("dialog");
            Navigator.of(context).pop();
          },child:Container(width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ), decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20)),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),))
        ],),),
      );
    });
  }
  var active = "home";
  void getindex(tab,name,ind,context){
    active = name;
    tab.animateTo(ind);
    notifyListeners();
  }
  var active2 = "home";
  void getinde2x(tab,name,ind,context){
    active2 = name;
    tab.animateTo(ind);
    notifyListeners();
  }
  var sectionketchins = "1";
  void ketchinssections(name){
    sectionketchins = name;
    notifyListeners();
  }
  void reset(){
    active2 = "home";
    active = "home";
    notifyListeners();
  }
  List services =[];
  var downloadservice = false;
  void getservices(context)async{
    Home2logic home2logic = Home2logic(context);
    var dats = await home2logic.getservices();
    services  = dats;
    downloadservice = true;
    print(services);
    notifyListeners();
  }
  List cupons =[];
  void getcupon(context)async{
    Home2logic home2logic = Home2logic(context);
    var dats = await home2logic.getcupons();
    cupons  = dats;
    notifyListeners();
  }
  List reviews =[];
  void getallreview(id)async{
    var context;
    Reviewslogic reviewslogic = Reviewslogic(context);
    var dats = await reviewslogic.getreview(id);
    reviews  = dats;
    notifyListeners();
  }
  var location;
  int discountprice = 0;
  void discountget(newprice){
    discountprice = newprice;
    notifyListeners();
  }
  int discointres = 0;
  void discountgetres(newprice){
    discountprice = newprice;
    notifyListeners();
  }
  void getcart(context)async{
    if(shoppingcart.length>=1){
      shoppingcart.clear();
      notifyListeners();
    }
    print("here");
    Shoppingcartlogic shoppingcartlogic = Shoppingcartlogic(context);
    var dats = await shoppingcartlogic.getcart();
    print(dats);
    print(dats["data"]["products"].toString().trim());
    if(dats["data"]["products"].toString().trim() =="null"){
    }
    else{
      shoppingcart  = dats["data"]["products"];
      totalpricecart =0;
      for(int f= 0; f<dats["data"]["products"].length ; f++){
        print(totalpricecart.toString());
        print(int.parse(totalpricecart.toString()));
       totalpricecart = int.parse(dats["data"]["products"][f]["Total"].toString()) +int.parse(totalpricecart.toString());
      }
      print(totalpricecart);
      shoppinglist.clear();
      for(int i = 0 ; i<shoppingcart.length ; i++){
        shoppinglist.add({"id" : shoppingcart[i]["ID"] , "num" : shoppingcart[i]["Qt"] });
      }
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      location = sharedPreferences.getString("region1");
    }
    notifyListeners();
  }
}