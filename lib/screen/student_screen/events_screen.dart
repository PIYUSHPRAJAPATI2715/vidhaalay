import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/get_notification_controller.dart';
import 'package:vidhaalay_app/controller/student_controller/event_list_controller_student.dart';
import 'package:vidhaalay_app/controller/teacher_controller/event_detail_controller.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import '../../repositories/calendar_repo.dart';
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
  final ScrollController _dateController = ScrollController();
  final ScrollController _monthController = ScrollController();

  final evenetListStudentController = Get.put(EvenetListStudentController());
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
    evenetListStudentController.selDate.value = selectedDate;
    evenetListStudentController.getEventData();
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
                                  controller: _monthController,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: months.length,
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
                top: size.height * .250,
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

                                // DateTime dateTime =
                                // DateTime.parse(items
                                //     .createdAt
                                //     .toString());
                                // String formattedDate =
                                // DateFormat('yyyy-MM-dd')
                                //     .format(dateTime);

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
                                                                items.date.toString(),
                                                              // formattedDate.toString(),
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
