import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/student_controller/exam_result_student_controller.dart';
import 'package:vidhaalay_app/repositories/calendar_repo.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_dropdown.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class ExamResultScreen extends StatefulWidget {
  const ExamResultScreen({Key? key}) : super(key: key);

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen> {
  final examResultController = Get.put(ExamResultStudentController());
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
    // examResultController.getExamResultData();
  }

  @override
  void initState() {
    super.initState();
    examResultController.getExamTypeData();
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
        title: Text(
          'Result',
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
          Container(
              height: size.height * .260,
              decoration: const BoxDecoration(
                color: AppThemes.primaryColor,
                borderRadius:
                BorderRadius.only(bottomLeft: Radius.circular(70)),
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
              )),
          Positioned.fill(
            top: size.height * .260,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 12)
                  .copyWith(bottom: 0),
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppThemes.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                          () => examResultController.isExamTypeLoading.value
                          ? SizedBox.shrink()
                          : Container(
                        // transformAlignment: Alignment.center,
                        // width: size.width * .45,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: examResultController
                            .getExamTypeModel.value.data!.isEmpty
                            ? SizedBox.shrink()
                            : Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Type -',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              width: 5,
                            ),

                            CommonDropDownButton(
                              value: examResultController
                                  .selectedExamType?.value,
                              items: examResultController
                                  .getExamTypeModel.value.data!
                                  .toList()
                                  .map((items) {
                                return DropdownMenuItem(
                                  value: items.id,
                                  child: Text(
                                    items.name!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: examResultController
                                          .selectedExamType
                                          ?.value ==
                                          items.id
                                          ? Colors.black
                                      // Colors.grey.shade900 // Change the color for selected item
                                          : Colors
                                          .black, // Default color for unselected items
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                examResultController
                                    .selectedExamType!
                                    .value = newValue!;
                                print(examResultController
                                    .selectedExamType?.value);

                                examResultController
                                    .getExamResultData();
                              },
                              width: size.width * 0.55,
                              backgroundColor: Colors.white,
                            ),

                            // DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     value: examResultController
                            //         .selectedExamType?.value,
                            //     // icon: Icon(Icons.keyboard_arrow_down,color: Colors.white),
                            //     dropdownStyleData:
                            //     DropdownStyleData(
                            //       maxHeight: size.height * 0.28,
                            //       width: size.width * 0.55,
                            //       padding: EdgeInsets.symmetric(
                            //           horizontal: 5),
                            //       isOverButton: false,
                            //       decoration: BoxDecoration(
                            //         borderRadius:
                            //         BorderRadius.circular(14),
                            //         color: Colors.white,
                            //       ),
                            //       offset: const Offset(-10, 0),
                            //       scrollbarTheme:
                            //       ScrollbarThemeData(
                            //         radius:
                            //         const Radius.circular(40),
                            //         thickness: MaterialStateProperty
                            //             .all<double>(6),
                            //         thumbVisibility:
                            //         MaterialStateProperty.all<
                            //             bool>(true),
                            //       ),
                            //     ),
                            //     menuItemStyleData:
                            //     const MenuItemStyleData(
                            //       height: 45,
                            //       padding: EdgeInsets.only(
                            //           left: 10, right: 10),
                            //     ),
                            //     // dropdownColor: Colors.white70,
                            //     items: examResultController
                            //         .getExamTypeModel.value.data!
                            //         .toList()
                            //         .map((items) {
                            //       return DropdownMenuItem(
                            //         value: items.id,
                            //         child: Text(
                            //           items.name!,
                            //           style: TextStyle(
                            //             fontWeight: FontWeight.w500,
                            //             fontSize: 17,
                            //             color: examResultController
                            //                 .selectedExamType
                            //                 ?.value ==
                            //                 items.id
                            //                 ? Colors.black
                            //             // Colors.grey.shade900 // Change the color for selected item
                            //                 : Colors
                            //                 .black, // Default color for unselected items
                            //           ),
                            //         ),
                            //       );
                            //     }).toList(),
                            //     onChanged: (newValue) {
                            //       examResultController
                            //           .selectedExamType!
                            //           .value = newValue!;
                            //       print(examResultController
                            //           .selectedExamType?.value);
                            //
                            //       examResultController
                            //           .getExamResultData();
                            //     },
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),

                    Obx(
                      () => examResultController.isDataLoading.value ?  SizedBox(
                          height: size.height * 0.525,
                          child: Center(child: const CommonProgressIndicator())) : Container(
                        height: size.height * 0.525,
                        // color: Colors.amber,
                        child: examResultController.getExamResultModel.value.data!.isEmpty ? Center(
                          child: Text(
                            "No result Available",
                          ),
                        ): ListView.builder(
                          // shrinkWrap: true,
                          itemCount: examResultController.getExamResultModel.value.data!.length,
                          physics: const BouncingScrollPhysics(),
                          // padding: EdgeInsets.symmetric(vertical: 5),
                          itemBuilder: (context, index) {
                            var values = examResultController.getExamResultModel.value.data![index];


                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                       values.from!,
                                        // '16th Mar',
                                        style: GoogleFonts.poppins(
                                            color: AppThemes.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        width: size.width * .52,
                                        padding: const EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                            color: AppThemes.lightPink,
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              values.subjectName!,
                                              // 'Social Scien/ce Social Science Social Science Social Science Social Science',
                                              style: GoogleFonts.poppins(
                                                  color: AppThemes.blueColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              values.marks! + "/" + values.totalMarks.toString(),
                                              // '52/100',
                                              style: GoogleFonts.poppins(
                                                  color: AppThemes.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      int.parse(values.marks!) >=  values.passingMarks! ? Text(
                                        'Pass',
                                        style: GoogleFonts.poppins(
                                            color: Colors.green,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ) :
                                      Text(
                                        'Fail',
                                        style: GoogleFonts.poppins(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
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
      bottomNavigationBar:  Obx(
            () => examResultController.isDataLoading.value ||
                examResultController.getExamResultModel.value.data!.isEmpty
                ? SizedBox.shrink() :

            SizedBox(
          width: size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: size.width,
                height: 45,
                color: examResultController.getExamResultModel.value.pass! ? AppThemes.primaryColor : Colors.red,
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      examResultController.getExamResultModel.value.pass! ?  'You passed in exam' : 'You failed in exam',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
