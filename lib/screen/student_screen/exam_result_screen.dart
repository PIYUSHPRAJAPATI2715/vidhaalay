import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/student_controller/exam_result_student_controller.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_dropdown.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class ExamResultScreen extends StatefulWidget {
  const ExamResultScreen({Key? key}) : super(key: key);

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen> {
  final examResultController = Get.put(ExamResultStudentController());

  RxString day = "".obs;
  RxString month = "".obs;
  RxString year = "".obs;
  RxString monthName = "".obs;
  RxString clinicId = "".obs;
  int selectedIndex = 0;
  int selectedMonthIndex = 0;

  var now = DateTime.now();
  var totalDays;
  var listOfDates;
  var todayDay;

  @override
  void initState() {
    super.initState();
    examResultController.getExamTypeData();
    year.value = DateFormat('yyyy').format(DateTime.now());
    month.value = DateFormat('MM').format(DateTime.now());
    monthName.value = DateFormat('MMMM').format(DateTime.now());
    day.value = DateFormat('dd').format(DateTime.now());
    getYear();
    now = DateTime.now();
    totalDays = daysInMonth(now);
    listOfDates = List<int>.generate(totalDays, (i) => i + 1);
    todayDay = DateFormat('dd').format(now);
    selectedIndex = int.parse(todayDay.toString()) - 1;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getWeekDates(now);
      if (!mounted) return;
      setState(() {});
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Scrollable.ensureVisible(keysList[selectedIndex].currentContext!,
            alignment: .5);
      });
    });
  }

  List<GlobalKey> keysList = [];

  List<DateTime> weekDates = [];

  getWeekDates(DateTime currentDate) {
    weekDates.clear();
    for (int i = 1 - int.parse(todayDay);
    i <= listOfDates.length - int.parse(todayDay);
    i++) {
      weekDates.add(currentDate.add(Duration(days: i)));
      // log(weekDates.toString());
      // log(DateFormat('EEEE').format(weekDates[0]));
    }
    setState(() {});
    keysList = List.generate(weekDates.length, (index) => GlobalKey());
    return weekDates;
  }

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  List<int> years = [];

  List<int> getYear() {
    for (int i = 2023; i <= 2050; i++) {
      years.add(i);
    }
    return years;
  }

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(date.year, date.month, date.day);
    log("Week days$firstDayThisMonth");
    var firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    log("Week days$firstDayNextMonth");
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppThemes.black,
          ),
        ),
        centerTitle: true,
      ),
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
              height: size.height * .260,
              decoration: const BoxDecoration(
                color: AppThemes.primaryColor,
                borderRadius:
                BorderRadius.only(bottomLeft: Radius.circular(70)),
              ),
              child: Padding(
                padding: EdgeInsets.all(size.width * .010),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          year.value.toString(),
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * .070,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: months.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    selectedMonthIndex = index;
                                    month.value = "${index + 1}".length != 2
                                        ? "0${index + 1}"
                                        : "${index + 1}";
                                    monthName.value = DateFormat('MMMM').format(
                                        DateTime.parse(
                                            "${year.value}-${month.value}-${day.value}"));
                                    now = DateTime.parse(
                                        "${year.value}-${month.value}-${day.value}");
                                    totalDays = daysInMonth(now);
                                    listOfDates = List<int>.generate(
                                        totalDays, (i) => i + 1);
                                    todayDay = DateFormat('dd').format(now);
                                    getWeekDates(now);
                                    log(DateFormat('EEEE').format(now));

                                    String date = year.value +
                                        "-" +
                                        month.value +
                                        "-" +
                                        day.value;

                                    // assignmentListStudentController.selDate.value = date;
                                    // assignmentListStudentController
                                    //     .getAssignmentData();
                                    // Get.back();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Text(months[index].toString(),
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                            color: index == selectedMonthIndex
                                                ? Colors.white
                                                : Colors.black)),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * .110,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Row(
                          children: List.generate(weekDates.length, (index) {
                            DateTime date = weekDates[index];
                            String formattedDate = DateFormat('d').format(date);
                            String formattedDate1 =
                            DateFormat('MM').format(date);
                            String formattedDate2 =
                            DateFormat('yyyy').format(date);
                            String weekDay = DateFormat('EEEE').format(date);
                            return Padding(
                              key: keysList[index],
                              padding: EdgeInsets.only(right: 0, left: 0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    day.value = formattedDate.length != 2
                                        ? "0$formattedDate"
                                        : formattedDate;
                                    // month.value = formattedDate1.length != 2 ? "0$formattedDate1" : formattedDate1;
                                    // year.value = formattedDate2;
                                    log(day.value);
                                    log(month.value);
                                    log(year.value);

                                    monthName.value = DateFormat('MMMM').format(
                                        DateTime.parse(
                                            "${year.value}-${month.value}-${day.value}"));

                                    String date = year.value +
                                        "-" +
                                        month.value +
                                        "-" +
                                        day.value;
                                    log(date);
                                    // assignmentListStudentController.selDate.value = date;
                                    // assignmentListStudentController
                                    //     .getAssignmentData();
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: index == selectedIndex
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            weekDay[0].toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: index == selectedIndex
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                          Text(
                                            formattedDate,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: index == selectedIndex
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Positioned.fill(
            top: size.height * .260,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 12)
                  .copyWith(bottom: 0),
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppThemes.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                          () => examResultController.isExamTypeLoading.value
                          ? SizedBox.shrink()
                          : Container(
                        // transformAlignment: Alignment.center,
                        // width: size.width * .45,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: examResultController
                            .getExamTypeModel.value.data!.isEmpty
                            ? SizedBox.shrink()
                            : Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Type -',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              width: 5,
                            ),

                            CommonDropDownButton(
                              value: examResultController
                                  .selectedExamType?.value,
                              items: examResultController
                                  .getExamTypeModel.value.data!
                                  .toList()
                                  .map((items) {
                                return DropdownMenuItem(
                                  value: items.id,
                                  child: Text(
                                    items.name!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: examResultController
                                          .selectedExamType
                                          ?.value ==
                                          items.id
                                          ? Colors.black
                                      // Colors.grey.shade900 // Change the color for selected item
                                          : Colors
                                          .black, // Default color for unselected items
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                examResultController
                                    .selectedExamType!
                                    .value = newValue!;
                                print(examResultController
                                    .selectedExamType?.value);

                                examResultController
                                    .getExamResultData();
                              },
                              width: size.width * 0.55,
                              backgroundColor: Colors.white,
                            ),

                            // DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     value: examResultController
                            //         .selectedExamType?.value,
                            //     // icon: Icon(Icons.keyboard_arrow_down,color: Colors.white),
                            //     dropdownStyleData:
                            //     DropdownStyleData(
                            //       maxHeight: size.height * 0.28,
                            //       width: size.width * 0.55,
                            //       padding: EdgeInsets.symmetric(
                            //           horizontal: 5),
                            //       isOverButton: false,
                            //       decoration: BoxDecoration(
                            //         borderRadius:
                            //         BorderRadius.circular(14),
                            //         color: Colors.white,
                            //       ),
                            //       offset: const Offset(-10, 0),
                            //       scrollbarTheme:
                            //       ScrollbarThemeData(
                            //         radius:
                            //         const Radius.circular(40),
                            //         thickness: MaterialStateProperty
                            //             .all<double>(6),
                            //         thumbVisibility:
                            //         MaterialStateProperty.all<
                            //             bool>(true),
                            //       ),
                            //     ),
                            //     menuItemStyleData:
                            //     const MenuItemStyleData(
                            //       height: 45,
                            //       padding: EdgeInsets.only(
                            //           left: 10, right: 10),
                            //     ),
                            //     // dropdownColor: Colors.white70,
                            //     items: examResultController
                            //         .getExamTypeModel.value.data!
                            //         .toList()
                            //         .map((items) {
                            //       return DropdownMenuItem(
                            //         value: items.id,
                            //         child: Text(
                            //           items.name!,
                            //           style: TextStyle(
                            //             fontWeight: FontWeight.w500,
                            //             fontSize: 17,
                            //             color: examResultController
                            //                 .selectedExamType
                            //                 ?.value ==
                            //                 items.id
                            //                 ? Colors.black
                            //             // Colors.grey.shade900 // Change the color for selected item
                            //                 : Colors
                            //                 .black, // Default color for unselected items
                            //           ),
                            //         ),
                            //       );
                            //     }).toList(),
                            //     onChanged: (newValue) {
                            //       examResultController
                            //           .selectedExamType!
                            //           .value = newValue!;
                            //       print(examResultController
                            //           .selectedExamType?.value);
                            //
                            //       examResultController
                            //           .getExamResultData();
                            //     },
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),

                    Obx(
                      () => examResultController.isDataLoading.value ?  SizedBox(
                          height: size.height * 0.525,
                          child: Center(child: const CommonProgressIndicator())) : Container(
                        height: size.height * 0.525,
                        // color: Colors.amber,
                        child: examResultController.getExamResultModel.value.data!.isEmpty ? Center(
                          child: Text(
                            "No result Available",
                          ),
                        ): ListView.builder(
                          // shrinkWrap: true,
                          itemCount: examResultController.getExamResultModel.value.data!.length,
                          physics: const BouncingScrollPhysics(),
                          // padding: EdgeInsets.symmetric(vertical: 5),
                          itemBuilder: (context, index) {
                            var values = examResultController.getExamResultModel.value.data![index];


                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                              values.from!,
                                        // '16th Mar',
                                        style: GoogleFonts.poppins(
                                            color: AppThemes.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        width: size.width * .40,
                                        padding: const EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                            color: AppThemes.lightPink,
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              values.subjectName!,

                                              // 'Social Science',
                                              style: GoogleFonts.poppins(
                                                  color: AppThemes.blueColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              values.marks! + "/" + values.totalMarks.toString(),
                                              // '52/100',
                                              style: GoogleFonts.poppins(
                                                  color: AppThemes.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      int.parse(values.marks!) >=  values.passingMarks! ? Text(
                                        'Pass',
                                        style: GoogleFonts.poppins(
                                            color: Colors.green,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ) :
                                      Text(
                                        'Fail',
                                        style: GoogleFonts.poppins(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
