import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay/controller/student_controller/syllabus_student_controller.dart';
import 'package:vidhaalay/widgets/circular_progressindicator.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:vidhaalay/resourses/app_assets.dart';


class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({Key? key}) : super(key: key);

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  final syllabusStudentController = Get.put(SyllabusStudentController());

  @override
  void initState() {
    super.initState();
    syllabusStudentController.getSubjectListData();
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
                height: size.height*.11,
                decoration: const BoxDecoration(
                  color: AppThemes.primaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

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
                                  padding: EdgeInsets.symmetric(horizontal: 15),
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
                  ],
                )
            ),

            Positioned.fill(
              top: size.height*.11,
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
                        height: 18,
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
