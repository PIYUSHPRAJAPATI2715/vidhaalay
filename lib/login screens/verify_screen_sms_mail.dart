import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import '../models/login_model.dart';
import '../models/model_email_verify.dart';
import '../models/verify_mobile_model.dart';

class VerifyOtpLogin extends StatefulWidget {
  const VerifyOtpLogin({Key? key}) : super(key: key);

  @override
  State<VerifyOtpLogin> createState() => _VerifyOtpLoginState();
}

class _VerifyOtpLoginState extends State<VerifyOtpLogin> {

  bool emailContainerClicked = true;
  bool smsContainerClicked = false;
  String selectedContainerValue = 'Email';

  bool isEmail = false;
  String email = '';
  String mobile = '';
  // var mobile = Get.arguments[1];
  // var email = Get.arguments[0];
  // var mobile = Get.arguments[1];
  checkVerify() async {
    SharedPreferences prefSms = await SharedPreferences.getInstance();
    SharedPreferences prefEmail = await SharedPreferences.getInstance();
    ModelEmailVerify verifyMailModel = ModelEmailVerify.fromJson(jsonDecode(prefEmail.getString("cookie")!));
    VerifyMobileModel verifySmsModel = VerifyMobileModel.fromJson(jsonDecode(prefSms.getString("cookie")!));
    if(verifyMailModel.data!.emailVerified == true && verifySmsModel.data!.mobileVerified == true){
      Get.toNamed(MyRouters.drawerForUser);
    }
  }
  @override
  void initState() {
    super.initState();
    // mobile = Get.arguments[0];
    // email = Get.arguments[1];
    checkVerify();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                  AppThemes.forgotBg,
                  AppThemes.forgotBg,
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

              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(70)),
              child: SvgPicture.asset('assets/images/forgot-pass.svg',fit: BoxFit.fitWidth,),
            ),
          ),

          Positioned.fill(
            top: 210,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "OTP Verify",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "Please verify mail and phone to access dashboard",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppThemes.textGray,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            emailContainerClicked = true;
                            smsContainerClicked = false;
                            selectedContainerValue = 'Email';
                          });

                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:  emailContainerClicked ?  AppThemes.primaryColor : Colors.transparent,
                              width: 2,
                            ),
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
                            children: [
                              SvgPicture.asset('assets/images/mail.svg'),
                              SizedBox(width: size.width*.040,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Verify With Email',style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18
                                    ),),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('if you have email linked to your account',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: AppThemes.textGray,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            smsContainerClicked = true;
                            emailContainerClicked = false;
                            selectedContainerValue = 'SMS';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: smsContainerClicked ? AppThemes.primaryColor : Colors.transparent,
                              width: 2,
                            ),
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
                            children: [
                              const Icon(Icons.phone_android,color: AppThemes.primaryColor,),
                              SizedBox(width: size.width*.040,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Verify with SMS',style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18
                                    ),),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('if you have phone linked to your account',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: AppThemes.textGray,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                           SharedPreferences pref = await SharedPreferences.getInstance();
                          // SharedPreferences prefEmail = await SharedPreferences.getInstance();
                          // ModelEmailVerify verifyMailModel = ModelEmailVerify.fromJson(jsonDecode(prefEmail.getString("cookie")!));
                          // VerifyMobileModel verifySmsModel = VerifyMobileModel.fromJson(jsonDecode(prefSms.getString("cookie")!));
                          if (selectedContainerValue.isNotEmpty) {
                            if (selectedContainerValue == 'Email') {
                              if ( pref.getBool('emailVerify') == true) {
                                showToast('Email Already Verified');
                              }
                              else {
                                // print(email);
                                Get.toNamed(MyRouters.verifyWithMail,arguments: mobile.toString());
                              }
                            }
                            else if (selectedContainerValue == 'SMS') {
                              if ( pref.getBool('mobileVerify') == true) {
                                showToast('Phone Already Verified');
                              }
                              else {
                                Get.toNamed(MyRouters.verifyWithSms,arguments: mobile.toString());
                              }
                            }
                          }
                          else {
                            showToast('Please Select One');
                          }

                          
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
                          "submit".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}

