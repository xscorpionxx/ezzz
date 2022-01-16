import 'package:ezzproject/logic/loation.dart';
import 'package:ezzproject/logic/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Location extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statelocation();
  }
}
class Statelocation extends State<Location>{
  var value1 = "المحافظة" ;
  var value2 = "المدينة" ;
  var value3 = "المنطقة" ;
  List region1list =["المحافظة"];
  List region2list =["المدينة"];
  List region3list =["المنطقة"];
  List region1back =[];
  List region2back =[];
  List region3back =[];
 Loginlogic loginlogic ;
  getdata()async{
    var dataa = await loginlogic.getdata();
    print(dataa);
    region1back = dataa["listre1"];
    region2back = dataa["listre2"];
    region3back = dataa["listre3"];
    for(int i =0 ; i<region1back.length ; i++){
      region1list.add(region1back[i]["name"].toString());
    }
    for(int a =0 ; a<region2back.length ; a++){
      region2list.add(region2back[a]["name"].toString());
    }
    for(int d =0 ; d<region3back.length ; d++){
      region3list.add(region3back[d]["name"].toString());
    }
    value1 = dataa["re1"];
    value2 = dataa["re2"];
    value3 = dataa["re3"];
    print("pravo");
    print(value1);
    setState(() {});
  }
  @override
  void initState() {
    loginlogic = new Loginlogic(context);
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
        child: ListView(children: [
         Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,child :Stack(children: [
           Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
             decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
               Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
               Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الموقع",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.05),))),
               Expanded(child: Container())
             ],),),
           Positioned( bottom: MediaQuery.of(context).size.height*0.04,left: MediaQuery.of(context).size.width*0.4 ,child : Container(width: MediaQuery.of(context).size.height*0.5,height: MediaQuery.of(context).size.height*0.5,decoration: BoxDecoration(color: Colors.white.withOpacity(0.3) , borderRadius: BorderRadius.circular(1000)),),)
         ],) ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only( top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.06),child: Text("حدد الموقع" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.045),),)
        ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only( top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.05),child: Text("المنطقة" ,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black26),),),
        Directionality(textDirection: TextDirection.rtl,
          child: Container(decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.05),child: ListTile(
            title: DropdownButtonHideUnderline(
                child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black),
                  value: value3
                  ,items: region3list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                  onChanged: (_) {
                    // val2 =_;
                    setState(() {});
                  },
                )),
          )),
        ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Text("المدينة" ,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black26),),),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.05),child: ListTile(
              title: DropdownButtonHideUnderline(
                  child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black),
                    value: value2
                    ,items: region2list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                    onChanged: (_) {
                      // val2 =_;
                      setState(() {});
                    },
                  )),
            )),
          ),Container(alignment: Alignment.centerRight,margin: EdgeInsets.only( right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.03),child: Text("المحافظة" ,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black26),),),
        Directionality(textDirection: TextDirection.rtl,
          child: Container(decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.05),child: ListTile(
            title: DropdownButtonHideUnderline(
                child: DropdownButton(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black),
                  value: value1
                  ,items: region1list.map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                  onChanged: (_) {
                    // val2 =_;
                    setState(() {});
                  },
                )),
          )),
        )
        ,
          InkWell(onTap: (){loginlogic.setlocation(value1, value2, value3);},
            child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
              child:Text("حفظ", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045)) ,),
          )
        ],),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}