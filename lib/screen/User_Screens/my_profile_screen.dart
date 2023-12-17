import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final getProfileController = Get.put(GetProfileController());
  final GlobalKey<FormState> formKey = GlobalKey();
  updateProfile() {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      updateProfileRepo(context: context,email: emailController.text.trim(),
          name: nameController.text.trim()
      ).then((value) async {
        if(value.status == true){
          showToast(value.msg.toString()!);
        }else{
          showToast(value.msg.toString().toString());
        }
      });
    }
  }


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
              child: Obx(() {
                return getProfileController.isProfileLoading.value == true ?
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Form(
                    key: formKey,
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
                            hintText:  getProfileController.getProfileModel.value.data!.name.toString(),
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
                        CommonTextfield(
                            obSecure: false,
                            controller: emailController,
                            readOnly: false,
                            // validator: MultiValidator([
                            //   RequiredValidator(errorText: 'email is required'),
                            //   EmailValidator(errorText: "Enter valid email ")
                            //   ]),
                            hintText: getProfileController.getProfileModel.value.data!.email.toString(),
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
                            controller: phoneController,
                            keyboardType: TextInputType.number,

                            // validator: MultiValidator([
                            //   RequiredValidator(errorText: 'number is required'),
                            //    ]),
                            hintText: getProfileController.getProfileModel.value.data!.mobile.toString(),
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
                        CommonTextfield(
                          obSecure: false,
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
                          hintText: getProfileController.getProfileModel.value.data!.uniqueId.toString(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            updateProfile();
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
                ) : CommonProgressIndicator();
              })
          )
        ],
      ),
    );
  }
}
