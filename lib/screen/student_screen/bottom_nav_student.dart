import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/student_controller/bottom_navigation_controller.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/screen/student_screen/drawer_student.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';


class BottomNavigationStudentScreen extends StatefulWidget {
  const BottomNavigationStudentScreen({super.key});

  @override
  State<BottomNavigationStudentScreen> createState() => _BottomNavigationStudentScreenState();
}

class _BottomNavigationStudentScreenState extends State<BottomNavigationStudentScreen> {
  final controller = Get.put(StudentBottomController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppThemes.primaryColor,
      key: controller.scaffoldKey,

      endDrawer:  const DrawerForStudent(),
      // drawer: DrawerForTeacher(),

      body: WillPopScope(
        onWillPop: ( ) async => false,
        child: Obx(() {
          return controller.screens[controller.currentIndex.value];
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
                    onTap: () {controller.currentIndex.value = 0;
                    setState(() {

                    });
                    } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.homeIcon,
                          width: 22,
                          height: 22,
                          color: controller.currentIndex.value == 0 ? AppThemes
                              .white : AppThemes.whiteOff,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Home',style: GoogleFonts.poppins(
                            color: controller.currentIndex.value == 0 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {controller.currentIndex.value = 1;
                    setState(() {

                    });
                    } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.attendanceIcon,
                          color: controller.currentIndex.value == 1 ? AppThemes
                              .white : AppThemes.whiteOff,
                          width: 22,
                          height: 22,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Attendance',style: GoogleFonts.poppins(
                            color: controller.currentIndex.value == 1 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {controller.currentIndex.value = 2;
                    setState(() {

                    });
                    } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.assignmentIcon,
                          color: controller.currentIndex.value == 2 ? AppThemes
                              .white : AppThemes.whiteOff,
                          width: 22,
                          height: 22,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Assignment',style: GoogleFonts.poppins(
                            color: controller.currentIndex.value == 2 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){controller.currentIndex.value = 3;
                    setState(() {

                    });
                    } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.eventsIcon,
                          width: 22,
                          height: 22,
                          color: controller.currentIndex.value == 3 ? AppThemes
                              .white : AppThemes.whiteOff,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Events',style: GoogleFonts.poppins(
                            color: controller.currentIndex.value == 3 ? AppThemes
                                .white : AppThemes.whiteOff,
                            fontSize: 10,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {controller.currentIndex.value = 4;
                    setState(() {

                    });
                    } ,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.moreIcon,
                          width: 22,
                          height: 22,
                          color: controller.currentIndex.value == 4 ? AppThemes
                              .white : AppThemes.whiteOff,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('More',style: GoogleFonts.poppins(
                            color: controller.currentIndex.value == 4 ? AppThemes
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
