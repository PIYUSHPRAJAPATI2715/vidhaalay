import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/screen/bottom_navbar_screen.dart';
import '../../widgets/appTheme.dart';
import '../controller/common.dart';
import '../models/login_model.dart';
import '../repositories/send_verify_otp_email_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/my_routers.dart';

class OtpScreenEmail extends StatefulWidget {
  const OtpScreenEmail({Key? key}) : super(key: key);

  @override
  State<OtpScreenEmail> createState() => _OtpScreenEmailState();
}

class _OtpScreenEmailState extends State<OtpScreenEmail> {

  final formKey99 = GlobalKey<FormState>();
  TextEditingController otpcontroller = TextEditingController();
  var email = Get.arguments[0];
  // String email = '';
  // String mobile = '';
  // getEmail() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));
  //   email = model.data!.email.toString();
  //   mobile = model.data!.mobile.toString();
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   getEmail();
  //
  // }
  final controller = Get.put(Controller());

  @override
  void initState() {
    super.initState();
    email = Get.arguments[0];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final defaultPinTheme =  PinTheme(
        width: 40,
        height: 40,
        textStyle: const TextStyle(
            fontSize: 22,
            color: AppThemes.textBlackColor
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            )

        ));
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
              child: SvgPicture.asset('assets/images/OTP.svg',fit: BoxFit.fitWidth,),
            ),
          ),
          Positioned(
            top: size.height*.050,
            left: size.width*.040,
            child: InkWell(
              onTap: (){
                Get.back();
              },
              child: const Icon(
                  Icons.arrow_back
              ),
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
                      'Enter your code?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Text(
                      'Enter your verification code sent on your Email',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppThemes.textGray,
                      ),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    Form(
                      key: formKey99,
                      child: Pinput(
                        focusedPinTheme:  PinTheme(
                            width: 40,
                            height: 40,
                            textStyle: const TextStyle(
                                fontSize: 22,
                                color: AppThemes.textBlackColor
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: AppThemes.primaryColor,
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppThemes.primaryColor.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            )),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "OTP code Required";
                          } else if (v.length != 6) {
                            return "Enter complete OTP code";
                          }
                          return null;
                        },
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        controller: otpcontroller,
                        keyboardType: TextInputType.number,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(formKey99.currentState!.validate()){
                          verifyEmailOtp(email: email.toString(),type: 'user',context: context,otp: otpcontroller.text.trim()).then((value) async {
                            showToast(value.msg.toString());

                            print("value10:  $value");
                            print(value.msg);

                            SharedPreferences pref = await SharedPreferences.getInstance();
                            pref.setBool('emailVerify', value.data!.emailVerified!);
                            // pref.setString('cookie', value.data!.token.toString());

                            // SharedPreferences prefEmail = await SharedPreferences.getInstance();
                            // prefEmail.setString("cookie", jsonEncode(value));
                            // print(prefEmail.toString());

                            bool? isEmailVerify = pref.getBool('emailVerify');
                            bool? isMobileVerify = pref.getBool('mobileVerify');
                            print("isEmailVerify : $isEmailVerify");
                            print("isMobileVerify : $isMobileVerify");

                            if(value.status == true){
                              // showToast(value.msg.toString());
                              if (isEmailVerify == true && isMobileVerify == true) {
                                pref.setBool('isLoggedIn', true);
                                // Get.offAllNamed(MyRouters.drawerForUser);
                                Get.offAll(() => BottomBarScreen(userType: 0,));
                              } else {
                                Get.back();
                                Get.back();
                              }
                              // Get.offAllNamed(MyRouters.verifyOtpLogin, arguments: []);
                            }else{
                              // showToast(value.msg.toString());
                            }
                          });
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
                        "continue".toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
