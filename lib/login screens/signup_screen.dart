import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import '../../widgets/common_textfield.dart';
import '../repositories/register_repo.dart';
import '../resourses/api_constant.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static var signupScreen = '/signupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  RxBool passWordVisibility = true.obs;

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  RxBool isPasswordShow = true.obs;
  RxBool isPasswordShow1 = true.obs;
  bool value = false;
  RxBool checkboxColor = false.obs;
  bool showValidation = false;
  bool showErrorMessage = false;

  register() {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      registerRepo(context: context,name: userNameController.text.trim(),email: emailController.text.trim(),
      password: passwordController.text.trim(),phone: phoneNumberController.text.trim()
      ).then((value) async {
            if(value.msg == "User registerd successfully"){
               showToast(value.msg);
               Get.toNamed(MyRouters.otpScreen);
            }else{
              showToast(value.msg);
            }
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
                    AppThemes.signupBg,
                    AppThemes.signupBg,
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
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(70)),
                child: Image.asset(AppAssets.signUp,fit: BoxFit.fitWidth,),
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
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Hello!",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                       Text(
                        "Create your profile to continue",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppThemes.textGray,
                        ),
                      ),

                      SizedBox(
                        height: size.height * 0.038,
                      ),
                      CommonTextfield(
                        hintText: 'Name',
                        obSecure: false,
                        controller: userNameController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Name is required";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.030,
                      ),
                      CommonTextfield(
                        hintText: 'Enter Email',
                        obSecure: false,
                        controller: emailController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "email is required";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.030,
                      ),
                      CommonTextfield(
                        hintText: 'Mobile Number',
                        obSecure: false,
                        controller: phoneNumberController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Mobile Number is required";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.030,
                      ),
                      CommonTextfield(
                        hintText: 'Password',
                        obSecure: isPasswordShow.value,
                        controller: passwordController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Password is required";
                          }
                          else{
                            return null;
                          }
                        },

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
                          )
                      ),
                      SizedBox(
                        height: size.height * 0.030,
                      ),
                      CommonTextfield(
                        hintText: 'Confirm Pasword',
                        obSecure: isPasswordShow1.value,
                        controller: confirmController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a password";
                          } else if (confirmController.text !=
                              passwordController.text) {
                            return "Confirm password should be match";
                          }
                          return null;
                        },
                          suffixIcon: GestureDetector(
                            onTap: () {
                              isPasswordShow1.value = !isPasswordShow1.value;
                            },
                            child: Icon(
                                isPasswordShow1.value
                                    ? CupertinoIcons.eye_slash_fill
                                    : CupertinoIcons.eye,
                                size: 18,
                                color: Colors.grey),
                          )
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.1,
                            child: Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: checkboxColor.value == false
                                      ? AppThemes.primaryColor
                                      : const Color(0xFF64646F)
                              ),
                              child: Checkbox(
                                  shape: const CircleBorder(),
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  value: value,
                                  activeColor: const Color(0xFF7ED957),
                                  onChanged: (newValue) {
                                    setState(() {
                                      value = newValue!;
                                      checkboxColor.value = !newValue;
                                    });
                                  }),
                            ),
                          ),

                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  color: Color(0xFF333F48), // Default text color
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'By creating an account you agree to ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: AppThemes.black, // Default text color
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: TextStyle(
                                      color: AppThemes.primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,// Change the color for "Terms & Conditions"
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(
                        height: 100 * 0.2,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          register();
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
                      const SizedBox(
                        height: 100 * 0.2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            "Already have an account?",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppThemes.black,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Get.back();
                            },
                            child:  Text(
                              " LOGIN",
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
                        height: 100 * 0.2,
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
}
