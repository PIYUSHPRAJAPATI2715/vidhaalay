import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import '../controller/bottom_controller.dart';
import '../widgets/appTheme.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final bottomController = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return Drawer(
        width: size.width * .78,
        backgroundColor: AppThemes.primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [

              Theme(
                data: ThemeData(
                  dividerColor: Colors.transparent
                ),
                child: SizedBox(
                  height: size.height * 0.33,
                  child: DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60', scale: 40),
                        ),
                        SizedBox(height: size.height * 0.016),
                        const Text(
                          "User", // Display user's name here
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: AppThemes.white,
                          ),
                        ),
                        SizedBox(height: size.height * 0.004),
                        const Text(
                          'Class - 12th',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppThemes.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                visualDensity:
                const VisualDensity(
                    horizontal: -4, vertical: -4),
                title: bottomController.currentIndex.value == 0
                    ? const Text(
                  'Video Lectured',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
                    : const Text(
                  'Video Lectures',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),

                ),
                leading: Image.asset(
                  AppAssets.videoIcon,

                  // Icons.home,
                  color: bottomController.currentIndex.value ==
                      0 ? AppThemes.white : AppThemes.white,
                  // width: 23,
                  // height: 23,
                ),
              ),
              const SizedBox(height: 10,),
              ListTile(
                visualDensity:
                const VisualDensity(
                    horizontal: -4, vertical: -4),
                title: bottomController.currentIndex.value == 0
                    ? const Text(
                  'Syllabus',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
                    : const Text(
                  'Syllabus',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),

                ),
                leading: Icon(
                  // "assets/icons/home.png",
                  Icons.home,
                  color: bottomController.currentIndex.value ==
                      0 ? AppThemes.white : AppThemes.white,
                  // width: 23,
                  // height: 23,
                ),
              ),
              const SizedBox(height: 10,),
              ListTile(
                visualDensity:
                const VisualDensity(
                    horizontal: -4, vertical: -4),
                title: bottomController.currentIndex.value == 0
                    ? const Text(
                  'Attendance',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
                    : const Text(
                  'Attendance',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),

                ),
                leading: Icon(
                  // "assets/icons/home.png",
                  Icons.home,
                  color: bottomController.currentIndex.value ==
                      0 ? AppThemes.white : AppThemes.white,
                  // width: 23,
                  // height: 23,
                ),
              ),
              const SizedBox(height: 10,),
              ListTile(
                visualDensity:
                const VisualDensity(
                    horizontal: -4, vertical: -4),
                title: bottomController.currentIndex.value == 0
                    ? const Text(
                  'Class Timetable',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
                    : const Text(
                  'Class Timetable',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),

                ),
                leading: Icon(
                  // "assets/icons/home.png",
                  Icons.home,
                  color: bottomController.currentIndex.value ==
                      0 ? AppThemes.white : AppThemes.white,
                  // width: 23,
                  // height: 23,
                ),
              ),
              const SizedBox(height: 10,),
              ListTile(
                visualDensity:
                const VisualDensity(
                    horizontal: -4, vertical: -4),
                title: bottomController.currentIndex.value == 0
                    ? const Text(
                  'Exam Timetable',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
                    : const Text(
                  'Exam Timetable',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),

                ),
                leading: Icon(
                  // "assets/icons/home.png",
                  Icons.home,
                  color: bottomController.currentIndex.value ==
                      0 ? AppThemes.white : AppThemes.white,
                  // width: 23,
                  // height: 23,
                ),
              ),
              const SizedBox(height: 10,),
              ListTile(
                visualDensity:
                const VisualDensity(
                    horizontal: -4, vertical: -4),
                title: bottomController.currentIndex.value == 0
                    ? const Text(
                  'Exam Results',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
                    : const Text(
                  'Exam Results',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),

                ),
                leading: Icon(
                  // "assets/icons/home.png",
                  Icons.home,
                  color: bottomController.currentIndex.value ==
                      0 ? AppThemes.white : AppThemes.white,
                  // width: 23,
                  // height: 23,
                ),
              ),
              const SizedBox(height: 10,),
              ListTile(
                visualDensity:
                const VisualDensity(
                    horizontal: -4, vertical: -4),
                title: bottomController.currentIndex.value == 0
                    ? const Text(
                  'settings',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
                    : const Text(
                  'settings',
                  style: TextStyle(
                      color: AppThemes.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),

                ),
                leading: Icon(
                  // "assets/icons/home.png",
                  Icons.home,
                  color: bottomController.currentIndex.value ==
                      0 ? AppThemes.white : AppThemes.white,
                  // width: 23,
                  // height: 23,
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.white,
                        width: 2
                    )
                ),
                child: Text(
                  'LOGOUT',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
