import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/teacher_flow/teacher_event_screen.dart';
import '../../controller/bottom_controller.dart';
import '../../controller/teacher_controller/teacherHomeController.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    teacherHomeController.getLatestEventData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: double.maxFinite,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, // Change the color here
            ),

            automaticallyImplyLeading: false,
            title: Text('vidhaalay'.toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: AppThemes.primaryColor,
              ),
            ),
            actions: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: size.width*.035).copyWith(left: 0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.toNamed(MyRouters.notificationScreenUser);
                        },
                        child: Image.asset(AppAssets.notification,width: 17,)
                    ),
                    SizedBox(
                      width: size.width*.065,
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(MyRouters.myProfileTeacher);
                      },
                      child: ClipOval(
                        child: Image.asset(
                          AppAssets.studentImg,
                          width: 32,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          /*endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Option 1'),
                  onTap: () {
                    // Add functionality for Option 1
                  },
                ),
                ListTile(
                  title: Text('Option 2'),
                  onTap: () {
                    // Add functionality for Option 2
                  },
                ),
              ],
            ),
          ),*/
          backgroundColor: Colors.transparent,
          body:  SingleChildScrollView(
            child: Obx(
                  () => Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.white,
                          Colors.white,
                          AppThemes.primaryColor,
                          AppThemes.primaryColor,
                        ],
                            end: Alignment.centerRight,
                            begin: Alignment.centerLeft,
                            stops: [0, .5,.501,1]
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding:  EdgeInsets.symmetric(horizontal: size.width*.052,vertical: 30),
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                              color: AppThemes.primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40)
                              )
                          ),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('latest event'.toUpperCase(),
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(
                                height: size.height*.010,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("Tap");
                                  Get.toNamed(MyRouters.celebrationScreenStu, arguments: teacherHomeController.getLatestEventModel.value.data?.id.toString());
                                  // Get.toNamed(MyRouters.teacherEventsScreen);
                                  // Get.to(() => TeacherEventsScreen());
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4.0),
                                          child: SvgPicture.asset(AppAssets.infoImg),
                                        ),
                                        SizedBox(
                                          width : size.width*.035,
                                        ),
                                        !teacherHomeController.isLoading.value ?
                                        teacherHomeController.getLatestEventModel.value.data?.eventName.toString() != null ?
                                        Container(
                                          width: size.width*.74,
                                          // color: Colors.amber,
                                          child: Text(
                                            // "Test test test test test Test test test test test Test test test test test Test test test test test Test test test test test Test test test test test Test test test test test",
                                            teacherHomeController.getLatestEventModel.value.data!.eventName.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ) : Text(" ") :  Text(" "),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: AppThemes.white,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 26.0),
                                  child:
                                  !teacherHomeController.isLoading.value ? Text(
                                    teacherHomeController.getLatestEventModel.value.data!.message.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ): Text(" ")
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                              )
                          ),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: size.width*.052,),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('NEXT CLASS',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Text('10 Am',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width*.050,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 6).copyWith(
                                                  right: 50
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppThemes.lightPink,
                                                borderRadius: BorderRadius.circular(13.0),
                                              ),
                                              child:  Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Science',
                                                    style: TextStyle(
                                                      color: AppThemes.blueColor,
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.w900,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: size.height*.010,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      ClipOval(
                                                        child: Image.asset(
                                                          AppAssets.studentImg,
                                                          width: 12,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        'By :',
                                                        style: GoogleFonts.poppins(
                                                            color: Colors.grey,
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                                      Text(
                                                        'Rosie David',
                                                        style:  GoogleFonts.poppins(
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight.w500
                                                        ),
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
                      ],
                    ),
                  ),

                  const Divider(
                    color: AppThemes.dividerColor,
                    height: 0.2,
                    thickness: 1,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          AppThemes.primaryColor,
                          AppThemes.primaryColor,
                          Colors.white,
                          Colors.white,
                        ],
                            end: Alignment.centerRight,
                            begin: Alignment.centerLeft,
                            stops: [0, .5,.501,1]
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20).copyWith(
                              bottom: 25
                          ),
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                              )
                          ),
                          child:   Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('assignment'.toUpperCase(),
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600
                                ),),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Social Science',
                                    style: GoogleFonts.poppins(
                                        color: AppThemes.blueColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600
                                    ),),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      ClipOval(
                                        child: Image.asset(
                                          AppAssets.studentImg,
                                          width: 13,
                                        ),
                                      ),
                                      Text(
                                        'By :',
                                        style: GoogleFonts.poppins(
                                            color: Colors.grey,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        'Rosie David',
                                        style:  GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('It has survived not only five centuries, but alse the leep into electronic typesetting remaining essentially unchanged. It was popularised in the',
                                style: TextStyle(
                                    color: AppThemes.blueColor,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w300
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                              color:  AppThemes.primaryColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40)
                              )
                          ),
                          child:  Column(
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
                                height: 28,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(AppAssets.pieChart,width: 90,),
                                  Column(
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
                                          Text('50%',
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
                                          Text('Absent ',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width*.13,
                                          ),
                                          Text('50%',
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
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
