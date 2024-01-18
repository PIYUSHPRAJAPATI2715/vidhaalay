import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/login%20screens/verify_screen_sms_mail.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/favourite_model_user.dart';
import 'package:vidhaalay_app/models/login_model.dart';
import 'package:vidhaalay_app/models/login_model_teacher.dart';
import 'package:vidhaalay_app/models/school_list_model.dart';
import 'package:vidhaalay_app/models/studentModel/login_student_model.dart';
import 'package:vidhaalay_app/repositories/login_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/bottom_nav_screen.dart';
import 'package:vidhaalay_app/resourses/helper.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/bottom_navbar_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/bottom_nav_student.dart';
import 'package:vidhaalay_app/screen/student_screen/drawer_student.dart';

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

        SharedPreferences pref = await SharedPreferences.getInstance();

        if (userType.value == "user") {
          print("Enter");
          final value = LoginModel.fromJson(jsonDecode(response.body));
          print("value : $value");

          bool isEmailVerify = value.data!.emailVerified!;
          bool isMobileVerify = value.data!.mobileVerified!;
          String userRole = value.data!.userType.toString();
          print("isEmailVerify : $isEmailVerify");
          print("isMobileVerify : $isMobileVerify");

          pref.setString('cookie', value.data!.token.toString());
          pref.setString('type', value.data!.userType.toString());
          pref.setString('username', value.data!.name.toString());
          pref.setBool('emailVerify', isEmailVerify);
          pref.setBool('mobileVerify', isMobileVerify);

          if (!isEmailVerify || !isMobileVerify) {
            print("E0");
            // Get.to(() => VerifyOtpLogin());
            Get.offAllNamed(MyRouters.verifyOtpLogin, arguments: [
              value.data!.email.toString(),
              value.data!.mobile.toString(),
              isMobileVerify,
              isEmailVerify
            ]);

            // Get.offAndToNamed(MyRouters.verifyOtpLogin, arguments: [value.data!.email.toString(),value.data!.mobile.toString()]);
          } else {
            pref.setBool('isLoggedIn', true);
            // Get.offAllNamed(MyRouters.drawerForUser);
            Get.offAll(() => BottomBarScreen(userType: 0,));
          }
        } else if (userType.value == "teacher") {
          final value = LoginModelTeacher.fromJson(jsonDecode(response.body));

          print("Enter Teacher");
          pref.setBool('isLoggedIn', true);
          pref.setString('cookie', value.data!.token.toString());
          pref.setString('type', value.data!.userType.toString());
          pref.setString('username', value.data!.name.toString());

          List<String> classList = value.data!.classArr!.map((item) => json.encode(item)).toList();
          print("classList : $classList");

          pref.setStringList('classArr', classList);

          List<String>? classListJson = pref.getStringList('classArr');
          print('Retrieved List from SharedPreferences: $classListJson');

          List<MyClass> resultList =
          (classListJson ?? []).map<MyClass>((jsonString) {
            return MyClass.fromJson(json.decode(jsonString));
          }).toList();
          print('Retrieved List model from resultList: $resultList');


          // List<Map<String, dynamic>> resultMapList =
          // (classListJson ?? []).map<Map<String, dynamic>>((jsonString) {
          //   return json.decode(jsonString);
          // }).toList();
          // print('Retrieved List<mAP> resultMapList: $resultMapList');

          // Get.offAllNamed(MyRouters.drawerForTeacher);
          Get.offAll(() => BottomBarScreen(userType: 1,));

        } else if (userType.value == "student") {
          print("Enter000");

          final value = LoginStudentModel.fromJson(jsonDecode(response.body));
          print("student value0 : $value");

          pref.setBool('isLoggedIn', true);
          pref.setString('type', "student");
          pref.setString('cookie', value.data!.token.toString());
          pref.setString('classId', value.data!.classId.toString());
          pref.setString('studentId', value.data!.id.toString());
          pref.setString('username', value.data!.name.toString());

          print("student id : ${value.data!.id.toString()}");
          print("student token : ${value.data!.token.toString()}");

          // Get.offAllNamed(MyRouters.drawerForStudent);
          Get.offAll(() => BottomBarScreen(userType: 2,));


          // Get.offAllNamed(MyRouters.bottomNavigationStudentScreen);


          // Get.offAllNamed(MyRouters.bottomNavigationStudentScreen);

          // bool isEmailVerify = value.data!.emailVerified!;
          // bool isMobileVerify = value.data!.mobileVerified!;
          // String userRole = value.data!.userType.toString();
          // print("isEmailVerify : $isEmailVerify");
          // print("isMobileVerify : $isMobileVerify");
          //
          // pref.setString('cookie', value.data!.token.toString());
          // pref.setString('type', value.data!.userType.toString());
          // pref.setBool('emailVerify', isEmailVerify);
          // pref.setBool('mobileVerify', isMobileVerify);
          //
          // if (!isEmailVerify || !isMobileVerify) {
          //   print("E0");
          //   // Get.to(() => VerifyOtpLogin());
          //   Get.offAllNamed(MyRouters.verifyOtpLogin, arguments: [
          //     value.data!.email.toString(),
          //     value.data!.mobile.toString(),
          //     isMobileVerify,
          //     isEmailVerify
          //   ]);
          //
          //   // Get.offAndToNamed(MyRouters.verifyOtpLogin, arguments: [value.data!.email.toString(),value.data!.mobile.toString()]);
          // } else {
          //   print("E1");
          //
          //   pref.setBool('isLoggedIn', true);
          //   // Get.offAll(() => DrawerForStudent());
          //   // Get.offAll(() => BottomNavigationStudentScreen());
          //   Get.offAllNamed(MyRouters.drawerForStudent);
          //   // Get.offAll(() => BottomNavigationScreen());
          // }

        } else {

        }
      } else {
        Helpers.hideLoader(loader);
        showToast(responseData['msg'].toString());
      }

      // if(!isEmailVerify || !isMobileVerify) {
    //       print("E0");
    //       // Get.to(() => VerifyOtpLogin());
    //       Get.offAllNamed(MyRouters.verifyOtpLogin,arguments: [value.data!.email.toString(),value.data!.mobile.toString(), isMobileVerify,isEmailVerify]);
    //
    //       // Get.offAndToNamed(MyRouters.verifyOtpLogin, arguments: [value.data!.email.toString(),value.data!.mobile.toString()]);
    //     } else if(userType.value == "teacher") {
    //
    //       print("Enter Teacher");
    //       pref.setBool('isLoggedIn', true);
    //       Get.offAllNamed(MyRouters.drawerForTeacher);
    //
    //     } else {
    //
    //       pref.setBool('isLoggedIn', true);
    //       Get.offAllNamed(MyRouters.drawerForUser);
    //     }
    //
    //   } else {
    //     Helpers.hideLoader(loader);
    //     showToast(responseData['msg'].toString());
    //
    //   }

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