import 'package:flutter/material.dart';
import 'package:get/get.dart';
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



class BottomController extends GetxController {


  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scaffoldKeyUser = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scaffoldKeyTeacher = GlobalKey<ScaffoldState>();

  var screens = [
    const StudentHomeScreen(),
    const AttendanceScreen(),
    const AssignmentScreen(),
    const EventsScreen(),
    const MoreScreen(),
  ];
  var teacherScreens = [
    const TeacherHomeScreen(),
    const TeacherAttendanceScreen(),
    const TeacherAssignmentScreen(),
    const TeacherEventsScreen(),
    const TeacherMoreScreen(),
  ];

  RxInt currentIndex = 0.obs;
  RxInt currentIndexTeacher = 0.obs;

  // user screens
  RxInt currentIndexUser = 0.obs;

  var screensUser = [
    const UserHomeScreen(),
    const VideoScreen(),
    const MyLecturesScreen(),
    const NotificationScreenUser(),
    // const DrawerForUser(),
     const UserMoreScreen(),

  ];
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
}
