import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/setting_controller.dart';
import 'package:vidhaalay_app/repositories/multi_login_repo.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/User_Screens/contactus_screen.dart';
import 'package:vidhaalay_app/screen/User_Screens/privacypolicy_screen.dart';
import 'package:vidhaalay_app/screen/User_Screens/termsandcondition_screen.dart';

import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';

class SettingScreenUser extends StatefulWidget {
  const SettingScreenUser({Key? key}) : super(key: key);

  @override
  State<SettingScreenUser> createState() => _SettingScreenUserState();
}

class _SettingScreenUserState extends State<SettingScreenUser> {

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
                  AppThemes.settingBgBlue,
                  AppThemes.settingBgBlue,
                ],
                end: Alignment.centerRight,
                begin: Alignment.centerLeft,
                stops: [0, .5, .501, 1],
              ),
            ),
          ),
          Container(
            height: 320,
            decoration: const BoxDecoration(
              color: AppThemes.signupBg,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60)),
              child: Image.asset(AppAssets.settingBg,fit: BoxFit.fitWidth,width: double.maxFinite,),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: size.height*.045,
              child:   Text("Settings",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: AppThemes.textBrown,
                    fontSize: 19,
                    fontWeight: FontWeight.w600
                ),),
          ),
          Positioned(
              left: 10,
              top: size.height*.027,
              child: IconButton(
                icon: Image.asset(AppAssets.arrowBack,width: 19,color: AppThemes.textBrown,),
                onPressed: (){
                  Get.back();
                },
              ),
          ),
          Positioned.fill(
            top: 320,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05,vertical: 45),
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppThemes.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(MyRouters.changePasswordUser);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(AppAssets.changePass,height: 15,),
                                const SizedBox(width: 12,),
                                Text('Change Password',
                                style: GoogleFonts.poppins(
                                  color: AppThemes.textBlackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                                ),
                                )
                              ],
                            ),
                           const Icon(Icons.arrow_forward_ios_outlined,size: 13,color: AppThemes.textGray,)
                          ],
                        ),
                      ),
                    ),
                   const SizedBox(height: 20),
                    InkWell(
                      onTap: (){
                        Get.to(()=>TermsAndConditionScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(AppAssets.termsIcon,height: 15,),
                                const SizedBox(width: 12,),
                                Text('Terms & Conditions',
                                style: GoogleFonts.poppins(
                                  color: AppThemes.textBlackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                                ),
                                )
                              ],
                            ),
                           const Icon(Icons.arrow_forward_ios_outlined,size: 13,color: AppThemes.textGray,)
                          ],
                        ),
                      ),
                    ),
                   const SizedBox(height: 20),
                    InkWell(
                      onTap: (){
                        Get.to(()=> PrivacyPolicyScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(AppAssets.privacyIcon,height: 15,),
                                const SizedBox(width: 12,),
                                Text('Privacy Policy',
                                style: GoogleFonts.poppins(
                                  color: AppThemes.textBlackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                                ),
                                )
                              ],
                            ),
                           const Icon(Icons.arrow_forward_ios_outlined,size: 13,color: AppThemes.textGray,)
                          ],
                        ),
                      ),
                    ),
                   const SizedBox(height: 20),
                    InkWell(
                      onTap: (){
                        Get.to(()=> ContactUsScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(AppAssets.contactIcon,height: 15,),
                                const SizedBox(width: 12,),
                                Text('Contact Us',
                                style: GoogleFonts.poppins(
                                  color: AppThemes.textBlackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                                ),
                                )
                              ],
                            ),
                           const Icon(Icons.arrow_forward_ios_outlined,size: 13,color: AppThemes.textGray,)
                          ],
                        ),
                      ),
                    ),
                   const SizedBox(height: 20),
                    InkWell(
                      onTap: (){
                        logOutUser(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.logout_sharp,size: 16,color: AppThemes.primaryColor,),
                                 const SizedBox(width: 12,),
                                Text('LOGOUT',
                                  style: GoogleFonts.poppins(
                                      color: AppThemes.textBlackColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15
                                  ),
                                )
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios_outlined,size: 13,color: AppThemes.textGray,)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

}
