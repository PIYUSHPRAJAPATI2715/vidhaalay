


import 'package:get/get.dart';
import 'package:vidhaalay_app/login%20screens/splash.dart';

class MyRouters{
  static var signInPage = "/signInPage";
  static var splash = "/splash";

  static var route = [
    GetPage(name: '/', page: () =>  const Splash()),
    // GetPage(name: '/signInPage', page: () =>  const SignInPage()),



  ];
}