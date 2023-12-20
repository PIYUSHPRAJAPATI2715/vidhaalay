import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

import '../../controller/bottom_controller.dart';
import '../../resourses/custon_drawer.dart';
import '../../widgets/appTheme.dart';
import 'drawer_user.dart';


class BottomNavigationUserScreen extends StatefulWidget {
  const BottomNavigationUserScreen({super.key});


  @override
  State<BottomNavigationUserScreen> createState() => _BottomNavigationUserScreenState();
}

class _BottomNavigationUserScreenState extends State<BottomNavigationUserScreen> {
  final controller = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppThemes.primaryColor,
      key: controller.scaffoldKeyUser,
      // drawer: const DrawerForUser(),
      endDrawer:  const DrawerForUser(),
      body: WillPopScope(
        onWillPop: ( ) async => false,
        child: Obx(() {
          return controller.screensUser[controller.currentIndexUser.value];
        }),
      ),
      bottomNavigationBar: Obx(() {
        return Container(
          color: AppThemes.navBarColor,
          height: size.height*.08,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {controller.currentIndexUser.value = 0;
                      setState(() {

                      });
                      } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.homeIcon,
                          width: 22,
                          height: 22,
                          color: controller.currentIndexUser.value == 0 ? AppThemes
                              .white : AppThemes.whiteOff,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Home',style: GoogleFonts.poppins(
                            color: controller.currentIndexUser.value == 0 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {controller.currentIndexUser.value = 1;
                    setState(() {

                    });
                      } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.videoIcon,
                          color: controller.currentIndexUser.value == 1 ? AppThemes
                              .white : AppThemes.whiteOff,
                          width: 22,
                          height: 22,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Videos',style: GoogleFonts.poppins(
                            color: controller.currentIndexUser.value == 1 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {controller.currentIndexUser.value = 2;
                    setState(() {

                    });
                      } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.myLecturesIcon,
                          color: controller.currentIndexUser.value == 2 ? AppThemes
                              .white : AppThemes.whiteOff,
                          width: 22,
                          height: 22,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('My Lectures',style: GoogleFonts.poppins(
                            color: controller.currentIndexUser.value == 2 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {controller.currentIndexUser.value = 3;

                    setState(() {

                    });} ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.notification,
                          width: 22,
                          height: 22,
                          color: controller.currentIndexUser.value == 3 ? AppThemes
                              .white : AppThemes.whiteOff,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Notifications',style: GoogleFonts.poppins(
                            color: controller.currentIndexUser.value == 3 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                   // controller.scaffoldKeyUser.currentState!.openDrawer();
                   //    controller.currentIndexUser.value = 4;
                    DrawerForUser();
                    print('click ');
                    setState(() {

                    });} ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.moreIcon,
                          width: 22,
                          height: 22,
                          color: controller.currentIndexUser.value == 4 ? AppThemes
                              .white : AppThemes.whiteOff,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('More',style: GoogleFonts.poppins(
                            color: controller.currentIndexUser.value == 4 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
