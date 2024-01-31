
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/login%20screens/signin_screen.dart';
import 'package:vidhaalay_app/models/multi_login_model.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';

Future<List<MultiLoginModel>> getLoginData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? encodedData = prefs.getStringList('loginData');

  if (encodedData != null) {
    List<MultiLoginModel> data = encodedData.map((item) => MultiLoginModel.fromJson(json.decode(item))).toList();
    return data;
  } else {
    return [];
  }
}

Future<void> saveLoginData(MultiLoginModel data) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<MultiLoginModel> loginData =
  await getLoginData();
  print("loginData length : ${loginData.length}");

  if(data.type == "teacher" || data.type == "user") {
    loginData.removeWhere((model) => model.type == data.type);
  }
  loginData.removeWhere((model) => model.email.toString() == data.email.toString());

  print("loginData length : ${loginData.length}");

  List<String> encodedData = loginData.map((item) => json.encode(item.toJson())).toList();
  print("encodedData : $encodedData");

  encodedData.add(json.encode(data.toJson()));
  print("encodedData : $encodedData");

  await prefs.setStringList('loginData', encodedData);
}

Future<void> deleteRecordByToken(String token) async {
  List<MultiLoginModel> loginData = await getLoginData();

  // Remove the record with the specified email
  loginData.removeWhere((model) => model.token == token);

  // Print the updated list (for demonstration purposes)
  print(loginData);

  List<String> encodedData = loginData.map((item) => json.encode(item.toJson())).toList();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('loginData', encodedData);
}


Future<void> deleteAllRecord() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('loginData', []);
  await prefs.clear();
  Get.offAll(() => SignInPage());

  showToast("Sign out from all accounts");
}