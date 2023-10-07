import 'package:get/get.dart';

import '../controller/bottom_controller.dart';
import '../login screens/create_new_pass.dart';
import '../login screens/forgot_pass_screen.dart';
import '../login screens/intro_page_screen.dart';
import '../login screens/otp_screen.dart';
import '../login screens/signin_screen.dart';
import '../login screens/signup_screen.dart';
import '../login screens/splash.dart';
import '../resourses/bottom_nav_screen.dart';
import '../resourses/custon_drawer.dart';



class MyRouters{
  static var splash = "/splash";
  static var introPageScreen = "/introPageScreen";
  static var signInPage = "/signInPage";
  static var signupScreen = "/signupScreen";
  static var forgotPasswordScreen = "/forgotPasswordScreen";
  static var otpScreen = "/otpScreen";
  static var createPasswordScreen = "/createPasswordScreen";
  static var bottomNavigationScreen = "/bottomNavigationScreen";

  static var route = [

    // auth screens
    GetPage(name: '/', page: () =>  const Splash()),
    GetPage(name: '/introPageScreen', page: () =>  const IntroPageScreen()),
    GetPage(name: '/signInPage', page: () =>  const SignInPage()),
    GetPage(name: '/signupScreen', page: () =>  const SignupScreen()),
    GetPage(name: '/forgotPasswordScreen', page: () =>  const ForgotPasswordScreen()),
    GetPage(name: '/otpScreen', page: () =>  const OtpScreen()),
    GetPage(name: '/createPasswordScreen', page: () =>  const CreatePasswordScreen()),

    //student screens
    GetPage(name: '/bottomNavigationScreen', page: () =>  const BottomNavigationScreen()),



  ];
}