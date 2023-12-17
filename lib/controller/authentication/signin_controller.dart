import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/login%20screens/verify_screen_sms_mail.dart';
import 'package:vidhaalay_app/models/favourite_model_user.dart';
import 'package:vidhaalay_app/models/login_model.dart';
import 'package:vidhaalay_app/models/school_list_model.dart';
import 'package:vidhaalay_app/repositories/login_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';

class SignInController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  // final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final TextEditingController pinController = TextEditingController();
  RxBool isPasswordVisibile = true.obs;
  bool showValidation = false;

  RxString userType = "user".obs;
  List<Map> userTypeData = [
    { 'key': 'user', 'value': 'Institute Finding' },
    { 'key': 'teacher', 'value': 'Faculty Login' },
    { 'key': 'student', 'value': 'Student Login' }
  ];

  RxBool isLoading = false.obs;


  String deviceType = '';
  String deviceToken = '';



  getDeviceInfo() async {
    deviceType = getDeviceType();
    print("deviceType : $deviceType");
    deviceToken = (await FirebaseMessaging.instance.getToken())!;
    print("deviceToken : $deviceToken");
  }

  String getDeviceType() {
    if (Platform.isAndroid) {
      return 'A';
    } else if (Platform.isIOS) {
      return 'I';
    } else {
      return 'Unknown';
    }
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      var userInfo = <String, dynamic>{};
      userInfo['email'] = emailController.text;
      userInfo['password'] = passwordController.text;
      userInfo['type'] =  userType.value;
      userInfo['device_type'] = deviceType;
      userInfo['device_token'] = deviceToken;
      print("userInfo : $userInfo");

      final headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      };

      http.Response response = await http.post(Uri.parse(ApiUrls.login),
          headers: headers,
          body: jsonEncode(userInfo));

      Map<String, dynamic> responseData = json.decode(response.body);
      print("responseData : ${responseData}");
      print(response.statusCode);


      if (response.statusCode == 200) {
        Helpers.hideLoader(loader);
        showToast(responseData['msg'].toString());

        final value  = LoginModel.fromJson(jsonDecode(response.body));
        print("value : $value");

        bool isEmailVerify = value.data!.emailVerified!;
        bool isMobileVerify = value.data!.mobileVerified!;
        print("isEmailVerify : $isEmailVerify");
        print("isMobileVerify : $isMobileVerify");

        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('cookie', value.data!.token.toString());
        pref.setString('type', value.data!.userType.toString());
        pref.setBool('emailVerify', isEmailVerify);
        pref.setBool('mobileVerify', isMobileVerify);

        if(!isEmailVerify || !isMobileVerify) {
          print("E0");
          // Get.to(() => VerifyOtpLogin());
          Get.offAllNamed(MyRouters.verifyOtpLogin,arguments: [value.data!.email.toString(),value.data!.mobile.toString(), isMobileVerify,isEmailVerify]);

          // Get.offAndToNamed(MyRouters.verifyOtpLogin, arguments: [value.data!.email.toString(),value.data!.mobile.toString()]);
        }
        // else if (!isMobileVerify) {
        //   print("E1");
        //   Get.offAllNamed(MyRouters.verifyOtpLogin,arguments: [value.data!.email.toString(),value.data!.mobile.toString(), isMobileVerify,isEmailVerify]);
        //
        //   // Get.offAndToNamed(MyRouters.verifyOtpLogin, arguments: [value.data!.email.toString(),value.data!.mobile.toString()]);
        // }
        else {
          pref.setBool('isLoggedIn', true);
          Get.offAllNamed(MyRouters.drawerForUser);
        }

      } else {
        Helpers.hideLoader(loader);
        showToast(responseData['msg'].toString());

      }

      // loginRepo(context: context,type:'user',email: emailController.text.trim(),
      //     password: passwordController.text.trim(),deviceType: getDeviceType().toString() ,deviceToken: token
      // ).then((value) async {
      //   if(value.status == true){
      //     log("fvfbgfbgf${value.data!.token}");
      //     SharedPreferences pref = await SharedPreferences.getInstance();
      //     pref.setString('cookie', value.data!.token.toString());
      //     pref.setBool('emailVerify', value.data!.emailVerified!);
      //     pref.setBool('mobileVerify', value.data!.mobileVerified!);
      //     log("fvfbgfbgf${value.data!.token}");
      //     log("fvfbgfbgf${value.data!.email}");
      //     // controller.emailController.text = value.data!.email.toString();
      //     if(value.data!.emailVerified == true && value.data!.mobileVerified == true){
      //       Get.offAllNamed(MyRouters.drawerForUser);
      //       showToast(value.msg.toString());
      //     }else{
      //       Get.offAndToNamed(MyRouters.verifyOtpLogin, arguments: [value.data!.email.toString(),value.data!.mobile.toString()]);
      //     }
      //   }else{
      //     showToast(value.msg.toString());
      //   }
      // });
    }
  }

// login(token) {
  //   if (formKey.currentState!.validate()) {
  //     FocusManager.instance.primaryFocus!.unfocus();
  //     loginRepo(context: context,type:'user',email: emailController.text.trim(),
  //         password: passwordController.text.trim(),deviceType: getDeviceType().toString() ,deviceToken: token
  //     ).then((value) async {
  //       if(value.status == true){
  //         log("fvfbgfbgf${value.data!.token}");
  //         SharedPreferences pref = await SharedPreferences.getInstance();
  //         pref.setString('cookie', value.data!.token.toString());
  //         pref.setBool('emailVerify', value.data!.emailVerified!);
  //         pref.setBool('mobileVerify', value.data!.mobileVerified!);
  //         log("fvfbgfbgf${value.data!.token}");
  //         log("fvfbgfbgf${value.data!.email}");
  //         // controller.emailController.text = value.data!.email.toString();
  //         if(value.data!.emailVerified == true && value.data!.mobileVerified == true){
  //           Get.offAllNamed(MyRouters.drawerForUser);
  //           showToast(value.msg.toString());
  //         }else{
  //           Get.offAndToNamed(MyRouters.verifyOtpLogin, arguments: [value.data!.email.toString(),value.data!.mobile.toString()]);
  //         }
  //       }else{
  //         showToast(value.msg.toString());
  //       }
  //     });
  //   }
  // }

}