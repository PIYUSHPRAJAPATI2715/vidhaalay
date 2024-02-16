import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/student_controller/exam_time_table_controller.dart';
import 'package:vidhaalay_app/repositories/calendar_repo.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/teacher_flow/update_exam_timetable.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_dropdown.dart';
import 'package:vidhaalay_app/widgets/common_profile_image_widget.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';


class ExamTimeTableScreen extends StatefulWidget {
  const ExamTimeTableScreen({Key? key}) : super(key: key);

  @override
  State<ExamTimeTableScreen> createState() => _ExamTimeTableScreenState();
}

class _ExamTimeTableScreenState extends State<ExamTimeTableScreen> {
  final ScrollController _dateController = ScrollController();
  final ScrollController _monthController = ScrollController();

  final studentExamTimeTableController = Get.put(StudentExamTimeTableController());
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

  getCurrentSessionYear(int currentYear) {
    currentSessionYear.clear();
    int currentMonth = int.parse(month.value);
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
    studentExamTimeTableController.selectedDate = selectedDate;
    studentExamTimeTableController.getExamTimeTableData();
  }

  @override
  void initState() {
    super.initState();
    selectedYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
    month.value = DateFormat('MM').format(DateTime.now());
    monthName.value = DateFormat('MMMM').format(DateTime.now());
    day.value = DateFormat('dd').format(DateTime.now());
    selecedDate();
    studentExamTimeTableController.getExamTypeData();
    selectedMonthIndex = selectCorrectMonthIndex(int.parse(month.value) - 1);
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Timetable',
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
              // height: 200,
                height: size.height*.280,
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
                      studentExamTimeTableController.isExamTypeLoading.value ? SizedBox.shrink()
                          : Container(
                        // transformAlignment: Alignment.center,
                        // width: size.width * .45,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: studentExamTimeTableController.getExamTypeModel.value.data!.isEmpty ? SizedBox.shrink() : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text('Type -',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white,),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              width: 5,
                            ),

                            CommonDropDownButton(
                              items: studentExamTimeTableController.getExamTypeModel.value.data!.toList().map((items) {
                              return DropdownMenuItem(
                                value: items.id,
                                child: Text(items.name!,style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: studentExamTimeTableController.selectedExamType?.value == items.id
                                      ? Colors.white
                                  // Colors.grey.shade900 // Change the color for selected item
                                      : Colors.black, // Default color for unselected items
                                ),
                                ),
                              );
                            }).toList(),
                              value:  studentExamTimeTableController.selectedExamType?.value,
                              onChanged: (newValue) {
                                studentExamTimeTableController.selectedExamType!.value = newValue!;
                                print(studentExamTimeTableController.selectedExamType?.value);

                                studentExamTimeTableController.getExamTimeTableData();
                              },
                              width: size.width * 0.55,
                              backgroundColor: AppThemes.themeBackgroundColor,
                            ),

