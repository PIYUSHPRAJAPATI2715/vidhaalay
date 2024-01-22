import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/student_controller/assignment_list_controller_student.dart';
import 'package:vidhaalay_app/controller/student_controller/event_list_controller_student.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/student_screen/assignment_details_screen.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({Key? key}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
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

  final assignmentListStudentController = Get.put(AssignmentListStudentController());

  @override
  void initState() {
    super.initState();
    year.value = DateFormat('yyyy').format(DateTime.now());
    month.value = DateFormat('MM').format(DateTime.now());
    monthName.value = DateFormat('MMMM').format(DateTime.now());
    day.value = DateFormat('dd').format(DateTime.now());

    assignmentListStudentController.getAssignmentData();

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
        title: Text('Assignments',
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
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
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      selectedMonthIndex = index;
                                      month.value = "${index + 1}".length != 2
                                          ? "0${index + 1}"
                                          : "${index + 1}";
                                      monthName.value = DateFormat('MMMM')
                                          .format(DateTime.parse(
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
                                      assignmentListStudentController.selDate.value = date;
                                      assignmentListStudentController
                                          .getAssignmentData();
                                      // Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(months[index].toString(),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                              color:
                                              index == selectedMonthIndex
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
                            children:
                            List.generate(weekDates.length, (index) {
                              DateTime date = weekDates[index];
                              String formattedDate =
                              DateFormat('d').format(date);
                              String formattedDate1 =
                              DateFormat('MM').format(date);
                              String formattedDate2 =
                              DateFormat('yyyy').format(date);
                              String weekDay =
                              DateFormat('EEEE').format(date);
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

                                      monthName.value = DateFormat('MMMM')
                                          .format(DateTime.parse(
                                          "${year.value}-${month.value}-${day.value}"));

                                      String date = year.value +
                                          "-" +
                                          month.value +
                                          "-" +
                                          day.value;
                                      log(date);
                                      assignmentListStudentController.selDate.value = date;
                                      assignmentListStudentController
                                          .getAssignmentData();
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
                                                  color:
                                                  index == selectedIndex
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                            Text(
                                              formattedDate,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                  index == selectedIndex
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
              top: size.height*.260,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 12).copyWith(bottom: 0),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
                ),
                child: Obx(
                  () {
                    return assignmentListStudentController.isDataLoading.value
                        ? const CommonProgressIndicator()
                        : SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('today'.toUpperCase(),
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w600
                            ),),
                          assignmentListStudentController
                              .getAssignmentModel
                              .value
                              .data!
                              .isEmpty
                              ?  Container(
                            height: size.height * .5,
                            // color: Colors.red,
                            child: Center(
                              child: Text(
                                "No Assignment Available",
                              ),
                            ),
                          )
                              : SizedBox(
                            height: size.height,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: assignmentListStudentController
                                  .getAssignmentModel
                                  .value
                                  .data!
                                  .length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var items =
                                assignmentListStudentController
                                    .getAssignmentModel
                                    .value
                                    .data![index];

                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => AssignmentDetailScreen(), arguments: items.id.toString());
                                    },
                                    child: Container(
                                      width: size.width * 0.72,
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                      // color: Colors.amber,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: size.width * 0.62,
                                                // color: Colors.amber,
                                                child: Text(
                                                  items.assignmentName!,
                                                  // 'Social Science Social Science Social Science Social Science',
                                                  style: GoogleFonts.poppins(
                                                      color: AppThemes.blueColor,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  ClipOval(
                                                    child: Image.asset(
                                                      AppAssets.studentImg,
                                                      width: 13,
                                                    ),
                                                  ),
                                                  Text(
                                                    'By : ',
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey,
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                  Container(
                                                    width: size.width * 0.2,
                                                    // color: Colors.amber,
                                                    child: Text(
                                                      items.teacher!.name!,
                                                      // 'Rosie David',
                                                      style:  GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            items.detail!,
                                            // 'It has survived not only five centuries, but alse five centuries, but alse the leep into electron five centuries, but alse the leep into electron the leep into electronic typesetting remaining essentially unchanged. It was popularised in the',
                                            style: TextStyle(
                                                color: AppThemes.blueColor,
                                                fontSize: 9,
                                                fontWeight: FontWeight.w300
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
    );
  }
}



