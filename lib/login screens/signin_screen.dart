import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import '../../widgets/common_button.dart';
import '../controller/bottom_controller.dart';
import '../resourses/custon_drawer.dart';
import '../widgets/common_textfield.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  RxBool passWordVisibility = true.obs;
  String category = 'Select category';
  var categoryitems = [
    'Select category',
    'Users',
    'Teachers',
    'Student',
  ];
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController userNameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  RxBool isPasswordShow = true.obs;
  bool value = false;
  RxBool checkboxColor = false.obs;
  bool showValidation = false;
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
                          isExpanded: true,
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
                        hintText: 'Enter mobile no.',
                        obSecure: false,
                        controller: userNameController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Email or Phone is required";
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
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                              Get.offAllNamed(MyRouters.bottomNavigationScreen);
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
}