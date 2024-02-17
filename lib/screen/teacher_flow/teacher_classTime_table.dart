import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/teacher_controller/class_time_controller.dart';
import 'package:vidhaalay_app/repositories/calendar_repo.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/teacher_flow/update_class_timeTable.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_dropdown.dart';
import 'package:vidhaalay_app/widgets/common_profile_image_widget.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class TeacherClassTimeScreen extends StatefulWidget {
  const TeacherClassTimeScreen({Key? key}) : super(key: key);

  @override
  State<TeacherClassTimeScreen> createState() => _TeacherClassTimeScreenState();
}

class _TeacherClassTimeScreenState extends State<TeacherClassTimeScreen> {

  final classTimeController = Get.put(ClassTimeController());
  final ScrollController _dateController = ScrollController();
  final ScrollController _monthController = ScrollController();
  List currentSessionYear = [];
  List<String> months =  CommonCalendar.monthsList;
  List daysInMonth = [];

  int selectedYear = 0;
  RxString month = "".obs;
  RxString monthName = "".obs;
  RxString day = "".obs;


  @override
  void initState() {
    super.initState();
    selectedYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
    month.value = DateFormat('MM').format(DateTime.now());
    monthName.value = DateFormat('MMMM').format(DateTime.now());
    day.value = DateFormat('dd').format(DateTime.now());
    selecedDate();
    classTimeController.getMyClass();

    classTimeController.selectedMonthIndex.value = selectCorrectMonthIndex(int.parse(month.value)) ;
    getCurrentSessionYear(selectedYear);
    daysInMonth =  getMonthDays(year: selectedYear,month: month.value);
    classTimeController.selectedIndex.value = int.parse(day.value) - 1;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      setState(() {});
      _dateController.animateTo(
        classTimeController.selectedIndex.value * 45.0, // Adjust 110 according to your item size and spacing
        duration: Duration(milliseconds: 1800),
        curve: Curves.easeInOut,
      );
      _monthController.animateTo(
        classTimeController.selectedMonthIndex.value * 65.0, // Adjust 110 according to your item size and spacing
        duration: Duration(milliseconds: 1800),
        curve: Curves.easeInOut,
      );
    });
  }

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
    classTimeController.selectedDate.value = selectedYear.toString()+"-"+ month.value +"-"+ day.value;
    print("selecedDate : $classTimeController.selectedDate.value");
    classTimeController.getTimeTableData();
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                height: size.height*.280,
                decoration: const BoxDecoration(
                  color: AppThemes.primaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                ),
                child:  Padding(
                  padding: EdgeInsets.all(size.width * .010),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      classTimeController.classList.value.isEmpty
                          ? SizedBox.shrink()
                          : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Class -',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CommonDropDownButton(
                              value: classTimeController
                                  .selectedClassId?.value,
                              items: classTimeController.classList.value
                                  .toList()
                                  .map((items) {
                                return DropdownMenuItem(
                                  value: items.id,
                                  child: Text(
                                    items.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: classTimeController
                                          .selectedClassId?.value ==
                                          items.id
                                          ? Colors.white
                                          : Colors.black,
                                      // color: classTimeController.selectedClassId?.value == items.id
                                      //     ? Colors.black
                                      //     : Colors.black, // Default color for unselected items
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                // print(newValue);
                                classTimeController
                                    .selectedClassId!.value = newValue!;
                                print(classTimeController
                                    .selectedClassId?.value);
                                classTimeController.getTimeTableData();

                                // classTimeController.getEventData(dateFormat : classTimeController.classTimeController.selectedDate.value.value, classId : classTimeController.selectedClassId.value);
                              },
                              width: size.width * 0.3,
                              backgroundColor: AppThemes.themeBackgroundColor,
                            ),
                          ]),

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
                                      classTimeController.selectedMonthIndex.value = index;
                                      month.value = selectMonthByIndex(index).toString().padLeft(2, '0');
                                      selectedYear = selectYearByMonth(month: month.value,);
                                      // print(month.value);
                                      daysInMonth = getMonthDays(year: selectedYear,month: month.value);
                                      if(daysInMonth.length <= int.parse(day.value) ) {
                                        day.value = 1.toString().padLeft(2, '0');
                                        classTimeController.selectedIndex.value = 0;
                                        _dateController.animateTo(
                                          classTimeController.selectedIndex.value * 1.0,
                                          duration: Duration(milliseconds: 1800),
                                          curve: Curves.easeInOut,
                                        );
                                      } else {
                                        _dateController.animateTo(
                                          classTimeController.selectedIndex.value * 45.0,
                                          duration: Duration(milliseconds: 1800),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                      selecedDate();

                                      setState(() {
                                      });
                                      // classTimeController.selectedMonthIndex.value =
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Center(
                                        child: Text(months[index].toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: index == classTimeController.selectedMonthIndex.value
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
                                    classTimeController.selectedIndex.value = index;
                                    day.value = (index + 1).toString().padLeft(2, '0');
                                    // print(classTimeController.selectedIndex.value);
                                    print(day.value);
                                    selecedDate();
                                    setState(() {

                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: index == classTimeController.selectedIndex.value
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
                                                  index == classTimeController.selectedIndex.value
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                            Text(
                                              daysInMonth[index].toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                  index == classTimeController.selectedIndex.value
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

            // Obx(
            //   () => Container(
            //       // height: 200,
            //       height: size.height*.280,
            //       decoration: const BoxDecoration(
            //         color: AppThemes.primaryColor,
            //         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
            //       ),
            //       child:  Padding(
            //         padding: EdgeInsets.all(size.width * .010),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(top: 5),
            //               child: Text(year.value.toString(),
            //                 style: GoogleFonts.poppins(
            //                     fontWeight: FontWeight.w500,
            //                     fontSize: 17,
            //                     color: Colors.white),
            //                 textAlign: TextAlign.center,
            //               ),
            //             ),
            //             Container(
            //               // transformAlignment: Alignment.center,
            //               // width: size.width * .45,
            //               padding: EdgeInsets.symmetric(horizontal: 15),
            //               decoration: BoxDecoration(
            //                 // color: Colors.white,
            //                   borderRadius: BorderRadius.circular(50)
            //               ),
            //               child: classTimeController.classList.value.isEmpty ? SizedBox.shrink() : Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   const SizedBox(
            //                     width: 10,
            //                   ),
            //                   Text('Class -',
            //                     style: GoogleFonts.poppins(
            //                       fontWeight: FontWeight.w500,
            //                       fontSize: 17,
            //                       color: Colors.white,),
            //                     textAlign: TextAlign.center,
            //                   ),
            //                   const SizedBox(
            //                     width: 5,
            //                   ),
            //
            //
            //                   CommonDropDownButton(
            //                     value:  classTimeController.selectedClassId?.value,
            //                     items: classTimeController.classList.value.toList().map((items) {
            //                       return DropdownMenuItem(
            //                         value: items.id,
            //                         child: Text(items.name,style: TextStyle(
            //                           fontWeight: FontWeight.w500,
            //                           fontSize: 17,
            //                           color: classTimeController.selectedClassId?.value == items.id
            //                               ? Colors.white
            //                           // Colors.grey.shade900 // Change the color for selected item
            //                               : Colors.black, // Default color for unselected items
            //                         ),
            //                         ),
            //                       );
            //                     }).toList(),
            //                     onChanged: (newValue) {
            //                       classTimeController.selectedClassId!.value = newValue!;
            //                       print(classTimeController.selectedClassId?.value);
            //                       classTimeController.getTimeTableData();
            //                     },
            //                     width: size.width * 0.3,
            //                     backgroundColor: AppThemes.themeBackgroundColor,
            //                   ),
            //
            //                   // DropdownButtonHideUnderline(
            //                   //   child: DropdownButton2(
            //                   //     value:  classTimeController.selectedClassId?.value,
            //                   //     // icon: Icon(Icons.keyboard_arrow_down,color: Colors.white),
            //                   //     dropdownStyleData: DropdownStyleData(
            //                   //       maxHeight: size.height * 0.28,
            //                   //       width: size.width * 0.3,
            //                   //       padding: EdgeInsets.symmetric(horizontal: 5),
            //                   //       isOverButton: false,
            //                   //       decoration: BoxDecoration(
            //                   //         borderRadius: BorderRadius.circular(14),
            //                   //         color: Colors.white70,
            //                   //       ),
            //                   //       offset: const Offset(-10, 0),
            //                   //       scrollbarTheme: ScrollbarThemeData(
            //                   //         radius: const Radius.circular(40),
            //                   //         thickness: MaterialStateProperty.all<double>(6),
            //                   //         thumbVisibility: MaterialStateProperty.all<bool>(true),
            //                   //       ),
            //                   //     ),
            //                   //     menuItemStyleData: const MenuItemStyleData(
            //                   //       height: 45,
            //                   //       padding: EdgeInsets.only(left: 10, right: 10),
            //                   //     ),
            //                   //     items: classTimeController.classList.value.toList().map((items) {
            //                   //       return DropdownMenuItem(
            //                   //         value: items.id,
            //                   //         child: Text(items.name,style: TextStyle(
            //                   //           fontWeight: FontWeight.w500,
            //                   //           fontSize: 17,
            //                   //           color: classTimeController.selectedClassId?.value == items.id
            //                   //               ? Colors.white
            //                   //           // Colors.grey.shade900 // Change the color for selected item
            //                   //               : Colors.black, // Default color for unselected items
            //                   //         ),
            //                   //         ),
            //                   //       );
            //                   //     }).toList(),
            //                   //     onChanged: (newValue) {
            //                   //       classTimeController.selectedClassId!.value = newValue!;
            //                   //       print(classTimeController.selectedClassId?.value);
            //                   //       classTimeController.getTimeTableData();
            //                   //     },
            //                   //   ),
            //                   // )
            //                 ],
            //               ),
            //             ),
            //
            //             Container(
            //               height: size.height*.050,
            //               decoration: BoxDecoration(
            //                 // color: Colors.amber,
            //                   borderRadius: BorderRadius.circular(10)),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Expanded(
            //                     child: ListView.builder(
            //                       scrollDirection: Axis.horizontal,
            //                       shrinkWrap: true,
            //                       itemCount: months.length,
            //                       itemBuilder:
            //                           (BuildContext context, int index) {
            //                         return InkWell(
            //                           onTap: () {
            //                             classTimeController.selectedMonthIndex.value = index;
            //                             month.value = "${index + 1}".length != 2
            //                                 ? "0${index + 1}"
            //                                 : "${index + 1}";
            //                             monthName.value = DateFormat('MMMM')
            //                                 .format(DateTime.parse(
            //                                 "${year.value}-${month.value}-${day.value}"));
            //                             now = DateTime.parse(
            //                                 "${year.value}-${month.value}-${day.value}");
            //                             totalDays = daysInMonth(now);
            //                             listOfDates = List<int>.generate(
            //                                 totalDays, (i) => i + 1);
            //                             todayDay = DateFormat('dd').format(now);
            //                             getWeekDates(now);
            //                             log(DateFormat('EEEE').format(now));
            //
            //                             String date = year.value+"-"+ month.value +"-"+ day.value;
            //                             log("date : $date");
            //                             classTimeController.selectedDate = date;
            //                             classTimeController.getTimeTableData();
            //                           },
            //                           child: Padding(
            //                             padding: const EdgeInsets.symmetric(
            //                                 horizontal: 10),
            //                             child: Center(
            //                               child: Text(months[index].toString(),
            //                                   style: GoogleFonts.poppins(
            //                                       fontWeight: FontWeight.w500,
            //                                       fontSize: 17,
            //                                       color: index == classTimeController.selectedMonthIndex.value
            //                                           ? Colors.white
            //                                           : Colors.black
            //                                   )
            //                               ),
            //                             ),
            //                           ),
            //                         );
            //                       },
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             SizedBox(
            //               height: size.height*.110,
            //               child: SingleChildScrollView(
            //                 scrollDirection: Axis.horizontal,
            //                 physics: BouncingScrollPhysics(),
            //                 child: Row(
            //                   children:
            //                   List.generate(weekDates.length, (index) {
            //                     DateTime date = weekDates[index];
            //                     String formattedDate =
            //                     DateFormat('d').format(date);
            //                     String formattedDate1 =
            //                     DateFormat('MM').format(date);
            //                     String formattedDate2 =
            //                     DateFormat('yyyy').format(date);
            //                     String weekDay =
            //                     DateFormat('EEEE').format(date);
            //                     return Padding(
            //                       key: keysList[index],
            //                       padding: EdgeInsets.only(right: 0, left: 0),
            //                       child: GestureDetector(
            //                         onTap: () {
            //                           setState(() {
            //                             classTimeController.selectedIndex.value = index;
            //                             print("classTimeController.selectedIndex.value : $classTimeController.selectedIndex.value");
            //
            //                             day.value = formattedDate.length != 2
            //                                 ? "0$formattedDate"
            //                                 : formattedDate;
            //                             // month.value = formattedDate1.length != 2 ? "0$formattedDate1" : formattedDate1;
            //                             // year.value = formattedDate2;
            //                             log(day.value);
            //                             log(month.value);
            //                             log(year.value);
            //
            //                             monthName.value = DateFormat('MMMM')
            //                                 .format(DateTime.parse(
            //                                 "${year.value}-${month.value}-${day.value}"));
            //
            //                             String date = year.value+"-"+ month.value +"-"+ day.value;
            //                             log(date);
            //                             classTimeController.selectedDate = date;
            //
            //                             classTimeController.getTimeTableData();
            //                           });
            //                         },
            //                         child: Padding(
            //                           padding: const EdgeInsets.all(8.0),
            //                           child: Container(
            //                             decoration: BoxDecoration(
            //                                 color: index == classTimeController.selectedIndex.value
            //                                     ? Colors.white
            //                                     : Colors.transparent,
            //                                 borderRadius:
            //                                 BorderRadius.circular(20)),
            //                             child: Padding(
            //                               padding: const EdgeInsets.all(12.0),
            //                               child: Column(
            //                                 children: [
            //                                   Text(
            //                                     weekDay[0].toString(),
            //                                     style: TextStyle(
            //                                         fontSize: 16,
            //                                         fontWeight: FontWeight.w600,
            //                                         color:
            //                                         index == classTimeController.selectedIndex.value
            //                                             ? Colors.black
            //                                             : Colors.white),
            //                                   ),
            //                                   Text(
            //                                     formattedDate,
            //                                     style: TextStyle(
            //                                         fontSize: 16,
            //                                         fontWeight: FontWeight.w600,
            //                                         color:
            //                                         index == classTimeController.selectedIndex.value
            //                                             ? Colors.black
            //                                             : Colors.white),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     );
            //                   }),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       )
            //   ),
            // ),

            Positioned.fill(
              top: size.height*.280,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 12).copyWith(bottom: 0),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
                ),
                child: Obx(() {
                  return  !classTimeController.isDataLoading.value ?
                  SingleChildScrollView(
                    // physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('today'.toUpperCase(),
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600
                              ),),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(MyRouters.createTimeTableScreen);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                decoration: BoxDecoration(
                                    color:                   AppThemes.primaryColor,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  children: [
                                    Text('add'.toUpperCase(),
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    Icon(
                                      Icons.add,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                        classTimeController.getTimetableModel.value.data!.isEmpty ?
                        SizedBox(
                            height: size.height * 0.5,
                            child: Center(child: Text('No time table available')
                            )
                        )
                            : SizedBox(
                          height: size.height,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: classTimeController.getTimetableModel.value.data!.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var value = classTimeController.getTimetableModel.value.data![index] ;
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
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Text(
                                              // '08 AM',
                                              value.fromTime!.toString(),
                                              style: GoogleFonts.poppins(
                                                  color: AppThemes.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600
                                              ),),
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
                                        flex: 7,
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
                                                // 'Social Science Social Scienc Social Scienc Social Scienc',
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
                                                  //     width: 13,
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
                                                    width: size.width*.345,
                                                    // color: Colors.green,
                                                  child: Text(
                                                      // "Test test test test test test test",
                                                      value.teacher!.name.toString(),
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
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(onPressed: () {
                                          Get.to(() => UpdateClassTimeTableScreen(id: value.id.toString(),));
                                        },
                                            icon: const Icon(Icons.edit,size: 19,)),
                                      ),
                                      Expanded(
                                        child: IconButton(onPressed: (){
                                          classTimeController.deleteTimetableAPI(context,value.id!);
                                        },
                                            icon: const Icon(Icons.delete,color: Colors.red,size: 19,)),
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
                  )
                      :  const CommonProgressIndicator();
                }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
