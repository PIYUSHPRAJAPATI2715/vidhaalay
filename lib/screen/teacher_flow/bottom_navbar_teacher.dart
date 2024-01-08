import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/screen/User_Screens/drawer_user.dart';

import '../../controller/bottom_controller.dart';
import '../../widgets/appTheme.dart';
import 'drawer_teacher.dart';




class BottomNavbarTeacher extends StatefulWidget {
  const BottomNavbarTeacher({Key? key}) : super(key: key);

  @override
  State<BottomNavbarTeacher> createState() => _BottomNavbarTeacherState();
}

class _BottomNavbarTeacherState extends State<BottomNavbarTeacher> {
  final controller = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppThemes.primaryColor,
      key: controller.scaffoldKeyTeacher,

      endDrawer:  const DrawerForTeacher(),
      // drawer: DrawerForTeacher(),

      body: WillPopScope(
        onWillPop: ( ) async => false,
        child: Obx(() {
          return controller.teacherScreens[controller.currentIndexTeacher.value];
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
                  InkWell(
                    onTap: () {controller.currentIndexTeacher.value = 0;
                    setState(() {

                    });
                    } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.homeIcon,
                          width: 22,
                          height: 22,
                          color: controller.currentIndexTeacher.value == 0 ? AppThemes
                              .white : AppThemes.whiteOff,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Home',style: GoogleFonts.poppins(
                            color: controller.currentIndexTeacher.value == 0 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {controller.currentIndexTeacher.value = 1;
                    setState(() {

                    });
                    } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.attendanceIcon,
                          color: controller.currentIndexTeacher.value == 1 ? AppThemes
                              .white : AppThemes.whiteOff,
                          width: 22,
                          height: 22,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Attendance',style: GoogleFonts.poppins(
                            color: controller.currentIndexTeacher.value == 1 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {controller.currentIndexTeacher.value = 2;
                    setState(() {

                    });
                    } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.assignmentIcon,
                          color: controller.currentIndexTeacher.value == 2 ? AppThemes
                              .white : AppThemes.whiteOff,
                          width: 22,
                          height: 22,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Assignment',style: GoogleFonts.poppins(
                            color: controller.currentIndexTeacher.value == 2 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){controller.currentIndexTeacher.value = 3;
                    setState(() {

                    });
                    } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.eventsIcon,
                          width: 22,
                          height: 22,
                          color: controller.currentIndexTeacher.value == 3 ? AppThemes
                              .white : AppThemes.whiteOff,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Events',style: GoogleFonts.poppins(
                            color: controller.currentIndexTeacher.value == 3 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {controller.currentIndexTeacher.value = 4;
                    setState(() {

                    });
                    } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.moreIcon,
                          width: 22,
                          height: 22,
                          color: controller.currentIndexTeacher.value == 4 ? AppThemes
                              .white : AppThemes.whiteOff,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('More',style: GoogleFonts.poppins(
                            color: controller.currentIndexTeacher.value == 4 ? AppThemes
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

