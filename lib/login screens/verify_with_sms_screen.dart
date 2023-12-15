import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/appTheme.dart';
import '../controller/common.dart';
import '../models/login_model.dart';
import '../repositories/send_verify_otp_email_repo.dart';
import '../resourses/api_constant.dart';
import '../routers/my_routers.dart';
import '../widgets/common_textfield.dart';

class VerifyWithSms extends StatefulWidget {
  const VerifyWithSms({Key? key}) : super(key: key);

  @override
  State<VerifyWithSms> createState() => _VerifyWithSmsState();
}

class _VerifyWithSmsState extends State<VerifyWithSms> {

  final formKey99 = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  @override
  void initState() {
    super.initState();
     if(Get.arguments !=null){
       mobile = Get.arguments;
       mobileController.text = mobile;
     }
  }
  String mobile = '';
  final controller = Get.put(Controller());
  // var phone = Get.arguments[0];
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
                child: Form(
                  key: formKey99,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Your Phone Number?',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        'Your Phone Number For Verify OTP',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppThemes.textGray,
                        ),
                      ),
                      const SizedBox(
                        height: 33,
                      ),
                      CommonTextfield(
                        hintText: "phone",
                        obSecure: false,
                        readOnly: true,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.number,
                        controller: mobileController,
                        // validator: (value){
                        //   if(value!.isEmpty){
                        //     return "Mobile Number is required";
                        //   }
                        //   else if(value.length<10){
                        //     return 'please enter correct number';
                        //   }
                        //   else{
                        //     return null;
                        //   }
                        // },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print(mobileController.text.toString());
                          if(formKey99.currentState!.validate()){
                            verifySmsOtpSendRepo(mobile: mobileController.text.toString(),type: 'user',context: context).then((value) {
                              if(value.status == true){
                                showToast(value.msg);
                                Get.offAllNamed(MyRouters.otpSmsScreen,arguments: [mobileController.text.toString()]);
                              }else{
                                showToast(value.msg);
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
          ),
        ],
      ),
    );
  }
}
