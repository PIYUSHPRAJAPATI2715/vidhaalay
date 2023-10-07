import 'package:flutter/material.dart';
import 'package:get/get.dart';
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



class BottomController extends GetxController {


  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var screens = [
    const StudentHomeScreen(),
    const AttendanceScreen(),
    const AssignmentScreen(),
    const EventsScreen(),
    const MoreScreen(),
  ];

  RxInt currentIndex = 0.obs;

  // user screens
  RxInt currentIndexUser = 0.obs;

  var screensUser = [
    const UserHomeScreen(),
    const VideoScreen(),
    const MyLecturesScreen(),
    const NotificationScreenUser(),
    const UserMoreScreen(),

  ];

}
