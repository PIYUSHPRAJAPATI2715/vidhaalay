import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vidhaalay_app/controller/student_controller/student_attandance_controller.dart';
import 'package:vidhaalay_app/repositories/calendar_repo.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';

import '../../controller/teacher_controller/student_attandance_controller.dart';
import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';


class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  final getStudentAttandanceController = Get.put(GetStudentAttandanceController());

  final List<String> months =  CommonCalendar.monthsList;
   final List<String> days = [
     'S','M','T','W','T','F','S'
   ];
  final int numberOfDays = 31;
  late DateTime _focusedDay;
  List<String> absentDates = ["01/12/2023","04/12/2023","05/12/2023"]; // Your list of absent dates
  List<String> presentDates = ["02/12/2023","03/12/2023"]; // Your list of present dates
  int selectedMonthIndex = 0;

  @override
  void initState() {
    _focusedDay = DateTime.now();
    // _selectedDay = DateTime.now();
    getStudentAttandanceController.getAttandanceData();
    super.initState();
  }

  // late DateTime _focusedDay;
  // late DateTime _selectedDay;
  // late List<Attendance> _attendanceData;
  // List<String> absentDates = ["01/12/2023","04/12/2023","05/12/2023"]; // Your list of absent dates
  // List<String> presentDates = ["02/12/2023","03/12/2023"]; // Your list of present dates
  // late PageController _pageController;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _focusedDay = DateTime.now();
  //   _selectedDay = DateTime.now();
  //   // Replace this with your actual JSON data
  //   final jsonData = [
  //     {
  //       "id": 86,
  //       "student_id": 4,
  //       "class_id": 2,
  //       "school_id": 6,
  //       "present": false,
  //       "status": 1,
  //       "createdAt": "2024-01-05T04:22:31.209Z",
  //       "updatedAt": "2024-01-05T04:22:31.209Z",
  //       "deletedAt": null
  //     },
  //     // Add more attendance records as needed
  //   ];
  //   _attendanceData = jsonData.map((data) => Attendance.fromJson(data)).toList();
  // }

  // Attendance _getAttendanceForDate(DateTime date) {
  //   // Find and return the attendance record for the selected date
  //   return _attendanceData.firstWhere(
  //         (attendance) => isSameDay(date, attendance.createdAt),
  //     orElse: () => Attendance(
  //       id: -1, // Use a placeholder value or handle differently based on your needs
  //       studentId: -1,
  //       classId: -1,
  //       schoolId: -1,
  //       present: false,
  //       status: -1,
  //       createdAt: date,
  //       updatedAt: date,
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppThemes.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                  AppThemes.primaryColor,
                  AppThemes.primaryColor,
                ],
                end: Alignment.centerRight,
                begin: Alignment.centerLeft,
                stops: [0, .5, .501, 1],
              ),
            ),
          ),
          Container(
            height: size.height*.160,
            decoration: const BoxDecoration(
              color: AppThemes.primaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: months.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            print(index);
                            selectedMonthIndex = index;

                            setState(() {
                              _focusedDay = DateTime.utc(
                                _focusedDay.year,
                                // _focusedDay.month + 1,
                                selectedMonthIndex + 1,
                                _focusedDay.day,
                              );
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              months[index],
                              style: TextStyle(fontSize: 18,color : selectedMonthIndex == index ?Colors.white : Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          days[index],
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Positioned.fill(
            top: size.height*.159,
            child: Container(
              // padding: const EdgeInsets.symmetric(vertical: 40).copyWith(bottom: 0),
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppThemes.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
              ),
              child: Obx(
                () => getStudentAttandanceController.isDataLoading.value ?  Center(child: CommonProgressIndicator()) : SingleChildScrollView(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TableCalendar(
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: _focusedDay,
                          calendarStyle: CalendarStyle(
                            outsideDaysVisible: false,
                            defaultTextStyle: TextStyle(color: Colors.red),
                            selectedTextStyle: TextStyle(color: Colors.blue),
                            disabledTextStyle: TextStyle(color: Colors.grey),
                          ),
                          daysOfWeekVisible: false,
                          headerVisible: false,
                          calendarBuilders: CalendarBuilders(
                            // dowBuilder: (context, date) {
                            //   return SizedBox.shrink();
                            // },
                            markerBuilder: (context, date, events) {
                              // Convert date to string in the format "dd/MM/yyyy"
                              String dateString = DateFormat('dd/MM/yyyy').format(date);

                              Color textColor = Colors.black;
                              if (absentDates.contains(dateString)) {
                                textColor = Colors.red;
                              } else if (presentDates.contains(dateString)) {
                                textColor = Colors.green;
                              }
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold, // Optional: Customize font weight
                                  ),
                                ),
                              );
                            },
                          ),
                          onPageChanged: (focusedDay) {
                            print(focusedDay);
                            setState(() {
                              // _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                              selectedMonthIndex = focusedDay.month - 1;
                              print(selectedMonthIndex);
                            });
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            // setState(() {
                            //   // _selectedDay = selectedDay;
                            // });
                          },
                        ),

                        // TableCalendar(
                        //   firstDay: DateTime.utc(2010, 10, 16),
                        //   lastDay: DateTime.utc(2030, 3, 14),
                        //   focusedDay: DateTime.now(),
                        //   headerVisible: false,
                        //   // headerStyle: HeaderStyle(
                        //   //   // Hide the left and right arrows
                        //   //   leftChevronIcon: Icon(Icons.arrow_left, color: Colors.transparent),
                        //   //   rightChevronIcon: Icon(Icons.arrow_right, color: Colors.transparent),
                        //   // ),
                        //   calendarBuilders: CalendarBuilders(
                        //     // headerTitleBuilder: (context, date) {
                        //     //   return null;
                        //     // },
                        //     dowBuilder: (context, date) {
                        //       return SizedBox.shrink();
                        //     },
                        //
                        //     // dayBuilder: (context, date) {
                        //     //   return Text('');
                        //     // },
                        //   ),
                        //   // mon
                        // ),
                        // const SizedBox(
                        //   height: 14,
                        // ),
                        const Divider(
                          color: AppThemes.dividerColor,
                          height: 1.2,
                          thickness: 2,
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: size.width * 0.06,vertical: 20).copyWith(bottom: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppThemes.black,
                                    ),
                                    width: 13,
                                    height: 13,
                                  ),
                                 const SizedBox(
                                    width: 8,
                                  ),

                                  Text('Today',
                                    style: GoogleFonts.poppins(
                                        color: AppThemes.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 45,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(AppAssets.pieChart,width: 130,),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppThemes.primaryColor,
                                            ),
                                            width: 13,
                                            height: 13,
                                          ),
                                          SizedBox(
                                            width: size.width*.030,
                                          ),
                                          Text('Present',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppThemes.black
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width*.13,
                                          ),
                                          Text('50%',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppThemes.black
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                            width: 13,
                                            height: 13,
                                          ),
                                          SizedBox(
                                            width: size.width*.030,
                                          ),
                                          Text('Absent ',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width*.13,
                                          ),
                                          Text('50%',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppThemes.black
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class Attendance {
  final int id;
  final int studentId;
  final int classId;
  final int schoolId;
  final bool present;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Attendance({
    required this.id,
    required this.studentId,
    required this.classId,
    required this.schoolId,
    required this.present,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      studentId: json['student_id'],
      classId: json['class_id'],
      schoolId: json['school_id'],
      present: json['present'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}