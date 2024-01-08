import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  StudentListController studentListController = Get.put(StudentListController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentListController.getMyClass();
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text('Student List',
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
                    () => studentListController.classList.value.isEmpty ? SizedBox.shrink() :  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Class - ',
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
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value:  studentListController.selectedClassId?.value,
                              // style: TextStyle(
                              //     color: Colors.green,
                              //     fontSize: 12,
                              //     fontWeight: FontWeight.w300),
                              icon: Icon(Icons.keyboard_arrow_down,color: Colors.white),
                              dropdownColor: Colors.white70,
                              items: studentListController.classList.value.toList().map((items) {
                                return DropdownMenuItem(
                                  value: items.id,
                                  child: Text(items.name,style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: studentListController.selectedClassId?.value == items.id
                                        ? Colors.white
                                    // Colors.grey.shade900 // Change the color for selected item
                                        : Colors.black, // Default color for unselected items
                                  ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                studentListController.selectedClassId!.value = newValue!;
                                print(studentListController.selectedClassId?.value);

                                studentListController.getStudentListData(classId: studentListController.selectedClassId.value.toString());
                              },
                            ),
                          )
                        ]
                    ),
                  )
                ],
              )
          ),

          Positioned.fill(
            top: size.height*.230,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 5).copyWith(bottom: 0,right: 3),
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppThemes.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
              ),
              child: Obx(
                () =>  studentListController.getStudentListModel.value.data != null?
                studentListController.getStudentListModel.value.data!.isEmpty ?
                Center(
                  child: Text(
                    "No Student List Available",
                    style: TextStyle(
                        color: Colors.black, fontSize: 15),
                  ),
                ) :
                SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Students',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: AppThemes.blueColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: studentListController.getStudentListModel.value.data?.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            MyRouters.studentDetailsScreen,arguments: studentListController.getStudentListModel.value.data![index].id);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius
                                                    .circular(10),
                                                boxShadow: const[
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    // Shadow color
                                                    blurRadius: 1,
                                                    // Spread radius
                                                    spreadRadius: 0,
                                                    // How much the shadow spreads
                                                    offset: Offset(0,
                                                        1), // Offset in (x, y) direction
                                                  ),
                                                ]
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    ClipOval(
                                                      child: CachedNetworkImage(
                                                        imageUrl: studentListController.getStudentListModel.value.data![index].profileImage.toString(),
                                                        fit: BoxFit.cover,
                                                        height: 30, width: 30,
                                                        errorWidget: (__, _, ___) =>
                                                            CircleAvatar(
                                                              child: Image.asset(
                                                                AppAssets.studentImg,
                                                                fit: BoxFit.cover,
                                                                height: 30, width: 30,
                                                              ),
                                                            ),
                                                        placeholder: (__, _) =>
                                                        const Center(
                                                            child:
                                                            CircularProgressIndicator()),
                                                      ),
                                                      // Image.asset(
                                                      //   AppAssets.studentImg,
                                                      //   height: 30, width: 30,
                                                      // ),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Text(
                                                      studentListController.getStudentListModel.value.data![index].name.toString(),
                                                      style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: 15,
                                                        color: AppThemes.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                    onTap: () {},
                                                    child: const Icon(
                                                      Icons.keyboard_arrow_right,
                                                      color: Colors.grey,))
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          )
                                        ],
                                      ),
                                    );
                                  })

                                  //   Padding(
                                  //   padding: EdgeInsets.only(top: 8),
                                  //   child: Card(
                                  //     elevation: 2.0,
                                  //     color: Colors.white,
                                  //     child: ListTile(
                                  //       leading: CircleAvatar(
                                  //         // radius: 25,
                                  //         child: CachedNetworkImage(
                                  //           imageUrl: studentListController.getStudentListModel.value.data![index].profileImage.toString(),
                                  //           fit: BoxFit.cover,
                                  //           width: size.width,
                                  //           height: size.height * .16,
                                  //           errorWidget: (__, _, ___) =>
                                  //               CircleAvatar(
                                  //                 child: Image.asset(
                                  //                   AppAssets.collageImg,
                                  //                   fit: BoxFit.cover,
                                  //                   width: size.width,
                                  //                   height: size.height * .16,
                                  //                 ),
                                  //               ),
                                  //           placeholder: (__, _) =>
                                  //           const Center(
                                  //               child:
                                  //               CircularProgressIndicator()),
                                  //         ),
                                  //       ),
                                  //       title: Text(studentListController.getStudentListModel.value.data![index].name.toString(),style: GoogleFonts.poppins(
                                  //         fontSize: 18,
                                  //         fontWeight: FontWeight.w500,
                                  //         color: Colors.grey,
                                  //       ),),
                                  //       trailing: InkWell(
                                  //           onTap: (){
                                  //
                                  //           },
                                  //           child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.grey,)),
                                  //
                                  //     ),
                                  //   ),
                                  // );
                                // },)

                            ],
                          ),
                        ),
                      ],
                    )
                ) :  Container(
                    height: size.height * .44,
                    width: size.width,
                    child:
                    Center(child: CommonProgressIndicator())
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
