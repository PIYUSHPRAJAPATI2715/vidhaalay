import 'dart:io';
import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/appTheme.dart';


class ApiUrls {
  static const String apiBaseUrl = 'http://13.127.76.67:3000/api/';
  static const String register = "${apiBaseUrl}user/register";
  static const String socialUrl = "${apiBaseUrl}user/signInWithGoogle";
  static const String login = "${apiBaseUrl}user/login";
  static const String resetViaEmail = "${apiBaseUrl}user/resetViaEmail";
  static const String resetViaSms = "${apiBaseUrl}user/resetViaSMS";
  static const String getCountryState = "${apiBaseUrl}common/countryStateList";
  static const String getCityUrl = "${apiBaseUrl}common/city/";
  static const String notificationUrl = "${apiBaseUrl}notification";
  static const String getFaqUrl = "${apiBaseUrl}common/faqs";
  static const String getProfileUrl = "${apiBaseUrl}user/my-profile";
  static const String updateLocationUrl = "${apiBaseUrl}user/update-location";
  static const String updateProfileUrl = "${apiBaseUrl}user/update-profile";
  static const String changePassUrl = "${apiBaseUrl}user/changePassword";
  static const String termsConditionUrl = "${apiBaseUrl}common/pages/term-conditions";
  static const String privacyPolicyUrl = "${apiBaseUrl}common/pages/privacy-policy";
  static const String contactUsUrl = "${apiBaseUrl}common/pages/contact-us";
  static const String verifyOtpEmailSend = "${apiBaseUrl}user/resetViaEmail";
  static const String verifyMobileOtp = "${apiBaseUrl}user/verifyOtp";
  static const String verifyEmailOtp = "${apiBaseUrl}user/verifyOtpEmail";
  static const String resetViaSMS = "${apiBaseUrl}user/resetViaSMS";
  static const String otpByMobile = "${apiBaseUrl}user/otpByMobile";
  static const String addMissionUrl = "${apiBaseUrl}addmissions";
  static const String addFavUrl = "${apiBaseUrl}favourite/addFav";
  static const String resetPassword = "${apiBaseUrl}user/reset-password";
  static const String resetByMobile = "${apiBaseUrl}user/resetByMobile";
  static const String forgotOtpVerSms = "${apiBaseUrl}user/verifyOtpForgot";
  static const String forgotOtpVerEmail = "${apiBaseUrl}user/verifyOtpEmailForgot";


  // User
  static const String schoolListUrl = "${apiBaseUrl}school/list";
  static const String getSchoolDetails = "${apiBaseUrl}school";
  static const String getFavouriteListUrl = "${apiBaseUrl}favourite";
  static const String addFavourite = "${apiBaseUrl}favourite/addFav";
  static const String topLectures = "${apiBaseUrl}lectures/top-lectures";
  static const String allLectures = "${apiBaseUrl}lectures/all-lectures";
  static const String getLecturesDetails = "${apiBaseUrl}lectures/lecture-by-id";

}


Future getAuthHeader() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  // pref.getString("cookie")!.toString().replaceAll('\"', '');
  print("Enter");
  print(pref.getString("cookie"));

  var gg ={
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    // HttpHeaders.authorizationHeader:"FLWSECK_TEST-SANDBOXDEMOKEY-X"
    if(pref.getString("cookie") != null)
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}',
  };
  print('token isss${gg}');
  return gg;
}
// HttpHeaders.contentTypeHeader: 'application/json',
// HttpHeaders.acceptHeader: 'application/json',
//     HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}',

showToast(String message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppThemes.primaryColor,
      textColor: Color(0xffffffff),
      fontSize: 14);
}