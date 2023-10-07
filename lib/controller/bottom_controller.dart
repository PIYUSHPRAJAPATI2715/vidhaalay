import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    // const ScheduleScreen(),
    // const RecordsScreen()
  ];

  RxInt currentIndex = 0.obs;


}
