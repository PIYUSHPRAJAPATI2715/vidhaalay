import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/models/TeacherModel/class_list_model.dart';
import 'package:vidhaalay_app/repositories/teacher/class_list_repo.dart';
import '../screen/User_Screens/drawer_user.dart';
import '../screen/User_Screens/my_lecturs_screen.dart';
import '../screen/User_Screens/notification_user_screen.dart';
import '../screen/User_Screens/user_home_screen.dart';
import '../screen/User_Screens/user_more_screen.dart';
import '../screen/User_Screens/videos_screen.dart';
import '../screen/student_screen/assignment_screen.dart';
import '../screen/student_screen/attendance_screen.dart';
import '../screen/student_screen/events_screen.dart';
import '../screen/student_screen/home_screen.dart';
import '../screen/student_screen/more_screen.dart';
import '../screen/teacher_flow/teacher_assigment_screen.dart';
import '../screen/teacher_flow/teacher_attendance_Screen.dart';
import '../screen/teacher_flow/teacher_event_screen.dart';
import '../screen/teacher_flow/teacher_home_screen.dart';
import '../screen/teacher_flow/teacher_more_screen.dart';

class BottomNavBarController extends GetxController {


  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int userType = 0;
  int selectedIndex = 0;

  var studentScreens = [
    const StudentHomeScreen(),
    const AttendanceScreen(),
    const AssignmentScreen(),
    const EventsScreen(),
    // const MoreScreen(),
  ];

  var teacherScreens = [
    const TeacherHomeScreen(),
    const TeacherAttendanceScreen(),
    const TeacherAssignmentScreen(),
    const TeacherEventsScreen(),
    // const TeacherMoreScreen(),
    // const MoreScreen(),
  ];

  var userScreens = [
    const UserHomeScreen(),
    const VideoScreen(),
    // const UserMoreScreen(),
    // const MoreScreen(),
  ];

  RxBool isClassLoading = true.obs;
  Rx<ClassList> getClassListModel = ClassList().obs;
  String? userClassName;

  Future getClassListData() async {
    isClassLoading.value = true;
    await getClassListRepo().then((value) {
      print("class value : $value");
      getClassListModel.value = value;
      isClassLoading.value = false;
    });
  }

}