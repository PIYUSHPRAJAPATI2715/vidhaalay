import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/PractiseScreen/bottom_practice.dart';
import 'package:vidhaalay_app/screen/bottom_navbar_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/drawer_student.dart';
import '../../routers/my_routers.dart';
import '../models/get_profile_model.dart';
import '../screen/User_Screens/bottom_nav_user.dart';
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
    Timer(const Duration(seconds: 1), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      bool? isFirstTime = pref.getBool("isFirstTime");
      bool? isLoggedIn = pref.getBool("isLoggedIn");
      // String? cookie = pref.getString("cookie");

      // Get.offAll(() => BottomPractise());

      if (isFirstTime == null) {
        print("Enter0");
        Get.offAllNamed(MyRouters.introPageScreen);
      } else if (isLoggedIn == null || !isLoggedIn) {
        print("Enter1");
        Get.offAllNamed(MyRouters.signInPage);
      } else {
        String? userType = pref.getString("type");
        print("userType : $userType");

        if(userType == "student") {
          Get.offAll(() => BottomBarScreen(userType: 2,));
        } else if(userType == "user") {
          Get.offAll(() => BottomBarScreen(userType: 0,));
        } else if(userType == "teacher") {
          Get.offAll(() => BottomBarScreen(userType: 1,));
        } else {
          Get.offAllNamed(MyRouters.signInPage);
        }

        // if(userType == "student") {
        //    // Get.offAllNamed(MyRouters.drawerForStudent);
        //    Get.offAll(() => DrawerForStudent());
        //    // Get.offAllNamed(MyRouters.bottomNavigationStudentScreen);
        //
        // } else if(userType == "user") {
        //   // Get.offAll(()=>BottomNavigationUserScreen());
        //   // Get.offAllNamed(MyRouters.bottomNavigationScreen);
        //   Get.offAllNamed(MyRouters.drawerForUser);
        // } else if(userType == "teacher") {
        //   Get.offAllNamed(MyRouters.drawerForTeacher);
        // } else {
        //   // Get.offAllNamed(MyRouters.drawerForUser);
        //   Get.offAllNamed(MyRouters.signInPage);
        // }
      }
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
                Image.asset('assets/images/New-Project-1-1.GIF'),
                // Text('vidhaalay'.toUpperCase(),
                //   style: const TextStyle(
                //       color: AppThemes.primaryColor,
                //       fontSize: 33,
                //       fontWeight: FontWeight.w800,
                //       letterSpacing: 2
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // const Text('Create Your Future',
                //   style:  TextStyle(
                //       color: AppThemes.textGray,
                //       fontSize: 13,
                //       fontWeight: FontWeight.w300
                //   ),
                //   textAlign: TextAlign.center,
                // ),
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
