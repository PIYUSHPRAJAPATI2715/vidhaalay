import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay/repositories/calendar_repo.dart';
import 'package:vidhaalay/resourses/app_assets.dart';
import 'package:vidhaalay/screen/User_Screens/notification_detail_user_screen.dart';
import 'package:vidhaalay/widgets/appTheme.dart';
import 'package:vidhaalay/widgets/circular_progressindicator.dart';

import '../../controller/get_notification_controller.dart';
import '../../routers/my_routers.dart';

class NotificationScreenUser extends StatefulWidget {
  const NotificationScreenUser({Key? key}) : super(key: key);

  @override
  State<NotificationScreenUser> createState() => _NotificationScreenUserState();
}

class _NotificationScreenUserState extends State<NotificationScreenUser> {
  final notificationController = Get.put(GetNotificationController());

  final ScrollController _dateController = ScrollController();
  final ScrollController _monthController = ScrollController();
  List currentSessionYear = CommonCalendar.currentSessionYear;
  List<String> months =  CommonCalendar.monthsList;
  RxString month = "".obs;
  RxString monthName = "".obs;
  RxString day = "".obs;


  selecedDate() {
    notificationController.selectedDate.value = notificationController.selectedYear.value.toString()+"-"+ month.value +"-"+ day.value;
    notificationController.getNotificationData(notificationController.selectedDate.value);
  }

