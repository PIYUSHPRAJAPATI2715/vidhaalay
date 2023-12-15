import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import '../controller/common.dart';
import '../repositories/login_repo.dart';
import '../repositories/social_login_repo.dart';
import '../resourses/api_constant.dart';
import '../widgets/common_textfield.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  RxBool passWordVisibility = true.obs;
  String category = 'Institute Finding';
  var categoryitems = [
    'Institute Finding',
    'Faculty Login',
    'Student Login',
  ];
  final controller = Get.put(Controller());
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  RxBool isPasswordShow = true.obs;
  bool value = false;
  RxBool checkboxColor = false.obs;
  bool showValidation = false;
  TextEditingController _textEditingController = TextEditingController();
  String _displayedValue = '';



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
  //         pref.setString('cookie', value.data!.toString());
  //         pref.setBool('emailVerify', value.data!.emailVerified!);
  //         pref.setBool('mobileVerify', value.data!.mobileVerified!);
  //         log("fvfbgfbgf${value.data!.token}");
  //         log("fvfbgfbgf${value.data!.email}");
  //         log("fvfbgfbgf${value.data!.mobile}");
  //         // controller.emailController.text = value.data!.email.toString();
  //         if(value.data!.emailVerified == true && value.data!.mobileVerified == true){
  //           Get.offAllNamed(MyRouters.drawerForUser);
  //           showToast(value.msg);
  //         }else{
  //           Get.offAndToNamed(MyRouters.verifyOtpLogin, arguments: [value.data!.email.toString(),value.data!.mobile.toString(), true]);
  //         }
  //       }else{
  //         showToast(value.msg);
  //       }
  //     });
  //   }
  // }


  login(token) {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      loginRepo(context: context,type:'user',email: emailController.text.trim(),
          password: passwordController.text.trim(),deviceType: getDeviceType().toString() ,deviceToken: token
      ).then((value) async {
        if(value.status == true){
          log("fvfbgfbgf${value.data!.token}");
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('cookie', value.data!.token.toString());
          log("fvfbgfbgf${value.data!.token}");
          if(value.data!.emailVerified == true && value.data!.mobileVerified == true){
            Get.offAllNamed(MyRouters.drawerForUser);
            showToast(value.msg);
          }else{
            Get.offAllNamed(MyRouters.verifyOtpLogin);
          }
        }else{
          showToast(value.msg);
        }
      });
    }
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

  void getDevice(){
    print('type is ${getDeviceType().toString()}');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceType();
    getDevice();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void updateDisplayedValue(String input) {
    if (input.isEmpty) {
      setState(() {
        _displayedValue = '';
      });
    }
    else if (int.tryParse(input) != null ) {
      setState(() {
        _displayedValue = '+91';
      });
    } else {
      setState(() {
        _displayedValue = '';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                    AppThemes.primaryColor,
                    AppThemes.primaryColor,
                  ],
                  end: Alignment.centerRight,
                  begin: Alignment.centerLeft,
                  stops: [0, .5, .501, 1],
                ),
              ),
            ),
            Container(
              height: 220,
              decoration: const BoxDecoration(
                color: AppThemes.signupBg,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60)),
                child: Image.asset(AppAssets.signIn,fit: BoxFit.fitWidth,width: double.maxFinite,),
              ),
            ),

            Positioned.fill(
              top: 220,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      const Text(
                        "Hello please login to continue",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppThemes.textGray,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (){
                                signInWithGoogle();
                              },
                              child: Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                                    decoration:BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                        ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset('assets/images/google_logo.png',height: 25,),
                                        const Text(
                                          "Google",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppThemes.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(
                              width: size.width*.060,
                            ),
                            Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                                  decoration:BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                        ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset('assets/images/facbook_image.png',height: 25,),
                                      const Text(
                                        "Facebook",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: AppThemes.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      const Center(
                        child:  Text(
                          "or login with",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppThemes.textGray,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.030,
                      ),

                      Container(
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: DropdownButtonFormField(
                          focusColor: Colors.grey.shade50,
                          isExpanded: false,
                          iconEnabledColor: const Color(0xff97949A),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          hint: Text(
                            category,
                            style: const TextStyle(
                                color: Color(0xff463B57),
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.justify,
                          ),
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffE3E3E3)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(25.0)))),
                          value: category,
                          items: categoryitems.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              category = newValue!;
                            });
                          },
                        ),
                      ),

                      // Container(
                      //   height: 50,
                      //     width: Get.width,
                      //     padding: const EdgeInsets.symmetric(horizontal: 20),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(25),
                      //       border: Border.all(
                      //         color: Colors.grey,
                      //         width: 0.5
                      //       )
                      //     ),
                      //   child: PopupMenuButton<String>(
                      //     shape: Border.all(
                      //       color: AppThemes.primaryColor
                      //     ),
                      //     position: PopupMenuPosition.over,
                      //     offset: const Offset(0, 50),
                      //     elevation: 8,
                      //     itemBuilder: (BuildContext context) {
                      //       return categoryitems.map((String item) {
                      //         return PopupMenuItem<String>(
                      //           value: item,
                      //           child: Text(item),
                      //         );
                      //       }).toList();
                      //     },
                      //     onSelected: (String selectedValue) {
                      //       setState(() {
                      //         category = selectedValue;
                      //       });
                      //     },
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: <Widget>[
                      //         Text(category,style: const TextStyle(
                      //           color: Colors.grey,
                      //         ),),
                      //         const Icon(Icons.keyboard_arrow_down,  color: Colors.grey,),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                        "Unique Id,Mobile No./Email Id",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppThemes.black,
                        ),
                      ),
                     const SizedBox(
                        height: 10,
                      ),
                      CommonTextfield(
                        // prefix: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(_displayedValue,textAlign: TextAlign.center,),
                        //   ],
                        // ),
                        // onChanged: (text) {
                        //   // updateDisplayedValue(text);
                        // },
                        hintText: 'Enter Email or Phone or Unique ID',
                        obSecure: false,
                        controller: emailController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Email or Phone or Unique ID is required";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppThemes.black,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.010,
                      ),
                      Obx(() {
                        return CommonTextfield(
                            controller: passwordController,
                            obSecure: isPasswordShow.value,
                            hintText: "Password",
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Password is required'),
                            ]),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                isPasswordShow.value = !isPasswordShow.value;
                              },
                              child: Icon(
                                  isPasswordShow.value
                                      ? CupertinoIcons.eye_slash_fill
                                      : CupertinoIcons.eye,
                                  size: 20,
                                  color: Colors.grey),
                            ));
                      }),
                      SizedBox(
                        height: size.height * 0.016,
                      ),
                      InkWell(
                        onTap: (){
                          Get.toNamed(MyRouters.forgotPasswordScreen);
                        },
                        child: const Center(
                          child:  Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppThemes.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100 * 0.2,
                      ),
                      ElevatedButton(
                        onPressed: () async{
                          String? token = await FirebaseMessaging.instance.getToken();
                          login(token!);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.maxFinite, 0),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: AppThemes.primaryColor,
                        ),
                        child: Text(
                          "login".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100 * 0.3,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            "Don't have an account?",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppThemes.black,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Get.toNamed(MyRouters.signupScreen);
                            },
                            child:  Text(
                              " create account".toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppThemes.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100 * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  signInWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().catchError((e){
      throw Exception(e);
    });

    log(googleUser!.email.toString());

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final value = await FirebaseAuth.instance.signInWithCredential(credential);
    log(value.credential!.accessToken!);
    //log(value.additionalUserInfo.a);
    var fromToken = await FirebaseMessaging.instance.getToken();

    socialLogin(provider: "google", token: value.credential!.accessToken!, context: context).then((value) async {
      if (value.status == true) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('user_info', jsonEncode(value));
        showToast(value.message);
        // Get.offAllNamed(MyRouters.bottomNavbar);
      } else {
        showToast(value.message);
      }
    });
  }
}
