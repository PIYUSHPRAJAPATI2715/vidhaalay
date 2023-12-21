import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/widgets/common_textfield.dart';
import '../../widgets/appTheme.dart';
import '../repositories/reset_via_email_repo.dart';
import '../resourses/api_constant.dart';



class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  RxBool isPasswordShow = true.obs;
  RxBool isConfirmedPasswordShow = true.obs;
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
              child: SvgPicture.asset('assets/images/reset-pass.svg',fit: BoxFit.fitWidth,),
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
                child:  Form(
                  key: _formKey1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                          "Create Password",
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          )),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                          "Reset your new password and login.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppThemes.textGray,
                        ),),
                      const SizedBox(
                        height:30,
                      ),
                      Obx(() {
                        return CommonTextfield(
                            controller: passwordController,
                            obSecure: isPasswordShow.value,
                            hintText: "Password",
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Password is required'),
                              MinLengthValidator(8,
                                  errorText:
                                  'Password must be at least 8 digits long'),
                              PatternValidator(
                                  r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                                  errorText:
                                  'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
                            ]),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                isPasswordShow.value = !isPasswordShow.value;
                              },
                              child: Icon(
                                  isPasswordShow.value
                                      ? CupertinoIcons.eye_slash_fill
                                      : CupertinoIcons.eye,
                                  size: 18,
                                  color: Colors.grey),
                            ));
                      }),
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(() {
                        return CommonTextfield(
                            obSecure: isConfirmedPasswordShow.value,
                            controller: confirmPasswordController,
                            hintText: "Confirm password",
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Confirm password is required";
                              } else if (value.trim().toString() !=
                                  passwordController.text.trim()) {
                                return "Confirm password is not matching with password";
                              } else {
                                return null;
                              }
                            },
                            suffixIcon: GestureDetector(
                              onTap: () {
                                isConfirmedPasswordShow.value =
                                !isConfirmedPasswordShow.value;
                              },
                              child: Icon(
                                  isConfirmedPasswordShow.value
                                      ? CupertinoIcons.eye_slash_fill
                                      : CupertinoIcons.eye,
                                  size: 18,
                                  color: Colors.grey),
                            ));
                      }),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if(_formKey1.currentState!.validate()){
                            changePassword(context: context,password: passwordController.text.trim(),confirmPassword: confirmPasswordController.text.trim()
                            ).then((value) async {
                              if(value.status == true){
                                showToast(value.msg.toString()!);
                                Get.offAllNamed(MyRouters.signInPage);
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
                          "save".toUpperCase(),
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
