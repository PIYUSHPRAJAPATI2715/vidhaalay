import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/get_notification_controller.dart';
import 'package:vidhaalay_app/controller/teacher_controller/event_detail_controller.dart';
import 'package:vidhaalay_app/controller/teacher_controller/get_assignment_list_controller.dart';
import 'package:vidhaalay_app/repositories/calendar_repo.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/student_screen/assignment_details_screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/create_assignment_screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/update_assignment_screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/update_event_screen.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_dropdown.dart';
import 'package:vidhaalay_app/widgets/common_profile_image_widget.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class CalndarScreen extends StatefulWidget {
  const CalndarScreen({Key? key}) : super(key: key);

  @override
  State<CalndarScreen> createState() => _CalndarScreenState();
}

class _CalndarScreenState extends State<CalndarScreen> {
    final ScrollController _controller = ScrollController();

  List currentSessionYear = [];
  List<String> months = [
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
    "January",
    "February",
    "March",
  ];
  List daysInMonth = [];

  int selectedYear = 0;
  RxString month = "".obs;
  RxString monthName = "".obs;
  RxString day = "".obs;
  String selectedDate = '';

  int selectedDateIndex = 0;
  int selectedMonthIndex = 0;

  // int selectCorrectMonthIndex(int currentMonth) {
  //   if(currentMonth < 4) {
  //     return currentMonth + 9;
  //   } else {
  //     return currentMonth - 4;
  //   }
  // }

  // String selectMonthByIndex(int index) {
  //   if(index > 8) {
  //     selectedYear = currentSessionYear[1];
  //     return (index - 8).toString();
  //   } else {
  //     selectedYear = currentSessionYear[0];
  //     return (index + 4).toString();
  //   }
  // }

  // getMonthDays() {
  //   int numberOfDayInMonth = DateTime(selectedYear, int.parse(month.value) + 1, 0).day;
  //   print("numberOfDayInMonth: $numberOfDayInMonth");
  //
  //   daysInMonth = List<int>.generate(numberOfDayInMonth, (i) => i + 1);
  //   print("Number of days in June 2024: $daysInMonth");
  // }


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
  }

  @override
  void initState() {
    super.initState();
    selectedYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
    month.value = DateFormat('MM').format(DateTime.now());
    monthName.value = DateFormat('MMMM').format(DateTime.now());
    day.value = DateFormat('dd').format(DateTime.now());
    selecedDate();
    selectedMonthIndex = selectCorrectMonthIndex(int.parse(month.value) - 1);
    getCurrentSessionYear(selectedYear);
    daysInMonth =  getMonthDays(year: selectedYear,month: month.value);
    selectedDateIndex = int.parse(day.value) - 1;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      setState(() {});
      _controller.animateTo(
        selectedDateIndex * 45.0, // Adjust 110 according to your item size and spacing
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
        leading: IconButton(
          onPressed: () {
            Get.offAll(()=> CalndarScreen());
          },
          icon: Icon(Icons.back_hand,color: Colors.black),
        ),
        title: Text('Assignment Calender',
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
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    selectedMonthIndex = index;
                                    month.value = selectMonthByIndex(index).toString().padLeft(2, '0');
                                    selectedYear = selectYearByMonth(month: month.value, currentSessionYear: currentSessionYear);
                                    // print(month.value);
                                    daysInMonth = getMonthDays(year: selectedYear,month: month.value);
                                    if(daysInMonth.length <= int.parse(day.value) ) {
                                      day.value = 1.toString();
                                      selectedDateIndex = 0;
                                      _controller.animateTo(
                                        selectedDateIndex * 1.0, // Adjust 110 according to your item size and spacing
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
                        controller: _controller,
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
              )
          ),

          Positioned.fill(
            top: size.height*.250,
            child: Container(
              height: size.height*.250,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius:
                BorderRadius.only(topRight: Radius.circular(50)),
              ),
              child:  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(selectedDate,style: TextStyle(color: Colors.black)),
                    Text(currentSessionYear.toString(),style: TextStyle(color: Colors.black)),
                    TextButton(onPressed: () {
                      // selectedDateIndex = 31;
                      _controller.animateTo(
                        selectedDateIndex * 50.0, // Adjust 110 according to your item size and spacing
                        duration: Duration(milliseconds: 1800),
                        curve: Curves.easeInOut,
                      );
                    }, child: Text('scrool')
                    )
                  ],
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
