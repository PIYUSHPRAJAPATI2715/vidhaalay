import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';


class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  final List<String> months = [
    'January', 'February', 'March', 'April',
    'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December'
  ];
   final List<String> days = [
     'S','M','T','W','T','F','S'
   ];
  final int numberOfDays = 31;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppThemes.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent,
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
            height: 120,
            decoration: const BoxDecoration(
              color: AppThemes.primaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: months.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          months[index],
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          days[index],
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Positioned.fill(
            top: size.height*.155,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40).copyWith(bottom: 0),
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppThemes.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final day = index + 1;
                          if (day <= numberOfDays) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              margin: const EdgeInsets.all(2),
                              child: Text(
                                day.toString().padLeft(2, '0'),
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Divider(
                      color: AppThemes.dividerColor,
                      height: 1.2,
                      thickness: 2,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: size.width * 0.06,vertical: 20).copyWith(bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppThemes.black,
                                ),
                                width: 13,
                                height: 13,
                              ),
                             const SizedBox(
                                width: 8,
                              ),

                              Text('Today',
                                style: GoogleFonts.poppins(
                                    color: AppThemes.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(AppAssets.pieChart,width: 130,),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppThemes.primaryColor,
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
            ),
          ),
        ],
      ),
    );
  }
}
