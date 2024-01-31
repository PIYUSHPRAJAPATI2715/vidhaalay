import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/student_controller/exam_time_table_controller.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/teacher_flow/update_exam_timetable.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_dropdown.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';


class ExamTimeTableScreen extends StatefulWidget {
  const ExamTimeTableScreen({Key? key}) : super(key: key);

  @override
  State<ExamTimeTableScreen> createState() => _ExamTimeTableScreenState();
}

class _ExamTimeTableScreenState extends State<ExamTimeTableScreen> {
  final studentExamTimeTableController = Get.put(StudentExamTimeTableController());

  RxString day = "".obs;
  RxString month = "".obs;
  RxString year = "".obs;
  RxString monthName = "".obs;
  RxString clinicId = "".obs;


  var now = DateTime.now();
  var totalDays;
  var listOfDates;
  var todayDay;

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
  void initState() {
    super.initState();

    year.value = DateFormat('yyyy').format(DateTime.now());
    month.value = DateFormat('MM').format(DateTime.now());
    monthName.value = DateFormat('MMMM').format(DateTime.now());
    day.value = DateFormat('dd').format(DateTime.now());

    String date = year.value+"-"+ month.value +"-"+ day.value;
    log("date : $date");
    studentExamTimeTableController.selectedDate = date;
    studentExamTimeTableController.getExamTypeData();


    studentExamTimeTableController.selectedMonthIndex.value = int.parse(month.value) - 1;
    print("sel Month: ${studentExamTimeTableController.selectedMonthIndex.value}");



    getYear();
    now = DateTime.now();
    totalDays = daysInMonth(now);
    listOfDates = List<int>.generate(totalDays, (i) => i + 1);
    todayDay = DateFormat('dd').format(now);
    studentExamTimeTableController.selectedIndex.value = int.parse(todayDay.toString()) - 1;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getWeekDates(now);
      if (!mounted) return;
      setState(() {});
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Scrollable.ensureVisible(keysList[studentExamTimeTableController.selectedIndex.value].currentContext!,
            alignment: .5);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Timetable',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppThemes.black,
          ),
        ),
        centerTitle: true,
      ),
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
              // height: 200,
                height: size.height*.280,
                decoration: const BoxDecoration(
                  color: AppThemes.primaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
                ),
                child:  Padding(
                  padding: EdgeInsets.all(size.width * .010),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(year.value.toString(),
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      studentExamTimeTableController.isExamTypeLoading.value ? SizedBox.shrink()
                          : Container(
                        // transformAlignment: Alignment.center,
                        // width: size.width * .45,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: studentExamTimeTableController.getExamTypeModel.value.data!.isEmpty ? SizedBox.shrink() : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text('Type -',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white,),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              width: 5,
                            ),

                            CommonDropDownButton(
                              items: studentExamTimeTableController.getExamTypeModel.value.data!.toList().map((items) {
                              return DropdownMenuItem(
                                value: items.id,
                                child: Text(items.name!,style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: studentExamTimeTableController.selectedExamType?.value == items.id
                                      ? Colors.white
                                  // Colors.grey.shade900 // Change the color for selected item
                                      : Colors.black, // Default color for unselected items
                                ),
                                ),
                              );
                            }).toList(),
                              value:  studentExamTimeTableController.selectedExamType?.value,
                              onChanged: (newValue) {
                                studentExamTimeTableController.selectedExamType!.value = newValue!;
                                print(studentExamTimeTableController.selectedExamType?.value);

                                studentExamTimeTableController.getExamTimeTableData();
                              },
                              width: size.width * 0.55,
                              backgroundColor: AppThemes.themeBackgroundColor,
                            ),

                            // DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     value:  studentExamTimeTableController.selectedExamType?.value,
                            //     // icon: Icon(Icons.keyboard_arrow_down,color: Colors.white),
                            //     dropdownStyleData: DropdownStyleData(
                            //       maxHeight: size.height * 0.28,
                            //       width: size.width * 0.55,
                            //       padding: EdgeInsets.symmetric(horizontal: 5),
                            //       isOverButton: false,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(14),
                            //         color: Colors.white70,
                            //       ),
                            //       offset: const Offset(-10, 0),
                            //       scrollbarTheme: ScrollbarThemeData(
                            //         radius: const Radius.circular(40),
                            //         thickness: MaterialStateProperty.all<double>(6),
                            //         thumbVisibility: MaterialStateProperty.all<bool>(true),
                            //       ),
                            //     ),
                            //     menuItemStyleData: const MenuItemStyleData(
                            //       height: 45,
                            //       padding: EdgeInsets.only(left: 10, right: 10),
                            //     ),
                            //     // dropdownColor: Colors.white70,
                            //     items: studentExamTimeTableController.getExamTypeModel.value.data!.toList().map((items) {
                            //       return DropdownMenuItem(
                            //         value: items.id,
                            //         child: Text(items.name!,style: TextStyle(
                            //           fontWeight: FontWeight.w500,
                            //           fontSize: 17,
                            //           color: studentExamTimeTableController.selectedExamType?.value == items.id
                            //               ? Colors.white
                            //           // Colors.grey.shade900 // Change the color for selected item
                            //               : Colors.black, // Default color for unselected items
                            //         ),
                            //         ),
                            //       );
                            //     }).toList(),
                            //     onChanged: (newValue) {
                            //       studentExamTimeTableController.selectedExamType!.value = newValue!;
                            //       print(studentExamTimeTableController.selectedExamType?.value);
                            //
                            //       studentExamTimeTableController.getExamTimeTableData();
                            //     },
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      Container(
                        height: size.height*.050,
                        decoration: BoxDecoration(
                          // color: Colors.amber,
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
                                      print(index);

                                      studentExamTimeTableController.selectedMonthIndex.value = index;

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


                                      String date = year.value+"-"+ month.value +"-"+ day.value;
                                      log("date : $date");
                                      studentExamTimeTableController.selectedDate = date;
                                      studentExamTimeTableController.getExamTimeTableData();

                                      // Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Center(
                                        child: Text(months[index].toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: index == studentExamTimeTableController.selectedMonthIndex.value
                                                    ? Colors.white
                                                    : Colors.black
                                            )
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: size.height*.110,
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
                                    studentExamTimeTableController.selectedIndex.value = index;
                                    print("selectedIndex : ${studentExamTimeTableController.selectedIndex.value}");

                                    setState(() {
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

                                      String date = year.value+"-"+ month.value +"-"+ day.value;
                                      log("date : $date");
                                      studentExamTimeTableController.selectedDate = date;
                                      studentExamTimeTableController.getExamTimeTableData();

                                      // evenetDetailController.getEventData(date);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: index == studentExamTimeTableController.selectedIndex.value
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
                                                  index == studentExamTimeTableController.selectedIndex.value
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                            Text(
                                              formattedDate,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                  index == studentExamTimeTableController.selectedIndex.value
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
                )
            ),

            Positioned.fill(
              top: size.height*.280,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25).copyWith(bottom: 0),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
                ),
                child: !studentExamTimeTableController.isDataLoading.value ? SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text('today'.toUpperCase(),
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w600
                          ),),
                      ),

                      studentExamTimeTableController.getExamTimetableModel.value.data!.isEmpty ? Container(
                        height: size.height * .4,
                        // color: Colors.red,
                        child: Center(
                          child: Text("No exam time table available"),
                        ),
                      ) : SizedBox(
                        height: size.height,
                        width: size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: studentExamTimeTableController.getExamTimetableModel.value.data!.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {

                            var value = studentExamTimeTableController.getExamTimetableModel.value.data![index];

                            DateTime timestampUtc = DateTime.parse(value.from!);
                            String formattedHour = timestampUtc.hour.toString().padLeft(2, '0');
                            String formattedMinute = timestampUtc.minute.toString().padLeft(2, '0');
                            String fromTime = '$formattedHour:$formattedMinute';
                            print("fromTime $fromTime");

                            DateTime timestampUtc1 = DateTime.parse(value.to!);
                            String formattedHour1 = timestampUtc1.hour.toString().padLeft(2, '0');
                            String formattedMinute1 = timestampUtc1.minute.toString().padLeft(2, '0');
                            String toTime = '$formattedHour1:$formattedMinute1';
                            print("toTime $toTime");

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Container(
                                  //   width: size.width * .9,
                                  //   padding: const EdgeInsets.all(9),
                                  //   decoration: BoxDecoration(
                                  //       color: AppThemes.lightGreyColor,
                                  //       borderRadius: BorderRadius.circular(8)
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //       Row(
                                  //         crossAxisAlignment: CrossAxisAlignment.start,
                                  //         children: [
                                  //           Column(
                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                  //             mainAxisAlignment: MainAxisAlignment.start,
                                  //             children: [
                                  //               Text(
                                  //                 fromTime,
                                  //                 // '08: AM',
                                  //                 style: GoogleFonts.poppins(
                                  //                     color: AppThemes.black,
                                  //                     fontSize: 14,
                                  //                     fontWeight: FontWeight.w600
                                  //                 ),
                                  //               ),
                                  //               Text(
                                  //                 // '09: AM',
                                  //                 toTime,
                                  //                 style: GoogleFonts.poppins(
                                  //                     color: AppThemes.black,
                                  //                     fontSize: 14,
                                  //                     fontWeight: FontWeight.w600
                                  //                 ),),
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             width: 10,
                                  //             height: size.height * .055,
                                  //             child:  VerticalDivider(
                                  //               thickness: 1,
                                  //               color: AppThemes.black,
                                  //             ),
                                  //           ),
                                  //           Container(
                                  //             // color: Colors.green,
                                  //             // width: size.width * .47,
                                  //             child: Column(
                                  //               crossAxisAlignment: CrossAxisAlignment.start,
                                  //               mainAxisAlignment: MainAxisAlignment.start,
                                  //               children: [
                                  //                 Text(
                                  //                   value.subject!.name!,
                                  //
                                  //                   // 'Social Science',
                                  //                   style: GoogleFonts.poppins(
                                  //                       color: AppThemes.blueColor,
                                  //                       fontSize: 14,
                                  //                       fontWeight: FontWeight.w600
                                  //                   ),
                                  //                   maxLines: 1,
                                  //                   overflow: TextOverflow.ellipsis,
                                  //                 ),
                                  //                 const SizedBox(
                                  //                   height: 5,
                                  //                 ),
                                  //                 Row(
                                  //                   children: [
                                  //                     Text('Class A-1',
                                  //                       style: GoogleFonts.poppins(
                                  //                           color: AppThemes.textGray,
                                  //                           fontSize: 10,
                                  //                           fontWeight: FontWeight.w500
                                  //                       ),),
                                  //
                                  //                     Padding(
                                  //                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  //                       child: const SizedBox(
                                  //                         height: 20,
                                  //                         child: VerticalDivider(
                                  //                           width: 1,
                                  //                           color: Colors.grey,
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //
                                  //                     Row(
                                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                                  //                       mainAxisAlignment: MainAxisAlignment.start,
                                  //                       children: [
                                  //                         ClipOval(
                                  //                           child: Image.asset(
                                  //                             AppAssets.studentImg,
                                  //                             width: 15,
                                  //                           ),
                                  //                         ),
                                  //                         const SizedBox(
                                  //                           width: 5,
                                  //                         ),
                                  //                         Text(
                                  //                           'By : ',
                                  //                           style: GoogleFonts.poppins(
                                  //                               color: Colors.grey,
                                  //                               fontSize: 12.0,
                                  //                               fontWeight: FontWeight.w500
                                  //                           ),
                                  //                         ),
                                  //                         Container(
                                  //                           width: size.width * .4,
                                  //                           // color: Colors.amber,
                                  //                           child: Text(
                                  //                             value.teacher!.name!,
                                  //                             // 'Rosie David',
                                  //                             style:  GoogleFonts.poppins(
                                  //                                 color: Colors.black,
                                  //                                 fontSize: 12.0,
                                  //                                 fontWeight: FontWeight.w500
                                  //                             ),
                                  //                             maxLines: 1,
                                  //                             overflow: TextOverflow.ellipsis,
                                  //                           ),
                                  //                         ),
                                  //                       ],
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //
                                  //     ],
                                  //   ),
                                  // ),
                                  Container(
                                    width: size.width,
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 9),
                                    decoration: BoxDecoration(
                                        color: AppThemes.lightGreyColor,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  fromTime,
                                                  // '08: AM',
                                                  style: GoogleFonts.poppins(
                                                      color: AppThemes.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                                Text(
                                                  // '09: AM',
                                                  toTime,
                                                  style: GoogleFonts.poppins(
                                                      color: AppThemes.black,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                              height: size.height * .05,
                                              child:  VerticalDivider(
                                                thickness: 1,
                                                color: AppThemes.black,
                                              ),
                                            ),
                                            Container(
                                              // color: Colors.green,
                                              // width: size.width * .47,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // color: Colors.green,
                                                    width: size.width * .73,
                                                    child: Text(
                                                      value.subject!.name!,
                                                      // 'Social Science Social Science Social Science Social Science Social Science',
                                                      style: GoogleFonts.poppins(
                                                          color: AppThemes.blueColor,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),

                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: size.width * .30,
                                                        // color: Colors.amber,
                                                        child: Text(
                                                          'Class - ' + value.seatClass!.name!,
                                                          style: GoogleFonts.poppins(
                                                              color: AppThemes.textGray,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w500
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                                        child: const SizedBox(
                                                          height: 20,
                                                          child: VerticalDivider(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          ClipOval(
                                                            child: Image.asset(
                                                              AppAssets.studentImg,
                                                              width: 15,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
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
                                                            width: size.width * .25,
                                                            // color: Colors.amber,
                                                            child: Text(
                                                              value.teacher!.name!,
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
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ) : const CommonProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