                            // DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     value:  studentExamTimeTableController.selectedExamType?.value,
                            //     // icon: Icon(Icons.keyboard_arrow_down,color: Colors.white),
                            //     dropdownStyleData: DropdownStyleData(
                            //       maxHeight: size.height * 0.28,
                            //       width: size.width * 0.55,
                            //       padding: EdgeInsets.symmetric(horizontal: 5),
                            //       isOverButton: false,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(14),
                            //         color: Colors.white70,
                            //       ),
                            //       offset: const Offset(-10, 0),
                            //       scrollbarTheme: ScrollbarThemeData(
                            //         radius: const Radius.circular(40),
                            //         thickness: MaterialStateProperty.all<double>(6),
                            //         thumbVisibility: MaterialStateProperty.all<bool>(true),
                            //       ),
                            //     ),
                            //     menuItemStyleData: const MenuItemStyleData(
                            //       height: 45,
                            //       padding: EdgeInsets.only(left: 10, right: 10),
                            //     ),
                            //     // dropdownColor: Colors.white70,
                            //     items: studentExamTimeTableController.getExamTypeModel.value.data!.toList().map((items) {
                            //       return DropdownMenuItem(
                            //         value: items.id,
                            //         child: Text(items.name!,style: TextStyle(
                            //           fontWeight: FontWeight.w500,
                            //           fontSize: 17,
                            //           color: studentExamTimeTableController.selectedExamType?.value == items.id
                            //               ? Colors.white
                            //           // Colors.grey.shade900 // Change the color for selected item
                            //               : Colors.black, // Default color for unselected items
                            //         ),
                            //         ),
                            //       );
                            //     }).toList(),
                            //     onChanged: (newValue) {
                            //       studentExamTimeTableController.selectedExamType!.value = newValue!;
                            //       print(studentExamTimeTableController.selectedExamType?.value);
                            //
                            //       studentExamTimeTableController.getExamTimeTableData();
                            //     },
                            //   ),
                            // )
                          ],
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
                                controller: _monthController,
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
                )
            ),

            Positioned.fill(
              top: size.height*.280,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25).copyWith(bottom: 0),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
                ),
                child: !studentExamTimeTableController.isDataLoading.value ? SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text('today'.toUpperCase(),
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w600
                          ),),
                      ),

                      studentExamTimeTableController.getExamTimetableModel.value.data!.isEmpty ? Container(
                        height: size.height * .4,
                        // color: Colors.red,
                        child: Center(
                          child: Text("No exam time table available"),
                        ),
                      ) : SizedBox(
                        height: size.height,
                        width: size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: studentExamTimeTableController.getExamTimetableModel.value.data!.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {

                            var value = studentExamTimeTableController.getExamTimetableModel.value.data![index];

                            // DateTime timestampUtc = DateTime.parse(value.from!);
                            // String formattedHour = timestampUtc.hour.toString().padLeft(2, '0');
                            // String formattedMinute = timestampUtc.minute.toString().padLeft(2, '0');
                            // String fromTime = '$formattedHour:$formattedMinute';
                            // print("fromTime $fromTime");
                            //
                            // DateTime timestampUtc1 = DateTime.parse(value.to!);
                            // String formattedHour1 = timestampUtc1.hour.toString().padLeft(2, '0');
                            // String formattedMinute1 = timestampUtc1.minute.toString().padLeft(2, '0');
                            // String toTime = '$formattedHour1:$formattedMinute1';
                            // print("toTime $toTime");

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Container(
                                  //   width: size.width * .9,
                                  //   padding: const EdgeInsets.all(9),
                                  //   decoration: BoxDecoration(
                                  //       color: AppThemes.lightGreyColor,
                                  //       borderRadius: BorderRadius.circular(8)
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //       Row(
                                  //         crossAxisAlignment: CrossAxisAlignment.start,
                                  //         children: [
                                  //           Column(
                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                  //             mainAxisAlignment: MainAxisAlignment.start,
                                  //             children: [
                                  //               Text(
                                  //                 fromTime,
                                  //                 // '08: AM',
                                  //                 style: GoogleFonts.poppins(
                                  //                     color: AppThemes.black,
                                  //                     fontSize: 14,
                                  //                     fontWeight: FontWeight.w600
                                  //                 ),
                                  //               ),
                                  //               Text(
                                  //                 // '09: AM',
                                  //                 toTime,
                                  //                 style: GoogleFonts.poppins(
                                  //                     color: AppThemes.black,
                                  //                     fontSize: 14,
                                  //                     fontWeight: FontWeight.w600
                                  //                 ),),
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             width: 10,
                                  //             height: size.height * .055,
                                  //             child:  VerticalDivider(
                                  //               thickness: 1,
                                  //               color: AppThemes.black,
                                  //             ),
                                  //           ),
                                  //           Container(
                                  //             // color: Colors.green,
                                  //             // width: size.width * .47,
                                  //             child: Column(
                                  //               crossAxisAlignment: CrossAxisAlignment.start,
                                  //               mainAxisAlignment: MainAxisAlignment.start,
                                  //               children: [
                                  //                 Text(
                                  //                   value.subject!.name!,
                                  //
                                  //                   // 'Social Science',
                                  //                   style: GoogleFonts.poppins(
                                  //                       color: AppThemes.blueColor,
                                  //                       fontSize: 14,
                                  //                       fontWeight: FontWeight.w600
                                  //                   ),
                                  //                   maxLines: 1,
                                  //                   overflow: TextOverflow.ellipsis,
                                  //                 ),
                                  //                 const SizedBox(
                                  //                   height: 5,
                                  //                 ),
                                  //                 Row(
                                  //                   children: [
                                  //                     Text('Class A-1',
                                  //                       style: GoogleFonts.poppins(
                                  //                           color: AppThemes.textGray,
                                  //                           fontSize: 10,
                                  //                           fontWeight: FontWeight.w500
                                  //                       ),),
                                  //
                                  //                     Padding(
                                  //                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  //                       child: const SizedBox(
                                  //                         height: 20,
                                  //                         child: VerticalDivider(
                                  //                           width: 1,
                                  //                           color: Colors.grey,
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //
                                  //                     Row(
                                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                                  //                       mainAxisAlignment: MainAxisAlignment.start,
                                  //                       children: [
                                  //                         ClipOval(
                                  //                           child: Image.asset(
                                  //                             AppAssets.studentImg,
                                  //                             width: 15,
                                  //                           ),
                                  //                         ),
                                  //                         const SizedBox(
                                  //                           width: 5,
                                  //                         ),
                                  //                         Text(
                                  //                           'By : ',
                                  //                           style: GoogleFonts.poppins(
                                  //                               color: Colors.grey,
                                  //                               fontSize: 12.0,
                                  //                               fontWeight: FontWeight.w500
                                  //                           ),
                                  //                         ),
                                  //                         Container(
                                  //                           width: size.width * .4,
                                  //                           // color: Colors.amber,
                                  //                           child: Text(
                                  //                             value.teacher!.name!,
                                  //                             // 'Rosie David',
                                  //                             style:  GoogleFonts.poppins(
                                  //                                 color: Colors.black,
                                  //                                 fontSize: 12.0,
                                  //                                 fontWeight: FontWeight.w500
                                  //                             ),
                                  //                             maxLines: 1,
                                  //                             overflow: TextOverflow.ellipsis,
                                  //                           ),
                                  //                         ),
                                  //                       ],
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //
                                  //     ],
                                  //   ),
                                  // ),
                                  Container(
                                    width: size.width,
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 9),
                                    decoration: BoxDecoration(
                                        color: AppThemes.lightGreyColor,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width * .16,
                                              // color: Colors.amber,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    value.from.toString(),
                                                    // '08: AM',
                                                    style: GoogleFonts.poppins(
                                                        color: AppThemes.black,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    // '09: AM',
                                                    value.to.toString(),
                                                    style: GoogleFonts.poppins(
                                                        color: AppThemes.black,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                              height: size.height * .05,
                                              child:  VerticalDivider(
                                                thickness: 1,
                                                color: AppThemes.black,
                                              ),
                                            ),
                                            Container(
                                              // color: Colors.green,
                                              // width: size.width * .47,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // color: Colors.green,
                                                    width: size.width * .72,
                                                    child: Text(
                                                      value.subject!.name!,
                                                      // 'Social Science Social Science Social Science Social Science Social Science',
                                                      style: GoogleFonts.poppins(
                                                          color: AppThemes.blueColor,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: size.width * .28,
                                                        // color: Colors.amber,
                                                        child: Text(
                                                          'Class - ' + value.seatClass!.name!,
                                                          style: GoogleFonts.poppins(
                                                              color: AppThemes.textGray,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w500
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                                        child: const SizedBox(
                                                          height: 20,
                                                          child: VerticalDivider(
                                                            width: 1,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),

                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          commonProfileImageCircle(
                                                            context: context,
                                                            isProfileImageLoading: value.teacher == null,
                                                            isProfileExist: value.teacher!.profileImage != null,
                                                            image: value.teacher!.profileImage.toString(),
                                                            radius: 8,
                                                            // classData.teacher.profileImage
                                                          ),
                                                          // ClipOval(
                                                          //   child: Image.asset(
                                                          //     AppAssets.studentImg,
                                                          //     width: 15,
                                                          //   ),
                                                          // ),
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
                                                            width: size.width * .24,
                                                            // color: Colors.amber,
                                                            child: Text(
                                                              value.teacher!.name!,
                                                              // 'Rosie David',
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
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ) : const CommonProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
