import 'dart:io';
import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/appTheme.dart';




class ApiUrls {
  static const String apiBaseUrl = 'http://13.127.76.67:3000/api/';
  static const String register = "${apiBaseUrl}user/register";
  static const String login = "${apiBaseUrl}user/login";
  static const String resetViaEmail = "${apiBaseUrl}user/resetViaEmail";
  static const String resetViaSms = "${apiBaseUrl}user/resetViaSMS";
  static const String getCountryState = "${apiBaseUrl}common/countryStateList";
  static const String getCityUrl = "${apiBaseUrl}common/city/";
  static const String notificationUrl = "${apiBaseUrl}notification";
  static const String getFaqUrl = "${apiBaseUrl}common/faqs";
  static const String getProfileUrl = "${apiBaseUrl}user/my-profile";
  static const String updateProfileUrl = "${apiBaseUrl}user/update-profile";
  static const String changePassUrl = "${apiBaseUrl}user/changePassword";
  static const String termsConditionUrl = "${apiBaseUrl}common/pages/term-conditions";
  static const String privacyPolicyUrl = "${apiBaseUrl}common/pages/privacy-policy";
  static const String contactUsUrl = "${apiBaseUrl}common/pages/privacy-policy";
  static const String schoolListUrl = "${apiBaseUrl}school/list";
  static const String getSchoolDetails = "${apiBaseUrl}school/1";



}

Future getAuthHeader() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  print(pref.getString("cookie")!.toString().replaceAll('\"', ''));
  return {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    if(pref.getString("cookie") != null)
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}',
  };
}
// HttpHeaders.contentTypeHeader: 'application/json',
// HttpHeaders.acceptHeader: 'application/json',
//     HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}',

showToast(message) {
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