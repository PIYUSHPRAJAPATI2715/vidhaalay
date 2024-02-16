import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vidhaalay_app/controller/teacher_controller/get_profile_controller_teacher.dart';
import 'package:vidhaalay_app/controller/user_Controller/get_profile_controller.dart';
import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';
import '../../widgets/common_textfield.dart';


class MyProfileTeacher extends StatefulWidget {
  const MyProfileTeacher({Key? key}) : super(key: key);

  @override
  State<MyProfileTeacher> createState() => _MyProfileTeacherState();
}

class _MyProfileTeacherState extends State<MyProfileTeacher> {

  final getTeacherProfileController = Get.put(GetTeacherProfileController());

  @override
  void initState() {
    // getTeacherProfileController.getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () {
          return SizedBox(
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
                      key: getTeacherProfileController.formKey,
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
                            controller: getTeacherProfileController.nameController,
                            hintText: 'Enter name here',
                            // hintText:  getTeacherProfileController.getProfileModel.value.data!.name.toString(),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'name is required'),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Subject',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppThemes.textGray
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2<String>(
                              isExpanded: true,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                hintText: 'Select subject',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide(
                                        color: Colors.grey!.withOpacity(0.5),
                                        width: 1
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide(
                                        color: Colors.grey!.withOpacity(0.5),
                                        width: 1
                                    )
                                ),
                              ),
                              value: getTeacherProfileController.selectClass?.value,
                              items: getTeacherProfileController.selectClassData.toList()
                                  .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  getTeacherProfileController.selectClass?.value = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select subject';
                                }
                                return null;
                              },
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: size.height * 0.28,
                                width: size.width * 0.9,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                isOverButton: false,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),
                                offset: const Offset(0, -10),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all<double>(6),
                                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 45,
                                padding: EdgeInsets.only(left: 10, right: 10),
                              ),
                            ),
                          ),

                          // DropdownButtonFormField<String>(
                          //   value: getTeacherProfileController.selectClass?.value,
                          //   items: getTeacherProfileController.selectClassData.toList()
                          //       .map((item) => DropdownMenuItem(
                          //     value: item,
                          //     child: Text(item),
                          //   ))
                          //       .toList(),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       getTeacherProfileController.selectClass?.value = value!;
                          //     });
                          //   },
                          //   menuMaxHeight: size.height * 0.25,
                          // borderRadius: BorderRadius.circular(10),
                          // style: TextStyle(
                          //   color: Colors.grey,
                          //   fontSize: 15,
                          // ),
                          // decoration: InputDecoration(
                          //     contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          //     hintText: 'Select Subject',
                          //     hintStyle: const TextStyle(
                          //       color: Colors.grey,
                          //       fontSize: 15,
                          //     ),
                          //     errorBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(50),
                          //       borderSide: BorderSide(
                          //           color: Colors.red,
                          //           width: 1
                          //       ),
                          //     ),
                          //     focusedErrorBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(50),
                          //       borderSide: BorderSide(
                          //           color: Colors.red,
                          //           width: 1
                          //       ),
                          //     ),
                          //     enabledBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(50),
                          //         borderSide: BorderSide(
                          //             color: Colors.grey!.withOpacity(0.5),
                          //             width: 1
                          //         )
                          //     ),
                          //
                          //     focusedBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(50),
                          //         borderSide: BorderSide(
                          //             color: Colors.grey!.withOpacity(0.5),
                          //             width: 1
                          //         )
                          //     ),
                          //   ),
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please select subject';
                          //     }
                          //     return null;
                          //   },
                          // ),

                          // Container(
                          //   height: 50,
                          //   width: Get.width,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(25),
                          //   ),
                          //   child: DropdownButtonFormField(
                          //     focusColor: Colors.grey.shade50,
                          //     isExpanded: true,
                          //     iconEnabledColor: const Color(0xff97949A),
                          //     icon: const Icon(Icons.keyboard_arrow_down),
                          //     hint: Text(
                          //       getTeacherProfileController.selectClass.value,
                          //       style: const TextStyle(
                          //           color: Color(0xff463B57),
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.w300),
                          //       textAlign: TextAlign.justify,
                          //     ),
                          //     decoration: InputDecoration(
                          //         fillColor: Colors.grey.shade50,
                          //         contentPadding: const EdgeInsets.symmetric(
                          //             horizontal: 20, vertical: 10),
                          //         focusedBorder: OutlineInputBorder(
                          //           borderSide:
                          //           BorderSide(color: Colors.grey.shade300),
                          //           borderRadius: BorderRadius.circular(25.0),
                          //         ),
                          //         enabledBorder: const OutlineInputBorder(
                          //             borderSide:
                          //             BorderSide(color: Color(0xffE3E3E3)),
                          //             borderRadius: BorderRadius.all(
                          //                 Radius.circular(25.0)))),
                          //     value: getTeacherProfileController.selectClass.value,
                          //     items: getTeacherProfileController.selectClassData.map((String items) {
                          //       return DropdownMenuItem(
                          //         value: items,
                          //         child: Text(
                          //           items,
                          //           style: const TextStyle(
                          //               color: Colors.grey, fontSize: 14),
                          //         ),
                          //       );
                          //     }).toList(),
                          //     onChanged: (String? newValue) {
                          //       setState(() {
                          //         getTeacherProfileController.selectClass.value = newValue!;
                          //       });
                          //     },
                          //   ),
                          // ),

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
                              controller: getTeacherProfileController.emailController,
                              readOnly: true,
                              hintText: 'Enter email here'
                          ),
                          // CommonTextfield(
                          //     obSecure: false,
                          //     controller: getTeacherProfileController.emailController,
                          //     readOnly: false,
                          //     validator: MultiValidator([
                          //       RequiredValidator(errorText: 'email is required'),
                          //       EmailValidator(errorText: "Enter valid email ")
                          //     ]),
                          //     hintText: 'Enter email here'
                          //   // hintText: getTeacherProfileController.getProfileModel.value.data!.email.toString(),
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
                            controller: getTeacherProfileController.phoneController,
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
                              controller: getTeacherProfileController.uniqueIdController,
                              readOnly: true,
                              hintText: 'Enter Unique Id'
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              getTeacherProfileController.updateProfile(context);
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
                            IconButton(
                              icon: Image.asset(
                                AppAssets.arrowBack,
                                width: 19,
                                color: AppThemes.white,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            // GestureDetector(
                            //     onTap: () {
                            //       Navigator.pop(context);
                            //     },
                            //     child:
                            //     Padding(
                            //         padding: EdgeInsets.all(5),
                            //         child: Icon(Icons.arrow_back,color: Colors.white,))
                            // ),
                            // SizedBox(
                            //   width: 15,
                            // ),
                            Container(
                                height: size.height * 0.05,
                                // width: size.width * 0.8,
                                width: size.width * 0.65,
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
                            child:   !getTeacherProfileController.isProfileLoading.value ?
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
                                : getTeacherProfileController.networkProfileImage != null ?
                            CachedNetworkImage(
                              imageUrl:  getTeacherProfileController.networkProfileImage.toString(),
                              fit: BoxFit.fill,
                              // width: double.maxFinite,
                              // height:  double.maxFinite,
                              errorWidget: (__, _, ___) =>
                                  Image.asset(
                                    AppAssets.studentImg,
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

                      // Obx(
                      //       () => Padding(
                      //     padding: EdgeInsets.only(bottom: 15),
                      //     child: Container(
                      //       height: size.height * .16,
                      //       width: size.width * .35,
                      //       decoration: BoxDecoration(
                      //         // color: Colors.green,
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //       child: ClipRRect(
                      //         borderRadius: BorderRadius.circular(15),
                      //         child: getTeacherProfileController.imagePath.value != "" ? Image.file(File(getTeacherProfileController.imagePath.value,),fit: BoxFit.fill)
                      //             : Image.asset(AppAssets.studentImg,fit: BoxFit.fill),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          getTeacherProfileController.selectOption(context);
                          // getTeacherProfileController.pickGalleryImage();
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
          );
        },
      )
    );
  }
}

