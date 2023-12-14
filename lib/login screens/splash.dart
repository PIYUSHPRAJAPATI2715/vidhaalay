import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routers/my_routers.dart';
import '../models/get_profile_model.dart';
import '../widgets/appTheme.dart';
import '../models/login_model.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if(pref.getString("cookie") != null){
        if (pref.getBool('emailVerify') == true){
          Get.offAllNamed(MyRouters.drawerForUser);
          if (pref.getBool('mobileVerify') == true){
            Get.offAllNamed(MyRouters.drawerForUser);
          }
        }
        else{
          Get.offAllNamed(MyRouters.verifyOtpLogin);
        }
      }
      else{
        Get.offAllNamed(MyRouters.introPageScreen);
      }
      // else{
      //     Get.offAllNamed(MyRouters.introPageScreen);

    //     if(model.data!.emailVerified == true && model.data!.mobileVerified == true){
    //       Get.offAllNamed(MyRouters.drawerForUser);
    //     }else{
    //       Get.offAllNamed(MyRouters.verifyOtpLogin);
    //     }
    //
    //   }else{
    //     Get.offAllNamed(MyRouters.introPageScreen);
     }
    );}

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
          backgroundColor: AppThemes.white,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/app.png',height: 200,),
                Text('vidhaalay'.toUpperCase(),
                  style: const TextStyle(
                      color: AppThemes.primaryColor,
                      fontSize: 33,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text('Create Your Future',
                  style:  TextStyle(
                      color: AppThemes.textGray,
                      fontSize: 13,
                      fontWeight: FontWeight.w300
                  ),
                  textAlign: TextAlign.center,
                ),
                // Container(
                //   height: size.height,
                //   width: size.width,
                //   child: Image.network((
                //       'https://m.media-amazon.com/images/I/61SPYKLqJjL._AC_UF1000,1000_QL80_.jpg'
                //   ),
                //     fit: BoxFit.fill,),
                // ),
              ],
            ),
          )),
    );
  }


}
