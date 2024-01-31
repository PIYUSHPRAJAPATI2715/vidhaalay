import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/controller/student_controller/bottom_navigation_controller.dart';
import 'package:vidhaalay_app/models/login_model.dart';
import 'package:vidhaalay_app/screen/User_Screens/bottom_nav_user.dart';
import 'package:vidhaalay_app/screen/User_Screens/videos_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/attendance_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/bottom_nav_student.dart';
import 'package:vidhaalay_app/screen/student_screen/class_timetable_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/exam_result_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/exam_timetable_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/syllabus_Screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/bottom_navbar_teacher.dart';
import 'package:vidhaalay_app/screen/teacher_flow/student_list_screen.dart';
import '../../controller/bottom_controller.dart';
import '../../resourses/api_constant.dart';
import '../../resourses/app_assets.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';


class DrawerForStudent extends StatefulWidget {
  const DrawerForStudent({super.key});

  @override
  State<DrawerForStudent> createState() => _DrawerForStudentState();
}

class _DrawerForStudentState extends State<DrawerForStudent> {
  final bottomController = Get.put(StudentBottomController());
  double value = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width * 0.65, //<-- SEE HERE
      // padding: const EdgeInsets.all(8.0),
      child: Drawer(
        backgroundColor:  AppThemes.primaryColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
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
                            "Rosie Wannh", // Display user's name here
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: AppThemes.white,
                            ),
                          ),
                          const Text(
                            "CLASS-12th", // Display user's name here
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppThemes.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: (){
                    // Get.to(() => VideoScreen());
                  },
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                  const VisualDensity(
                      horizontal: -4, vertical: -4),
                  title: const Text(
                    'Video Lecture',
                    style: TextStyle(
                        color: AppThemes.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  leading: Image.asset(
                    AppAssets.videoIcon,
                    height: 20,
                    width: 24,
                    color: AppThemes.white,
                    // width: 23,
                    // height: 23,
                  ),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: (){
                    Get.to(() => SyllabusScreen());
                  },
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                  const VisualDensity(
                      horizontal: -4, vertical: -4),
                  title: const Text(
                    'Syllabus',
                    style: TextStyle(
                        color: AppThemes.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  leading: Image.asset(
                    AppAssets.syllabusImg,
                    height: 20,
                    width: 24,
                    color: AppThemes.white,
                    // width: 23,
                    // height: 23,
                  ),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: (){
                    Get.to(() => AttendanceScreen());
                  },
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                  const VisualDensity(
                      horizontal: -4, vertical: -4),
                  title: const Text(
                    'Attendance',
                    style: TextStyle(
                        color: AppThemes.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  leading: Image.asset(
                    AppAssets.personIcon,
                    height: 20,
                    width: 24,
                    color: AppThemes.white,
                    // width: 23,
                    // height: 23,
                  ),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: () {
                    Get.to(() => ClassTimeTableScreen());

                    // Get.toNamed(MyRouters.teacherClassTimeScreen);
                  },
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                  const VisualDensity(
                      horizontal: -4, vertical: -4),
                  title: const Text(
                    'Class Timetable',
                    style: TextStyle(
                        color: AppThemes.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),

                  ),
                  leading: Image.asset(
                    AppAssets.attendanceIcon,
                    height: 20,
                    width: 24,
                    color: AppThemes.white,
                    // width: 23,
                    // height: 23,
                  ),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: (){
                    Get.to(() => ExamTimeTableScreen());
                  },
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                  const VisualDensity(
                      horizontal: -4, vertical: -4),
                  title: const Text(
                    'Exam Timetable',
                    style: TextStyle(
                        color: AppThemes.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),

                  ),
                  leading: Image.asset(
                    AppAssets.examTimeTableImg,
                    height: 20,
                    width: 24,
                    color: AppThemes.white,
                    // width: 23,
                    // height: 23,
                  ),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: (){
                    Get.to(() => ExamResultScreen());
                  },
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                  const VisualDensity(
                      horizontal: -4, vertical: -4),
                  title: const Text(
                    'Exam Result',
                    style: TextStyle(
                        color: AppThemes.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),

                  ),
                  leading: Image.asset(
                    AppAssets.examResultImg,
                    height: 20,
                    width: 24,
                    color: AppThemes.white,
                    // width: 23,
                    // height: 23,
                  ),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  onTap: (){
                    Get.toNamed(MyRouters.settingScreenUser);
                  },
                  contentPadding: EdgeInsets.zero,
                  visualDensity:
                  const VisualDensity(
                      horizontal: -4, vertical: -4),
                  title: const Text(
                    'Settings',
                    style: TextStyle(
                        color: AppThemes.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),

                  ),
                  leading: Icon(
                    // "assets/icons/home.png",
                    Icons.settings_outlined,
                    color:  AppThemes.white,
                    // width: 23,
                    // height: 23,
                  ),
                ),
                SizedBox(height: size.height*.05,),
                InkWell(
                  onTap: (){
                    logOutUser();

                    // Get.offAllNamed(MyRouters.signInPage);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: Colors.white,
                            width: 2
                        )
                    ),
                    child: const Text(
                      'LOGOUT',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  logOutUser() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    LoginModel modelSiteSettings = LoginModel();
    if (sharedPreference.getString("token") != null) {
      modelSiteSettings =
          LoginModel.fromJson(jsonDecode(sharedPreference.getString("token")!));
    }
    await sharedPreference.clear();
    Get.offAllNamed(MyRouters.signInPage);
    showToast(message:"Logged out");
    if (modelSiteSettings.data != null) {
      sharedPreference.setString("token", jsonEncode(modelSiteSettings));
    }
    sharedPreference.setBool("isFirstTime", false);
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Switch Account'),
          content: const Text('Do you want to switch account?'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Get.back();
                },

                child: const Text('No')
            ),
            TextButton(
              onPressed: () {
                Get.offAllNamed(MyRouters.signInPage);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
