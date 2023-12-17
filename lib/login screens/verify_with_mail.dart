import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import '../controller/common.dart';
import '../models/login_model.dart';
import '../repositories/reset_via_email_repo.dart';
import '../repositories/send_verify_otp_email_repo.dart';
import '../resourses/api_constant.dart';
import '../widgets/common_textfield.dart';

class VerifyWithMail extends StatefulWidget {
  const VerifyWithMail({Key? key}) : super(key: key);

  @override
  State<VerifyWithMail> createState() => _VerifyWithMailState();
}

class _VerifyWithMailState extends State<VerifyWithMail> {
  //
  // getEmail() async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));
  //   emailController.text = model.data!.email.toString();
  // }

  String email = '';
  final formKey99 = GlobalKey<FormState>();
  final controller = Get.put(Controller());
  TextEditingController emailController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // getEmail();
    // gmail = Get.arguments[0];
     email = Get.arguments;
     // print(email);
     emailController.text = email;
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
                        'Enter your email',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        'Enter Your Email For Verify Email',
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
                        hintText:"gmail",
                        obSecure: false,
                        readOnly: false,
                        controller:emailController,
                        validator: MultiValidator([
                          EmailValidator(
                              errorText: 'enter a valid email address'),
                          RequiredValidator(errorText: 'Please enter a email')
                        ]),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey99.currentState!.validate()) {
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            // pref.getString('type');
                            // pref.getString('type').toString()
                            verifyEmailOtpSend(context: context,email: emailController.text.toString(),type: "user").then((value) async {
                              if(value.status == true) {
                                showToast(value.msg.toString().toString());
                                Get.toNamed(MyRouters.otpScreenEmail,arguments: [emailController.text]);
                              }else{
                                showToast(value.msg.toString().toString());
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
