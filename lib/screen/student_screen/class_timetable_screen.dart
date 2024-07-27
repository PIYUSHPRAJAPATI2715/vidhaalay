import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay/controller/student_controller/student_class_timetable_controller.dart';
import 'package:vidhaalay/controller/teacher_controller/class_time_controller.dart';
import 'package:vidhaalay/repositories/calendar_repo.dart';
import 'package:vidhaalay/routers/my_routers.dart';
import 'package:vidhaalay/screen/teacher_flow/update_class_timeTable.dart';
import 'package:vidhaalay/widgets/circular_progressindicator.dart';
import 'package:vidhaalay/widgets/common_profile_image_widget.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay/resourses/app_assets.dart';


class ClassTimeTableScreen extends StatefulWidget {
  const ClassTimeTableScreen({Key? key}) : super(key: key);

  @override
  State<ClassTimeTableScreen> createState() => _ClassTimeTableScreenState();
}

class _ClassTimeTableScreenState extends State<ClassTimeTableScreen> {
  
  final studentClassTimeController = Get.put(StudentClassTimeController());
  final ScrollController _dateController = ScrollController();
  final ScrollController _monthController = ScrollController();
  List currentSessionYear = CommonCalendar.currentSessionYear;
  List<String> months =  CommonCalendar.monthsList;
  RxString month = "".obs;
  RxString monthName = "".obs;
  RxString day = "".obs;

  selecedDate() {
    studentClassTimeController.selectedDate.value = studentClassTimeController.selectedYear.value.toString()+"-"+ month.value +"-"+ day.value;
    print("selecedDate : ${studentClassTimeController.selectedDate.value}");
    studentClassTimeController.getTimeTableData();
  }
  
  @override
  void initState() {
    super.initState();
    month.value = DateFormat('MM').format(DateTime.now());
    monthName.value = DateFormat('MMMM').format(DateTime.now());
    day.value = DateFormat('dd').format(DateTime.now());
    studentClassTimeController.selectedMonthIndex.value = selectCorrectMonthIndex(int.parse(month.value));
    studentClassTimeController.selectedYear.value = selectYearByMonth(month: month.value);
    studentClassTimeController.daysInMonth.value =  getMonthDays(year: studentClassTimeController.selectedYear.value,month: month.value);
    studentClassTimeController.selectedIndex.value = int.parse(day.value) - 1;
    selecedDate();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      setState(() {});
      _dateController.animateTo(
        studentClassTimeController.selectedIndex.value * 45.0, // Adjust 110 according to your item size and spacing
        duration: Duration(milliseconds: 1800),
        curve: Curves.easeInOut,
      );
      _monthController.animateTo(
        studentClassTimeController.selectedMonthIndex.value * 65.0, // Adjust 110 according to your item size and spacing
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

          Obx(
                () => Container(
              // height: 200,
                height: size.height*.21,
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
                                      color: studentClassTimeController.selectedYear.value == currentSessionYear[0] ? Colors.white : Colors.black
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
                                      color: studentClassTimeController.selectedYear.value == currentSessionYear[1] ? Colors.white : Colors.black
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
                                      studentClassTimeController.selectedMonthIndex.value = index;
                                      month.value = selectMonthByIndex(index).toString().padLeft(2, '0');
                                      studentClassTimeController.selectedYear.value = selectYearByMonth(month: month.value);
                                      studentClassTimeController.daysInMonth.value = getMonthDays(year: studentClassTimeController.selectedYear.value,month: month.value);
                                      if(studentClassTimeController.daysInMonth.value.length <= int.parse(day.value) ) {
                                        day.value = 1.toString().padLeft(2, '0');
                                        studentClassTimeController.selectedIndex.value = 0;
                                        _dateController.animateTo(
                                          studentClassTimeController.selectedIndex.value * 1.0,
                                          duration: Duration(milliseconds: 1800),
                                          curve: Curves.easeInOut,
                                        );
                                      } else {
                                        _dateController.animateTo(
                                          studentClassTimeController.selectedIndex.value * 45.0,
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
                                                color: index == studentClassTimeController.selectedMonthIndex.value
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
                        height: size.height*.085,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          controller: _dateController,
                          child: Row(
                            children: List.generate(studentClassTimeController.daysInMonth.value.length, (index) {

                              DateTime specifiedDate = DateTime(2024, int.parse(month.value), studentClassTimeController.daysInMonth.value[index]);
                              String dayName = DateFormat('EEEE').format(specifiedDate).substring(0, 1);
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    studentClassTimeController.selectedIndex.value = index;
                                    day.value = (index + 1).toString().padLeft(2, '0');
                                    // print(studentClassTimeController.selectedIndex.value);
                                    print(day.value);
                                    selecedDate();
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    height: size.height*.08,
                                    decoration: BoxDecoration(
                                        color: index == studentClassTimeController.selectedIndex.value
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
                                                index == studentClassTimeController.selectedIndex.value
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                          Text(
                                            studentClassTimeController.daysInMonth.value[index].toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                index == studentClassTimeController.selectedIndex.value
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
          ),

          Positioned.fill(
            top: size.height*.21,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 12).copyWith(bottom: 0),
              height: size.height * 0.4,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppThemes.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
              ),
              child: Obx(() {
                return  !studentClassTimeController.isDataLoading.value ?
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CommonCalendar.currentDate == studentClassTimeController.selectedDate.value
                            ?  'today'.toUpperCase() :
                        CommonCalendar.yesterdayDate == studentClassTimeController.selectedDate.value ?
                        'yesterday'.toUpperCase() :
                        CommonCalendar.tommorrowdayDate == studentClassTimeController.selectedDate.value ?
                        'tommorrow'.toUpperCase() : studentClassTimeController.selectedDate.value,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),),

                      studentClassTimeController.getTimetableModel.value.data!.isEmpty ?
                      SizedBox(
                          height: size.height * 0.5,
                          child: Center(child: Text('No time table available')
                          )
                      )
                          : Container(
                        height: size.height,
                        width: size.width,
                        // color: Colors.black,

                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: studentClassTimeController.getTimetableModel.value.data!.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var value = studentClassTimeController.getTimetableModel.value.data![index] ;
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
                                      child: Column(
                                        children: [
                                          Text(
                                            // '08 AM',
                                            value.fromTime!.toString(),
                                            style: GoogleFonts.poppins(
                                                color: AppThemes.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          // Text(
                                          //   // '08 AM',
                                          //   value.toTime!.toString(),
                                          //   style: GoogleFonts.poppins(
                                          //       color: AppThemes.black,
                                          //       fontSize: 14,
                                          //       fontWeight: FontWeight.w600
                                          //   ),),
                                        ],
                                      ),
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
                                              value.subject!.name.toString(),
                                              // "Test test test  test test test testvtest test test test",
                                              style: GoogleFonts.poppins(
                                                  color: AppThemes.blueColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                // ClipOval(
                                                //   child: Image.asset(
                                                //     AppAssets.studentImg,
                                                //     width: 13,
                                                //   ),
                                                // ),
                                                commonProfileImageCircle(
                                                  context: context,
                                                  isProfileImageLoading: value.teacher == null,
                                                  isProfileExist: value.teacher!.profileImage != null,
                                                  image: value.teacher!.profileImage.toString(),
                                                  radius: 8,
                                                  // classData.teacher.profileImage
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'By : ',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.grey,
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                                Container(
                                                  width: size.width * .52,
                                                  // color: Colors.amber,
                                                  child: Text(
                                                    // "Test test test  test test test testvtest test test test",
                                                    value.teacher!.name.toString(),
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
                                      ),
                                    ),
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
