import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/User_Screens/termsandcondition_screen.dart';
import '../../widgets/appTheme.dart';
import '../../widgets/common_textfield.dart';
import '../controller/common.dart';
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
  // final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  RxBool isPasswordShow = true.obs;
  RxBool isPasswordShow1 = true.obs;
  bool value = false;
  RxBool checkboxColor = false.obs;
  bool showValidation = false;
  bool showErrorMessage = false;

  final controller = Get.put(Controller());


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
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
                     Form(
                       key: formKey,
                       child: Column(
                         children: [
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
                             validator: MultiValidator([
                               EmailValidator(
                                   errorText: 'enter a valid email address'),
                               RequiredValidator(errorText: 'Please enter a email')
                             ]),
                           ),
                           SizedBox(
                             height: size.height * 0.030,
                           ),
                           CommonTextfield(
                             hintText: 'Mobile Number',
                             obSecure: false,
                             inputFormatters: [
                               LengthLimitingTextInputFormatter(10),
                             ],
                             keyboardType: TextInputType.phone,
                             controller: controller.phoneNumberController,
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
                           SizedBox(
                             height: size.height * 0.030,
                           ),
                           Obx(() {
                             return  CommonTextfield(
                                 hintText: 'Password',
                                 obSecure: isPasswordShow.value,
                                 controller: passwordController,
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
                                       size: 20,
                                       color: Colors.grey),
                                 )
                             );
                           }),
                           SizedBox(
                             height: size.height * 0.030,
                           ),
                           Obx(() {
                             return      CommonTextfield(
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
                                       size: 20,
                                       color: Colors.grey),
                                 )
                             );
                           }),
                           SizedBox(
                             height: size.height * 0.015,
                           ),
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Transform.scale(
                                 scale: 1.1,
                                 child:    Theme(
                                   data: ThemeData(
                                     unselectedWidgetColor: checkboxColor
                                         .value == false ? AppThemes.primaryColor
                                         .withOpacity(.78) : AppThemes.primaryColor,

                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.only(bottom: 10),
                                     child: Checkbox(
                                         side: BorderSide(
                                             color: showValidation == false
                                                 ? AppThemes.primaryColor
                                                 : Colors.red,
                                             width: 2),
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(100)),
                                         materialTapTargetSize: MaterialTapTargetSize
                                             .shrinkWrap,
                                         value: value,
                                         activeColor: AppThemes
                                             .primaryColor,
                                         onChanged: (newValue) {
                                           setState(() {
                                             value = newValue!;
                                             showValidation = newValue;
                                             checkboxColor.value = !newValue;
                                             print(showValidation);
                                           });
                                         }),
                                   ),
                                 ),
                               ),
                               Container(
                                   // width: 230,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text('By creating an account you agree to ',
                                         style: TextStyle(
                                           fontWeight: FontWeight.w500,
                                           fontSize: 13,
                                           color: AppThemes.black, // Default text color
                                         ),
                                       ),
                                       GestureDetector(
                                           onTap: () {
                                             Get.to(() => TermsAndConditionScreen());
                                           },
                                           child: Text('Terms & Conditions',
                                             style: TextStyle(
                                               color: AppThemes.primaryColor,
                                               fontWeight: FontWeight.w500,
                                               fontSize: 13,// Change the color for "Terms & Conditions"
                                             ),
                                           )
                                       ),
                                     ],
                                   )
                               ),
                               // Expanded(
                               //   child: RichText(
                               //     text: const TextSpan(
                               //       style: TextStyle(
                               //         fontWeight: FontWeight.w300,
                               //         fontSize: 14,
                               //         color: Color(0xFF333F48), // Default text color
                               //       ),
                               //       children: <TextSpan>[
                               //         TextSpan(
                               //           text: 'By creating an account you agree to ',
                               //           style: TextStyle(
                               //             fontWeight: FontWeight.w500,
                               //             fontSize: 13,
                               //             color: AppThemes.black, // Default text color
                               //           ),
                               //         ),
                               //         TextSpan(
                               //           text: 'Terms & Conditions',
                               //           style: TextStyle(
                               //             color: AppThemes.primaryColor,
                               //             fontWeight: FontWeight.w500,
                               //             fontSize: 13,// Change the color for "Terms & Conditions"
                               //           ),
                               //         ),
                               //       ],
                               //     ),
                               //   ),
                               // ),
                             ],
                           ),
                         ],
                       ),
                     ),

                    const SizedBox(
                      height: 100 * 0.2,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate() &&  showValidation == true) {
                          registerRepo(context: context,name: userNameController.text,email: emailController.text,
                              password: passwordController.text,phone: controller.phoneNumberController.text
                          ).then((value) async {
                            if(value.status == true){
                              showToast(value.msg.toString());
                              // Get.toNamed(MyRouters.signInPage);
                              Get.offAllNamed(MyRouters.signInPage);
                            }else{
                              showToast(value.msg.toString());
                            }

                          });
                        }
                        else if(showValidation == false){
                          showToast('Please Select Terms & Conditions');
                          // if (showValidation) {
                          //   showToast('Please Select Terms & Conditions');
                          // }
                          setState(() {
                          });
                        }
                        else{
                          showValidation = true;
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
    );
  }
}
