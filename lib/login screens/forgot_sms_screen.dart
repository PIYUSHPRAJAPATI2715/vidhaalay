import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import '../repositories/reset_via_email_repo.dart';
import '../resourses/api_constant.dart';
import '../widgets/common_textfield.dart';

class ForgetSmsScreen extends StatefulWidget {
  const ForgetSmsScreen({Key? key}) : super(key: key);

  @override
  State<ForgetSmsScreen> createState() => _ForgetSmsScreenState();
}

class _ForgetSmsScreenState extends State<ForgetSmsScreen> {

  final formKey99 = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
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
                        'Enter Your Phone Number?',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        'Enter Your Phone Number For Forgot Password',
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
                        hintText: 'Enter Phone Number',
                        obSecure: false,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.number,
                        controller: mobileController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Mobile Number is required";
                          }
                          else if(value.length<10){
                            return 'please enter correct number';
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      ElevatedButton(
                        onPressed: () {
                          if (formKey99.currentState!.validate()) {
                            forgotPassOtpSms(context: context,mobile: mobileController.text,
                            ).then((value) async {
                              if(value.status == true){
                                showToast(value.msg.toString()!);
                                Get.toNamed(MyRouters.forgotOtpSmsScreen,arguments: mobileController.text.trim());
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
          ),
        ],
      ),
    );
  }
}
