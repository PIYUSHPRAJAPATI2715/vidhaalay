import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/teacher_controller/exam_result_controller.dart';
import 'package:vidhaalay_app/controller/teacher_controller/studentlist_controller.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_button.dart';
import 'package:vidhaalay_app/widgets/common_textfield.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class ExamResultScreenTeacher extends StatefulWidget {
  const ExamResultScreenTeacher({Key? key}) : super(key: key);

  @override
  State<ExamResultScreenTeacher> createState() =>
      _ExamResultScreenTeacherState();
}

class _ExamResultScreenTeacherState extends State<ExamResultScreenTeacher> {
  final examResultController = Get.put(ExamResultController());

  @override
  void initState() {
    examResultController.stuId.value = Get.arguments;
    examResultController.getStudetnDetails(
        stuId: examResultController.stuId.value);
    // examResultController.getExamTypeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            AppAssets.arrowBack,
            width: 25,
            height: 25,
          ),
        ),
      ),
      body: Obx(
            () => examResultController.isDetailsLoading.value ||
            examResultController.isExamTypeLoading.value
            ? Container(child: Center(child: CommonProgressIndicator()))
            : Stack(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              AppAssets.studentImg,
                              width: 45,
                              height: 45,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                examResultController
                                    .getStudentDetailsModel
                                    .value
                                    .data!
                                    .name!,
                                // 'Rosie Kumar',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: AppThemes.white,
                                ),
                              ),
                              Text(
                                examResultController
                                    .getStudentDetailsModel
                                    .value
                                    .data!
                                    .class0!
                                    .name!,
                                // 'Class 8th',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppThemes.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Divider(
                                color: AppThemes.white,
                                thickness: 0.5,
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    examResultController.isExamTypeLoading.value
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
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Obx(
                                () {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: examResultController
                                      .selectedExamType
                                      ?.value,
                                  icon: Icon(
                                      Icons
                                          .keyboard_arrow_down,
                                      color: Colors.white),
                                  dropdownColor:
                                  Colors.white70,
                                  items: examResultController
                                      .getExamTypeModel
                                      .value
                                      .data!
                                      .toList()
                                      .map((items) {
                                    return DropdownMenuItem(
                                      value: items.id,
                                      child: Text(
                                        items.name!,
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 17,
                                          color: examResultController
                                              .selectedExamType
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
                                    examResultController
                                        .selectedExamType!
                                        .value = newValue!;
                                    print(examResultController
                                        .selectedExamType
                                        ?.value);

                                    examResultController
                                        .getExamResultData();
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Expanded(
                    //       child: Text('Half Yearly',
                    //         textAlign: TextAlign.center,
                    //         style: GoogleFonts.poppins(
                    //           fontSize: 19,
                    //           fontWeight: FontWeight.w600,
                    //           color: AppThemes.black,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'August - November',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: AppThemes.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            Positioned.fill(
              top: size.height * .230,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 30, horizontal: 10)
                    .copyWith(bottom: 0),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius:
                  BorderRadius.only(topRight: Radius.circular(60)),
                ),
                child: examResultController.isDataLoading.value ||
                    examResultController
                        .getExamResultModel.value.data ==
                        null
                    ? Center(child: CommonProgressIndicator())
                    : examResultController.getExamResultModel.value
                    .data!.isEmpty
                    ? Container(
                  height: size.height * .4,
                  // color: Colors.red,
                  child: Center(
                    child: Text("No result available"),
                  ),
                )
                    : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: AppThemes.blueColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Subjects',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: AppThemes.blueColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Out of 100',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: AppThemes.blueColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: examResultController.getExamResultModel.value.data!.length,
                            physics:
                            const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {

                              var value = examResultController.getExamResultModel.value.data![index];

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
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          value.from!,
                                          // '16th Mar',
                                          style: GoogleFonts
                                              .poppins(
                                              color:
                                              AppThemes
                                                  .black,
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight
                                                  .w600),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .symmetric(
                                              horizontal:
                                              28.0)
                                              .copyWith(
                                              left: 0),
                                          child: Container(
                                            width: size.width *
                                                .40,
                                            padding:
                                            const EdgeInsets
                                                .all(9),
                                            decoration: BoxDecoration(
                                                color: AppThemes
                                                    .lightPink,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    8)),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  'Social Science',
                                                  style: GoogleFonts.poppins(
                                                      color: AppThemes
                                                          .blueColor,
                                                      fontSize:
                                                      14,
                                                      fontWeight:
                                                      FontWeight
                                                          .w600),
                                                ),
                                                Text(
                                                  value.marks!.toString()+"/"+value.totalMarks!.toString(),
                                                  // '0/100',
                                                  style: GoogleFonts.poppins(
                                                      color: AppThemes
                                                          .black,
                                                      fontSize:
                                                      15,
                                                      fontWeight:
                                                      FontWeight
                                                          .w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child:
                                        CommonTextFieldResult(
                                          hintText: '0',
                                          obSecure: false,
                                          keyboardType:
                                          TextInputType
                                              .number,
                                          inputFormatters: [
                                            // FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}$')),
                                            LengthLimitingTextInputFormatter(
                                                3),
                                            FilteringTextInputFormatter
                                                .allow(RegExp(
                                                r'[0-9]')),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: size.width,
                          decoration: const BoxDecoration(
                              color: AppThemes.primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              )),
                          child: CustomOutlineButton(
                            title: 'Send',
                            backgroundColor: AppThemes.primaryColor,
                            onPressed: () {
                              // examResultController.createExamResultAPI(context);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:  Obx(
        () => examResultController.isDetailsLoading.value ||
            examResultController.isExamTypeLoading.value
            ? SizedBox.shrink() : SizedBox(
          width: size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: size.width,
                height: 45,
                color: Colors.red,
                child: InkWell(
                  onTap: () {},
                  child: const Center(
                    child: Text(
                      'Each Subjects needs 36 marks to pass',
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
