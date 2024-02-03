import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/teacher_controller/studentlist_controller.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_button.dart';
import 'package:vidhaalay_app/widgets/common_profile_image_widget.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

import '../../widgets/common_textfield.dart';


class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  StudentListController studentListController = Get.put(StudentListController());
  int stuId = 0;

  @override
  void initState() {
    stuId = Get.arguments;
    studentListController.getStudetnDetails(stuId: stuId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('vidhaalay'.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppThemes.primaryColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Image.asset(AppAssets.arrowBack,width: 25,height: 25,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
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
      body: Obx(
        () => studentListController.isDetailsLoading.value ?  Container(
          // height: size.height * .44,
          // width: size.width,
            child:
            Center(child: CommonProgressIndicator())
        ) :  Stack(
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
                height: 165,
                decoration: const BoxDecoration(
                  color: AppThemes.primaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
                ),
            ),
            Positioned.fill(
                top: size.height*.216,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 15).copyWith(bottom: 0),
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: AppThemes.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
                  ),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child:  Text(
                              studentListController.getStudentDetailsModel.value.data!.name!.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                                color: AppThemes.black,
                              ),
                            ),
                          ),
                          Center(
                            child:  Text(
                              studentListController.getStudentDetailsModel.value.data!.class0!.name!.toString(),
                              // 'Class-8th',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: AppThemes.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CommonRow(
                           text1: 'Father\'s Name',
                            text2: 'David Wanney',
                          ),
                          CommonRow(
                           text1: 'Mother\'s Name',
                            text2: "Marina",
                          ),
                          CommonRow(
                           text1: 'Date of Birth',
                            text2: studentListController.getStudentDetailsModel.value.data!.dob!.toString(),
                          ),
                          CommonRow(
                           text1: 'Gender',
                            text2: studentListController.getStudentDetailsModel.value.data!.gender!.toString(),
                          ),
                          CommonRow(
                           text1: 'Category SC/OBC/ST/gen',
                            text2: 'SC',
                          ),
                          CommonRow(
                           text1: 'Mother Tongue',
                            text2: 'Hindi',
                          ),
                          CommonRow(
                           text1: 'Blood Group',
                            text2: 'B+',
                          ),
                        ],
                      )
                  ),
                ),
              ),

            Positioned.fill(
                left: 0,
                right: 0,
                top: size.height*-.550,

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    commonProfileImageCircle(
                      context: context,
                      isProfileImageLoading:  studentListController.getStudentDetailsModel.value.data == null,
                      isProfileExist:
                      studentListController.getStudentDetailsModel.value.data!.profileImage !=
                          null,
                      image: studentListController.getStudentDetailsModel.value.data!.profileImage
                          .toString(),
                      radius: 70,
                    ),

                    // ClipOval(
                    //   child: Image.asset(AppAssets.studentImg),
                    // ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
