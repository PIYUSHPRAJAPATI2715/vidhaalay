import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vidhaalay/controller/student_controller/student_attandance_controller.dart';
import 'package:vidhaalay/models/studentModel/student_attandance_model.dart';
import 'package:vidhaalay/repositories/calendar_repo.dart';
import 'package:vidhaalay/widgets/circular_progressindicator.dart';

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
  List currentSessionYear = CommonCalendar.currentSessionYear;

  final List<String> days = [
     'S','M','T','W','T','F','S'
   ];
  final int numberOfDays = 31;
  late DateTime _focusedDay;
  List<String> absentDates = []; // Your list of absent dates
  List<String> presentDates = []; // Your list of present dates
  List<String> nothingDates = []; // Your list of present dates
  // int  getStudentAttandanceController.selectedMonthIndex.value = 0;
  RxString month = "".obs;
  RxString monthName = "".obs;
  RxString day = "".obs;
  final ScrollController _monthController = ScrollController();
  int touchedIndex = -1;
  // final _calendarController = CalendarController();

  @override
  void initState() {
    getStudentAttandanceController.selectedYear.value = int.parse(DateFormat('yyyy').format(DateTime.now()));
    month.value = DateFormat('MM').format(DateTime.now());
    monthName.value = DateFormat('MMMM').format(DateTime.now());
    day.value = DateFormat('dd').format(DateTime.now());
    getStudentAttandanceController.selectedMonthIndex.value = selectCorrectMonthIndex(int.parse(month.value));
    getStudentAttandanceController.selectedYear.value = selectYearByMonth(month: month.value);
    getStudentAttandanceController.selectedMonth.value = int.parse(month.value);
    getStudentAttandanceController.daysInMonth.value =  getMonthDays(year: getStudentAttandanceController.selectedYear.value,month: month.value);
    getStudentAttandanceController.selectedIndex.value = int.parse(day.value) - 1;

    _focusedDay = DateTime.now();
    // _selectedDay = DateTime.now();
    getStudentAttandanceController.getAttandanceData();
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      setState(() {});
      _monthController.animateTo(
        getStudentAttandanceController.selectedMonthIndex.value * 65.0, // Adjust 110 according to your item size and spacing
        duration: Duration(milliseconds: 1800),
        curve: Curves.easeInOut,
      );
    });
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
    var size = MediaQuery.of(context).size;
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
      body: Obx(
        () => Stack(
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
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      transformAlignment: Alignment.center,
                      // width: size.width * .45,
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(currentSessionYear[0].toString(),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: getStudentAttandanceController.selectedYear.value == currentSessionYear[0] ? Colors.white : Colors.black
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(' - ',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Text(currentSessionYear[1].toString(),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: getStudentAttandanceController.selectedYear.value == currentSessionYear[1] ? Colors.white : Colors.black
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: months.length,
                      controller: _monthController,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                               getStudentAttandanceController.selectedMonthIndex.value = index;
                               month.value = selectMonthByIndex(index).toString().padLeft(2, '0');
                               getStudentAttandanceController.selectedYear.value = selectYearByMonth(month: month.value);
                               getStudentAttandanceController.selectedMonth.value = int.parse(month.value);
                               print(index);
                               _focusedDay = DateTime(getStudentAttandanceController.selectedYear.value,getStudentAttandanceController.selectedMonth.value,01);
                               getStudentAttandanceController.getAttandanceData();
                               setState(() {
                                // _focusedDay = DateTime.utc(
                                //   _focusedDay.year,
                                //   // _focusedDay.month + 1,
                                //    getStudentAttandanceController.selectedMonthIndex.value + 1,
                                //   _focusedDay.day,
                                // );
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                months[index],
                                style: TextStyle(fontSize: 18,color :  getStudentAttandanceController.selectedMonthIndex.value == index ?Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
              top: size.height*.160,
              child: Container(
                // padding: const EdgeInsets.symmetric(vertical: 40).copyWith(bottom: 0),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
                ),
                child: getStudentAttandanceController.isDataLoading.value ?  Center(child: CommonProgressIndicator()) :
                Builder(
                  builder: (context) {
                    var attandanceData = null;
                    List<AttendanceData> monthlyData = [];
                    if (getStudentAttandanceController.getStudentAttandanceModel.value.data != null) {
                      attandanceData =
                          getStudentAttandanceController.getStudentAttandanceModel.value.data?.attRatio;
                      if(getStudentAttandanceController.getStudentAttandanceModel.value.data!.attendanceData != null) {
                        monthlyData =
                        getStudentAttandanceController.getStudentAttandanceModel.value.data!.attendanceData!;

                        presentDates.clear();
                        absentDates.clear();

                        monthlyData!.forEach((element) {
                          if(element.present == 2) {
                            presentDates.add(DateFormat("dd/MM/yyyy").format(DateTime.parse(element.createdAt!.toString())));
                          } else if (element.present == 0) {
                            absentDates.add(DateFormat("dd/MM/yyyy").format(DateTime.parse(element.createdAt!.toString())));
                          } else {
                            nothingDates.add(DateFormat("dd/MM/yyyy").format(DateTime.parse(element.createdAt!.toString())));
                          }
                        });
                      }
                    }

                    // print("presentDates $presentDates");
                    // print("absentDates $absentDates");

                    return SingleChildScrollView(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TableCalendar(
                              firstDay: CommonCalendar.startDate!,
                              lastDay:  CommonCalendar.endDate!,
                              focusedDay: _focusedDay,
                              calendarStyle: CalendarStyle(
                                outsideDaysVisible: false,
                                defaultTextStyle: TextStyle(color: AppThemes.red),
                                selectedTextStyle: TextStyle(color: Colors.blue),
                                disabledTextStyle: TextStyle(color: Colors.grey),
                              ),
                              daysOfWeekVisible: false,
                              headerVisible: false,
                              calendarBuilders: CalendarBuilders(
                                // dowBuilder: (context, date) {
                                //   return SizedBox.shrink();
                                // },
                                todayBuilder: (context, date, _) {
                                  String dateString = DateFormat('dd/MM/yyyy').format(date);
                                  // print("dateString : $dateString");

                                  Color textColor = Colors.black;

                                  if (absentDates.contains(dateString)) {
                                    textColor = AppThemes.red;
                                  } else if (presentDates.contains(dateString)) {
                                    textColor = AppThemes.primaryColor;
                                  } else {
                                    textColor = AppThemes.textGray;
                                  }

                                  return Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppThemes.primaryColor)
                                    ),
                                    child: Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold, // Optional: Customize font weight
                                      ),
                                    ),
                                  );
                                },
                                markerBuilder: (context, date, events) {
                                  // Convert date to string in the format "dd/MM/yyyy"
                                  String dateString = DateFormat('dd/MM/yyyy').format(date);
                                  // print("dateString : $dateString");

                                  Color textColor =  AppThemes.textGray;

                                  if (absentDates.contains(dateString)) {
                                    textColor = Colors.red;
                                  } else if (presentDates.contains(dateString)) {
                                    textColor = AppThemes.primaryColor;
                                  } else {
                                    textColor = AppThemes.textGray;
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
                                // _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                                getStudentAttandanceController.selectedMonthIndex.value = selectCorrectMonthIndex(focusedDay.month);
                                getStudentAttandanceController.selectedYear.value = selectYearByMonth(month: focusedDay.month.toString());
                                getStudentAttandanceController.selectedMonth.value = focusedDay.month;

                                print( "_focusedDay" + "${_focusedDay}");
                                // print( "Month" + "${getStudentAttandanceController.selectedMonthIndex.value}");
                                // print( "year" + "${getStudentAttandanceController.selectedYear.value}");

                                getStudentAttandanceController.getAttandanceData();
                                // setState(() {
                                //   _monthController.animateTo(
                                //     getStudentAttandanceController.selectedMonthIndex.value * 70.0,
                                //     duration: Duration(milliseconds: 1500),
                                //     curve: Curves.easeInOut,
                                //   );
                                // });
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                // setState(() {
                                //   // _selectedDay = selectedDay;
                                // });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
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
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       decoration: const BoxDecoration(
                                  //         shape: BoxShape.circle,
                                  //         color: AppThemes.black,
                                  //       ),
                                  //       width: 13,
                                  //       height: 13,
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 8,
                                  //     ),
                                  //
                                  //     Text('Today',
                                  //       style: GoogleFonts.poppins(
                                  //           color: AppThemes.black,
                                  //           fontSize: 15,
                                  //           fontWeight: FontWeight.w500
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'attendance'.toUpperCase(),
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 19,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      attandanceData != null
                                          ? Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Image.asset(AppAssets.pieChart,width: 90,),

                                          Container(
                                            height: size.height * 0.14,
                                            width: size.width * 0.35,
                                            // color: Colors.red,
                                            child: PieChart(
                                              PieChartData(
                                                  pieTouchData: PieTouchData(
                                                    touchCallback:
                                                        (FlTouchEvent event,
                                                        pieTouchResponse) {
                                                      setState(() {
                                                        if (!event
                                                            .isInterestedForInteractions ||
                                                            pieTouchResponse ==
                                                                null ||
                                                            pieTouchResponse
                                                                .touchedSection ==
                                                                null) {
                                                          touchedIndex = -1;
                                                          return;
                                                        }
                                                        touchedIndex =
                                                            pieTouchResponse
                                                                .touchedSection!
                                                                .touchedSectionIndex;
                                                      });
                                                    },
                                                  ),
                                                  startDegreeOffset: 180,
                                                  borderData: FlBorderData(
                                                    show: false,
                                                  ),
                                                  sectionsSpace: 2,
                                                  centerSpaceRadius: 0,
                                                  sections: showingSections(
                                                      absentValue: double.parse(
                                                          attandanceData.absent
                                                              .toString()),
                                                      presentValue: double.parse(
                                                          attandanceData.present
                                                              .toString()),
                                                      nothingValue: double.parse(
                                                          attandanceData.holiday.toString()),),

                                                // attandanceData.present.toDouble()),
                                              ),
                                            ),
                                          ),

                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                    width: size.width * .030,
                                                  ),
                                                  Text(
                                                    'Present',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppThemes.black),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * .13,
                                                  ),
                                                  Text(
                                                    attandanceData.present
                                                        .toString() +
                                                        "%",
                                                    // '50%',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                        color: AppThemes.black),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppThemes.red,
                                                    ),
                                                    width: 13,
                                                    height: 13,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * .030,
                                                  ),
                                                  Text(
                                                    'Absent ',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppThemes.red),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * .13,
                                                  ),
                                                  Text(
                                                    attandanceData.absent
                                                        .toString() +
                                                        "%",
                                                    // '50%',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                        color: AppThemes.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                          : Text("No Attandance Available")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  List<PieChartSectionData> showingSections({
    required double presentValue,
    required double absentValue,
    required double nothingValue,
  }) {
    return List.generate(
      3,
          (i) {
        final isTouched = i == touchedIndex;
        const color0 = AppThemes.primaryColor;
        const color1 = AppThemes.red;
        const color2 = AppThemes.textGray;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: presentValue,
              // pieData[i],
              title: '',
              radius: 45,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: AppThemes.black, width: 3)
                  : BorderSide(color: AppThemes.black.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: absentValue,
              // pieData[i],
              title: '',
              radius: 45,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: AppThemes.white, width: 3)
                  : BorderSide(color: AppThemes.white.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: nothingValue,
              // pieData[i],
              title: '',
              radius: 45,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: AppThemes.black, width: 3)
                  : BorderSide(color: AppThemes.black.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
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