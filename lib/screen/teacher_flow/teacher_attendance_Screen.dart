import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<TeacherAttendanceScreen> createState() => _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {

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
          onPressed: (){},
          icon: Image.asset(AppAssets.moreIcon,width: 25,height: 25,),
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
              height: 180,
              decoration: const BoxDecoration(
                color: AppThemes.primaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text('Student Attendance',
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
                const SizedBox(
                   height: 10,
                 ),
                 Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text('Class-8 th',
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
              )
          ),

          Positioned.fill(
            top: size.height*.230,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 10).copyWith(bottom: 0),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Students',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppThemes.blueColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text('Present',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppThemes.blueColor,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text('Absent',
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
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: size.height,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Row(
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        AppAssets.studentImg,
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text('Marry Jones',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppThemes.blueColor,
                                      ),
                                    ),
                                  ],
                                ),
                                  Row(
                                  children: [
                                    Container(
                                      height: 23,
                                      width: 23,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 6,
                                          color: AppThemes.primaryColor
                                        )
                                      ),
                                    ),
                                     SizedBox(
                                      width: size.width*.12,
                                    ),
                                    Container(
                                      height: 23,
                                      width: 23,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 4,
                                              color: Colors.grey
                                          )
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width*.04,
                                    ),
                                  ],
                                ),
                                 
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
