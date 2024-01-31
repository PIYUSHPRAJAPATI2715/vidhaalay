import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/teacher_controller/exam_timetable_controller.dart';
import 'package:vidhaalay_app/screen/teacher_flow/update_exam_timetable.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_dropdown.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';


class TeacherExamTimeTableScreen extends StatefulWidget {
  const TeacherExamTimeTableScreen({Key? key}) : super(key: key);

  @override
  State<TeacherExamTimeTableScreen> createState() => _TeacherExamTimeTableScreenState();
}

class _TeacherExamTimeTableScreenState extends State<TeacherExamTimeTableScreen> {

  final examTimeTableController = Get.put(ExamTimeTableController());

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
    examTimeTableController.selectedDate = date;
    examTimeTableController.selectedMonthIndex.value = int.parse(month.value) - 1;
    print("sel Month: ${examTimeTableController.selectedMonthIndex.value}");


    examTimeTableController.getMyClass();
    examTimeTableController.getExamTypeData();


    getYear();
    now = DateTime.now();
    totalDays = daysInMonth(now);
    listOfDates = List<int>.generate(totalDays, (i) => i + 1);
    todayDay = DateFormat('dd').format(now);
    examTimeTableController.selectedIndex.value = int.parse(todayDay.toString()) - 1;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getWeekDates(now);
      if (!mounted) return;
      setState(() {});
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Scrollable.ensureVisible(keysList[examTimeTableController.selectedIndex.value].currentContext!,
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
                  height: size.height*.33,
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
                        examTimeTableController.isExamTypeLoading.value ? SizedBox.shrink()
                            : Container(
                          // transformAlignment: Alignment.center,
                          // width: size.width * .45,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            // color: Colors.white,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: examTimeTableController.getExamTypeModel.value.data!.isEmpty ? SizedBox.shrink() : Row(
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
                                value:  examTimeTableController.selectedExamType?.value,
                                items: examTimeTableController.getExamTypeModel.value.data!.toList().map((items) {
                                  return DropdownMenuItem(
                                    value: items.id,
                                    child: Text(items.name!,style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: examTimeTableController.selectedExamType?.value == items.id
                                          ? Colors.white
                                      // Colors.grey.shade900 // Change the color for selected item
                                          : Colors.black, // Default color for unselected items
                                    ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  examTimeTableController.selectedExamType!.value = newValue!;
                                  print(examTimeTableController.selectedExamType?.value);

                                  examTimeTableController.getExamTimeTableData();
                                },
                                width: size.width * 0.55,
                                backgroundColor: AppThemes.themeBackgroundColor,
                              ),

                              // DropdownButtonHideUnderline(
                              //       child: DropdownButton2(
                              //         value:  examTimeTableController.selectedExamType?.value,
                              //         // icon: Icon(Icons.keyboard_arrow_down,color: Colors.white),
                              //         dropdownStyleData: DropdownStyleData(
                              //           maxHeight: size.height * 0.28,
                              //           width: size.width * 0.55,
                              //           padding: EdgeInsets.symmetric(horizontal: 5),
                              //           isOverButton: false,
                              //           decoration: BoxDecoration(
                              //             borderRadius: BorderRadius.circular(14),
                              //             color: Colors.white70,
                              //           ),
                              //           offset: const Offset(-10, 0),
                              //           scrollbarTheme: ScrollbarThemeData(
                              //             radius: const Radius.circular(40),
                              //             thickness: MaterialStateProperty.all<double>(6),
                              //             thumbVisibility: MaterialStateProperty.all<bool>(true),
                              //           ),
                              //         ),
                              //         menuItemStyleData: const MenuItemStyleData(
                              //           height: 45,
                              //           padding: EdgeInsets.only(left: 10, right: 10),
                              //         ),
                              //         // dropdownColor: Colors.white70,
                              //         items: examTimeTableController.getExamTypeModel.value.data!.toList().map((items) {
                              //           return DropdownMenuItem(
                              //             value: items.id,
                              //             child: Text(items.name!,style: TextStyle(
                              //               fontWeight: FontWeight.w500,
                              //               fontSize: 17,
                              //               color: examTimeTableController.selectedExamType?.value == items.id
                              //                   ? Colors.white
                              //               // Colors.grey.shade900 // Change the color for selected item
                              //                   : Colors.black, // Default color for unselected items
                              //             ),
                              //             ),
                              //           );
                              //         }).toList(),
                              //         onChanged: (newValue) {
                              //           examTimeTableController.selectedExamType!.value = newValue!;
                              //           print(examTimeTableController.selectedExamType?.value);
                              //
                              //           examTimeTableController.getExamTimeTableData();
                              //         },
                              //       ),
                              //     )
                            ],
                          ),
                        ),

                         Container(
                          // transformAlignment: Alignment.center,
                          // width: size.width * .45,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            // color: Colors.white,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: examTimeTableController.classList.value.isEmpty ? SizedBox.shrink() : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text('Class -',
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
                                value:  examTimeTableController.selectedClassId?.value,
                                items: examTimeTableController.classList.value.toList().map((items) {
                                  return DropdownMenuItem(
                                    value: items.id,
                                    child: Text(items.name,style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: examTimeTableController.selectedClassId?.value == items.id
                                          ? Colors.white
                                      // Colors.grey.shade900 // Change the color for selected item
                                          : Colors.black, // Default color for unselected items
                                    ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  examTimeTableController.selectedClassId!.value = newValue!;
                                  print(examTimeTableController.selectedClassId?.value);
                                  examTimeTableController.getExamTimeTableData();
                                },
                                width: size.width * 0.3,
                                backgroundColor: AppThemes.themeBackgroundColor,
                              ),

                              // DropdownButtonHideUnderline(
                              //       child: DropdownButton2(
                              //         value:  examTimeTableController.selectedClassId?.value,
                              //         items: examTimeTableController.classList.value.toList().map((items) {
                              //           return DropdownMenuItem(
                              //             value: items.id,
                              //             child: Text(items.name,style: TextStyle(
                              //               fontWeight: FontWeight.w500,
                              //               fontSize: 17,
                              //               color: examTimeTableController.selectedClassId?.value == items.id
                              //                   ? Colors.white
                              //               // Colors.grey.shade900 // Change the color for selected item
                              //                   : Colors.black, // Default color for unselected items
                              //             ),
                              //             ),
                              //           );
                              //         }).toList(),
                              //         onChanged: (newValue) {
                              //           examTimeTableController.selectedClassId!.value = newValue!;
                              //           print(examTimeTableController.selectedClassId?.value);
                              //           examTimeTableController.getExamTimeTableData();
                              //         },
                              //         dropdownStyleData: DropdownStyleData(
                              //           maxHeight: size.height * 0.28,
                              //           width: size.width * 0.3,
                              //           padding: EdgeInsets.symmetric(horizontal: 5),
                              //           isOverButton: false,
                              //           decoration: BoxDecoration(
                              //             borderRadius: BorderRadius.circular(14),
                              //             color: Colors.white70,
                              //           ),
                              //           offset: const Offset(-10, 0),
                              //           scrollbarTheme: ScrollbarThemeData(
                              //             radius: const Radius.circular(40),
                              //             thickness: MaterialStateProperty.all<double>(6),
                              //             thumbVisibility: MaterialStateProperty.all<bool>(true),
                              //           ),
                              //         ),
                              //         menuItemStyleData: const MenuItemStyleData(
                              //           height: 45,
                              //           padding: EdgeInsets.only(left: 10, right: 10),
                              //         ),
                              //
                              //       ),
                              //     )
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

                                            examTimeTableController.selectedMonthIndex.value = index;

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
                                            examTimeTableController.selectedDate = date;
                                            examTimeTableController.getExamTimeTableData();

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
                                                      color: index == examTimeTableController.selectedMonthIndex.value
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
                                        examTimeTableController.selectedIndex.value = index;
                                        print("selectedIndex : ${examTimeTableController.selectedIndex.value}");

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
                                        examTimeTableController.selectedDate = date;
                                        examTimeTableController.getExamTimeTableData();

                                        // evenetDetailController.getEventData(date);
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: index == examTimeTableController.selectedIndex.value
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
                                                    index == examTimeTableController.selectedIndex.value
                                                        ? Colors.black
                                                        : Colors.white),
                                              ),
                                              Text(
                                                formattedDate,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                    index == examTimeTableController.selectedIndex.value
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
              top: size.height*.33,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 12).copyWith(bottom: 0),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
                ),
                child: examTimeTableController.isDataLoading.value ? const CommonProgressIndicator() :  SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('today'.toUpperCase(),
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w600
                            ),),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(MyRouters.createExamTimeTable);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(
                                  color:                   AppThemes.primaryColor,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  Text('add'.toUpperCase(),
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600
                                    ),),
                                  Icon(
                                    Icons.add,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      // Text('today'.toUpperCase(),
                      //   style: GoogleFonts.poppins(
                      //       color: Colors.black,
                      //       fontSize: 19,
                      //       fontWeight: FontWeight.w600
                      //   ),),

                      examTimeTableController.getExamTimetableModel.value.data!.isEmpty ? Container(
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
                          itemCount: examTimeTableController.getExamTimetableModel.value.data!.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {

                            var value = examTimeTableController.getExamTimetableModel.value.data![index];

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
                                  Container(
                                    width: size.width * .7,
                                    padding: const EdgeInsets.all(9),
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
                                                    width: size.width * .505,
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
                                                    children: [
                                                      Container(
                                                        width: size.width * .18,
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
                                                            width: size.width * .17,
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

                                  Container(
                                    width: size.width * .22,
                                    // color: Colors.blue,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        Expanded(
                                          child: IconButton(onPressed: (){
                                            Get.to(() => UpdateExamTimeTable(id: value.id!.toString(),));
                                          },
                                              icon: const Icon(Icons.edit,size: 19,)),
                                        ),
                                        Expanded(
                                          child: IconButton(onPressed: (){
                                            examTimeTableController.deleteExamTimetableAPI(context,value.id!);
                                          },
                                              icon: const Icon(Icons.delete,color: Colors.red,size: 19,)),
                                        )
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
