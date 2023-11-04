import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';

import '../../routers/my_routers.dart';

class NotificationScreenUser extends StatefulWidget {
  const NotificationScreenUser({Key? key}) : super(key: key);

  @override
  State<NotificationScreenUser> createState() => _NotificationScreenUserState();
}

class _NotificationScreenUserState extends State<NotificationScreenUser> {
  RxString day = "".obs;
  RxString month = "".obs;
  RxString year = "".obs;
  RxString monthName = "".obs;
  RxString clinicId = "".obs;
  int selectedIndex = 0;

  var now = DateTime.now();
  var totalDays;
  var listOfDates;
  var todayDay;

  @override
  void initState() {
    super.initState();
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
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppThemes.white,
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
                color: AppThemes.primaryColor,
              ),
              // CarouselSlider(
              //   options: CarouselOptions(
              //     height: 200, // Adjust the height as needed
              //     aspectRatio: 16/9, // Adjust the aspect ratio as needed
              //     viewportFraction: 0.8, // Adjust the visible item fraction
              //     initialPage: 0, // Set the initial page
              //     enableInfiniteScroll: true, // Enable infinite scrolling
              //     reverse: false, // Set to true for reverse sliding
              //     autoPlay: true, // Enable auto-play
              //     autoPlayInterval: Duration(seconds: 3), // Set auto-play interval
              //     autoPlayAnimationDuration: Duration(milliseconds: 800),
              //     autoPlayCurve: Curves.fastOutSlowIn,
              //     enlargeCenterPage: true, // Enlarge the center item
              //     scrollDirection: Axis.horizontal, // Set the scrolling direction
              //   ),
              //   items: [ ClipRRect(
              //     borderRadius: const BorderRadius.only(
              //         bottomLeft: Radius.elliptical(190, 85)),
              //     child: Image.asset(
              //       AppAssets.collageImg,
              //       fit: BoxFit.cover,
              //       width: double.maxFinite,
              //     ),
              //   ),],
              // ),

              Container(
                height: size.height * .288,
                decoration: const BoxDecoration(
                    color: AppThemes.primaryColor,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30))),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 10,
                  child: Padding(
                    padding: EdgeInsets.all(size.width * .010),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          height: 60,
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
                                        selectedIndex = index;
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
                                            horizontal: 5),
                                        child: Text(months[index].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: index == selectedIndex
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
                          height: 90,
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
                                  padding: EdgeInsets.only(right: 5, left: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                        day.value = formattedDate.length != 2
                                            ? "0$formattedDate"
                                            : formattedDate;
                                        // month.value = formattedDate1.length != 2 ? "0$formattedDate1" : formattedDate1;
                                        // year.value = formattedDate2;
                                        log(month.value);
                                        monthName.value = DateFormat('MMMM')
                                            .format(DateTime.parse(
                                                "${year.value}-${month.value}-${day.value}"));
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                weekDay[0].toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        index == selectedIndex
                                                            ? Colors.black
                                                            : Colors.white),
                                              ),
                                              Text(
                                                formattedDate,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
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
                top: size.height * .298,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(50)),
                  ),
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                        ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 18),
                                  color: const Color(0xffecffd2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            AppAssets.notificaationIcon,
                                            height: 16,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Holi Celebration",
                                                style: GoogleFonts.poppins(
                                                    color:
                                                        AppThemes.primaryColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                "Holi Celebration ",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "12:30 PM",
                                        style: GoogleFonts.poppins(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
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
                  ),
                ),
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
