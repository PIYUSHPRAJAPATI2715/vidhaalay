import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay/controller/student_controller/exam_time_table_controller.dart';
import 'package:vidhaalay/repositories/calendar_repo.dart';
import 'package:vidhaalay/routers/my_routers.dart';
import 'package:vidhaalay/screen/teacher_flow/update_exam_timetable.dart';
import 'package:vidhaalay/widgets/circular_progressindicator.dart';
import 'package:vidhaalay/widgets/common_dropdown.dart';
import 'package:vidhaalay/widgets/common_profile_image_widget.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay/resourses/app_assets.dart';


class ExamTimeTableScreen extends StatefulWidget {
  const ExamTimeTableScreen({Key? key}) : super(key: key);

  @override
  State<ExamTimeTableScreen> createState() => _ExamTimeTableScreenState();
}

class _ExamTimeTableScreenState extends State<ExamTimeTableScreen> {

  final studentExamTimeTableController = Get.put(StudentExamTimeTableController());
  List<int> yearList = CommonCalendar.yearsList;

  @override
  void initState() {
    super.initState();
    studentExamTimeTableController.getExamTypeData();
    studentExamTimeTableController.selectedYear.value = int.parse(DateFormat('yyyy').format(DateTime.now()));
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
      body:

      // Obx(
      //       () => !studentExamTimeTableController.isDataLoading.value ? SingleChildScrollView(
      //         physics: NeverScrollableScrollPhysics(),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             studentExamTimeTableController.isExamTypeLoading.value ? SizedBox.shrink()
      //                 : Container(
      //               child: studentExamTimeTableController.getExamTypeModel.value.data!.isEmpty ? SizedBox.shrink() : Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   const SizedBox(
      //                     width: 10,
      //                   ),
      //                   Text('Type -',
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
      //                   Center(
      //                     child: CommonDropDownButton(
      //                       items: studentExamTimeTableController.getExamTypeModel.value.data!.toList().map((items) {
      //                         return DropdownMenuItem(
      //                           value: items.id,
      //                           child: Text(items.name!,style: TextStyle(
      //                             fontWeight: FontWeight.w500,
      //                             fontSize: 17,
      //                             color: studentExamTimeTableController.selectedExamType?.value == items.id
      //                                 ? Colors.black
      //                                 :Colors.black
      //                           ),
      //                           ),
      //                         );
      //                       }).toList(),
      //                       value:  studentExamTimeTableController.selectedExamType?.value,
      //                       onChanged: (newValue) {
      //                         studentExamTimeTableController.selectedExamType!.value = newValue!;
      //                         print(studentExamTimeTableController.selectedExamType?.value);
      //
      //                         studentExamTimeTableController.getExamTimeTableData();
      //                       },
      //                       width: size.width * 0.55,
      //                       backgroundColor: AppThemes.themeBackgroundColor,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //
      //             studentExamTimeTableController.getExamTimetableModel.value.data!.isEmpty ? Container(
      //               height: size.height * .8,
      //               // color: Colors.red,
      //               child: Center(
      //                 child: Text("No exam time table available"),
      //               ),
      //             ) : SizedBox(
      //               height: size.height,
      //               width: size.width,
      //               child: ListView.builder(
      //                 shrinkWrap: true,
      //                 itemCount: studentExamTimeTableController.getExamTimetableModel.value.data!.length,
      //                 physics: const BouncingScrollPhysics(),
      //                 itemBuilder: (context, index) {
      //
      //                   var value = studentExamTimeTableController.getExamTimetableModel.value.data![index];
      //                   return Padding(
      //                     padding: const EdgeInsets.symmetric(vertical: 8.0),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Container(
      //                           width: size.width,
      //                           padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 9),
      //                           decoration: BoxDecoration(
      //                               color: AppThemes.lightGreyColor,
      //                               borderRadius: BorderRadius.circular(8)
      //                           ),
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Row(
      //                                 crossAxisAlignment: CrossAxisAlignment.start,
      //                                 children: [
      //                                   Container(
      //                                     width: size.width * .19,
      //                                     // color: Colors.amber,
      //                                     child: Column(
      //                                       crossAxisAlignment: CrossAxisAlignment.start,
      //                                       mainAxisAlignment: MainAxisAlignment.start,
      //                                       children: [
      //                                         Text(
      //                                           value.from.toString(),
      //                                           // '08: AM',
      //                                           style: GoogleFonts.poppins(
      //                                               color: AppThemes.black,
      //                                               fontSize: 14,
      //                                               fontWeight: FontWeight.w600
      //                                           ),
      //                                           maxLines: 1,
      //                                           overflow: TextOverflow.ellipsis,
      //                                         ),
      //                                         Text(
      //                                           // '09: AM',
      //                                           value.to.toString(),
      //                                           style: GoogleFonts.poppins(
      //                                               color: AppThemes.black,
      //                                               fontSize: 14,
      //                                               fontWeight: FontWeight.w600
      //                                           ),
      //                                           maxLines: 1,
      //                                           overflow: TextOverflow.ellipsis,
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                   SizedBox(
      //                                     width: 10,
      //                                     height: size.height * .05,
      //                                     child:  VerticalDivider(
      //                                       thickness: 1,
      //                                       color: AppThemes.black,
      //                                     ),
      //                                   ),
      //                                   Container(
      //                                     // color: Colors.green,
      //                                     width: size.width * .69,
      //                                     child: Column(
      //                                       crossAxisAlignment: CrossAxisAlignment.start,
      //                                       mainAxisAlignment: MainAxisAlignment.start,
      //                                       children: [
      //                                         Container(
      //                                           // color: Colors.green,
      //                                           width: size.width * .7,
      //                                           child: Text(
      //                                             value.subject!.name!,
      //                                             // 'Social Science Social Science Social Science Social Science Social Science',
      //                                             style: GoogleFonts.poppins(
      //                                                 color: AppThemes.blueColor,
      //                                                 fontSize: 14,
      //                                                 fontWeight: FontWeight.w600
      //                                             ),
      //                                             maxLines: 1,
      //                                             overflow: TextOverflow.ellipsis,
      //                                           ),
      //                                         ),
      //                                         const SizedBox(
      //                                           height: 5,
      //                                         ),
      //                                         Row(
      //                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                                           children: [
      //                                             Container(
      //                                               width: size.width * .3,
      //                                               // color: Colors.amber,
      //                                               child: Text(
      //                                                 'Class - ' + value.seatClass!.name!,
      //                                                 // 'Class - ' + value.seatClass!.name!,
      //                                                 style: GoogleFonts.poppins(
      //                                                     color: AppThemes.textGray,
      //                                                     fontSize: 10,
      //                                                     fontWeight: FontWeight.w500
      //                                                 ),
      //                                                 maxLines: 1,
      //                                                 overflow: TextOverflow.ellipsis,
      //                                               ),
      //                                             ),
      //
      //                                             Row(
      //                                               crossAxisAlignment: CrossAxisAlignment.start,
      //                                               mainAxisAlignment: MainAxisAlignment.start,
      //                                               children: [
      //                                                 Padding(
      //                                                   padding: EdgeInsets.symmetric(horizontal: 3.0),
      //                                                   child: const SizedBox(
      //                                                     height: 20,
      //                                                     child: VerticalDivider(
      //                                                       width: 1,
      //                                                       color: Colors.grey,
      //                                                     ),
      //                                                   ),
      //                                                 ),
      //
      //                                                 commonProfileImageCircle(
      //                                                   context: context,
      //                                                   isProfileImageLoading: value.teacher == null,
      //                                                   isProfileExist: value.teacher!.profileImage != null,
      //                                                   image: value.teacher!.profileImage.toString(),
      //                                                   radius: 8,
      //                                                   // classData.teacher.profileImage
      //                                                 ),
      //                                                 // ClipOval(
      //                                                 //   child: Image.asset(
      //                                                 //     AppAssets.studentImg,
      //                                                 //     width: 15,
      //                                                 //   ),
      //                                                 // ),
      //                                                 const SizedBox(
      //                                                   width: 5,
      //                                                 ),
      //                                                 Text(
      //                                                   'By : ',
      //                                                   style: GoogleFonts.poppins(
      //                                                       color: Colors.grey,
      //                                                       fontSize: 12.0,
      //                                                       fontWeight: FontWeight.w500
      //                                                   ),
      //                                                 ),
      //                                                 Container(
      //                                                   width: size.width * .24,
      //                                                   // color: Colors.amber,
      //                                                   child: Text(
      //                                                     value.teacher!.name!,
      //                                                     // 'Rosie David Rosie David Rosie David',
      //                                                     style:  GoogleFonts.poppins(
      //                                                         color: Colors.black,
      //                                                         fontSize: 12.0,
      //                                                         fontWeight: FontWeight.w500
      //                                                     ),
      //                                                     maxLines: 1,
      //                                                     overflow: TextOverflow.ellipsis,
      //                                                   ),
      //                                                 ),
      //                                               ],
      //                                             ),
      //                                           ],
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                 ],
      //                               ),
      //
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   );
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //       ) : const CommonProgressIndicator(),
      // ),

      Obx(
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
                height: size.height*.200,
                decoration: const BoxDecoration(
                  color: AppThemes.primaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                ),
                child:  Padding(
                  padding: EdgeInsets.all(size.width * .010),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height*.008,
                      ),
                      Container(
                        // height: 70,
                        height: size.height*.07,
                        // color: Colors.red,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: List.generate(
                                yearList.length, (index) {
                              var item = yearList[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    studentExamTimeTableController.selectedYear.value = item!;
                                    studentExamTimeTableController.getExamTimeTableData();
                                  },
                                  child: Container(
                                    height: size.height*.07,
                                    width: size.width*.15,
                                    decoration: BoxDecoration(
                                        color: item == studentExamTimeTableController.selectedYear.value
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius:
                                        BorderRadius.circular(12)),
                                    child: Center(
                                      child: Text(
                                        item.toString(),
                                        // subjectName[index].toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                            FontWeight.w600,
                                            color: item ==
                                                studentExamTimeTableController.selectedYear.value
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: size.height*.01,
                      ),
                      studentExamTimeTableController.isExamTypeLoading.value
                          ? SizedBox(
                        height: size.height*.07,
                      )
                          : studentExamTimeTableController
                          .getExamTypeModel.value.data!.isEmpty
                          ? SizedBox(
                        height: size.height*.07,
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
                        height: size.height*.07,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal:  size.width*.02,),
                          child: Row(
                            children: List.generate(
                                studentExamTimeTableController
                                    .getExamTypeModel
                                    .value
                                    .data!
                                    .length, (index) {
                              var item = studentExamTimeTableController
                                  .getExamTypeModel
                                  .value
                                  .data![index];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: size.width*.02),
                                child: GestureDetector(
                                  onTap: () {
                                    studentExamTimeTableController.selectedExamType.value = item.id!;
                                    studentExamTimeTableController.getExamTimeTableData();
                                    setState(() {
                                      // selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    height: size.height*.07,
                                    // width: size.width*.,
                                    padding: EdgeInsets.symmetric(horizontal:  size.width*.03),
                                    decoration: BoxDecoration(
                                        color: item.id == studentExamTimeTableController.selectedExamType.value
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius:
                                        BorderRadius.circular(
                                            12)
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.name.toString(),
                                        // subjectName[index].toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                            FontWeight.w600,
                                            color: item.id ==
                                                studentExamTimeTableController.selectedExamType.value
                                                ? Colors.black
                                                : Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 70,
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     physics: BouncingScrollPhysics(),
                      //     padding: EdgeInsets.symmetric(horizontal: 15),
                      //     child: Row(
                      //       children: List.generate(
                      //           yearList.length, (index) {
                      //         var item = yearList[index];
                      //
                      //         return Padding(
                      //           // key: keysList[index],
                      //           padding: const EdgeInsets.only(
                      //               right: 0, left: 0),
                      //           child: GestureDetector(
                      //             onTap: () {
                      //               studentExamTimeTableController.selectedYear.value = item!;
                      //               studentExamTimeTableController.getExamTimeTableData();
                      //             },
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(10.0)
                      //                   .copyWith(left: 0, right: 10),
                      //               child: Container(
                      //                 decoration: BoxDecoration(
                      //                     color: item == studentExamTimeTableController.selectedYear.value
                      //                         ? Colors.white
                      //                         : Colors.transparent,
                      //                     borderRadius:
                      //                     BorderRadius.circular(
                      //                         12)),
                      //                 child: Padding(
                      //                   padding:
                      //                   const EdgeInsets.all(12.0),
                      //                   child: Column(
                      //                     children: [
                      //                       Text(
                      //                         item.toString(),
                      //                         // subjectName[index].toString(),
                      //                         style: TextStyle(
                      //                             fontSize: 16,
                      //                             fontWeight:
                      //                             FontWeight.w600,
                      //                             color: item ==
                      //                                 studentExamTimeTableController.selectedYear.value
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
                      //
                      // studentExamTimeTableController.isExamTypeLoading.value
                      //     ? SizedBox(
                      //   height: 70,
                      // )
                      //     : studentExamTimeTableController
                      //     .getExamTypeModel.value.data!.isEmpty
                      //     ? SizedBox(
                      //   height: 70,
                      //   child: Center(
                      //     child: Text(
                      //       "No subject available",
                      //       style: TextStyle(
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.white),
                      //     ),
                      //   ),
                      // )
                      //     : SizedBox(
                      //   height: 70,
                      //   child: SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     physics: BouncingScrollPhysics(),
                      //     padding: EdgeInsets.symmetric(horizontal: 15),
                      //     child: Row(
                      //       children: List.generate(
                      //           studentExamTimeTableController
                      //               .getExamTypeModel
                      //               .value
                      //               .data!
                      //               .length, (index) {
                      //         var item = studentExamTimeTableController
                      //             .getExamTypeModel
                      //             .value
                      //             .data![index];
                      //
                      //         return Padding(
                      //           // key: keysList[index],
                      //           padding: const EdgeInsets.only(
                      //               right: 0, left: 0),
                      //           child: GestureDetector(
                      //             onTap: () {
                      //               studentExamTimeTableController.selectedExamType.value = item.id!;
                      //               studentExamTimeTableController.getExamTimeTableData();
                      //               setState(() {
                      //                 // selectedIndex = index;
                      //               });
                      //             },
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(10.0)
                      //                   .copyWith(left: 0, right: 10),
                      //               child: Container(
                      //                 decoration: BoxDecoration(
                      //                     color: item.id == studentExamTimeTableController.selectedExamType.value
                      //                         ? Colors.white
                      //                         : Colors.transparent,
                      //                     borderRadius:
                      //                     BorderRadius.circular(
                      //                         12)),
                      //                 child: Padding(
                      //                   padding:
                      //                   const EdgeInsets.all(12.0),
                      //                   child: Column(
                      //                     children: [
                      //                       Text(
                      //                         item.name.toString(),
                      //                         // subjectName[index].toString(),
                      //                         style: TextStyle(
                      //                             fontSize: 16,
                      //                             fontWeight:
                      //                             FontWeight.w600,
                      //                             color: item.id ==
                      //                                 studentExamTimeTableController.selectedExamType.value
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
                    ],
                  ),
                )
            ),

            Positioned.fill(
              top: size.height*.200,
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
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
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
                                              width: size.width * .19,
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
                                              width: size.width * .69,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // color: Colors.green,
                                                    width: size.width * .7,
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
                                                        width: size.width * .3,
                                                        // color: Colors.amber,
                                                        child: Text(
                                                          'Class - ' + value.seatClass!.name!,
                                                          // 'Class - ' + value.seatClass!.name!,
                                                          style: GoogleFonts.poppins(
                                                              color: AppThemes.textGray,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w500
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),

                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 3.0),
                                                            child: const SizedBox(
                                                              height: 20,
                                                              child: VerticalDivider(
                                                                width: 1,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                          ),

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
                                                              // 'Rosie David Rosie David Rosie David',
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