//
// SingleChildScrollView(
// padding: const EdgeInsets.symmetric(horizontal: 18.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text('Name',
// style: GoogleFonts.poppins(
// fontWeight: FontWeight.w500,
// fontSize: 14,
// color: AppThemes.textGray
// ),
// ),
// const SizedBox(
// height: 5,
// ),
// CommonTextfield(
// obSecure: false,
// controller: getTeacherProfileController.nameController,
// // validator: MultiValidator([
// //   RequiredValidator(errorText: 'Password is required'),
// //   MinLengthValidator(8,
// //       errorText:
// //       'Password must be at least 8 digits long'),
// //   PatternValidator(
// //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
// //       errorText:
// //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
// // ]),
// hintText: 'Enter Your Name'
// ),
// const SizedBox(
// height: 20,
// ),
// Text('Subject',
// style: GoogleFonts.poppins(
// fontWeight: FontWeight.w500,
// fontSize: 14,
// color: AppThemes.textGray
// ),
// ),
// const SizedBox(
// height: 5,
// ),
// Container(
// height: 50,
// width: Get.width,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(25),
// ),
// child: DropdownButtonFormField(
// focusColor: Colors.grey.shade50,
// isExpanded: true,
// iconEnabledColor: const Color(0xff97949A),
// icon: const Icon(Icons.keyboard_arrow_down),
// hint: Text(
// getTeacherProfileController.selectClass.value,
// style: const TextStyle(
// color: Color(0xff463B57),
// fontSize: 16,
// fontWeight: FontWeight.w300),
// textAlign: TextAlign.justify,
// ),
// decoration: InputDecoration(
// fillColor: Colors.grey.shade50,
// contentPadding: const EdgeInsets.symmetric(
// horizontal: 20, vertical: 10),
// focusedBorder: OutlineInputBorder(
// borderSide:
// BorderSide(color: Colors.grey.shade300),
// borderRadius: BorderRadius.circular(25.0),
// ),
// enabledBorder: const OutlineInputBorder(
// borderSide:
// BorderSide(color: Color(0xffE3E3E3)),
// borderRadius: BorderRadius.all(
// Radius.circular(25.0)))),
// value: getTeacherProfileController.selectClass.value,
// items: getTeacherProfileController.selectClassData.map((String items) {
// return DropdownMenuItem(
// value: items,
// child: Text(
// items,
// style: const TextStyle(
// color: Colors.grey, fontSize: 14),
// ),
// );
// }).toList(),
// onChanged: (String? newValue) {
// setState(() {
// getTeacherProfileController.selectClass.value = newValue!;
// });
// },
// ),
// ),
// const SizedBox(
// height: 20,
// ),
// Text('Email Address',
// style: GoogleFonts.poppins(
// fontWeight: FontWeight.w500,
// fontSize: 14,
// color: AppThemes.textGray
// ),
// ),
// const SizedBox(
// height: 5,
// ),
// CommonTextfield(
// obSecure: false,
// controller: getTeacherProfileController.emailController,
// readOnly: false,
// validator: MultiValidator([
// RequiredValidator(errorText: 'email is required'),
// EmailValidator(errorText: "Enter valid email ")
// ]),
// hintText: 'Enter email here'
// // hintText: getTeacherProfileController.getProfileModel.value.data!.email.toString(),
// ),
// const SizedBox(
// height: 20,
// ),
// Text('Mobile Number',
// style: GoogleFonts.poppins(
// fontWeight: FontWeight.w500,
// fontSize: 14,
// color: AppThemes.textGray
// ),
// ),
// const SizedBox(
// height: 5,
// ),
// CommonTextfield(
// obSecure: false,
// readOnly: false,
// controller: getTeacherProfileController.phoneController,
// keyboardType: TextInputType.number,
// hintText: 'Enter number here',
// // getTeacherProfileController.getProfileModel.value.data!.mobile.toString(),
// validator: (value){
// if(value!.isEmpty){
// return "Mobile Number is required";
// }
// else if(value.length<10){
// return 'please enter correct number';
// }
// else{
// return null;
// }
// },
// inputFormatters: [
// LengthLimitingTextInputFormatter(10),
// ],
// ),
// const SizedBox(
// height: 20,
// ),
// Text('Unique Id',
// style: GoogleFonts.poppins(
// fontWeight: FontWeight.w500,
// fontSize: 14,
// color: AppThemes.textGray
// ),
// ),
// const SizedBox(
// height: 5,
// ),
// CommonTextfieldReadOnly(
// obSecure: false,
// controller: getTeacherProfileController.uniqueIdController,
// readOnly: true,
// hintText: 'Enter Mobile Number'
// ),
// const SizedBox(
// height: 20,
// ),
//
// const SizedBox(
// height: 30,
// ),
// ElevatedButton(
// onPressed: () {
// // if(formKey.currentState!.validate()){
// //   Get.offAllNamed(MyRouters.bottomNavigationScreen);
// // }
// },
// style: ElevatedButton.styleFrom(
// minimumSize: const Size(double.maxFinite, 0),
// padding: const EdgeInsets.symmetric(vertical: 12),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(50),
// ),
// backgroundColor: AppThemes.primaryColor,
// ),
// child: Text(
// "save".toUpperCase(),
// style: const TextStyle(
// color: Colors.white,
// fontSize: 16,
// fontWeight: FontWeight.w600,
// ),
// ),
// ),
// ],
// ),
// )