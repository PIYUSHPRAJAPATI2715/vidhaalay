import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/bottom_controller.dart';
import 'package:vidhaalay_app/controller/new_botttom_controller.dart';
import 'package:vidhaalay_app/models/TeacherModel/create_event_model.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/screen/User_Screens/drawer_user.dart';
import 'package:vidhaalay_app/screen/common_drawer.dart';
import 'package:vidhaalay_app/screen/student_screen/assignment_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/attendance_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/drawer_student.dart';
import 'package:vidhaalay_app/screen/student_screen/home_screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/create_event_screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/drawer_teacher.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';

class BottomBarScreen extends StatefulWidget{

  final int userType;

  const BottomBarScreen({super.key, required this.userType});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final controller = Get.put(BottomNavBarController());

  // if 0 then user
  // if 1 then teacher
  // if 2 then student
  // int controller.userType = 0;

  // final GlobalKey<ScaffoldState> controller.scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.userType = widget.userType;
    print("controller.userType : $controller.userType");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Scaffold(
      key: controller.scaffoldKey,
      endDrawer: commonDrawer(),
      // controller.userType == 0 ? DrawerForUser() : controller.userType == 1 ?  DrawerForTeacher() : DrawerForStudent(),
      body: controller.userType == 0 ? controller.userScreens.elementAt(controller.selectedIndex)
          : controller.userType == 1 ? controller.teacherScreens.elementAt(controller.selectedIndex)
          : controller.studentScreens.elementAt(controller.selectedIndex),

      bottomNavigationBar: controller.userType == 0 ? Container(
        height: size.height*.08,
        child: BottomNavigationBar(
          backgroundColor: AppThemes.navBarColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAssets.homeIcon),size: 23),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAssets.videoIcon),size: 23),
              label: 'Videos',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAssets.moreIcon),size: 23),
              label: 'More',
            ),
          ],
          selectedLabelStyle: GoogleFonts.poppins(
              color: AppThemes.white,
              fontSize: 13,
              fontWeight: FontWeight.w500
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
              color: AppThemes.whiteOff!.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500
          ),
          selectedIconTheme: IconThemeData(
            size: 25,
          ),
          unselectedIconTheme: IconThemeData(
            size: 23,
          ),
          selectedItemColor: AppThemes.white,
          unselectedItemColor: AppThemes.whiteOff!.withOpacity(0.8),
          currentIndex: controller.selectedIndex,
          onTap: (value) {
            print(value);

            if(value == 2) {
              controller.scaffoldKey.currentState?.openEndDrawer();
            } else {
              controller.selectedIndex = value;
            }
            setState(() {

            });
          },
        ),
      ) : controller.userType == 1 ? Container(
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
                  onTap: () {controller.selectedIndex = 0;
                  setState(() {

                  });
                  } ,
                  child: Column(
                    children: [
                      Image.asset(
                        AppAssets.homeIcon,
                        width: 22,
                        height: 22,
                        color: controller.selectedIndex == 0 ? AppThemes
                            .white : AppThemes.whiteOff,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('Home',style: GoogleFonts.poppins(
                          color: controller.selectedIndex == 0 ? AppThemes
                              .white : AppThemes.whiteOff,
                          fontSize: 10,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {controller.selectedIndex = 1;
                  setState(() {

                  });
                  } ,
                  child: Column(
                    children: [
                      Image.asset(
                        AppAssets.attendanceIcon,
                        color: controller.selectedIndex == 1 ? AppThemes
                            .white : AppThemes.whiteOff,
                        width: 22,
                        height: 22,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('Attendance',style: GoogleFonts.poppins(
                          color: controller.selectedIndex == 1 ? AppThemes
                              .white : AppThemes.whiteOff,
                          fontSize: 10,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {controller.selectedIndex = 2;
                  setState(() {

                  });
                  } ,
                  child: Column(
                    children: [
                      Image.asset(
                        AppAssets.assignmentIcon,
                        color: controller.selectedIndex == 2 ? AppThemes
                            .white : AppThemes.whiteOff,
                        width: 22,
                        height: 22,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('Assignment',style: GoogleFonts.poppins(
                          color: controller.selectedIndex == 2 ? AppThemes
                              .white : AppThemes.whiteOff,
                          fontSize: 10,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){controller.selectedIndex = 3;
                  setState(() {

                  });
                  } ,
                  child: Column(
                    children: [
                      Image.asset(
                        AppAssets.eventsIcon,
                        width: 22,
                        height: 22,
                        color: controller.selectedIndex == 3 ? AppThemes
                            .white : AppThemes.whiteOff,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('Events',style: GoogleFonts.poppins(
                          color: controller.selectedIndex == 3 ? AppThemes
                              .white : AppThemes.whiteOff,
                          fontSize: 10,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("tap ");
                    controller.scaffoldKey.currentState?.openEndDrawer();
                  } ,
                  child: Column(
                    children: [
                      Image.asset(
                        AppAssets.moreIcon,
                        width: 22,
                        height: 22,
                        color: controller.selectedIndex == 4 ? AppThemes
                            .white : AppThemes.whiteOff,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('More',style: GoogleFonts.poppins(
                          color: controller.selectedIndex == 4 ? AppThemes
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
      ) : Container(
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
                onTap: () {controller.selectedIndex = 0;
                setState(() {

                });
                } ,
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.homeIcon,
                      width: 22,
                      height: 22,
                      color: controller.selectedIndex == 0 ? AppThemes
                          .white : AppThemes.whiteOff,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('Home',style: GoogleFonts.poppins(
                        color: controller.selectedIndex == 0 ? AppThemes
                            .white : AppThemes.whiteOff,
                        fontSize: 10,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
              ),
              InkWell(
                onTap: () {controller.selectedIndex = 1;
                setState(() {

                });
                } ,
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.attendanceIcon,
                      color: controller.selectedIndex == 1 ? AppThemes
                          .white : AppThemes.whiteOff,
                      width: 22,
                      height: 22,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('Attendance',style: GoogleFonts.poppins(
                        color: controller.selectedIndex == 1 ? AppThemes
                            .white : AppThemes.whiteOff,
                        fontSize: 10,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
              ),
              InkWell(
                onTap: () {controller.selectedIndex = 2;
                setState(() {

                });
                } ,
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.assignmentIcon,
                      color: controller.selectedIndex == 2 ? AppThemes
                          .white : AppThemes.whiteOff,
                      width: 22,
                      height: 22,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('Assignment',style: GoogleFonts.poppins(
                        color: controller.selectedIndex == 2 ? AppThemes
                            .white : AppThemes.whiteOff,
                        fontSize: 10,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
              ),
              InkWell(
                onTap: (){controller.selectedIndex = 3;
                setState(() {

                });
                } ,
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.eventsIcon,
                      width: 22,
                      height: 22,
                      color: controller.selectedIndex == 3 ? AppThemes
                          .white : AppThemes.whiteOff,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('Events',style: GoogleFonts.poppins(
                        color: controller.selectedIndex == 3 ? AppThemes
                            .white : AppThemes.whiteOff,
                        fontSize: 10,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  controller.scaffoldKey.currentState?.openEndDrawer();
                },
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.moreIcon,
                      width: 22,
                      height: 22,
                      color: controller.selectedIndex == 4 ? AppThemes
                          .white : AppThemes.whiteOff,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('More',style: GoogleFonts.poppins(
                        color: controller.selectedIndex == 4 ? AppThemes
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
    )

    );
  }
}

// BottomNavigationBar(
// items: controller.userType == 0 ? [
// BottomNavigationBarItem(
// icon: Icon(CupertinoIcons.house_fill,size: 30),
// label: 'Home',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.category),
// label: 'Category',
// ),
// BottomNavigationBarItem(
// icon: Icon(CupertinoIcons.profile_circled,size: 30),
// label: 'Account',
// ),
// ] : controller.userType == 1 ? [
// BottomNavigationBarItem(
// icon: Icon(CupertinoIcons.house_fill,size: 22),
// label: 'Home',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.category,size: 22),
// label: 'Category',
// ),
// BottomNavigationBarItem(
// icon: Icon(CupertinoIcons.profile_circled,size: 22),
// label: 'Account',
// ),
// BottomNavigationBarItem(
// icon: Icon(CupertinoIcons.profile_circled,size: 22),
// label: 'Account',
// ),
// BottomNavigationBarItem(
// icon: Icon(CupertinoIcons.profile_circled,size: 22),
// label: 'Account',
// ),
// ] : [
// BottomNavigationBarItem(
// icon: Icon(CupertinoIcons.house_fill,size: 30),
// label: 'Home',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.category),
// label: 'Category',
// ),
// BottomNavigationBarItem(
// icon: Icon(CupertinoIcons.profile_circled,size: 30),
// label: 'Account',
// ),
// ] ,
//
// currentIndex: controller.selectedIndex,
// onTap: (value) {
// int lastIndex = controller.studentScreens.length;
//
// if(value == lastIndex) {
// print("Tap");
// // controller.scaffoldKey.currentState?.openDrawer();
// controller.scaffoldKey.currentState?.openEndDrawer();
// // Scaffold.of(context).openDrawer();
// } else {
// controller.selectedIndex = value;
// }
// },
// // onItemTapped(context,_selectedIndex),
// ),
