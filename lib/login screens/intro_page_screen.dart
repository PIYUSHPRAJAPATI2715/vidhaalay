import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import '../../widgets/common_button.dart';


class IntroPageScreen extends StatefulWidget {
  const IntroPageScreen({Key? key}) : super(key: key);
  static var introPageScreen = '/introPageScreen';

  @override
  State<IntroPageScreen> createState() => _IntroPageScreenState();
}

class _IntroPageScreenState extends State<IntroPageScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppThemes.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: size.width*.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Welcome',
                  style: TextStyle(
                      color: AppThemes.secondaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 20
                  ),),
                const Text('Easy to search',
                  style: TextStyle(
                      color: AppThemes.primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 23
                  ),),
                SizedBox(
                  height: size.height*.010,
                ),
                const Text('Lorem Ipsum is simply dummy text of\nthe printing and typesetting industry.',
                  style: TextStyle(
                      color: AppThemes.textGray,
                      fontWeight: FontWeight.w500,
                      fontSize: 13
                  ),),
              ],
            ),
          ),
          SizedBox(
            height: size.height*.070,
          ),
          Image.asset(AppAssets.introImg,fit: BoxFit.fitWidth,height: size.height*.40,width: size.width,),
          SizedBox(
            height: size.height*.035,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: size.width*.06),
            child: SizedBox(
              width: size.width,
              child: CommonButton(
                title: 'get started'.toUpperCase(),
                onPressed: () async {
                  final pref = await SharedPreferences.getInstance();
                  pref.setBool("isFirstTime", false);

                  Get.offAllNamed(MyRouters.signInPage);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}