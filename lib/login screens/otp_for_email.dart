import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import '../../widgets/appTheme.dart';

class OtpScreenEmail extends StatefulWidget {
  const OtpScreenEmail({Key? key}) : super(key: key);

  @override
  State<OtpScreenEmail> createState() => _OtpScreenEmailState();
}

class _OtpScreenEmailState extends State<OtpScreenEmail> {

  final formKey99 = GlobalKey<FormState>();
  TextEditingController otpcontroller = TextEditingController();
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
                        Get.toNamed(MyRouters.createPasswordScreen);
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