import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';


class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({Key? key}) : super(key: key);

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  RxString day = "".obs;
  RxString month = "".obs;
  RxString  year = "".obs;
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
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024",
  ];
  List<String> subjectName = [
    "S.sc",
    "Science",
    "Maths",
    "Hindi",
    "English",
  ];
  List<String> className = [
    "5th",
    "6th",
    "7th",
    "8th",
    "9th",
    "10th",
    "11th",
    "12th",
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
        title: Text('Syllabus',
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
              height: 230,
              decoration: const BoxDecoration(
                color: AppThemes.primaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Container(
                    height: 45,
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
                    height: 70,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children:
                        List.generate(subjectName.length, (index) {
                          return Padding(
                            key: keysList[index],
                            padding: const EdgeInsets.only(right: 0, left: 0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0).copyWith(left: 0,right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: index == selectedIndex
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius:
                                      BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          subjectName[index].toString(),
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
                  Container(
                    height: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: className.length,
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
                                child:Padding(
                                  padding: const EdgeInsets.all(10.0).copyWith(left: 0,right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: index == selectedIndex
                                            ? Colors.white
                                            : Colors.transparent,
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15).copyWith(bottom: 0),
                                      child: Column(
                                        children: [
                                          Text(
                                            className[index].toString(),
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
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),

          Positioned.fill(
            top: size.height*.300,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 12).copyWith(bottom: 0),
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppThemes.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
              ),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Teach by:',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),),
                       Row(
                         children: [
                           ClipOval(
                             child: Image.asset(AppAssets.studentImg,height: 30,),
                           ),
                          const SizedBox(
                             width: 6,
                           ),
                           Text('Rosie David',
                             style: GoogleFonts.poppins(
                                 color: Colors.orange,
                                 fontSize: 17,
                                 fontWeight: FontWeight.w500
                             ),),
                         ],
                       )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Text('Syllabus',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600
                        ),),
                    ),
                    SizedBox(
                      height: size.height,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 22,
                              ),
                               Row(
                                 children: [
                                   Container(
                                     height: 40,
                                     width: 40,
                                     alignment: Alignment.center,
                                     decoration: const BoxDecoration(
                                       image: DecorationImage(image: AssetImage(AppAssets.greenSquare))
                                     ),
                                     child:  Text('1',
                                       style: GoogleFonts.poppins(
                                           color: AppThemes.white,
                                           fontSize: 16,
                                           fontWeight: FontWeight.w500
                                       ),),
                                   ),
                                   const SizedBox(
                                     width: 15,
                                   ),

                                   Expanded(
                                     child: Container(
                                       padding: const EdgeInsets.all(10),
                                       width: size.width,
                                       decoration: BoxDecoration(
                                         color: AppThemes.lightPink,
                                         borderRadius: BorderRadius.circular(8)
                                       ),
                                       child: Text('Number Systems',
                                         textAlign: TextAlign.center,
                                         style: GoogleFonts.poppins(
                                             color: AppThemes.blueColor,
                                             fontSize: 16,
                                             fontWeight: FontWeight.w500
                                         ),),
                                     ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
