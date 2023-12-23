import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/resourses/size.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import '../../controller/get_profile_controller.dart';
import '../../repositories/update_profile_repo.dart';
import '../../resourses/api_constant.dart';
import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';
import '../../widgets/common_textfield.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  final getProfileController = Get.put(GetProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getProfileController.getProfileData();
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                    key: getProfileController.formKey,
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
                          controller: getProfileController.nameController,
                          hintText: 'Enter name here',
                          // hintText:  getProfileController.getProfileModel.value.data!.name.toString(),
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'name is required'),
                          ]),
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
                        CommonTextfield(
                            obSecure: false,
                            controller: getProfileController.emailController,
                            readOnly: false,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'email is required'),
                              EmailValidator(errorText: "Enter valid email ")
                            ]),
                            hintText: 'Enter email here'
                          // hintText: getProfileController.getProfileModel.value.data!.email.toString(),
                        ),
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
                        CommonTextfield(
                          obSecure: false,
                          readOnly: false,
                          controller: getProfileController.phoneController,
                          keyboardType: TextInputType.number,
                          hintText: 'Enter number here',
                          // getProfileController.getProfileModel.value.data!.mobile.toString(),
                          validator: (value){
                            if(value!.isEmpty){
                              return "Mobile Number is required";
                            }
                            else if(value.length<10){
                              return 'please enter correct number';
                            }
                            else{
                              return null;
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Text('Unique Id',
                        //   style: GoogleFonts.poppins(
                        //       fontWeight: FontWeight.w500,
                        //       fontSize: 14,
                        //       color: AppThemes.textGray
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        // CommonTextfield(
                        //   obSecure: false,
                        //   readOnly: true,
                        //   onTap: () {
                        //     // showToast("you can not change your unique Id");
                        //   },
                        //   controller: getProfileController.uniqueIdController,
                        //   hintText: getProfileController.getProfileModel.value.data!.uniqueId.toString(),
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            getProfileController.updateProfile(context);
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
                    Obx(
                      () => Padding(
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
                            child: getProfileController.imagePath.value != "" ? Image.file(File(getProfileController.imagePath.value,),fit: BoxFit.fill)
                                            : Image.asset(AppAssets.studentImg,fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getProfileController.pickGalleryImage();
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
        )
    );
  }
}