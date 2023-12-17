import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/appTheme.dart';
import '../controller/common.dart';
import '../models/login_model.dart';
import '../repositories/reset_via_email_repo.dart';
import '../repositories/send_verify_otp_email_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/my_routers.dart';

class ForgotOtpSmsScreen extends StatefulWidget {
  const ForgotOtpSmsScreen({Key? key}) : super(key: key);

  @override
  State<ForgotOtpSmsScreen> createState() => _ForgotOtpSmsScreenState();
}

class _ForgotOtpSmsScreenState extends State<ForgotOtpSmsScreen> {

  final formKey99 = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  final controller = Get.put(Controller());
  String mobile = '';

  @override
  void initState() {
    super.initState();
    mobile = Get.arguments;
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
                        controller: otpController,
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
                          forgotSmsOtpRepo(context: context,mobile: mobile.toString(),otp: otpController.text.trim(),type: 'user'
                          ).then((value) async {
                            if(value.status == true){
                              showToast(value.msg.toString()!);
                              Get.toNamed(MyRouters.createPasswordScreen);
                            }else{
                              showToast(value.msg.toString()!);
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
