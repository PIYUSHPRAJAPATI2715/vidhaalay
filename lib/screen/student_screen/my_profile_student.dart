import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vidhaalay_app/controller/student_controller/get_student_profile_controller.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';

import '../../resourses/app_assets.dart';
import '../../resourses/size.dart';
import '../../widgets/appTheme.dart';
import '../../widgets/common_textfield.dart';


class MyProfileScreenStu extends StatefulWidget {
  const MyProfileScreenStu({Key? key}) : super(key: key);

  @override
  State<MyProfileScreenStu> createState() => _MyProfileScreenStuState();
}

class _MyProfileScreenStuState extends State<MyProfileScreenStu> {

    final getStudentProfileController = Get.put(GetStudentProfileController());

  @override
  void initState() {
    // getStudentProfileController.getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Obx(
          () =>  Container(
            height: size.height,
            width: size.width,
            // color: Colors.deepOrange,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.37,left: 20,right: 20),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: getStudentProfileController.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppThemes.textGray
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            controller: getStudentProfileController.nameController,
                            hintText: 'Enter name here',
                            // hintText:  getStudentProfileController.getProfileModel.value.data!.name.toString(),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'name is required'),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Parents Name',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppThemes.textGray
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CommonTextfieldReadOnly(
                              obSecure: false,
                              controller: getStudentProfileController.parentsNameController,
                              readOnly: true,
                              hintText: 'Enter Your Parents Name'
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Blood Group',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppThemes.textGray
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CommonTextfieldReadOnly(
                              obSecure: false,
                              controller: getStudentProfileController.bloodGroupController,
                              readOnly: true,
                              hintText: 'Enter Your Blood Group'
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Address',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppThemes.textGray
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CommonTextfieldReadOnly(
                              obSecure: false,
                              controller: getStudentProfileController.addressController,
                              readOnly: true,
                              hintText: 'Enter Your Address'
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Email Address',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppThemes.textGray
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CommonTextfieldReadOnly(
                              obSecure: false,
                              controller: getStudentProfileController.emailController,
                              readOnly: true,
                              hintText: 'Enter email here'
                          ),
                          // CommonTextfield(
                          //     obSecure: false,
                          //     controller: getStudentProfileController.emailController,
                          //     readOnly: false,
                          //     validator: MultiValidator([
                          //       RequiredValidator(errorText: 'email is required'),
                          //       EmailValidator(errorText: "Enter valid email ")
                          //     ]),
                          //     hintText: 'Enter email here'
                          //   // hintText: getStudentProfileController.getProfileModel.value.data!.email.toString(),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Mobile Number',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppThemes.textGray
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CommonTextfieldReadOnly(
                            obSecure: false,
                            controller: getStudentProfileController.phoneController,
                            readOnly: true,
                            hintText: 'Enter number here',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Unique Id',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppThemes.textGray
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CommonTextfieldReadOnly(
                              obSecure: false,
                              controller: getStudentProfileController.uniqueIdController,
                              readOnly: true,
                              hintText: 'Enter Unique Id'
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              getStudentProfileController.updateProfile(context);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.maxFinite, 0),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              backgroundColor: AppThemes.primaryColor,
                            ),
                            child: Text(
                              "save".toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: size.height * 0.245,
                        // color: Colors.green,
                        child: Image.asset(AppAssets.myProfileBg,fit: BoxFit.fill,alignment: Alignment.topCenter,)
                    ),
                    Positioned(
                        top: 45,
                        left: 20,
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back,color: Colors.white,)),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                                height: size.height * 0.05,
                                // width: size.width * 0.8,
                                width: size.width * 0.72,
                                // width: 260,
                                // color: Colors.black,
                                child: Center(
                                    child: Text("My profile",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          color: AppThemes.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600
                                      ),)
                                )
                            ),
                          ],
                        )
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.16),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                       Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Container(
                                height: size.height * .16,
                                width: size.width * .35,
                                decoration: BoxDecoration(
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child:  getStudentProfileController.isProfileLoading.value ?
                                  Shimmer.fromColors(
                                    // ignore: sort_child_properties_last
                                    child:
                                    Container(height: 86,
                                        width: 154,
                                        color: Colors.grey),
                                    baseColor: Colors
                                        .grey[300]!,
                                    highlightColor: Colors
                                        .grey[400]!,
                                  )
                                  // Image.asset(AppAssets.studentImg,fit: BoxFit.fill)
                                      : getStudentProfileController.networkProfileImage != null ?
                                  CachedNetworkImage(
                                    imageUrl:  getStudentProfileController.networkProfileImage.toString(),
                                    fit: BoxFit.fill,
                                    // width: double.maxFinite,
                                    // height:  double.maxFinite,
                                    errorWidget: (__, _, ___) =>
                                        Image.asset(
                                          AppAssets.collageImg,
                                          fit: BoxFit.cover,
                                          width: double.maxFinite,
                                        ),
                                    imageBuilder: (context,
                                        imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              // colorFilter: ColorFilter.mode(
                                              //     Colors.red, BlendMode.colorBurn),
                                            ),
                                          ),
                                        ),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                          // ignore: sort_child_properties_last
                                          child:
                                          Container(height: 86,
                                              width: 154,
                                              color: Colors.grey),
                                          baseColor: Colors
                                              .grey[300]!,
                                          highlightColor: Colors
                                              .grey[400]!,
                                        ),
                                  )
                                  // Image.network(getTeacherProfileController.networkProfileImage.toString(),fit: BoxFit.fill)
                                      : Image.asset(AppAssets.studentImg,fit: BoxFit.fill),
                                ),
                              ),
                            ),
                      GestureDetector(
                        onTap: () {
                          getStudentProfileController.selectOption(context);
                          // getStudentProfileController.pickGalleryImage();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                              color: AppThemes.primaryColor,
                              shape: BoxShape.circle
                          ),
                          child: Image.asset(AppAssets.camera,height: 15,),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  // final TextEditingController getStudentProfileController.parentsNameController = TextEditingController();
  // final TextEditingController bloodGrpController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  //
  // Rx<File> image = File("").obs;
  //
  // @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //         Container(
  //           color : AppThemes.white,
  //         ),
  //
  //
  //         SizedBox(
  //             width: double.maxFinite,
  //             child: Image.asset(AppAssets.myProfileBg,fit: BoxFit.fitWidth,width: double.maxFinite)),
  //         Positioned(
  //           left: 0,
  //           right: 0,
  //           top: size.height*.045,
  //           child:   Text("My Profile",
  //             textAlign: TextAlign.center,
  //             style: GoogleFonts.poppins(
  //                 color: AppThemes.white,
  //                 fontSize: 19,
  //                 fontWeight: FontWeight.w600
  //             ),),
  //         ),
  //
  //         Positioned(
  //           left: 20,
  //           top: size.height*.050,
  //           child: GestureDetector(
  //             child: Image.asset(AppAssets.arrowBack,width: 19,color: AppThemes.white,),
  //             onTap: (){
  //
  //               Get.toNamed(MyRouters.bottomNavigationScreen);
  //             },
  //           ),
  //         ),
  //         Positioned(
  //             left: 0,
  //             right: 0,
  //             top: 0,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(6),
  //               child: GestureDetector(
  //                 onTap: (){
  //                     // NewHelper()
  //                     //     .addFilePicker()
  //                     //     .then((value) {
  //                     //   image.value = value;
  //                     // });
  //                 },
  //                   child: image.value.path == ""?
  //                       GestureDetector(
  //                         onTap: (){
  //                           // NewHelper()
  //                           //     .addFilePicker()
  //                           //     .then((value) {
  //                           //   image.value = value;
  //                           // });
  //                         },
  //                         child:  Image.asset(AppAssets.studentImg),
  //                       ):SizedBox(
  //                       width: double.maxFinite,
  //                       height: AddSize.size100,
  //                       child: Image.file(image.value)),
  //               ),
  //             )
  //         ),
  //         Positioned(
  //             left: 0,
  //             right: 0,
  //             top: size.height*.30,
  //             child: Column(
  //               children: [
  //                 GestureDetector(
  //                   onTap: (){
  //
  //                   },
  //                   child: Container(
  //                     padding: const EdgeInsets.all(6),
  //                     decoration: const BoxDecoration(
  //                         color: AppThemes.primaryColor,
  //                         shape: BoxShape.circle
  //                     ),
  //                     child: Image.asset(AppAssets.camera,height: 15,),
  //                   ),
  //                 ),
  //               ],
  //             )
  //         ),
  //         Positioned.fill(
  //             top: size.height*.39,
  //             child: SingleChildScrollView(
  //               padding: const EdgeInsets.symmetric(horizontal: 18.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('Name',
  //                     style: GoogleFonts.poppins(
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 14,
  //                         color: AppThemes.textGray
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   CommonTextfield(
  //                       obSecure: false,
  //                       controller: nameController,
  //                       // validator: MultiValidator([
  //                       //   RequiredValidator(errorText: 'Password is required'),
  //                       //   MinLengthValidator(8,
  //                       //       errorText:
  //                       //       'Password must be at least 8 digits long'),
  //                       //   PatternValidator(
  //                       //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
  //                       //       errorText:
  //                       //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
  //                       // ]),
  //                       hintText: 'Enter Your Name'
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Text('Parents Name',
  //                     style: GoogleFonts.poppins(
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 14,
  //                         color: AppThemes.textGray
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   CommonTextfield(
  //                       obSecure: false,
  //                       controller: getStudentProfileController.parentsNameController,
  //                       // validator: MultiValidator([
  //                       //   RequiredValidator(errorText: 'Password is required'),
  //                       //   MinLengthValidator(8,
  //                       //       errorText:
  //                       //       'Password must be at least 8 digits long'),
  //                       //   PatternValidator(
  //                       //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
  //                       //       errorText:
  //                       //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
  //                       // ]),
  //                       hintText: 'Enter Your Parents Name'
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Text('Blood Group',
  //                     style: GoogleFonts.poppins(
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 14,
  //                         color: AppThemes.textGray
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   CommonTextfield(
  //                       obSecure: false,
  //                       controller: getStudentProfileController.parentsNameController,
  //                       // validator: MultiValidator([
  //                       //   RequiredValidator(errorText: 'Password is required'),
  //                       //   MinLengthValidator(8,
  //                       //       errorText:
  //                       //       'Password must be at least 8 digits long'),
  //                       //   PatternValidator(
  //                       //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
  //                       //       errorText:
  //                       //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
  //                       // ]),
  //                       hintText: 'Enter Your Blood Group'
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Text('Address',
  //                     style: GoogleFonts.poppins(
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 14,
  //                         color: AppThemes.textGray
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   CommonTextfield(
  //                       obSecure: false,
  //                       controller: getStudentProfileController.parentsNameController,
  //                       // validator: MultiValidator([
  //                       //   RequiredValidator(errorText: 'Password is required'),
  //                       //   MinLengthValidator(8,
  //                       //       errorText:
  //                       //       'Password must be at least 8 digits long'),
  //                       //   PatternValidator(
  //                       //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
  //                       //       errorText:
  //                       //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
  //                       // ]),
  //                       hintText: 'Enter Your Address'
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Text('Email Address',
  //                     style: GoogleFonts.poppins(
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 14,
  //                         color: AppThemes.textGray
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   CommonTextfield(
  //                       obSecure: false,
  //                       controller: emailController,
  //                       // validator: MultiValidator([
  //                       //   RequiredValidator(errorText: 'Password is required'),
  //                       //   MinLengthValidator(8,
  //                       //       errorText:
  //                       //       'Password must be at least 8 digits long'),
  //                       //   PatternValidator(
  //                       //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
  //                       //       errorText:
  //                       //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
  //                       // ]),
  //                       hintText: 'Enter Your Email'
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Text( "Unique Id,Mobile No./Email Id",
  //                     style: GoogleFonts.poppins(
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 14,
  //                         color: AppThemes.textGray
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   CommonTextfield(
  //                       obSecure: false,
  //                       controller: emailController,
  //                       readOnly: true,
  //                       // validator: MultiValidator([
  //                       //   RequiredValidator(errorText: 'Password is required'),
  //                       //   MinLengthValidator(8,
  //                       //       errorText:
  //                       //       'Password must be at least 8 digits long'),
  //                       //   PatternValidator(
  //                       //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
  //                       //       errorText:
  //                       //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
  //                       // ]),
  //                       hintText: 'Enter Unique Id,Mobile No./Email Id'
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //
  //                   const SizedBox(
  //                     height: 30,
  //                   ),
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       // if(formKey.currentState!.validate()){
  //                       //   Get.offAllNamed(MyRouters.bottomNavigationScreen);
  //                       // }
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       minimumSize: const Size(double.maxFinite, 0),
  //                       padding: const EdgeInsets.symmetric(vertical: 12),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(50),
  //                       ),
  //                       backgroundColor: AppThemes.primaryColor,
  //                     ),
  //                     child: Text(
  //                       "save".toUpperCase(),
  //                       style: const TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //                  const SizedBox(
  //                     height: 40,
  //                   ),
  //                 ],
  //               ),
  //             )
  //         )
  //       ],
  //     ),
  //   );
  // }
}
