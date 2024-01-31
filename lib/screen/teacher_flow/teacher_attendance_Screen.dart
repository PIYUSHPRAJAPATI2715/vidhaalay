import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/teacher_controller/student_attandance_controller.dart';
import 'package:vidhaalay_app/models/TeacherModel/add_attandance_model.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_dropdown.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  StudentAttandanceController studentAttandanceController =
  Get.put(StudentAttandanceController());

  @override
  void initState() {
    studentAttandanceController.getMyClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'vidhaalay'.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppThemes.primaryColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            AppAssets.arrowBack,
            width: 25,
            height: 25,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(MyRouters.myProfileTeacher);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      AppAssets.studentImg,
                      width: 30,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
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
              height: size.height * .230,
              decoration: const BoxDecoration(
                color: AppThemes.primaryColor,
                borderRadius:
                BorderRadius.only(bottomLeft: Radius.circular(70)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Student Attendance',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: AppThemes.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                        () => studentAttandanceController.classList.value.isEmpty
                        ? SizedBox.shrink()
                        : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Class - ',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: AppThemes.white,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),

                          CommonDropDownButton(
                            value: studentAttandanceController
                                .selectedClassId?.value,
                            items: studentAttandanceController
                                .classList.value
                                .toList()
                                .map((items) {
                              return DropdownMenuItem(
                                value: items.id,
                                child: Text(
                                  items.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: studentAttandanceController
                                        .selectedClassId
                                        ?.value ==
                                        items.id
                                        ? Colors.white
                                    // Colors.grey.shade900 // Change the color for selected item
                                        : Colors
                                        .black, // Default color for unselected items
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              studentAttandanceController
                                  .selectedClassId!.value = newValue!;
                              print(studentAttandanceController
                                  .selectedClassId?.value);
                              // studentAttandanceController.getStudentListData(classId: studentAttandanceController.selectedClassId.value.toString());
                              studentAttandanceController.getAttandanceListDataAPI(classId: studentAttandanceController.selectedClassId.value.toString());
                            },
                            width: size.width * 0.3,
                            backgroundColor: AppThemes.themeBackgroundColor,
                          ),

                          // DropdownButtonHideUnderline(
                          //   child: DropdownButton2(
                          //     value: studentAttandanceController
                          //         .selectedClassId?.value,
                          //     // icon: Icon(Icons.keyboard_arrow_down,
                          //     //     color: Colors.white),
                          //     // dropdownColor: Colors.white70,
                          //     dropdownStyleData: DropdownStyleData(
                          //       maxHeight: size.height * 0.28,
                          //       width: size.width * 0.3,
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
                          //     items: studentAttandanceController
                          //         .classList.value
                          //         .toList()
                          //         .map((items) {
                          //       return DropdownMenuItem(
                          //         value: items.id,
                          //         child: Text(
                          //           items.name,
                          //           style: TextStyle(
                          //             fontWeight: FontWeight.w500,
                          //             fontSize: 17,
                          //             color: studentAttandanceController
                          //                 .selectedClassId
                          //                 ?.value ==
                          //                 items.id
                          //                 ? Colors.white
                          //             // Colors.grey.shade900 // Change the color for selected item
                          //                 : Colors
                          //                 .black, // Default color for unselected items
                          //           ),
                          //         ),
                          //       );
                          //     }).toList(),
                          //     onChanged: (newValue) {
                          //       studentAttandanceController
                          //           .selectedClassId!.value = newValue!;
                          //       print(studentAttandanceController
                          //           .selectedClassId?.value);
                          //       // studentAttandanceController.getStudentListData(classId: studentAttandanceController.selectedClassId.value.toString());
                          //       studentAttandanceController.getAttandanceListDataAPI(classId: studentAttandanceController.selectedClassId.value.toString());
                          //     },
                          //   ),
                          // )
                        ]),
                  )
                ],
              )),
          Positioned.fill(
              top: size.height * .230,
              child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 40, horizontal: 10)
                      .copyWith(bottom: 0),
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    // color: AppThemes.primaryColor,
                    color: AppThemes.white,
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(60)),
                  ),
                  child: Obx(() => studentAttandanceController.isAttandanceDataLoading.value ?
                  Center(child: CommonProgressIndicator())
                      :
                  studentAttandanceController
                      .getAttandanceListData.value.data !=
                      null
                      ? studentAttandanceController.getAttandanceListData.value.data!.isEmpty ?
                  Center(
                    child: Text(
                      "No Student List Available",
                      style: TextStyle(
                          color: Colors.black, fontSize: 15),
                    ),
                  ) : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Students',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppThemes.blueColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Present',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppThemes.blueColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Absent',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppThemes.blueColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: size.height,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: studentAttandanceController.getAttandanceListData.value.data!.length,
                              physics:
                              const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var value  = studentAttandanceController.getAttandanceListData.value.data![index];
                                // RxBool isPresent = false.obs;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width * 0.57,
                                            // color: Colors.green,
                                            child: Row(
                                              children: [
                                                ClipOval(
                                                  child: Image.asset(
                                                    AppAssets.studentImg,
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: size.width * 0.45,
                                                  // color: Colors.blue,
                                                  child: Text(
                                                    value.studentName!,
                                                    // 'Marry Jones Marry Jones Marry Jones Marry Jones Marry Jones',
                                                    textAlign: TextAlign.left,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppThemes.blueColor,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              // color: Colors.amber,
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    value: true,
                                                    groupValue: value.present!,
                                                    activeColor: AppThemes.primaryColor,
                                                    onChanged: (value){
                                                      setState(() {
                                                        studentAttandanceController.getAttandanceListData.value.data![index].present = value;
                                                      });
                                                      // setState(() {
                                                      //   studentAttandanceController.isPresent.value[index] = present!;
                                                      //   print("present : ${studentAttandanceController.isPresent.value[index]}");
                                                      //   studentAttandanceController.manageAddAttandance(studentId: value.id!, isPresent: studentAttandanceController.isPresent.value[index]);
                                                      // });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Radio(
                                                    value: false,
                                                    groupValue: value.present!,
                                                    activeColor: AppThemes.red,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        studentAttandanceController.getAttandanceListData.value.data![index].present = value;
                                                      });
                                                      // setState(() {
                                                      //   studentAttandanceController.isPresent.value[index] = absent!;
                                                      //   print("absent : ${studentAttandanceController.isPresent.value[index]}");
                                                      //   studentAttandanceController.manageAddAttandance(studentId: value.id!, isPresent: studentAttandanceController.isPresent.value[index]);
                                                      // });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ))
                      : Container(
                      height: size.height * .44,
                      width: size.width,
                      child: Center(child: CommonProgressIndicator())
                  )
                  )
              )
          ),

          /* before */
          // Positioned.fill(
          //     top: size.height * .230,
          //     child: Container(
          //         padding:
          //         const EdgeInsets.symmetric(vertical: 40, horizontal: 10)
          //             .copyWith(bottom: 0),
          //         height: size.height,
          //         width: size.width,
          //         decoration: const BoxDecoration(
          //           color: AppThemes.white,
          //           borderRadius:
          //           BorderRadius.only(topRight: Radius.circular(60)),
          //         ),
          //         child: Obx(() => studentAttandanceController
          //             .getStudentListModel.value.data !=
          //             null
          //             ? studentAttandanceController.getStudentListModel.value.data!.isEmpty ?
          //         Center(
          //           child: Text(
          //             "No Student List Available",
          //             style: TextStyle(
          //                 color: Colors.black, fontSize: 15),
          //           ),
          //         ) : SingleChildScrollView(
          //             physics: const AlwaysScrollableScrollPhysics(),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Padding(
          //                   padding: const EdgeInsets.symmetric(horizontal: 5.0),
          //                   child: Row(
          //                     mainAxisAlignment:
          //                     MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Text(
          //                         'Students',
          //                         textAlign: TextAlign.center,
          //                         style: GoogleFonts.poppins(
          //                           fontSize: 15,
          //                           fontWeight: FontWeight.w600,
          //                           color: AppThemes.blueColor,
          //                         ),
          //                       ),
          //                       Row(
          //                         children: [
          //                           Text(
          //                             'Present',
          //                             textAlign: TextAlign.center,
          //                             style: GoogleFonts.poppins(
          //                               fontSize: 15,
          //                               fontWeight: FontWeight.w600,
          //                               color: AppThemes.blueColor,
          //                             ),
          //                           ),
          //                           const SizedBox(
          //                             width: 15,
          //                           ),
          //                           Text(
          //                             'Absent',
          //                             textAlign: TextAlign.center,
          //                             style: GoogleFonts.poppins(
          //                               fontSize: 15,
          //                               fontWeight: FontWeight.w600,
          //                               color: AppThemes.blueColor,
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 const SizedBox(
          //                   height: 30,
          //                 ),
          //                 SizedBox(
          //                   height: size.height,
          //                   child: ListView.builder(
          //                     shrinkWrap: true,
          //                     itemCount: studentAttandanceController.getStudentListModel.value.data!.length,
          //                     physics:
          //                     const AlwaysScrollableScrollPhysics(),
          //                     itemBuilder: (context, index) {
          //                       var value  = studentAttandanceController.getStudentListModel.value.data![index];
          //                       // RxBool isPresent = false.obs;
          //
          //                       return Padding(
          //                         padding: const EdgeInsets.symmetric(horizontal: 5.0),
          //                         child: Column(
          //                           children: [
          //                             Row(
          //                               mainAxisAlignment:
          //                               MainAxisAlignment.spaceBetween,
          //                               children: [
          //                                 Container(
          //                                   width: size.width * 0.57,
          //                                   // color: Colors.green,
          //                                   child: Row(
          //                                     children: [
          //                                       ClipOval(
          //                                         child: Image.asset(
          //                                           AppAssets.studentImg,
          //                                           height: 30,
          //                                           width: 30,
          //                                         ),
          //                                       ),
          //                                       const SizedBox(
          //                                         width: 10,
          //                                       ),
          //                                       Container(
          //                                         width: size.width * 0.45,
          //                                         // color: Colors.blue,
          //                                         child: Text(
          //                                           value.name!,
          //                                           // 'Marry Jones Marry Jones Marry Jones Marry Jones Marry Jones',
          //                                           textAlign: TextAlign.left,
          //                                           style: GoogleFonts.poppins(
          //                                             fontSize: 15,
          //                                             fontWeight: FontWeight.w600,
          //                                             color: AppThemes.blueColor,
          //                                           ),
          //                                           maxLines: 2,
          //                                           overflow: TextOverflow.ellipsis,
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 Obx(
          //                                   () => Container(
          //                                     // color: Colors.amber,
          //                                     child: Row(
          //                                       children: [
          //                                         Radio(
          //                                           value: true,
          //                                           groupValue: studentAttandanceController.isPresent.value[index],
          //                                           activeColor: AppThemes.primaryColor,
          //                                           onChanged: (present){
          //                                             setState(() {
          //                                               studentAttandanceController.isPresent.value[index] = present!;
          //                                               print("present : ${studentAttandanceController.isPresent.value[index]}");
          //                                               studentAttandanceController.manageAddAttandance(studentId: value.id!, isPresent: studentAttandanceController.isPresent.value[index]);
          //                                             });
          //                                           },
          //                                         ),
          //                                         SizedBox(
          //                                           width: 15,
          //                                         ),
          //                                         Radio(
          //                                           value: false,
          //                                           groupValue: studentAttandanceController.isPresent.value[index],
          //                                           activeColor: AppThemes.red,
          //                                           onChanged: (absent){
          //                                             setState(() {
          //                                               studentAttandanceController.isPresent.value[index] = absent!;
          //                                               print("absent : ${studentAttandanceController.isPresent.value[index]}");
          //                                               studentAttandanceController.manageAddAttandance(studentId: value.id!, isPresent: studentAttandanceController.isPresent.value[index]);
          //                                             });
          //                                           },
          //                                         ),
          //                                         SizedBox(
          //                                           width: 5,
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                             const SizedBox(
          //                               height: 30,
          //                             )
          //                           ],
          //                         ),
          //                       );
          //                     },
          //                   ),
          //                 )
          //               ],
          //             ))
          //             : Container(
          //             height: size.height * .44,
          //             width: size.width,
          //             child: Center(child: CommonProgressIndicator())
          //         )
          //         )
          //     )
          // ),
        ],
      ),
      bottomNavigationBar: Obx(
            () => studentAttandanceController
            .getAttandanceListData.value.data !=
            null
            ? studentAttandanceController.getAttandanceListData.value.data!.isEmpty ? SizedBox.shrink()
            : SizedBox(
          width: size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: size.width,
                height: 40,
                color: AppThemes.primaryColor,
                child: InkWell(
                  onTap: () {
                    studentAttandanceController.addAttandanceAPI(context);
                  },
                  child:  const Center(
                    child:  Text(
                      'SUBMIT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ) : SizedBox.shrink(),
      ),
      // bottomNavigationBar: Obx(
      //   () => studentAttandanceController
      //       .getStudentListModel.value.data !=
      //       null
      //       ? studentAttandanceController.getStudentListModel.value.data!.isEmpty ? SizedBox.shrink()
      //       : SizedBox(
      //     width: size.width,
      //     child: Row(
      //       mainAxisSize: MainAxisSize.max,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Container(
      //           width: size.width,
      //           height: 40,
      //           color: AppThemes.primaryColor,
      //           child: InkWell(
      //             onTap: () {
      //               studentAttandanceController.addAttandanceAPI(context);
      //             },
      //             child:  const Center(
      //               child:  Text(
      //                 'SUBMIT',
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.w500,
      //                   fontSize: 18,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ) : SizedBox.shrink(),
      // ),
    );
  }
}
