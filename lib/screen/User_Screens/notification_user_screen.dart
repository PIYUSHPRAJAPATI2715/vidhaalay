import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';

import '../../controller/get_notification_controller.dart';
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

  final notificationController = Get.put(GetNotificationController());

  @override
  void initState() {
    super.initState();
    notificationController.getNotificationData();
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
          automaticallyImplyLeading: true,
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
                  height: size.height*.260,
                  decoration: const BoxDecoration(
                    color: AppThemes.primaryColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
                  ),
                  child:  Padding(
                    padding: EdgeInsets.all(size.width * .010),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          height: size.height*.070,
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
                                            horizontal: 10,vertical: 10),
                                        child: Text(months[index].toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
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
                    return notificationController.isDataLoading.value == true ?
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
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
                            itemCount: notificationController.getNotificationModel.value.data!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var items = notificationController.getNotificationModel.value.data![index];
                              DateTime dateTime = DateTime.parse(items.createdAt.toString());
                              String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                              return Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18).copyWith(top: 10),
                                    color: const Color(0xffecffd2),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets.only(top: 2.0),
                                                child: Image.asset(
                                                  AppAssets.greenInfo,
                                                  height: 14,
                                                  width: 14,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          items.title.toString(),
                                                          style: GoogleFonts.poppins(
                                                              color:
                                                              AppThemes.primaryColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ),
                                                        Text(
                                                          formattedDate.toString(),
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.grey,
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.w400),
                                                        ),
                                                      ],
                                                    ),

                                                    Text(
                                                      items.message.toString(),
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.grey,
                                                          fontSize: 10,
                                                          fontWeight:
                                                          FontWeight.w500),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ): const CommonProgressIndicator();
                  })
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
