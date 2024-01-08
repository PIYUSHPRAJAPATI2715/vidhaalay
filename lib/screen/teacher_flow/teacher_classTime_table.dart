import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/teacher_controller/class_time_controller.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class TeacherClassTimeScreen extends StatefulWidget {
  const TeacherClassTimeScreen({Key? key}) : super(key: key);

  @override
  State<TeacherClassTimeScreen> createState() => _TeacherClassTimeScreenState();
}

class _TeacherClassTimeScreenState extends State<TeacherClassTimeScreen> {

  final classTimeController = Get.put(ClassTimeController());

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
    classTimeController.getMyClass();
    // classTimeController.getTimeTableData();

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
        title: Text('Class Timetable',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppThemes.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Image.asset(AppAssets.arrowBack,width: 25,height: 25,),
        ),
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
              // height: 200,
              height: size.height*.250,
              decoration: const BoxDecoration(
                color: AppThemes.primaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
              ),
              child:  Padding(
                padding: EdgeInsets.all(size.width * .010),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const SizedBox(height: 10),
                    // Container(
                    //   height: 60,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Expanded(
                    //         child: ListView.builder(
                    //           scrollDirection: Axis.horizontal,
                    //           shrinkWrap: true,
                    //           itemCount: months.length,
                    //           itemBuilder:
                    //               (BuildContext context, int index) {
                    //             return InkWell(
                    //               onTap: () {
                    //                 selectedIndex = index;
                    //                 month.value = "${index + 1}".length != 2
                    //                     ? "0${index + 1}"
                    //                     : "${index + 1}";
                    //                 monthName.value = DateFormat('MMMM')
                    //                     .format(DateTime.parse(
                    //                     "${year.value}-${month.value}-${day.value}"));
                    //                 now = DateTime.parse(
                    //                     "${year.value}-${month.value}-${day.value}");
                    //                 totalDays = daysInMonth(now);
                    //                 listOfDates = List<int>.generate(
                    //                     totalDays, (i) => i + 1);
                    //                 todayDay = DateFormat('dd').format(now);
                    //                 getWeekDates(now);
                    //                 log(DateFormat('EEEE').format(now));
                    //                 // Get.back();
                    //               },
                    //               child: Padding(
                    //                 padding: const EdgeInsets.symmetric(
                    //                     horizontal: 10,vertical: 10),
                    //                 child: Text(months[index].toString(),
                    //                     style: GoogleFonts.poppins(
                    //                         fontWeight: FontWeight.w500,
                    //                         fontSize: 17,
                    //                         color: index == selectedIndex
                    //                             ? Colors.white
                    //                             : Colors.black)),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 80,
                    //   child: SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     physics: BouncingScrollPhysics(),
                    //     child: Row(
                    //       children:
                    //       List.generate(weekDates.length, (index) {
                    //         DateTime date = weekDates[index];
                    //         String formattedDate =
                    //         DateFormat('d').format(date);
                    //         String formattedDate1 =
                    //         DateFormat('MM').format(date);
                    //         String formattedDate2 =
                    //         DateFormat('yyyy').format(date);
                    //         String weekDay =
                    //         DateFormat('EEEE').format(date);
                    //         return Padding(
                    //           key: keysList[index],
                    //           padding: EdgeInsets.only(right: 0, left: 0),
                    //           child: GestureDetector(
                    //             onTap: () {
                    //               setState(() {
                    //                 selectedIndex = index;
                    //                 day.value = formattedDate.length != 2
                    //                     ? "0$formattedDate"
                    //                     : formattedDate;
                    //                 // month.value = formattedDate1.length != 2 ? "0$formattedDate1" : formattedDate1;
                    //                 // year.value = formattedDate2;
                    //                 log(month.value);
                    //                 monthName.value = DateFormat('MMMM')
                    //                     .format(DateTime.parse(
                    //                     "${year.value}-${month.value}-${day.value}"));
                    //               });
                    //             },
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: Container(
                    //                 decoration: BoxDecoration(
                    //                     color: index == selectedIndex
                    //                         ? Colors.white
                    //                         : Colors.transparent,
                    //                     borderRadius:
                    //                     BorderRadius.circular(20)),
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(12.0),
                    //                   child: Column(
                    //                     children: [
                    //                       Text(
                    //                         weekDay[0].toString(),
                    //                         style: TextStyle(
                    //                             fontSize: 16,
                    //                             fontWeight: FontWeight.w600,
                    //                             color:
                    //                             index == selectedIndex
                    //                                 ? Colors.black
                    //                                 : Colors.white),
                    //                       ),
                    //                       Text(
                    //                         formattedDate,
                    //                         style: TextStyle(
                    //                             fontSize: 16,
                    //                             fontWeight: FontWeight.w600,
                    //                             color:
                    //                             index == selectedIndex
                    //                                 ? Colors.black
                    //                                 : Colors.white),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       }),
                    //     ),
                    //   ),
                    // ),
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
                              Text(year.value.toString(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              // Text(year.value.toString(),
                              //   style: GoogleFonts.poppins(
                              //       fontWeight: FontWeight.w500,
                              //       fontSize: 17,
                              //       color: Colors.black),
                              //   textAlign: TextAlign.center,
                              // ),
                              classTimeController.classList.value.isEmpty ? SizedBox.shrink() : Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text('Class -',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: Colors.black,),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Obx(
                                        () {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          value:  classTimeController.selectedClassId?.value,
                                          // style: TextStyle(
                                          //     color: Colors.green,
                                          //     fontSize: 12,
                                          //     fontWeight: FontWeight.w300),
                                          icon: Icon(Icons.keyboard_arrow_down,color: Colors.black),
                                          items: classTimeController.classList.value.toList().map((items) {
                                            return DropdownMenuItem(
                                              value: items.id,
                                              child: Text(items.name,style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: classTimeController.selectedClassId?.value == items.id
                                                    ? Colors.black
                                                // Colors.grey.shade900 // Change the color for selected item
                                                    : Colors.black, // Default color for unselected items
                                              ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            // print(newValue);
                                            classTimeController.selectedClassId!.value = newValue!;
                                            print(classTimeController.selectedClassId?.value);

                                            classTimeController.getTimeTableData(classId: classTimeController.selectedClassId.value);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  // SizedBox(
                                  //   height: 20,
                                  //   width: 40,
                                  //   child: DropdownButtonFormField(
                                  //     focusColor: Colors.grey.shade50,
                                  //     isExpanded: true,
                                  //     iconEnabledColor: const Color(0xff97949A),
                                  //     icon: const Icon(Icons.keyboard_arrow_down),
                                  //     hint: Text(
                                  //       classTimeController.selectedClassId.value.toString(),
                                  //       style: const TextStyle(
                                  //           color: Colors.white,
                                  //           fontSize: 12,
                                  //           fontWeight: FontWeight.w300),
                                  //       textAlign: TextAlign.justify,
                                  //     ),
                                  //     decoration: InputDecoration(
                                  //         fillColor: Colors.grey.shade50,
                                  //         contentPadding: const EdgeInsets.symmetric(
                                  //             horizontal: 20, vertical: 13),
                                  //         focusedBorder: OutlineInputBorder(
                                  //           borderSide:
                                  //           BorderSide(color: Colors.grey.shade300),
                                  //           borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25)),
                                  //         ),
                                  //         enabledBorder: const OutlineInputBorder(
                                  //             borderSide:
                                  //             BorderSide(color: Color(0xffE3E3E3)),
                                  //             borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25))
                                  //         )
                                  //     ),
                                  //     value: classTimeController.selectedClassId.value,
                                  //     items: classTimeController.classList.value.toList().map((items) {
                                  //       return DropdownMenuItem(
                                  //         value: items.id,
                                  //         child: Text(
                                  //           items.name,
                                  //           style: const TextStyle(
                                  //               color: Colors.grey, fontSize: 14),
                                  //         ),
                                  //       );
                                  //     }).toList(),
                                  //     onChanged: (newValue) {
                                  //         classTimeController.selectedClassId.value = newValue!;
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   height: size.height*.045,
                    //   decoration: BoxDecoration(
                    //     // color: Colors.amberAccent,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //
                    //       // Expanded(
                    //       //   child: ListView.builder(
                    //       //     scrollDirection: Axis.horizontal,
                    //       //     shrinkWrap: true,
                    //       //     itemCount: years.length,
                    //       //     itemBuilder:
                    //       //         (BuildContext context, int index) {
                    //       //       return InkWell(
                    //       //         onTap: () {
                    //       //           selectedMonthIndex = index;
                    //       //           month.value = "${index + 1}".length != 2
                    //       //               ? "0${index + 1}"
                    //       //               : "${index + 1}";
                    //       //           monthName.value = DateFormat('MMMM')
                    //       //               .format(DateTime.parse(
                    //       //               "${year.value}-${month.value}-${day.value}"));
                    //       //           now = DateTime.parse(
                    //       //               "${year.value}-${month.value}-${day.value}");
                    //       //           totalDays = daysInMonth(now);
                    //       //           listOfDates = List<int>.generate(
                    //       //               totalDays, (i) => i + 1);
                    //       //           todayDay = DateFormat('dd').format(now);
                    //       //           getWeekDates(now);
                    //       //           log(DateFormat('EEEE').format(now));
                    //       //           // Get.back();
                    //       //         },
                    //       //         child: Padding(
                    //       //           padding: const EdgeInsets.symmetric(
                    //       //               horizontal: 10,vertical: 5),
                    //       //           child: Text(year.value.toString(),
                    //       //               style: GoogleFonts.poppins(
                    //       //                   fontWeight: FontWeight.w500,
                    //       //                   fontSize: 17,
                    //       //                   color: index == selectedMonthIndex
                    //       //                       ? Colors.white
                    //       //                       : Colors.black)
                    //       //           ),
                    //       //         ),
                    //       //       );
                    //       //     },
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),

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
                                    print("selectedIndex : $selectedIndex");

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
                                    log(date);

                                    // evenetDetailController.getEventData(date);
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
              )
          ),

          Positioned.fill(
            top: size.height*.250,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 12).copyWith(bottom: 0),
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppThemes.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
              ),
              child: Obx(() {
                return  !classTimeController.isDataLoading.value ?
                classTimeController.getTimetableModel.value.data!.isEmpty ?
                    Center(child: Text('No time table available'))
                    :
                SingleChildScrollView(
                  // physics: BouncingScrollPhysics(),
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
                              Get.toNamed(MyRouters.createTimeTableScreen);
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

                      SizedBox(
                        height: size.height,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: classTimeController.getTimetableModel.value.data!.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var value = classTimeController.getTimetableModel.value.data![index] ;
                            // DateTime dateTime = DateTime.parse(value.from!);
                            // Format the DateTime object to display time in AM/PM format
                            // String formattedTime = DateFormat('h:mm a').format(dateTime);
                            String formattedTime = value.fromTime!;

                            print("Formatted Time: $formattedTime");

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 22,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        // '08 AM',
                                        formattedTime,
                                        style: GoogleFonts.poppins(
                                            color: AppThemes.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600
                                        ),),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        width: size.width*.60,
                                        padding: const EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                            color: AppThemes.lightPink,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.subjectId.toString(),
                                              // 'Social Science',
                                              style: GoogleFonts.poppins(
                                                  color: AppThemes.blueColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600
                                              ),),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                ClipOval(
                                                  child: Image.asset(
                                                    AppAssets.studentImg,
                                                    width: 13,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'By :',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.grey,
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                                Text(
                                                  value.teacher!.name.toString(),
                                                  // 'Rosie David',
                                                  style:  GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   child: IconButton(onPressed: (){
                                    //     Get.toNamed(MyRouters.createTimeTableScreen);
                                    //   },
                                    //       icon: const Icon(Icons.edit,size: 19,)),
                                    // ),
                                    Expanded(
                                      child: IconButton(onPressed: (){
                                        classTimeController.deleteTimetableAPI(context,value.id!);
                                      },
                                          icon: const Icon(Icons.delete,color: Colors.red,size: 19,)),
                                    )
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
                    :  const CommonProgressIndicator();
              }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
