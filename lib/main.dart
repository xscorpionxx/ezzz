import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/Loginpage.dart';
import 'package:ezzproject/screens/aboutapp.dart';
import 'package:ezzproject/screens/addauction.dart';
import 'package:ezzproject/screens/addcoupons.dart';
import 'package:ezzproject/screens/addreview.dart';
import 'package:ezzproject/screens/addservice.dart';
import 'package:ezzproject/screens/addservice2.dart';
import 'package:ezzproject/screens/addservice3.dart';
import 'package:ezzproject/screens/allreviews.dart';
import 'package:ezzproject/screens/changepassword.dart';
import 'package:ezzproject/screens/chat.dart';
import 'package:ezzproject/screens/confirmation.dart';
import 'package:ezzproject/screens/confirmchefs.dart';
import 'package:ezzproject/screens/cupons.dart';
import 'package:ezzproject/screens/detailpage.dart';
import 'package:ezzproject/screens/editservice.dart';
import 'package:ezzproject/screens/editservice2.dart';
import 'package:ezzproject/screens/editservice3.dart';
import 'package:ezzproject/screens/error.dart';
import 'package:ezzproject/screens/home.dart';
import 'package:ezzproject/screens/home2.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/marasil_detail.dart';
import 'package:ezzproject/screens/mazadat.dart';
import 'package:ezzproject/screens/notification.dart';
import 'package:ezzproject/screens/orderdata.dart';
import 'package:ezzproject/screens/orders.dart';
import 'package:ezzproject/screens/partner.dart';
import 'package:ezzproject/screens/profile.dart';
import 'package:ezzproject/screens/profile2.dart';
import 'package:ezzproject/screens/recommend.dart';
import 'package:ezzproject/screens/request.dart';
import 'package:ezzproject/screens/reservation.dart';
import 'package:ezzproject/screens/send_reqeust.dart';
import 'package:ezzproject/screens/services.dart';
import 'package:ezzproject/screens/shareapp.dart';
import 'package:ezzproject/screens/shoppingcart.dart';
import 'package:ezzproject/screens/showimages.dart';
import 'package:ezzproject/screens/showpage.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:ezzproject/screens/sucess.dart';
import 'package:ezzproject/screens/terms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/Loginpage.dart';
import 'screens/addservice.dart';
import 'screens/home.dart';
import 'screens/home.dart';
Mainlogic mainlogic = new Mainlogic();
void main() {
  runApp(
 ChangeNotifierProvider(create: (_){
   return Notifires();
 },child: MyApp(),)
     );
}
class MyApp extends StatelessWidget {
  Mainlogic mainlogic = new Mainlogic();
  @override
  Widget build(BuildContext context) {
    return
    MaterialApp(theme: ThemeData(fontFamily: 'Tajawal'),title: "Ezz",debugShowCheckedModeBanner: false,
   home:Home()
      // Section1(username: data,)
   );
      FutureBuilder(future: mainlogic.getdata() , builder: (context ,snapshot ){
      if(snapshot.hasError){
        return MaterialApp(title: "error",debugShowCheckedModeBanner: false,
          home: Loginpage());
      }
      if(snapshot.connectionState ==ConnectionState.done){
        if(mainlogic.data["email"] !=null){
          return    FutureBuilder(future: mainlogic.login(mainlogic.data["email"],mainlogic.data["password"]) , builder: (context ,snapshot ){
            if(snapshot.hasError){
              return MaterialApp(theme: ThemeData(fontFamily: 'Tajawal'),title: "Faltery",debugShowCheckedModeBanner: false,
                  home: Erroralert());
            }
            if(snapshot.connectionState ==ConnectionState.done){
              return MaterialApp(theme: ThemeData(fontFamily: 'Tajawal'),title: "Flatery",debugShowCheckedModeBanner: false,
                  home: mainlogic.message !="Login successfully" ? Loginpage():mainlogic.type =="تاجر"?Home2(): Home() //Section1(username: data,)
              );
            }
            return MaterialApp(title:"Loading",debugShowCheckedModeBanner: false,
              home: Scaffold(body: Center(child: CircularProgressIndicator()),),);
          });
        }
        else{
          return MaterialApp(theme: ThemeData(fontFamily: 'Tajawal'),title: "Flatery",debugShowCheckedModeBanner: false,
              home: Loginpage()
          );
        }
      }
      return MaterialApp(title:"Loading",debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator()),),);
    },);
  }
}