  @override
  void initState() {
    super.initState();
    notificationController.selectedYear.value = int.parse(DateFormat('yyyy').format(DateTime.now()));
    month.value = DateFormat('MM').format(DateTime.now());
    monthName.value = DateFormat('MMMM').format(DateTime.now());
    day.value = DateFormat('dd').format(DateTime.now());
    selecedDate();
    notificationController.selectedMonthIndex.value = selectCorrectMonthIndex(int.parse(month.value));
    notificationController.selectedYear.value = selectYearByMonth(month: month.value);
    notificationController.daysInMonth.value =  getMonthDays(year: notificationController.selectedYear.value,month: month.value);
    notificationController.selectedIndex.value = int.parse(day.value) - 1;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      setState(() {});
      _dateController.animateTo(
        notificationController.selectedIndex.value * 45.0, // Adjust 110 according to your item size and spacing
        duration: Duration(milliseconds: 1800),
        curve: Curves.easeInOut,
      );
      _monthController.animateTo(
        notificationController.selectedMonthIndex.value * 65.0, // Adjust 110 according to your item size and spacing
        duration: Duration(milliseconds: 1800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              // Get.toNamed(MyRouters.bottomNavigationUserScreen);
              Get.back();
            },
          ),
          title: Text(
            "Notification Calender",
            // "Event Calender",
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
                  height: size.height*.22,
                  decoration: const BoxDecoration(
                    color: AppThemes.primaryColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                  ),
                  child:  Padding(
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
                                        color: notificationController.selectedYear.value == currentSessionYear[0] ? Colors.white : Colors.black
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
                                        color: notificationController.selectedYear.value == currentSessionYear[1] ? Colors.white : Colors.black
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
                                  controller: _monthController,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: months.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        notificationController.selectedMonthIndex.value = index;
                                        month.value = selectMonthByIndex(index).toString().padLeft(2, '0');
                                        notificationController.selectedYear.value = selectYearByMonth(month: month.value);
                                        notificationController.daysInMonth.value = getMonthDays(year: notificationController.selectedYear.value,month: month.value);
                                        if(notificationController.daysInMonth.value.length <= int.parse(day.value) ) {
                                          day.value = 1.toString().padLeft(2, '0');
                                          notificationController.selectedIndex.value = 0;
                                          _dateController.animateTo(
                                            notificationController.selectedIndex.value * 1.0,
                                            duration: Duration(milliseconds: 1800),
                                            curve: Curves.easeInOut,
                                          );
                                        } else {
                                          _dateController.animateTo(
                                            notificationController.selectedIndex.value * 45.0,
                                            duration: Duration(milliseconds: 1800),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                        selecedDate();

                                        setState(() {
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Center(
                                          child: Text(months[index].toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17,
                                                  color: index == notificationController.selectedMonthIndex.value
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

                        // SizedBox(
                        //   height: size.height*.110,
                        //   child: SingleChildScrollView(
                        //     scrollDirection: Axis.horizontal,
                        //     physics: BouncingScrollPhysics(),
                        //     controller: _dateController,
                        //     child: Row(
                        //       children: List.generate(notificationController.daysInMonth.value.length, (index) {
                        //
                        //         DateTime specifiedDate = DateTime(2024, int.parse(month.value), notificationController.daysInMonth.value[index]);
                        //         String dayName = DateFormat('EEEE').format(specifiedDate).substring(0, 1);
                        //
                        //         return Padding(
                        //           padding: EdgeInsets.only(right: 0, left: 0),
                        //           child: GestureDetector(
                        //             onTap: () {
                        //               notificationController.selectedIndex.value = index;
                        //               day.value = (index + 1).toString().padLeft(2, '0');
                        //               // print(notificationController.selectedIndex.value);
                        //               print(day.value);
                        //               selecedDate();
                        //               setState(() {
                        //
                        //               });
                        //             },
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(8.0),
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     color: index == notificationController.selectedIndex.value
                        //                         ? Colors.white
                        //                         : Colors.transparent,
                        //                     borderRadius:
                        //                     BorderRadius.circular(20)),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(12.0),
                        //                   child: Column(
                        //                     children: [
                        //                       Text(
                        //                         dayName.toString(),
                        //                         style: TextStyle(
                        //                             fontSize: 16,
                        //                             fontWeight: FontWeight.w600,
                        //                             color:
                        //                             index == notificationController.selectedIndex.value
                        //                                 ? Colors.black
                        //                                 : Colors.white),
                        //                       ),
                        //                       Text(
                        //                         notificationController.daysInMonth.value[index].toString(),
                        //                         style: TextStyle(
                        //                             fontSize: 16,
                        //                             fontWeight: FontWeight.w600,
                        //                             color:
                        //                             index == notificationController.selectedIndex.value
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
                        SizedBox(
                          height: size.height*.085,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            controller: _dateController,
                            child: Row(
                              children: List.generate(notificationController.daysInMonth.value.length, (index) {

                                DateTime specifiedDate = DateTime(2024, int.parse(month.value), notificationController.daysInMonth.value[index]);
                                String dayName = DateFormat('EEEE').format(specifiedDate).substring(0, 1);
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      notificationController.selectedIndex.value = index;
                                      day.value = (index + 1).toString().padLeft(2, '0');
                                      // print(notificationController.selectedIndex.value);
                                      print(day.value);
                                      selecedDate();
                                      setState(() {

                                      });
                                    },
                                    child: Container(
                                      height: size.height*.08,
                                      decoration: BoxDecoration(
                                          color: index == notificationController.selectedIndex.value
                                              ? Colors.white
                                              : Colors.transparent,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              dayName.toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                  index == notificationController.selectedIndex.value
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                            Text(
                                              notificationController.daysInMonth.value[index].toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                  index == notificationController.selectedIndex.value
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                          ],
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
                top: size.height * .22,
                child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(50)),
                    ),
                    child: Obx(() {
                      return notificationController.isNoData.value == true
                          ? Center(
                              child: Text(
                                "No Longer Notification Available",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            )
                          : notificationController.isDataLoading.value == true
                              ? SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        CommonCalendar.currentDate == notificationController.selectedDate.value
                                            ?  'today'.toUpperCase() :
                                        CommonCalendar.yesterdayDate == notificationController.selectedDate.value ?
                                        'yesterday'.toUpperCase() :
                                        CommonCalendar.tommorrowdayDate == notificationController.selectedDate.value ?
                                        'tommorrow'.toUpperCase() : notificationController.selectedDate.value,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                        ),),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       horizontal: 18.0, vertical: 10),
                                      //   child: Text(
                                      //     "today".toUpperCase(),
                                      //     style: GoogleFonts.poppins(
                                      //         color: AppThemes.black,
                                      //         fontSize: 21,
                                      //         fontWeight: FontWeight.w600),
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      notificationController
                                              .getNotificationModel
                                              .value
                                              .data!
                                              .isEmpty
                                          ? Container(
                                              height: size.height * .5,
                                              // color: Colors.red,
                                              child: Center(
                                                child: Text(
                                                  "No notification found for this date",
                                                ),
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount: notificationController
                                                  .getNotificationModel
                                                  .value
                                                  .data!
                                                  .length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                var items =
                                                    notificationController
                                                        .getNotificationModel
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
                                                        Get.to(() => UserNotificationDetailScreen(
                                                            id: notificationController
                                                                .getNotificationModel
                                                                .value
                                                                .data![index]
                                                                .id
                                                                .toString()));
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
                                                                     padding: const EdgeInsets.only(top: 5.0),
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
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                            Container(
                                                                              // color: Colors.green,
                                                                              width: size.width * .52,
                                                                              child: Text(
                                                                                items.title.toString(),
                                                                                style: GoogleFonts.poppins(color: AppThemes.primaryColor, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              formattedDate.toString(),
                                                                              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w400),
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
                                )
                              : const CommonProgressIndicator();
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
