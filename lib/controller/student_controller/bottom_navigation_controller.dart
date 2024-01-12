import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/screen/student_screen/assignment_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/attendance_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/events_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/home_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/more_screen.dart';


class StudentBottomController extends GetxController {


  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  double value = 0;

  RxInt currentIndex = 0.obs;

  var screens = [
    const StudentHomeScreen(),
    const AttendanceScreen(),
    const AssignmentScreen(),
    const EventsScreen(),
    const MoreScreen(),
  ];

}