import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';

import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';
import '../../widgets/common_textfield.dart';


class MyProfileTeacher extends StatefulWidget {
  const MyProfileTeacher({Key? key}) : super(key: key);

  @override
  State<MyProfileTeacher> createState() => _MyProfileTeacherState();
}

class _MyProfileTeacherState extends State<MyProfileTeacher> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String selectClass = 'Select Subject';
  var selectClassData = [
    'Select Subject',
    'Science', 'Sst', 'English', 'Hindi',
    'Math', 'Computer',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color : AppThemes.white,
          ),


          SizedBox(
              width: double.maxFinite,
              child: Image.asset(AppAssets.myProfileBg,fit: BoxFit.fitWidth,width: double.maxFinite)),
          Positioned(
            left: 0,
            right: 0,
            top: size.height*.045,
            child:   Text("My Profile",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: AppThemes.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w600
              ),),
          ),
          Positioned(
            left: 20,
            top: size.height*.050,
            child: InkWell(
              child: Image.asset(AppAssets.arrowBack,width: 19,color: AppThemes.white,),
              onTap: (){
                Get.back();
                Get.back();
              },
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(AppAssets.studentImg),
              )
          ),
          Positioned(
              left: 0,
              right: 0,
              top: size.height*.30,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){

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
              )
          ),
          Positioned.fill(
              top: size.height*.39,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
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
                        controller: nameController,
                        // validator: MultiValidator([
                        //   RequiredValidator(errorText: 'Password is required'),
                        //   MinLengthValidator(8,
                        //       errorText:
                        //       'Password must be at least 8 digits long'),
                        //   PatternValidator(
                        //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                        //       errorText:
                        //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
                        // ]),
                        hintText: 'Enter Your Name'
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
                    Container(
                      height: 50,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: DropdownButtonFormField(
                        focusColor: Colors.grey.shade50,
                        isExpanded: true,
                        iconEnabledColor: const Color(0xff97949A),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: Text(
                          selectClass,
                          style: const TextStyle(
                              color: Color(0xff463B57),
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.justify,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade50,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffE3E3E3)),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(25.0)))),
                        value: selectClass,
                        items: selectClassData.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectClass = newValue!;
                          });
                        },
                      ),
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
                    const SizedBox(
                      height: 5,
                    ),
                    CommonTextfieldReadOnly(
                        obSecure: false,
                        controller: emailController,
                        readOnly: true,
                        // validator: MultiValidator([
                        //   RequiredValidator(errorText: 'Password is required'),
                        //   MinLengthValidator(8,
                        //       errorText:
                        //       'Password must be at least 8 digits long'),
                        //   PatternValidator(
                        //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                        //       errorText:
                        //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
                        // ]),
                        hintText: 'Enter Your Email'
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
                        controller: emailController,
                        readOnly: true,
                        // validator: MultiValidator([
                        //   RequiredValidator(errorText: 'Password is required'),
                        //   MinLengthValidator(8,
                        //       errorText:
                        //       'Password must be at least 8 digits long'),
                        //   PatternValidator(
                        //       r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                        //       errorText:
                        //       'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
                        // ]),
                        hintText: 'Enter Mobile Number'
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // if(formKey.currentState!.validate()){
                        //   Get.offAllNamed(MyRouters.bottomNavigationScreen);
                        // }
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
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
