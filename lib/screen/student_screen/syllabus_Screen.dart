import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/student_controller/syllabus_student_controller.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
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

  final syllabusStudentController = Get.put(SyllabusStudentController());

  @override
  void initState() {
    super.initState();
    syllabusStudentController.getClassListData();

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
  // List<String> subjectName = [
  //   "S.sc",
  //   "Science",
  //   "Maths",
  //   "Hindi",
  //   "English",
  // ];
  // List<String> className = [
  //   "5th",
  //   "6th",
  //   "7th",
  //   "8th",
  //   "9th",
  //   "10th",
  //   "11th",
  //   "12th",
  // ];

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
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Image.asset(AppAssets.arrowBack,width: 25,height: 25,),
        ),
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
                height: size.height*.25,
                decoration: const BoxDecoration(
                  color: AppThemes.primaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
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

                    syllabusStudentController.isSubjectLoading.value
                        ? SizedBox(
                            height: 70,
                          )
                        : syllabusStudentController
                                .getSubjectListModel.value.data!.isEmpty
                            ? SizedBox(
                                height: 70,
                                child: Center(
                                  child: Text(
                                    "No subject available",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 70,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  child: Row(
                                    children: List.generate(
                                        syllabusStudentController
                                            .getSubjectListModel
                                            .value
                                            .data!
                                            .length, (index) {
                                      var item = syllabusStudentController
                                          .getSubjectListModel
                                          .value
                                          .data![index];

                                      return Padding(
                                        // key: keysList[index],
                                        padding: const EdgeInsets.only(
                                            right: 0, left: 0),
                                        child: GestureDetector(
                                          onTap: () {
                                            syllabusStudentController.selectedSubject = item.id;
                                            syllabusStudentController.getSyllabusData();
                                            setState(() {
                                              // selectedIndex = index;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0)
                                                .copyWith(left: 0, right: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: item.id == syllabusStudentController.selectedSubject
                                                      ? Colors.white
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      item.name.toString(),
                                                      // subjectName[index].toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: item.id ==
                                                              syllabusStudentController.selectedSubject
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

                    syllabusStudentController.isClassLoading.value
                        ? SizedBox(
                      height: 60,
                    )
                        : syllabusStudentController
                        .getClassListModel.value.data!.isEmpty
                        ? SizedBox(
                      height: 60,
                      child: Center(
                        child: Text(
                          "No class available",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    )
                        : Container(
                      height: 60,
                      decoration: BoxDecoration(
                          // color: Colors.pink,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: syllabusStudentController.getClassListModel.value.data!.length,
                              itemBuilder:
                                  (BuildContext context, int index) {

                                var item =syllabusStudentController.getClassListModel.value.data![index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: InkWell(
                                    onTap: () {
                                      syllabusStudentController.selectedClass = item.id;
                                      syllabusStudentController.getSubjectListData();
                                      setState(() {
                                        // selectedIndex = index;
                                      });

                                      // selectedIndex = index;
                                      // month.value = "${index + 1}".length != 2
                                      //     ? "0${index + 1}"
                                      //     : "${index + 1}";
                                      // monthName.value = DateFormat('MMMM')
                                      //     .format(DateTime.parse(
                                      //     "${year.value}-${month.value}-${day.value}"));
                                      // now = DateTime.parse(
                                      //     "${year.value}-${month.value}-${day.value}");
                                      // totalDays = daysInMonth(now);
                                      // listOfDates = List<int>.generate(
                                      //     totalDays, (i) => i + 1);
                                      // todayDay = DateFormat('dd').format(now);
                                      // getWeekDates(now);
                                      // log(DateFormat('EEEE').format(now));
                                      // Get.back();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:  item.id ==
                                          syllabusStudentController.selectedClass
                                          ? Colors.white
                                          : Colors.transparent,
                                      radius: 22,
                                      child: Center(
                                        child: Container(
                                          width: 40,
                                          child: Center(
                                            child: Text(
                                                item.name.toString(),
                                              // item.name.toString().substring(0, 4),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                  item.id ==
                                                      syllabusStudentController.selectedClass
                                                      ? Colors.black
                                                      : Colors.white
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0).copyWith(left: 0,right: 10),
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //         color: index == selectedIndex
                                    //             ? Colors.white
                                    //             : Colors.transparent,
                                    //         shape: BoxShape.circle),
                                    //     child:
                                    //   ),
                                    // ),
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
              top: size.height*.25,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 12).copyWith(bottom: 0),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(45)),
                ),
                child: syllabusStudentController.isDataLoading.value
                    ? const CommonProgressIndicator()
                    : SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Teach by:',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  AppAssets.studentImg,
                                  height: 30,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Rosie David',
                                style: GoogleFonts.poppins(
                                    color: Colors.orange,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: Text(
                          'Syllabus',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      syllabusStudentController
                          .getSyllabusModel.value.data!.isNotEmpty
                                ? SizedBox(
                                    height: size.height,
                                    width: size.width,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: syllabusStudentController
                                          .getSyllabusModel.value.data!.length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var item = syllabusStudentController
                                            .getSyllabusModel
                                            .value
                                            .data![index];

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 22,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 43,
                                                  width: 45,
                                                  alignment: Alignment.center,
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              AppAssets
                                                                  .greenSquare))),
                                                  child: Center(
                                                    child: Text(
                                                      (index + 1).toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: AppThemes
                                                                  .white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    width: size.width,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            AppThemes.lightPink,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Text(
                                                      item.topic.toString(),
                                                      // 'Number Systems',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: AppThemes
                                                                  .blueColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    ))
                                : Container(
                        height: size.height * 0.45,
                                  child: Center(
                                      child: Text(
                                        "No syllabus available",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
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
