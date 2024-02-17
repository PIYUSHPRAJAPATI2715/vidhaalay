import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/student_controller/assignment_list_controller_student.dart';
import 'package:vidhaalay_app/controller/student_controller/event_list_controller_student.dart';
import 'package:vidhaalay_app/repositories/calendar_repo.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/student_screen/assignment_details_screen.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_profile_image_widget.dart';
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
  final ScrollController _dateController = ScrollController();
  final ScrollController _monthController = ScrollController();

  final assignmentListStudentController = Get.put(AssignmentListStudentController());
  List currentSessionYear = [];
  List<String> months =  CommonCalendar.monthsList;
  List daysInMonth = [];

  int selectedYear = 0;
  RxString month = "".obs;
  RxString monthName = "".obs;
  RxString day = "".obs;
  String selectedDate = '';

  int selectedDateIndex = 0;
  int selectedMonthIndex = 0;

  getCurrentSessionYear(int currentYear) {
    currentSessionYear.clear();

    int currentMonth = int.parse(month.value);
    // int currentMonth = 4;
    // int currentYear = int.parse();

    if(currentMonth < 4) {
      currentSessionYear = [currentYear -1,currentYear];
      selectedYear = currentSessionYear[1];
    } else {
      currentSessionYear = [currentYear,currentYear+1];
      selectedYear = currentSessionYear[0];
    }
  }

  selecedDate() {
    selectedDate = selectedYear.toString()+"-"+ month.value +"-"+ day.value;
    print("selecedDate : $selectedDate");
    assignmentListStudentController.selDate.value = selectedDate;
    assignmentListStudentController.getAssignmentData();
  }

  @override
  void initState() {
    super.initState();
    selectedYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
    month.value = DateFormat('MM').format(DateTime.now());
    monthName.value = DateFormat('MMMM').format(DateTime.now());
    day.value = DateFormat('dd').format(DateTime.now());
    selecedDate();
    selectedMonthIndex = selectCorrectMonthIndex(int.parse(month.value)) ;
    getCurrentSessionYear(selectedYear);
    daysInMonth =  getMonthDays(year: selectedYear,month: month.value);
    selectedDateIndex = int.parse(day.value) - 1;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      setState(() {});
      _dateController.animateTo(
        selectedDateIndex * 45.0, // Adjust 110 according to your item size and spacing
        duration: Duration(milliseconds: 1800),
        curve: Curves.easeInOut,
      );
      _monthController.animateTo(
        selectedMonthIndex * 65.0, // Adjust 110 according to your item size and spacing
        duration: Duration(milliseconds: 1800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
              height: size.height * .250,
              decoration: const BoxDecoration(
                color: AppThemes.primaryColor,
                borderRadius:
                BorderRadius.only(bottomLeft: Radius.circular(50)),
              ),
              child: Padding(
                padding: EdgeInsets.all(size.width * .010),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                    color: selectedYear == currentSessionYear[0] ? Colors.white : Colors.black
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
                                    color: selectedYear == currentSessionYear[1] ? Colors.white : Colors.black
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
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
                              controller: _monthController,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    selectedMonthIndex = index;
                                    month.value = selectMonthByIndex(index).toString().padLeft(2, '0');
                                    selectedYear = selectYearByMonth(month: month.value,);
                                    // print(month.value);
                                    daysInMonth = getMonthDays(year: selectedYear,month: month.value);
                                    if(daysInMonth.length <= int.parse(day.value) ) {
                                      day.value = 1.toString().padLeft(2, '0');
                                      selectedDateIndex = 0;
                                      _dateController.animateTo(
                                        selectedDateIndex * 1.0,
                                        duration: Duration(milliseconds: 1800),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      _dateController.animateTo(
                                        selectedDateIndex * 45.0,
                                        duration: Duration(milliseconds: 1800),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                    selecedDate();

                                    setState(() {
                                    });
                                    // selectedMonthIndex =
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Center(
                                      child: Text(months[index].toString(),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                              color: index == selectedMonthIndex
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
                        controller: _dateController,
                        child: Row(
                          children: List.generate(daysInMonth.length, (index) {

                            DateTime specifiedDate = DateTime(2024, int.parse(month.value), daysInMonth[index]);
                            String dayName = DateFormat('EEEE').format(specifiedDate).substring(0, 1);

                            return Padding(
                              padding: EdgeInsets.only(right: 0, left: 0),
                              child: GestureDetector(
                                onTap: () {
                                  selectedDateIndex = index;
                                  day.value = (index + 1).toString().padLeft(2, '0');
                                  // print(selectedDateIndex);
                                  print(day.value);
                                  selecedDate();
                                  setState(() {

                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: index == selectedDateIndex
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            dayName.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                index == selectedDateIndex
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                          Text(
                                            daysInMonth[index].toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                index == selectedDateIndex
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
            top: size.height*.250,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 12).copyWith(bottom: 0),
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppThemes.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
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
                                                commonProfileImageCircle(
                                                  context: context,
                                                  isProfileImageLoading: items.teacher == null,
                                                  isProfileExist: items.teacher!.profileImage != null,
                                                  image: items.teacher!
                                                      .profileImage!
                                                      .toString(),
                                                  radius: 8,
                                                  // classData.teacher.profileImage
                                                ),
                                                // ClipOval(
                                                //   child: Image.asset(
                                                //     AppAssets.studentImg,
                                                //     width: 13,
                                                //   ),
                                                // ),
                                                Text(
                                                  ' By : ',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.grey,
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                                Container(
                                                  width: size.width * 0.18,
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



/* Before Calendar*/

// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:vidhaalay_app/controller/student_controller/assignment_list_controller_student.dart';
// import 'package:vidhaalay_app/controller/student_controller/event_list_controller_student.dart';
// import 'package:vidhaalay_app/routers/my_routers.dart';
// import 'package:vidhaalay_app/screen/student_screen/assignment_details_screen.dart';
// import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
// import 'package:vidhaalay_app/widgets/common_profile_image_widget.dart';
// import '../../widgets/appTheme.dart';
// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:vidhaalay_app/resourses/app_assets.dart';
//
// class AssignmentScreen extends StatefulWidget {
//   const AssignmentScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AssignmentScreen> createState() => _AssignmentScreenState();
// }
//
// class _AssignmentScreenState extends State<AssignmentScreen> {
//   RxString day = "".obs;
//   RxString month = "".obs;
//   RxString year = "".obs;
//   RxString monthName = "".obs;
//   RxString clinicId = "".obs;
//   int selectedIndex = 0;
//   int selectedMonthIndex = 0;
//
//   var now = DateTime.now();
//   var totalDays;
//   var listOfDates;
//   var todayDay;
//
//   final assignmentListStudentController = Get.put(AssignmentListStudentController());
//
//   @override
//   void initState() {
//     super.initState();
//     year.value = DateFormat('yyyy').format(DateTime.now());
//     month.value = DateFormat('MM').format(DateTime.now());
//     monthName.value = DateFormat('MMMM').format(DateTime.now());
//     day.value = DateFormat('dd').format(DateTime.now());
//     assignmentListStudentController.selDate.value = year.value+"-"+ month.value +"-"+ day.value;
//
//     selectedMonthIndex = int.parse(month.value) - 1;
//
//     assignmentListStudentController.getAssignmentData();
//
//     getYear();
//     now = DateTime.now();
//     totalDays = daysInMonth(now);
//     listOfDates = List<int>.generate(totalDays, (i) => i + 1);
//     todayDay = DateFormat('dd').format(now);
//     selectedIndex = int.parse(todayDay.toString()) - 1;
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       getWeekDates(now);
//       if (!mounted) return;
//       setState(() {});
//       Future.delayed(const Duration(seconds: 1)).then((value) {
//         Scrollable.ensureVisible(keysList[selectedIndex].currentContext!,
//             alignment: .5);
//       });
//     });
//   }
//
//   List<GlobalKey> keysList = [];
//
//   List<DateTime> weekDates = [];
//   getWeekDates(DateTime currentDate) {
//     weekDates.clear();
//     for (int i = 1 - int.parse(todayDay);
//     i <= listOfDates.length - int.parse(todayDay);
//     i++) {
//       weekDates.add(currentDate.add(Duration(days: i)));
//       // log(weekDates.toString());
//       // log(DateFormat('EEEE').format(weekDates[0]));
//     }
//     setState(() {});
//     keysList = List.generate(weekDates.length, (index) => GlobalKey());
//     return weekDates;
//   }
//
//   List<String> months =  CommonCalendar.monthsList;
//   List<int> years = [];
//
//   List<int> getYear() {
//     for (int i = 2023; i <= 2050; i++) {
//       years.add(i);
//     }
//     return years;
//   }
//
//   int daysInMonth(DateTime date) {
//     var firstDayThisMonth = DateTime(date.year, date.month, date.day);
//     log("Week days$firstDayThisMonth");
//     var firstDayNextMonth = DateTime(firstDayThisMonth.year,
//         firstDayThisMonth.month + 1, firstDayThisMonth.day);
//     log("Week days$firstDayNextMonth");
//     return firstDayNextMonth.difference(firstDayThisMonth).inDays;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Assignments',
//           style: GoogleFonts.poppins(
//             fontSize: 19,
//             fontWeight: FontWeight.w600,
//             color: AppThemes.black,
//           ),
//         ),
//         centerTitle: true,
//       ),
//         body: Stack(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.white,
//                     Colors.white,
//                     AppThemes.primaryColor,
//                     AppThemes.primaryColor,
//                   ],
//                   end: Alignment.centerRight,
//                   begin: Alignment.centerLeft,
//                   stops: [0, .5, .501, 1],
//                 ),
//               ),
//             ),
//             Container(
//                 height: size.height * .260,
//                 decoration: const BoxDecoration(
//                   color: AppThemes.primaryColor,
//                   borderRadius:
//                   BorderRadius.only(bottomLeft: Radius.circular(70)),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(size.width * .010),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 15, vertical: 5),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(50)),
//                           child: Text(
//                             year.value.toString(),
//                             style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 17,
//                                 color: Colors.black),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: size.height * .070,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 shrinkWrap: true,
//                                 itemCount: months.length,
//                                 itemBuilder:
//                                     (BuildContext context, int index) {
//                                   return InkWell(
//                                     onTap: () {
//                                       selectedMonthIndex = index;
//                                       month.value = "${index + 1}".length != 2
//                                           ? "0${index + 1}"
//                                           : "${index + 1}";
//                                       monthName.value = DateFormat('MMMM')
//                                           .format(DateTime.parse(
//                                           "${year.value}-${month.value}-${day.value}"));
//                                       now = DateTime.parse(
//                                           "${year.value}-${month.value}-${day.value}");
//                                       totalDays = daysInMonth(now);
//                                       listOfDates = List<int>.generate(
//                                           totalDays, (i) => i + 1);
//                                       todayDay = DateFormat('dd').format(now);
//                                       getWeekDates(now);
//                                       log(DateFormat('EEEE').format(now));
//
//                                       String date = year.value +
//                                           "-" +
//                                           month.value +
//                                           "-" +
//                                           day.value;
//                                       assignmentListStudentController.selDate.value = date;
//                                       assignmentListStudentController
//                                           .getAssignmentData();
//                                       // Get.back();
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 10, vertical: 10),
//                                       child: Text(months[index].toString(),
//                                           style: GoogleFonts.poppins(
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 17,
//                                               color:
//                                               index == selectedMonthIndex
//                                                   ? Colors.white
//                                                   : Colors.black)),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * .110,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           physics: BouncingScrollPhysics(),
//                           child: Row(
//                             children:
//                             List.generate(weekDates.length, (index) {
//                               DateTime date = weekDates[index];
//                               String formattedDate =
//                               DateFormat('d').format(date);
//                               String formattedDate1 =
//                               DateFormat('MM').format(date);
//                               String formattedDate2 =
//                               DateFormat('yyyy').format(date);
//                               String weekDay =
//                               DateFormat('EEEE').format(date);
//                               return Padding(
//                                 key: keysList[index],
//                                 padding: EdgeInsets.only(right: 0, left: 0),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       selectedIndex = index;
//                                       day.value = formattedDate.length != 2
//                                           ? "0$formattedDate"
//                                           : formattedDate;
//                                       // month.value = formattedDate1.length != 2 ? "0$formattedDate1" : formattedDate1;
//                                       // year.value = formattedDate2;
//                                       log(day.value);
//                                       log(month.value);
//                                       log(year.value);
//
//                                       monthName.value = DateFormat('MMMM')
//                                           .format(DateTime.parse(
//                                           "${year.value}-${month.value}-${day.value}"));
//
//                                       String date = year.value +
//                                           "-" +
//                                           month.value +
//                                           "-" +
//                                           day.value;
//                                       log(date);
//                                       assignmentListStudentController.selDate.value = date;
//                                       assignmentListStudentController
//                                           .getAssignmentData();
//                                     });
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: index == selectedIndex
//                                               ? Colors.white
//                                               : Colors.transparent,
//                                           borderRadius:
//                                           BorderRadius.circular(20)),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(12.0),
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               weekDay[0].toString(),
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w600,
//                                                   color:
//                                                   index == selectedIndex
//                                                       ? Colors.black
//                                                       : Colors.white),
//                                             ),
//                                             Text(
//                                               formattedDate,
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w600,
//                                                   color:
//                                                   index == selectedIndex
//                                                       ? Colors.black
//                                                       : Colors.white),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//             Positioned.fill(
//               top: size.height*.260,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 12).copyWith(bottom: 0),
//                 height: size.height,
//                 width: size.width,
//                 decoration: const BoxDecoration(
//                   color: AppThemes.white,
//                   borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
//                 ),
//                 child: Obx(
//                   () {
//                     return assignmentListStudentController.isDataLoading.value
//                         ? const CommonProgressIndicator()
//                         : SingleChildScrollView(
//                       physics: NeverScrollableScrollPhysics(),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('today'.toUpperCase(),
//                             style: GoogleFonts.poppins(
//                                 color: Colors.black,
//                                 fontSize: 19,
//                                 fontWeight: FontWeight.w600
//                             ),),
//                           assignmentListStudentController
//                               .getAssignmentModel
//                               .value
//                               .data!
//                               .isEmpty
//                               ?  Container(
//                             height: size.height * .5,
//                             // color: Colors.red,
//                             child: Center(
//                               child: Text(
//                                 "No Assignment Available",
//                               ),
//                             ),
//                           )
//                               : SizedBox(
//                             height: size.height,
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: assignmentListStudentController
//                                   .getAssignmentModel
//                                   .value
//                                   .data!
//                                   .length,
//                               physics: BouncingScrollPhysics(),
//                               itemBuilder: (context, index) {
//                                 var items =
//                                 assignmentListStudentController
//                                     .getAssignmentModel
//                                     .value
//                                     .data![index];
//
//                                 return Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 10),
//                                   child: InkWell(
//                                     onTap: () {
//                                       Get.to(() => AssignmentDetailScreen(), arguments: items.id.toString());
//                                     },
//                                     child: Container(
//                                       width: size.width * 0.72,
//                                       padding: EdgeInsets.symmetric(vertical: 5),
//                                       // color: Colors.amber,
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(
//                                                 width: size.width * 0.62,
//                                                 // color: Colors.amber,
//                                                 child: Text(
//                                                   items.assignmentName!,
//                                                   // 'Social Science Social Science Social Science Social Science',
//                                                   style: GoogleFonts.poppins(
//                                                       color: AppThemes.blueColor,
//                                                       fontSize: 14,
//                                                       fontWeight: FontWeight.w600
//                                                   ),
//                                                   maxLines: 1,
//                                                   overflow: TextOverflow.ellipsis,
//                                                 ),
//                                               ),
//                                               Row(
//                                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                 children: [
//                                                   commonProfileImageCircle(
//                                                     context: context,
//                                                     isProfileImageLoading: items.teacher == null,
//                                                     isProfileExist: items.teacher!.profileImage != null,
//                                                     image: items.teacher!
//                                                         .profileImage!
//                                                         .toString(),
//                                                     radius: 8,
//                                                     // classData.teacher.profileImage
//                                                   ),
//                                                   // ClipOval(
//                                                   //   child: Image.asset(
//                                                   //     AppAssets.studentImg,
//                                                   //     width: 13,
//                                                   //   ),
//                                                   // ),
//                                                   Text(
//                                                     ' By : ',
//                                                     style: GoogleFonts.poppins(
//                                                         color: Colors.grey,
//                                                         fontSize: 12.0,
//                                                         fontWeight: FontWeight.w500
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     width: size.width * 0.18,
//                                                     // color: Colors.amber,
//                                                     child: Text(
//                                                       items.teacher!.name!,
//                                                       // 'Rosie David',
//                                                       style:  GoogleFonts.poppins(
//                                                           color: Colors.black,
//                                                           fontSize: 12.0,
//                                                           fontWeight: FontWeight.w500
//                                                       ),
//                                                       maxLines: 1,
//                                                       overflow: TextOverflow.ellipsis,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             height: 5,
//                                           ),
//                                           Text(
//                                             items.detail!,
//                                             // 'It has survived not only five centuries, but alse five centuries, but alse the leep into electron five centuries, but alse the leep into electron the leep into electronic typesetting remaining essentially unchanged. It was popularised in the',
//                                             style: TextStyle(
//                                                 color: AppThemes.blueColor,
//                                                 fontSize: 9,
//                                                 fontWeight: FontWeight.w300
//                                             ),
//                                             maxLines: 3,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//     );
//   }
// }
//
//
//
