import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';

import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';
import '../../widgets/common_textfield.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color : AppThemes.white,
          ),
          SizedBox(
            width: double.maxFinite,
              child: Image.asset(AppAssets.myProfileBg,fit: BoxFit.fitWidth,width: double.maxFinite)),
          Positioned(
            left: 0,
            right: 0,
            top: size.height*.045,
            child:   Text("My Profile",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: AppThemes.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w600
              ),),
          ),
          Positioned(
            left: 10,
            top: size.height*.027,
            child: IconButton(
              icon: Image.asset(AppAssets.arrowBack,width: 19,color: AppThemes.white,),
              onPressed: (){
                Get.toNamed(MyRouters.drawerForUser);
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(AppAssets.studentImg),
            )
          ),
          Positioned(
            left: 0,
            right: 0,
            top: size.height*.30,
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppThemes.primaryColor,
                      shape: BoxShape.circle
                    ),
                    child: Image.asset(AppAssets.camera,height: 15,),
                  ),
                ),
              ],
            )
          ),
          Positioned.fill(
            top: size.height*.39,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppThemes.textGray
                    ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CommonTextfield(
                        obSecure: false,
                        controller: nameController,
                        // validator: MultiValidator([
                        //   RequiredValidator(errorText: 'Password is required'),
                        //   MinLengthValidator(8,
                        //       errorText:
                        //       'Password must be at least 8 digits long'),
                        //   PatternValidator(
                        //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                        //       errorText:
                        //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
                        // ]),
                        hintText: 'Enter Your Name'
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Email Address',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppThemes.textGray
                    ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CommonTextfield(
                        obSecure: false,
                        controller: emailController,
                        // validator: MultiValidator([
                        //   RequiredValidator(errorText: 'Password is required'),
                        //   MinLengthValidator(8,
                        //       errorText:
                        //       'Password must be at least 8 digits long'),
                        //   PatternValidator(
                        //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                        //       errorText:
                        //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
                        // ]),
                        hintText: 'Enter Your Email'
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Mobile Number',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppThemes.textGray
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CommonTextfield(
                        obSecure: false,
                        controller: emailController,
                        // validator: MultiValidator([
                        //   RequiredValidator(errorText: 'Password is required'),
                        //   MinLengthValidator(8,
                        //       errorText:
                        //       'Password must be at least 8 digits long'),
                        //   PatternValidator(
                        //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                        //       errorText:
                        //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
                        // ]),
                        hintText: 'Enter Mobile Number'
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Unique Id',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppThemes.textGray
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                TextFormField(
                  readOnly: true,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  autofocus: false,
                  decoration: InputDecoration(
                    counterStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                    ),
                    errorMaxLines: 2,
                    hintText: 'UN345G',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    fillColor: AppThemes.disableColor,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), // Adjust the vertical padding here
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // if(formKey.currentState!.validate()){
                        //   Get.offAllNamed(MyRouters.bottomNavigationScreen);
                        // }
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
              )
          )
        ],
      ),
    );
  }
}
