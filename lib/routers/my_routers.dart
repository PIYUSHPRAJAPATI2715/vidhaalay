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
import '../screen/User_Screens/bottom_nav_user.dart';
import '../screen/User_Screens/change_password_user.dart';
import '../screen/User_Screens/drawer_user.dart';
import '../screen/User_Screens/favorites_screen.dart';
import '../screen/User_Screens/my_profile_screen.dart';
import '../screen/User_Screens/registrtion_screens.dart';
import '../screen/User_Screens/schools_details_Screen.dart';
import '../screen/User_Screens/setting_screen.dart';
import '../screen/student_screen/more_screen.dart';



class MyRouters{
  static var splash = "/splash";
  static var introPageScreen = "/introPageScreen";
  static var signInPage = "/signInPage";
  static var signupScreen = "/signupScreen";
  static var forgotPasswordScreen = "/forgotPasswordScreen";
  static var otpScreen = "/otpScreen";
  static var createPasswordScreen = "/createPasswordScreen";
  static var bottomNavigationScreen = "/bottomNavigationScreen";
  static var schoolsDetailsScreen = "/schoolsDetailsScreen";
  static var settingScreenUser = "/settingScreenUser";
  static var changePasswordUser = "/changePasswordUser";
  static var myProfileScreen = "/myProfileScreen";
  static var favoritesScreen = "/favoritesScreen";
  static var registrationScreen = "/registrationScreen";
  static var drawerForUser = "/drawerForUser";

  static var bottomNavigationUserScreen = "/bottomNavigationUserScreen";

  static var route = [

    // auth screens
    GetPage(name: '/', page: () =>  const MoreScreen()),
    GetPage(name: '/introPageScreen', page: () =>  const IntroPageScreen()),
    GetPage(name: '/signInPage', page: () =>  const SignInPage()),
    GetPage(name: '/signupScreen', page: () =>  const SignupScreen()),
    GetPage(name: '/forgotPasswordScreen', page: () =>  const ForgotPasswordScreen()),
    GetPage(name: '/otpScreen', page: () =>  const OtpScreen()),
    GetPage(name: '/createPasswordScreen', page: () =>  const CreatePasswordScreen()),

    //student screens
    GetPage(name: '/bottomNavigationScreen', page: () =>  const BottomNavigationScreen()),

    //user screens
    GetPage(name: '/bottomNavigationUserScreen', page: () =>  const BottomNavigationUserScreen()),
    GetPage(name: '/schoolsDetailsScreen', page: () =>  const SchoolsDetailsScreen()),
    GetPage(name: '/settingScreenUser', page: () =>  const SettingScreenUser()),
    GetPage(name: '/changePasswordUser', page: () =>  const ChangePasswordUser()),
    GetPage(name: '/myProfileScreen', page: () =>  const MyProfileScreen()),
    GetPage(name: '/favoritesScreen', page: () =>  const FavoritesScreen()),
    GetPage(name: '/registrationScreen', page: () =>  const RegistrationScreen()),

    GetPage(name: '/drawerForUser', page: () =>  const DrawerForUser()),
  ];
}