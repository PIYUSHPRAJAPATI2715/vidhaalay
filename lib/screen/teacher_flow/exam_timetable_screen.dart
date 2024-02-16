import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/teacher_controller/exam_timetable_controller.dart';
import 'package:vidhaalay_app/repositories/calendar_repo.dart';
import 'package:vidhaalay_app/screen/teacher_flow/update_exam_timetable.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_dropdown.dart';
import 'package:vidhaalay_app/widgets/common_profile_image_widget.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';


class TeacherExamTimeTableScreen extends StatefulWidget {
  const TeacherExamTimeTableScreen({Key? key}) : super(key: key);

  @override
  State<TeacherExamTimeTableScreen> createState() => _TeacherExamTimeTableScreenState();
}

class _TeacherExamTimeTableScreenState extends State<TeacherExamTimeTableScreen> {

  final examTimeTableController = Get.put(ExamTimeTableController());
  final ScrollController _dateController = ScrollController();
  final ScrollController _monthController = ScrollController();
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
  
  @override
  void initState() {
    super.initState();
    examTimeTableController.getMyClass();
    examTimeTableController.getExamTypeData();
    selectedYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
    month.value = DateFormat('MM').format(DateTime.now());
    monthName.value = DateFormat('MMMM').format(DateTime.now());
    day.value = DateFormat('dd').format(DateTime.now());
    selecedDate();

    examTimeTableController.selectedMonthIndex.value = selectCorrectMonthIndex(int.parse(month.value) - 1);
    getCurrentSessionYear(selectedYear);
    daysInMonth =  getMonthDays(year: selectedYear,month: month.value);
    examTimeTableController.selectedIndex.value = int.parse(day.value) - 1;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      setState(() {});
      _dateController.animateTo(
        examTimeTableController.selectedIndex.value * 45.0, // Adjust 110 according to your item size and spacing
        duration: Duration(milliseconds: 1800),
        curve: Curves.easeInOut,
      );
      _monthController.animateTo(
        examTimeTableController.selectedMonthIndex.value * 65.0, // Adjust 110 according to your item size and spacing
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
    examTimeTableController.selectedDate = selectedYear.toString()+"-"+ month.value +"-"+ day.value;
    print("selecedDate : $examTimeTableController.selectedDate.value");
    examTimeTableController.getExamTimeTableData();
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
                height: size.height*.332,
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

                      examTimeTableController.isExamTypeLoading.value ? SizedBox.shrink()
                          : Container(
                        // transformAlignment: Alignment.center,
                        // width: size.width * .45,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: examTimeTableController.getExamTypeModel.value.data!.isEmpty ? SizedBox.shrink() : Row(
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
                              value:  examTimeTableController.selectedExamType?.value,
                              items: examTimeTableController.getExamTypeModel.value.data!.toList().map((items) {
                                return DropdownMenuItem(
                                  value: items.id,
                                  child: Text(items.name!,style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: examTimeTableController.selectedExamType?.value == items.id
                                        ? Colors.white
                                    // Colors.grey.shade900 // Change the color for selected item
                                        : Colors.black, // Default color for unselected items
                                  ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                examTimeTableController.selectedExamType!.value = newValue!;
                                print(examTimeTableController.selectedExamType?.value);

                                examTimeTableController.getExamTimeTableData();
                              },
                              width: size.width * 0.55,
                              backgroundColor: AppThemes.themeBackgroundColor,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        // transformAlignment: Alignment.center,
                        // width: size.width * .45,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: examTimeTableController.classList.value.isEmpty ? SizedBox.shrink() : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text('Class -',
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
                              value:  examTimeTableController.selectedClassId?.value,
                              items: examTimeTableController.classList.value.toList().map((items) {
                                return DropdownMenuItem(
                                  value: items.id,
                                  child: Text(items.name,style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: examTimeTableController.selectedClassId?.value == items.id
                                        ? Colors.white
                                    // Colors.grey.shade900 // Change the color for selected item
                                        : Colors.black, // Default color for unselected items
                                  ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                examTimeTableController.selectedClassId!.value = newValue!;
                                print(examTimeTableController.selectedClassId?.value);
                                examTimeTableController.getExamTimeTableData();
                              },
                              width: size.width * 0.3,
                              backgroundColor: AppThemes.themeBackgroundColor,
                            ),

                            // DropdownButtonHideUnderline(
                            //       child: DropdownButton2(
                            //         value:  examTimeTableController.selectedClassId?.value,
                            //         items: examTimeTableController.classList.value.toList().map((items) {
                            //           return DropdownMenuItem(
                            //             value: items.id,
                            //             child: Text(items.name,style: TextStyle(
                            //               fontWeight: FontWeight.w500,
                            //               fontSize: 17,
                            //               color: examTimeTableController.selectedClassId?.value == items.id
                            //                   ? Colors.white
                            //               // Colors.grey.shade900 // Change the color for selected item
                            //                   : Colors.black, // Default color for unselected items
                            //             ),
                            //             ),
                            //           );
                            //         }).toList(),
                            //         onChanged: (newValue) {
                            //           examTimeTableController.selectedClassId!.value = newValue!;
                            //           print(examTimeTableController.selectedClassId?.value);
                            //           examTimeTableController.getExamTimeTableData();
                            //         },
                            //         dropdownStyleData: DropdownStyleData(
                            //           maxHeight: size.height * 0.28,
                            //           width: size.width * 0.3,
                            //           padding: EdgeInsets.symmetric(horizontal: 5),
                            //           isOverButton: false,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(14),
                            //             color: Colors.white70,
                            //           ),
                            //           offset: const Offset(-10, 0),
                            //           scrollbarTheme: ScrollbarThemeData(
                            //             radius: const Radius.circular(40),
                            //             thickness: MaterialStateProperty.all<double>(6),
                            //             thumbVisibility: MaterialStateProperty.all<bool>(true),
                            //           ),
                            //         ),
                            //         menuItemStyleData: const MenuItemStyleData(
                            //           height: 45,
                            //           padding: EdgeInsets.only(left: 10, right: 10),
                            //         ),
                            //
                            //       ),
                            //     )
                          ],
                        ),
                      ),

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
                                      examTimeTableController.selectedMonthIndex.value = index;
                                      month.value = selectMonthByIndex(index).toString().padLeft(2, '0');
                                      selectedYear = selectYearByMonth(month: month.value, currentSessionYear: currentSessionYear);
                                      // print(month.value);
                                      daysInMonth = getMonthDays(year: selectedYear,month: month.value);
                                      if(daysInMonth.length <= int.parse(day.value) ) {
                                        day.value = 1.toString().padLeft(2, '0');
                                        examTimeTableController.selectedIndex.value = 0;
                                        _dateController.animateTo(
                                          examTimeTableController.selectedIndex.value * 1.0,
                                          duration: Duration(milliseconds: 1800),
                                          curve: Curves.easeInOut,
                                        );
                                      } else {
                                        _dateController.animateTo(
                                          examTimeTableController.selectedIndex.value * 45.0,
                                          duration: Duration(milliseconds: 1800),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                      selecedDate();

                                      setState(() {
                                      });
                                      // examTimeTableController.selectedMonthIndex.value =
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Center(
                                        child: Text(months[index].toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: index == examTimeTableController.selectedMonthIndex.value
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
                                    examTimeTableController.selectedIndex.value = index;
                                    day.value = (index + 1).toString().padLeft(2, '0');
                                    // print(examTimeTableController.selectedIndex.value);
                                    print(day.value);
                                    selecedDate();
                                    setState(() {

                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: index == examTimeTableController.selectedIndex.value
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
                                                  index == examTimeTableController.selectedIndex.value
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                            Text(
                                              daysInMonth[index].toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                  index == examTimeTableController.selectedIndex.value
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
              top: size.height*.332,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 12).copyWith(bottom: 0),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
                ),
                child: examTimeTableController.isDataLoading.value ? const CommonProgressIndicator() :  SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
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
                              Get.toNamed(MyRouters.createExamTimeTable);
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
                      // Text('today'.toUpperCase(),
                      //   style: GoogleFonts.poppins(
                      //       color: Colors.black,
                      //       fontSize: 19,
                      //       fontWeight: FontWeight.w600
                      //   ),),

                      examTimeTableController.getExamTimetableModel.value.data!.isEmpty ? Container(
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
                          itemCount: examTimeTableController.getExamTimetableModel.value.data!.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {

                            var value = examTimeTableController.getExamTimetableModel.value.data![index];

                            // DateTime timestampUtc = DateTime.parse(value.from!);
                            // String formattedHour = timestampUtc.hour.toString().padLeft(2, '0');
                            // String formattedMinute = timestampUtc.minute.toString().padLeft(2, '0');
                            // String fromTime = '$formattedHour:$formattedMinute';
                            // print("fromTime $fromTime");

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
                                  Container(
                                    width: size.width * .7,
                                    padding: const EdgeInsets.all(9),
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
                                              width: 8,
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
                                                    width: size.width * .37,
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
                                                    children: [
                                                      Container(
                                                        width: size.width * .17,
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
                                                            width: size.width * .15,
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

                                  Container(
                                    width: size.width * .22,
                                    // color: Colors.blue,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        Expanded(
                                          child: IconButton(onPressed: (){
                                            Get.to(() => UpdateExamTimeTable(id: value.id!.toString(),));
                                          },
                                              icon: const Icon(Icons.edit,size: 19,)),
                                        ),
                                        Expanded(
                                          child: IconButton(onPressed: (){
                                            examTimeTableController.deleteExamTimetableAPI(context,value.id!);
                                          },
                                              icon: const Icon(Icons.delete,color: Colors.red,size: 19,)),
                                        )
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
