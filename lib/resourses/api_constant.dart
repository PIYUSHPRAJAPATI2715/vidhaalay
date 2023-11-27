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