import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screen/student_screen/home_screen.dart';



class BottomController extends GetxController {


  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var screens = [
    const StudentHomeScreen(),
    const StudentHomeScreen(),
    const StudentHomeScreen(),
    // const ScheduleScreen(),
    // const RecordsScreen()
  ];

  RxInt currentIndex = 0.obs;


}
