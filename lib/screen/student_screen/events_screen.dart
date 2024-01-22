import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/get_notification_controller.dart';
import 'package:vidhaalay_app/controller/student_controller/event_list_controller_student.dart';
import 'package:vidhaalay_app/controller/teacher_controller/event_detail_controller.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';


class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {

  RxString day = "".obs;
  RxString month = "".obs;
  RxString year = "".obs;
  RxString monthName = "".obs;
  RxString clinicId = "".obs;
  int selectedMonthIndex = 0;
  int selectedIndex = 0;

  var now = DateTime.now();
  var totalDays;
  var listOfDates;
  var todayDay;
  var FullDate;

  final evenetListStudentController = Get.put(EvenetListStudentController());

  @override
  void initState() {
    super.initState();
    // _listScrollController.addListener(_scrollListener);

    year.value = DateFormat('yyyy').format(DateTime.now());
    month.value = DateFormat('MM').format(DateTime.now());

    print("month");
    print(month.value);
    selectedMonthIndex = int.parse(month.value);
    print(selectedMonthIndex);

    monthName.value = DateFormat('MMMM').format(DateTime.now());
    print("monthName.value : ${monthName.value}");
    // evenetListStudentController.getNotificationData(monthName.value);

    day.value = DateFormat('dd').format(DateTime.now());

    log(day.value);
    log(month.value);
    log(year.value);

    String date = year.value + "-" + month.value + "-" + day.value;
    log(date);

    evenetListStudentController.selDate.value = date;
    evenetListStudentController.getEventData();

    // getYear();
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
  // List<DateTime> years = [];

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
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: AppThemes.white,
          leading: IconButton(
            icon: Image.asset(
              AppAssets.arrowBack,
              width: 19,
              color: AppThemes.textBrown,
            ),
            onPressed: () {
              Get.toNamed(MyRouters.bottomNavigationUserScreen);
              // Get.back();
            },
          ),
          title: Text(
            "Event Calender",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: AppThemes.black,
                fontSize: 19,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: SafeArea(
          child: Stack(
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
                                        evenetListStudentController.selDate.value = date;
                                        evenetListStudentController
                                            .getEventData();
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
                                        evenetListStudentController.selDate.value = date;
                                        evenetListStudentController
                                            .getEventData();
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
                top: size.height * .260,
                child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.only(topRight: Radius.circular(50)),
                    ),
                    child: Obx(() {
                      return evenetListStudentController.isDataLoading.value
                          ? const CommonProgressIndicator()
                          : SingleChildScrollView(
                        physics:
                        const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 10),
                              child: Text(
                                "today".toUpperCase(),
                                style: GoogleFonts.poppins(
                                    color: AppThemes.black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            evenetListStudentController
                                .getEventModel
                                .value
                                .data!
                                .isEmpty
                                ? Container(
                              height: size.height * .5,
                              // color: Colors.red,
                              child: Center(
                                child: Text(
                                  "No Event Available",
                                ),
                              ),
                            )
                                : ListView.builder(
                              itemCount: evenetListStudentController
                                  .getEventModel
                                  .value
                                  .data!
                                  .length,
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var items =
                                evenetListStudentController
                                    .getEventModel
                                    .value
                                    .data![index];
                                DateTime dateTime =
                                DateTime.parse(items
                                    .createdAt
                                    .toString());
                                String formattedDate =
                                DateFormat('yyyy-MM-dd')
                                    .format(dateTime);
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(MyRouters.celebrationScreenStu, arguments: items.id.toString());

                                        // Get.to(() => Eve(
                                        //     id: evenetListStudentController
                                        //         .getEventModel
                                        //         .value
                                        //         .data![index]
                                        //         .id
                                        //         .toString()));
                                      },
                                      child: Container(
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            vertical:
                                            15,
                                            horizontal:
                                            18)
                                            .copyWith(
                                            top: 10),
                                        color: const Color(
                                            0xffecffd2),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top:
                                                        2.0),
                                                    child: Image
                                                        .asset(
                                                      AppAssets
                                                          .greenInfo,
                                                      height:
                                                      14,
                                                      width: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child:
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: size.width * 0.6,
                                                              // color: Colors.amber,
                                                              child: Text(
                                                                items.eventName.toString(),
                                                                style: GoogleFonts.poppins(color: AppThemes.primaryColor, fontSize: 15, fontWeight: FontWeight.w500),
                                                              ),
                                                            ),
                                                            Text(
                                                              formattedDate.toString(),
                                                              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w400),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          items
                                                              .message
                                                              .toString(),
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.grey,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w500),
                                                          maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      );
                    })),
              ),
            ],
          ),
        )
      // SingleChildScrollView(
      //   padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 18.0),
      //         child: Text("today".toUpperCase(),
      //           style: GoogleFonts.poppins(
      //               color: AppThemes.black,
      //               fontSize: 21,
      //               fontWeight: FontWeight.w600
      //           ),),
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       ListView.builder(
      //           itemCount: 5 ,
      //           shrinkWrap: true,
      //           itemBuilder:  (context, index) {
      //             return Column(
      //               children: [
      //                 Container(
      //                   padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 18),
      //                     color: const Color(0xffecffd2),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                      Row(
      //                        crossAxisAlignment: CrossAxisAlignment.start,
      //                        children: [
      //                          Image.asset(AppAssets.notificaationIcon, height: 16,),
      //                         const SizedBox(
      //                            width: 10,
      //                          ),
      //                          Column(
      //                            crossAxisAlignment: CrossAxisAlignment.start,
      //                            children: [
      //                              Text("Holi Celebration",
      //                                style: GoogleFonts.poppins(
      //                                    color: AppThemes.primaryColor,
      //                                    fontSize: 15,
      //                                    fontWeight: FontWeight.w500
      //                                ),),
      //                              Text("Holi Celebration ",
      //                                style: GoogleFonts.poppins(
      //                                    color: Colors.grey,
      //                                    fontSize: 10,
      //                                    fontWeight: FontWeight.w500
      //                                ),),
      //                            ],
      //                          ),
      //                        ],
      //                      ),
      //                       Text("12:30 PM",
      //                         style: GoogleFonts.poppins(
      //                             color: Colors.grey,
      //                             fontSize: 13,
      //                             fontWeight: FontWeight.w400
      //                         ),),
      //                     ],
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   height: 10,
      //                 ),
      //               ],
      //             );
      //           },
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
