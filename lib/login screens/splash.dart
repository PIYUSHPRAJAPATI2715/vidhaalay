import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routers/my_routers.dart';
import '../widgets/appTheme.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () async {
    //   SharedPreferences pref = await SharedPreferences.getInstance();
    //   if (pref.getString('cookie') != null) {
    //     Get.offAllNamed(MyRouters.introPageScreen);
    //   }
    //   else {
    //     Get.offAllNamed(MyRouters.signInPage);
    //   }
      Get.offAllNamed(MyRouters.introPageScreen);
    }
    );
  }

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
                Image.asset('assets/images/appicon.png',height: size.height*.20,),
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
