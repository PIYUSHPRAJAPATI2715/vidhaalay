import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  State<ExamResultScreenTeacher> createState() => _ExamResultScreenTeacherState();
}

class _ExamResultScreenTeacherState extends State<ExamResultScreenTeacher> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Result',
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
              height: size.height*.230,
              decoration: const BoxDecoration(
                color: AppThemes.primaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        ClipOval(
                          child: Image.asset(AppAssets.studentImg,width: 45,height: 45,),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rosie Kumar',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: AppThemes.white,
                              ),
                            ),
                            Text('Class 8th',
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
                        )
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text('Half Yearly',
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
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text('August - November',
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
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10).copyWith(bottom: 0),
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
                      children: const[
                          Expanded(
                           flex: 2,
                          child:  Text(
                          'Date',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppThemes.blueColor,
                          ),
                        ),),

                         Expanded(
                           flex: 4,
                          child:  Text(
                          'Subjects',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppThemes.blueColor,
                          ),
                        ),),
                         Expanded(
                           flex: 2,
                          child:  Text(
                          'Out of 100',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppThemes.blueColor,
                          ),
                        ),),
                      ],
                    ),
                      SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 22,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text('16th Mar',
                                        style: GoogleFonts.poppins(
                                            color: AppThemes.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600
                                        ),),
                                    ),

                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 28.0).copyWith(left: 0),
                                        child: Container(
                                          width: size.width*.40,
                                          padding: const EdgeInsets.all(9),
                                          decoration: BoxDecoration(
                                              color: AppThemes.lightPink,
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text('Social Science',
                                                style: GoogleFonts.poppins(
                                                    color: AppThemes.blueColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              Text('0/100',
                                                style: GoogleFonts.poppins(
                                                    color: AppThemes.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600
                                                ),),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CommonTextFieldResult(
                                        hintText: '0',
                                        obSecure: false,
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
                        child: const CustomOutlineButton(
                          title: 'Send',
                          backgroundColor: AppThemes.primaryColor,

                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:  SizedBox(
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
                onTap: (){},
                child:  const Center(
                  child:  Text(
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
    );
  }
}
