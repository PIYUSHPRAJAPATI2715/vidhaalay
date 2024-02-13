
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/controller/authentication/signin_controller.dart';
import 'package:vidhaalay_app/login%20screens/signin_screen.dart';
import 'package:vidhaalay_app/models/login_model.dart';
import 'package:vidhaalay_app/models/multi_login_model.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';


logOutUser(BuildContext context) async {
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  print("Enter000 delete start");
  print("Enter000 delete start");
  deleteRecordByEmail(sharedPreference.getString("email")!);


  Future.delayed(Duration(seconds: 1), () async {
    LoginModel modelSiteSettings = LoginModel();
    // printAllRecord();
    if (sharedPreference.getString("token") != null) {
      // deleteRecordByToken(sharedPreference.getString("token")!);
      modelSiteSettings =
          LoginModel.fromJson(jsonDecode(sharedPreference.getString("token")!));
    }

    List<MultiLoginModel> loginData = await getLoginData();
    print("Enter000 before save");
    printAllRecord();
    await sharedPreference.clear();

    if(loginData.isNotEmpty) {
      saveLoginListAllData(loginData,context);

      // print("Enter000 after save");
      // printAllRecord();
    } else {
      Get.offAllNamed(MyRouters.signInPage);
      showToast(message:"Logged out");
      if (modelSiteSettings.data != null) {
        sharedPreference.setString("token", jsonEncode(modelSiteSettings));
      }
    }
    sharedPreference.setBool("isFirstTime", false);
  });
}

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

Future<void> saveLoginListAllData(List<MultiLoginModel> data,BuildContext context) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> encodedData = data.map((item) => json.encode(item.toJson())).toList();
  print("encodedData : $encodedData");

  await prefs.setStringList('loginData', encodedData);

  MultiLoginModel lastData = data[data.length - 1];

  final signInController = Get.put(SignInController());

  signInController.login(
    context: context,
    email: lastData.email!,
    type: lastData.type!,
    pass: lastData.password!,
  );
}

Future<void> saveLoginData(MultiLoginModel data) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<MultiLoginModel> loginData =
  await getLoginData();
  print("loginData length : ${loginData.length}");

  if(data.type == "teacher" || data.type == "user") {
    loginData.removeWhere((model) => model.type == data.type);
  } else {
    loginData.removeWhere((model) => model.email.toString() == data.email.toString());
  }
  print("loginData length : ${loginData.length}");

  List<String> encodedData = loginData.map((item) => json.encode(item.toJson())).toList();
  print("encodedData : $encodedData");

  encodedData.add(json.encode(data.toJson()));
  print("encodedData : $encodedData");

  await prefs.setStringList('loginData', encodedData);
}

// Future<void> deleteRecordByToken(String token) async {
//   List<MultiLoginModel> loginData = await getLoginData();
//
//   // Remove the record with the specified email
//   loginData.removeWhere((model) => model.token == token);
//
//   // Print the updated list (for demonstration purposes)
//   print(loginData);
//
//   List<String> encodedData = loginData.map((item) => json.encode(item.toJson())).toList();
//   print("encodedData: $encodedData");
//
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setStringList('loginData', encodedData);
// }

Future<void> deleteRecordByEmail(String email) async {
  print("email $email");
  List<MultiLoginModel> loginData = await getLoginData();

  print("encodedData delete000: $loginData");
  print("encodedData delete000: ${loginData.length}");

  loginData.removeWhere((model) => model.email == email);

  List<String> encodedData = loginData.map((item) => json.encode(item.toJson())).toList();
  print("encodedData delete000: $encodedData");
  print("encodedData delete000: ${encodedData.length}");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('loginData', encodedData);
  print("Enter000 Delete complete");
  printAllRecord();
}

Future<void> deleteAllRecord() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('loginData', []);
  await prefs.clear();
  Get.offAll(() => SignInPage());

  showToast(message:"Sign out from all accounts");
}


Future<void> printAllRecord() async {
  List<MultiLoginModel> loginData = await getLoginData();
  List<String> encodedData = loginData.map((item) => json.encode(item.toJson())).toList();
  print("encodedData delete: $encodedData");
  print("encodedData delete: ${encodedData.length}");
}