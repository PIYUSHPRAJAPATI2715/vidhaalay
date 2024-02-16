import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vidhaalay_app/controller/teacher_controller/get_profile_controller_teacher.dart';
import 'package:vidhaalay_app/controller/teacher_controller/teacherHomeController.dart';
import 'package:vidhaalay_app/models/get_profile_model.dart';
import 'package:vidhaalay_app/repositories/get_profile_repo.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/student_screen/assignment_details_screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/teacher_event_screen.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_profile_image_widget.dart';
import 'package:vidhaalay_app/widgets/resources.dart';
import '../../controller/bottom_controller.dart';
import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({Key? key}) : super(key: key);

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  final controller = Get.put(BottomController());
  final teacherHomeController = Get.put(TeacherHomeController());
  final getTeacherProfileController = Get.put(GetTeacherProfileController());

  int touchedIndex = -1;
  List pieData = [50.0, 50.0];

  // String? networkProfileImage;
  // bool isProfileLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Teacher home enter");
    teacherHomeController.getLatestEventData();
    getTeacherProfileController.getProfileData();
    // getProfile();
    // teacherHomeController.getLatestAssignmentRepo();
  }

  // Future<void> getProfile() async {
  //   GetProfileModel getProfileModel = GetProfileModel();
  //
  //   await getProfileRepo().then((value) {
  //     isProfileLoading = false;
  //     getProfileModel = value;
  //     setState(() {
  //       networkProfileImage = getProfileModel.data!.profileImage;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        title: Text(
          'vidhaalay'.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: AppThemes.primaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .035)
                .copyWith(left: 0),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(MyRouters.notificationScreenUser);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AppAssets.notification,
                        width: 20,
                      ),
                    )),
                SizedBox(
                  width: size.width * .045,
                ),
                 Obx(
                   () {
                     print("profile Image : ${getTeacherProfileController.networkProfileImage}");

                     return  GestureDetector(
                       onTap: () {
                         Get.toNamed(MyRouters.myProfileTeacher);
                       },
                       child: commonProfileImageCircle(
                       context: context,
                            isProfileImageLoading: !getTeacherProfileController
                                .isProfileLoading.value,
                            isProfileExist: getTeacherProfileController
                                    .networkProfileImage !=
                                null,
                            image:
                            getTeacherProfileController
                                // .getProfileModel.value.data!.profileImage
                                .networkProfileImage
                       ),
                        // CircleAvatar(
                       //   radius: 18,
                       //   backgroundColor: Colors.transparent,
                       //   child: ClipOval(
                       //     child: !getTeacherProfileController.isProfileLoading.value
                       //         ? Shimmer.fromColors(
                       //       // ignore: sort_child_properties_las t
                       //       child: CircleAvatar(
                       //           radius: 18, backgroundColor: Colors.grey),
                       //       baseColor: Colors.grey[300]!,
                       //       highlightColor: Colors.grey[400]!,
                       //     )
                       //         :
                       //     getTeacherProfileController.networkProfileImage != null
                       //     // getTeacherProfileController.getProfileModel.value.data?.profileImage != null
                       //         ? CachedNetworkImage(
                       //       imageUrl:
                       //       // getTeacherProfileController.networkProfileImage.toString(),
                       //       getTeacherProfileController.getProfileModel.value.data!.profileImage.toString(),
                       //       fit: BoxFit.fill,
                       //       errorWidget: (__, _, ___) => Image.asset(
                       //         AppAssets.collageImg,
                       //         fit: BoxFit.cover,
                       //         width: double.maxFinite,
                       //       ),
                       //       imageBuilder: (context, imageProvider) =>
                       //           Container(
                       //             decoration: BoxDecoration(
                       //               image: DecorationImage(
                       //                 image: imageProvider,
                       //                 fit: BoxFit.cover,
                       //               ),
                       //             ),
                       //           ),
                       //       placeholder: (context, url) =>
                       //           Shimmer.fromColors(
                       //             // ignore: sort_child_properties_last
                       //             child: CircleAvatar(
                       //                 radius: 18,
                       //                 backgroundColor: Colors.grey),
                       //             baseColor: Colors.grey[300]!,
                       //             highlightColor: Colors.grey[400]!,
                       //           ),
                       //     )
                       //     // Image.network(getProfileController.networkProfileImage.toString(),fit: BoxFit.fill)
                       //         : Image.asset(
                       //       AppAssets.studentImg,
                       //       fit: BoxFit.cover,
                       //       // height: 35,
                       //     ),
                       //   ),
                       // ),
                     );
                   },
                 ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () {
          var eventData = null;
          var assignmentData = null;
          var classData = null;
          var attandanceData = null;

          if(teacherHomeController
              .getLatestEventModel
              .value
              .data != null) {
            eventData =  teacherHomeController
                .getLatestEventModel
                .value
                .data?.event;
            assignmentData =  teacherHomeController
                .getLatestEventModel
                .value
                .data?.assignment;
            classData =  teacherHomeController
                .getLatestEventModel
                .value
                .data?.nextClass;
            attandanceData =  teacherHomeController
                .getLatestEventModel
                .value
                .data?.attRatio;
          }
          // print("eventData ${eventData.id}");

          return teacherHomeController.isLoading.value ?
          Center(child: CommonProgressIndicator())
              : Center(
            child: Container(
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Container(
                        color: AppThemes.white,
                        child: Container(
                          width: size.width,
                          // height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50)
                              ),
                              color: AppThemes.primaryColor),
                          padding: EdgeInsets.symmetric(horizontal: 20)!.copyWith(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'latest event'.toUpperCase(),
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: size.height * .010,
                              ),
                              eventData !=
                                  null
                                  ? GestureDetector(
                                onTap: () {
                                  print("Tap");
                                  Get.toNamed(
                                      MyRouters.celebrationScreenStu,
                                      arguments: eventData.id
                                          .toString());
                                },
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  top: 4.0),
                                              child: SvgPicture.asset(
                                                  AppAssets.infoImg),
                                            ),
                                            SizedBox(
                                              width: size.width * .035,
                                            ),
                                            Container(
                                              width: size.width * .74,
                                              // color: Colors.amber,
                                              child: Text(
                                                // "Test test test test test Test test test test test Test test test test test Test test test test test Test test test test test Test test test test test Test test test test test",
                                                eventData.eventName
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                    FontWeight.w700),
                                                maxLines: 1,
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: AppThemes.white,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 26.0),
                                        child: Text(
                                          // "Test test test test test Test test test test test Test test test test test Test test test test test Test test test test test Test test test test test Test test test test test",

                                              eventData.message
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.w500),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  ],
                                ),
                              )
                                  : Text("No event available")
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Container(
                        color: AppThemes.primaryColor,
                        child: Container(
                          width: size.width,
                          // height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50)
                              ),
                              // borderRadius: BorderRadius.circular(10),
                              color: AppThemes.white),
                          // padding: EdgeInsets.only(top: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .052,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'NEXT CLASS',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    classData ==
                                        null ||  classData.subject == null
                                        ? Text("No Class Available")
                                        : Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              classData.time,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                            SizedBox(
                                              width: size.width * .050,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 18, vertical: 6)
                                                  .copyWith(right: 50),
                                              decoration: BoxDecoration(
                                                color: AppThemes.lightPink,
                                                borderRadius:
                                                BorderRadius.circular(13.0),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    classData.subject.name,
                                                    // 'Science',
                                                    style: TextStyle(
                                                      color: AppThemes.blueColor,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.w900,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * .010,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      ClipOval(
                                                        child: Image.asset(
                                                          AppAssets.studentImg,
                                                          width: 12,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        'By : ',
                                                        style: GoogleFonts.poppins(
                                                            color: Colors.grey,
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                      Text(
                                                        classData.teacher.name,
                                                        // 'Rosie David',
                                                        style: GoogleFonts.poppins(
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Flexible(
                    //   flex: 4,
                    //   fit: FlexFit.tight,
                    //   child: Container(
                    //     color: AppThemes.primaryColor,
                    //     child: Container(
                    //       width: size.width,
                    //       // height: 200,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.only(
                    //               topRight: Radius.circular(50)
                    //           ),
                    //           // borderRadius: BorderRadius.circular(10),
                    //           color: AppThemes.white),
                    //       // padding: EdgeInsets.only(top: 20),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Padding(
                    //             padding: EdgeInsets.symmetric(
                    //               horizontal: size.width * .052,
                    //             ),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'NEXT CLASS',
                    //                   style: GoogleFonts.poppins(
                    //                       color: Colors.black,
                    //                       fontSize: 19,
                    //                       fontWeight: FontWeight.w600),
                    //                 ),
                    //                 const SizedBox(
                    //                   height: 15,
                    //                 ),
                    //                 classData !=
                    //                     null
                    //                     ? Row(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Row(
                    //                       crossAxisAlignment:
                    //                       CrossAxisAlignment.center,
                    //                       mainAxisAlignment:
                    //                       MainAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                                 classData.time,
                    //                                 style: TextStyle(
                    //                                     color: Colors.black,
                    //                                     fontSize: 13,
                    //                                     fontWeight:
                    //                                         FontWeight.w700),
                    //                               ),
                    //                               SizedBox(
                    //                           width: size.width * .050,
                    //                         ),
                    //                         Container(
                    //                           padding: const EdgeInsets.symmetric(
                    //                               horizontal: 18, vertical: 6)
                    //                               .copyWith(right: 50),
                    //                           decoration: BoxDecoration(
                    //                             color: AppThemes.lightPink,
                    //                             borderRadius:
                    //                             BorderRadius.circular(13.0),
                    //                           ),
                    //                           child: Column(
                    //                             mainAxisAlignment:
                    //                             MainAxisAlignment.start,
                    //                             crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                             children: [
                    //                               Text(
                    //                                 classData.subject.name,
                    //                                 // 'Science',
                    //                                 style: TextStyle(
                    //                                   color: AppThemes.blueColor,
                    //                                   fontSize: 15.0,
                    //                                   fontWeight: FontWeight.w900,
                    //                                 ),
                    //                               ),
                    //                               SizedBox(
                    //                                 height: size.height * .010,
                    //                               ),
                    //                               Row(
                    //                                 crossAxisAlignment:
                    //                                 CrossAxisAlignment.center,
                    //                                 mainAxisAlignment:
                    //                                 MainAxisAlignment.center,
                    //                                 children: [
                    //                                   // commonProfileImageCircle(
                    //                                   //     context: context,
                    //                                   //     isProfileImageLoading: false,
                    //                                   //     isProfileExist:
                    //                                   //     classData.teacher.profileImage !=
                    //                                   //         null,
                    //                                   //     image: classData.teacher.profileImage
                    //                                   // ),
                    //
                    //                                   // commonProfileImageCircle(
                    //                                   //   context: context,
                    //                                   //   isProfileImageLoading: classData.teacher == null,
                    //                                   //   isProfileExist:
                    //                                   //   classData.teacher.profileImage !=
                    //                                   //       null,
                    //                                   //   image: classData.teacher.profileImage
                    //                                   //       .toString(),
                    //                                   //   radius: 10,
                    //                                   //   // classData.teacher.profileImage
                    //                                   // ),
                    //                                   ClipOval(
                    //                                     child: Image.asset(
                    //                                       AppAssets.studentImg,
                    //                                       width: 12,
                    //                                     ),
                    //                                   ),
                    //                                   const SizedBox(width: 10),
                    //                                   Text(
                    //                                     'By : ',
                    //                                     style: GoogleFonts.poppins(
                    //                                         color: Colors.grey,
                    //                                         fontSize: 12.0,
                    //                                         fontWeight:
                    //                                         FontWeight.w500),
                    //                                   ),
                    //                                   Text(
                    //                                     classData.teacher.name,
                    //                                     // 'Rosie David',
                    //                                     style: GoogleFonts.poppins(
                    //                                         color: Colors.black,
                    //                                         fontSize: 12.0,
                    //                                         fontWeight:
                    //                                         FontWeight.w500),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ],
                    //                 )
                    //                     : Text("No Class Available"),
                    //                 const SizedBox(
                    //                   height: 10,
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const Divider(
                      color: AppThemes.dividerColor,
                      height: 0.2,
                      thickness: 1,
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Container(
                        color: AppThemes.primaryColor,
                        child: Container(
                          width: size.width,
                          // height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50)
                              ),
                              color: AppThemes.white),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          // !.copyWith(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'assignment'.toUpperCase(),
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              assignmentData ==
                                  null || assignmentData.id == null
                                  ? Text("No Assignment Available")
                              //     SizedBox(
                              //   height: 10,
                              // )
                                  : GestureDetector(
                                onTap: () {
                                  Get.to(() => AssignmentDetailScreen(),
                                      arguments: assignmentData!
                                          .id
                                          .toString());
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: size.width * 0.54,
                                          // color: Colors.amber,
                                          child: Text(capitalizeFirstLetter(assignmentData.assignmentName!.toString()),
                                            // 'Social Science',
                                            style: GoogleFonts.poppins(
                                                color: AppThemes.blueColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            commonProfileImageCircle(
                                              context: context,
                                              isProfileImageLoading:  assignmentData
                                                  .teacher == null,
                                              isProfileExist:
                                              assignmentData
                                                  .teacher.profileImage !=
                                                  null,
                                              image: assignmentData
                                                  .teacher!
                                                  .profileImage!
                                                  .toString(),
                                              radius: 8,
                                            ),

                                            // ClipOval(
                                            //   child: Image.asset(
                                            //     AppAssets.studentImg,
                                            //     width: 13,
                                            //   ),
                                            // ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              'By : ',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.grey,
                                                  fontSize: 12.0,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            Container(
                                              width: size.width * 0.215,
                                              // color: Colors.amber,
                                              child: Text(
                                                assignmentData
                                                    .teacher!
                                                    .name!
                                                    .toString(),
                                                // 'Rosie David',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                    FontWeight.w500),
                                                maxLines: 1,
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      assignmentData!
                                          .detail
                                          .toString(),
                                      // 'It has survived not only five centuries, but alse the leep into electronic typesetting remaining essentially unchanged. It was popularised in the as survived not only five centuries, but alse the leep into electronic typesetting remaining essentially unchanged. It was popularised in the',
                                      style: TextStyle(
                                          color: AppThemes.blueColor,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w300),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ), //Container
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Container(
                        width: size.width,
                        // height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50)
                            ),
                            color: AppThemes.primaryColor),
                        padding: EdgeInsets.symmetric(horizontal: 20)!.copyWith(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('attendance'.toUpperCase(),
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            attandanceData !=
                                null
                                ?  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Image.asset(AppAssets.pieChart,width: 90,),
                                Container(
                                  height: size.height * 0.14,
                                  width: size.width * 0.35,
                                  // color: Colors.red,
                                  child: PieChart(
                                    PieChartData(
                                      pieTouchData: PieTouchData(
                                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                          setState(() {
                                            if (!event.isInterestedForInteractions ||
                                                pieTouchResponse == null ||
                                                pieTouchResponse.touchedSection == null) {
                                              touchedIndex = -1;
                                              return;
                                            }
                                            touchedIndex = pieTouchResponse
                                                .touchedSection!.touchedSectionIndex;
                                          });
                                        },
                                      ),
                                      startDegreeOffset: 180,
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      sectionsSpace: 2,
                                      centerSpaceRadius: 0,
                                      sections: showingSections(absentValue: double.parse(attandanceData.absent),
                                          presentValue: double.parse(attandanceData.present),),
                                          // attandanceData.present.toDouble()),
                                    ),
                                  ),
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppThemes.white,
                                          ),
                                          width: 13,
                                          height: 13,
                                        ),
                                        SizedBox(
                                          width: size.width*.030,
                                        ),
                                        Text('Present',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppThemes.black
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width*.13,
                                        ),
                                        Text(
                                          attandanceData.present.toString() + "%",
                                          // '50%',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppThemes.black
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          width: 13,
                                          height: 13,
                                        ),
                                        SizedBox(
                                          width: size.width*.030,
                                        ),
                                        Text('Absent',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width*.13,
                                        ),
                                        Text(
                                          attandanceData.absent.toString() + "%",
                                          // '50%',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppThemes.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ) : Text("No Attandance Available")
                          ],
                        ),
                      ), //Container
                    ), //Flexible
                  ], //<Widget>[]
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ) //Padding
            ), //Container
          );
        }

      )
    );
  }

  List<PieChartSectionData> showingSections(
      {
    required double presentValue,
    required double absentValue,
  }) {
    return List.generate(
      2,
          (i) {
        final isTouched = i == touchedIndex;
        const color0 = AppThemes.white;
        const color1 = AppThemes.red;
        // const color2 = AppThemes.red;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: presentValue,
              // pieData[i],
              title: '',
              radius: 45,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: AppThemes.black, width: 3)
                  : BorderSide(color: AppThemes.black.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: absentValue,
              // pieData[i],
              title: '',
              radius: 45,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: AppThemes.white, width: 3)
                  : BorderSide(color: AppThemes.white.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }
}


// Obx(
//       () => SingleChildScrollView(
//     physics: NeverScrollableScrollPhysics(),
//     child: Column(
//       children: [
//         Container(
//           height: size.height * 0.38,
//
//           // height: double.maxFinite,
//           // width: size.width,
//           decoration: const BoxDecoration(
//             // color: Colors.pink
//
//               gradient: LinearGradient(
//                   colors: [
//                     Colors.white,
//                     Colors.white,
//                     AppThemes.primaryColor,
//                     AppThemes.primaryColor,
//                   ],
//                   end: Alignment.centerRight,
//                   begin: Alignment.centerLeft,
//                   stops: [0, .5, .501, 1])),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: size.width * .052, vertical: 30),
//                 height: size.height * 0.18,
//                 width: size.width,
//                 decoration: const BoxDecoration(
//                     color: AppThemes.primaryColor,
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(40))),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'latest event'.toUpperCase(),
//                       style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 19,
//                           fontWeight: FontWeight.w700),
//                     ),
//                     SizedBox(
//                       height: size.height * .010,
//                     ),
//                     !teacherHomeController.isLoading.value
//                         ? teacherHomeController
//                         .getLatestEventModel.value.data !=
//                         null
//                         ? GestureDetector(
//                       onTap: () {
//                         print("Tap");
//                         Get.toNamed(
//                             MyRouters.celebrationScreenStu,
//                             arguments: teacherHomeController
//                                 .getLatestEventModel
//                                 .value
//                                 .data
//                                 ?.id
//                                 .toString());
//                       },
//                       child: Column(
//                         crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             crossAxisAlignment:
//                             CrossAxisAlignment.center,
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding:
//                                     const EdgeInsets.only(
//                                         top: 4.0),
//                                     child: SvgPicture.asset(
//                                         AppAssets.infoImg),
//                                   ),
//                                   SizedBox(
//                                     width: size.width * .035,
//                                   ),
//                                   Container(
//                                     width: size.width * .74,
//                                     // color: Colors.amber,
//                                     child: Text(
//                                       // "Test test test test test Test test test test test Test test test test test Test test test test test Test test test test test Test test test test test Test test test test test",
//                                       teacherHomeController
//                                           .getLatestEventModel
//                                           .value
//                                           .data!
//                                           .eventName
//                                           .toString(),
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 13,
//                                           fontWeight:
//                                           FontWeight.w700),
//                                       maxLines: 1,
//                                       overflow:
//                                       TextOverflow.ellipsis,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               const Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: 16,
//                                 color: AppThemes.white,
//                               ),
//                             ],
//                           ),
//                           Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 26.0),
//                               child: Text(
//                                 teacherHomeController
//                                     .getLatestEventModel
//                                     .value
//                                     .data!
//                                     .message
//                                     .toString(),
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight:
//                                     FontWeight.w500),
//                                 maxLines: 3,
//                                 overflow: TextOverflow.ellipsis,
//                               )),
//                         ],
//                       ),
//                     )
//                         : Text("No event available")
//                         : SizedBox()
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 24),
//                 height: size.height * 0.2,
//                 width: double.maxFinite,
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(40),
//                       bottomLeft: Radius.circular(40),
//                     )),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: size.width * .052,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'NEXT CLASS',
//                             style: GoogleFonts.poppins(
//                                 color: Colors.black,
//                                 fontSize: 19,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     '10 Am',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                   SizedBox(
//                                     width: size.width * .050,
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 18, vertical: 6)
//                                         .copyWith(right: 50),
//                                     decoration: BoxDecoration(
//                                       color: AppThemes.lightPink,
//                                       borderRadius:
//                                       BorderRadius.circular(13.0),
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                           'Science',
//                                           style: TextStyle(
//                                             color: AppThemes.blueColor,
//                                             fontSize: 15.0,
//                                             fontWeight: FontWeight.w900,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: size.height * .010,
//                                         ),
//                                         Row(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                           children: [
//                                             ClipOval(
//                                               child: Image.asset(
//                                                 AppAssets.studentImg,
//                                                 width: 12,
//                                               ),
//                                             ),
//                                             const SizedBox(width: 10),
//                                             Text(
//                                               'By : ',
//                                               style: GoogleFonts.poppins(
//                                                   color: Colors.grey,
//                                                   fontSize: 12.0,
//                                                   fontWeight:
//                                                   FontWeight.w500),
//                                             ),
//                                             Text(
//                                               'Rosie David',
//                                               style: GoogleFonts.poppins(
//                                                   color: Colors.black,
//                                                   fontSize: 12.0,
//                                                   fontWeight:
//                                                   FontWeight.w500),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const Divider(
//           color: AppThemes.dividerColor,
//           height: 0.2,
//           thickness: 1,
//         ),
//         Container(
//           height: size.height * 0.44,
//           decoration: const BoxDecoration(
//             // color: Colors.pink
//               gradient: LinearGradient(
//                   colors: [
//                     AppThemes.primaryColor,
//                     AppThemes.primaryColor,
//                     Colors.white,
//                     Colors.white,
//                   ],
//                   end: Alignment.centerRight,
//                   begin: Alignment.centerLeft,
//                   stops: [0, .5, .501, 1])),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 20, vertical: 20)
//                     .copyWith(bottom: 25),
//                 height: size.height * 0.19,
//                 width: double.maxFinite,
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(40),
//                       bottomLeft: Radius.circular(40),
//                     )),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'assignment'.toUpperCase(),
//                       style: GoogleFonts.poppins(
//                           color: Colors.black,
//                           fontSize: 19,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     teacherHomeController.isAssignmentLoading.value ||
//                         teacherHomeController.getLatestAssignmentModel
//                             .value.data ==
//                             null
//                         ? SizedBox()
//                         : GestureDetector(
//                       onTap: () {
//                         Get.to(() => AssignmentDetailScreen(),
//                             arguments: teacherHomeController
//                                 .getLatestAssignmentModel
//                                 .value
//                                 .data!
//                                 .id
//                                 .toString());
//                       },
//                       child: Column(
//                         children: [
//                           Row(
//                             crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 width: size.width * 0.54,
//                                 // color: Colors.amber,
//                                 child: Text(
//                                   teacherHomeController
//                                       .getLatestAssignmentModel
//                                       .value
//                                       .data!
//                                       .assignmentName!
//                                       .toString(),
//                                   // 'Social Science',
//                                   style: GoogleFonts.poppins(
//                                       color: AppThemes.blueColor,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               Row(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.start,
//                                 children: [
//                                   ClipOval(
//                                     child: Image.asset(
//                                       AppAssets.studentImg,
//                                       width: 13,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 2,
//                                   ),
//                                   Text(
//                                     'By : ',
//                                     style: GoogleFonts.poppins(
//                                         color: Colors.grey,
//                                         fontSize: 12.0,
//                                         fontWeight:
//                                         FontWeight.w500),
//                                   ),
//                                   Container(
//                                     width: size.width * 0.215,
//                                     // color: Colors.amber,
//                                     child: Text(
//                                       teacherHomeController
//                                           .getLatestAssignmentModel
//                                           .value
//                                           .data!
//                                           .teacher!
//                                           .name!
//                                           .toString(),
//                                       // 'Rosie David',
//                                       style: GoogleFonts.poppins(
//                                           color: Colors.black,
//                                           fontSize: 12.0,
//                                           fontWeight:
//                                           FontWeight.w500),
//                                       maxLines: 1,
//                                       overflow:
//                                       TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             teacherHomeController
//                                 .getLatestAssignmentModel
//                                 .value
//                                 .data!
//                                 .detail
//                                 .toString(),
//                             // 'It has survived not only five centuries, but alse the leep into electronic typesetting remaining essentially unchanged. It was popularised in the as survived not only five centuries, but alse the leep into electronic typesetting remaining essentially unchanged. It was popularised in the',
//                             style: TextStyle(
//                                 color: AppThemes.blueColor,
//                                 fontSize: 9,
//                                 fontWeight: FontWeight.w300),
//                             maxLines: 3,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 20, vertical: 18),
//                 width: double.maxFinite,
//                 height: size.height * 0.25,
//                 decoration: const BoxDecoration(
//                     color: AppThemes.primaryColor,
//                     borderRadius:
//                     BorderRadius.only(topRight: Radius.circular(40))),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       'attendance'.toUpperCase(),
//                       style: GoogleFonts.poppins(
//                           color: Colors.white,
//                           fontSize: 19,
//                           fontWeight: FontWeight.w700),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Image.asset(AppAssets.pieChart,width: 90,),
//                         Container(
//                           height: size.height * 0.15,
//                           width: size.width * 0.4,
//                           // color: Colors.red,
//                           child: PieChart(
//                             PieChartData(
//                               pieTouchData: PieTouchData(
//                                 touchCallback: (FlTouchEvent event,
//                                     pieTouchResponse) {
//                                   setState(() {
//                                     if (!event
//                                         .isInterestedForInteractions ||
//                                         pieTouchResponse == null ||
//                                         pieTouchResponse.touchedSection ==
//                                             null) {
//                                       touchedIndex = -1;
//                                       return;
//                                     }
//                                     touchedIndex = pieTouchResponse
//                                         .touchedSection!
//                                         .touchedSectionIndex;
//                                   });
//                                 },
//                               ),
//                               startDegreeOffset: 180,
//                               borderData: FlBorderData(
//                                 show: false,
//                               ),
//                               sectionsSpace: 2,
//                               centerSpaceRadius: 0,
//                               sections: showingSections(),
//                             ),
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: AppThemes.white,
//                                   ),
//                                   width: 13,
//                                   height: 13,
//                                 ),
//                                 SizedBox(
//                                   width: size.width * .030,
//                                 ),
//                                 Text(
//                                   'Present',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                       color: AppThemes.black),
//                                 ),
//                                 SizedBox(
//                                   width: size.width * .13,
//                                 ),
//                                 Text(
//                                   '50%',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppThemes.black),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 12,
//                             ),
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.red,
//                                   ),
//                                   width: 13,
//                                   height: 13,
//                                 ),
//                                 SizedBox(
//                                   width: size.width * .030,
//                                 ),
//                                 Text(
//                                   'Absent ',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.red),
//                                 ),
//                                 SizedBox(
//                                   width: size.width * .13,
//                                 ),
//                                 Text(
//                                   '50%',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppThemes.black),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
