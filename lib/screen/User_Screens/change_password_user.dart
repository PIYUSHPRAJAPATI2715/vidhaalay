import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/widgets/common_textfield.dart';

import '../../repositories/change_password_repo.dart';
import '../../resourses/api_constant.dart';
import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';

class ChangePasswordUser extends StatefulWidget {
  const ChangePasswordUser({Key? key}) : super(key: key);

  @override
  State<ChangePasswordUser> createState() => _ChangePasswordUserState();
}

class _ChangePasswordUserState extends State<ChangePasswordUser> {

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RxBool isPasswordShow = true.obs;
  RxBool isConfirmedPasswordShow = true.obs;
  RxBool isOldPasswordShow = true.obs;

  updatePassword() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (_formKey.currentState!.validate()) {
      changePassRepo(context: context,oldPassword: oldPasswordController.text.trim(),
          password: confirmPasswordController.text.trim(),type: 'user'
      ).then((value) async {
        if(value.status == true){
          showToast(value.msg);
        }else{
          showToast(value.msg);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppThemes.white,
        elevation: 0,
        centerTitle: true,
        leading:  IconButton(
          icon: Image.asset(AppAssets.arrowBack,width: 19,color: AppThemes.textBrown,),
          onPressed: (){
            Get.back();
          },
        ),
        title:  Text("Change Password",
          style: GoogleFonts.poppins(
            color: AppThemes.textBrown,
            fontSize: 17,
            fontWeight: FontWeight.w600
          ),),
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
                  AppThemes.changePassBg,
                  AppThemes.changePassBg,
                ],
                end: Alignment.centerRight,
                begin: Alignment.centerLeft,
                stops: [0, .5, .501, 1],
              ),
            ),
          ),
          Container(
            height: 240,
            decoration: const BoxDecoration(
              color: AppThemes.signupBg,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60)),
              child: Image.asset(AppAssets.changePassBg,fit: BoxFit.fitWidth,width: double.maxFinite,),
            ),
          ),

          Positioned.fill(
            top: 240,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05,vertical: 45),
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: AppThemes.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
              ),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Obx(() {
                      return Column(
                        children: [

                          CommonTextfield(
                              obSecure: isOldPasswordShow.value,
                              controller: oldPasswordController,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  isOldPasswordShow.value = !isOldPasswordShow.value;
                                },
                                child: Icon(
                                    isOldPasswordShow.value
                                        ? CupertinoIcons.eye_slash_fill
                                        : CupertinoIcons.eye,
                                    size: 18,
                                    color: Colors.grey),
                              ),
                              hintText: 'Old Password'
                          ),
                         const SizedBox(
                            height: 25,
                          ),
                          CommonTextfield(
                            controller: passwordController,
                              obSecure: isPasswordShow.value,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Confirm password is required";
                                } else if (value.trim().toString() !=
                                    passwordController.text.trim()) {
                                  return "Confirm password is not matching with password";
                                } else {
                                  return null;
                                }
                              },
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  isPasswordShow.value = !isPasswordShow.value;
                                },
                                child: Icon(
                                    isPasswordShow.value
                                        ? CupertinoIcons.eye_slash_fill
                                        : CupertinoIcons.eye,
                                    size: 18,
                                    color: Colors.grey),
                              ),
                              hintText: 'Password'
                          ),
                         const SizedBox(
                            height: 25,
                          ),
                          CommonTextfield(
                            controller: confirmPasswordController,
                              obSecure: isConfirmedPasswordShow.value,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  isConfirmedPasswordShow.value = !isConfirmedPasswordShow.value;
                                },
                                child: Icon(
                                    isConfirmedPasswordShow.value
                                        ? CupertinoIcons.eye_slash_fill
                                        : CupertinoIcons.eye,
                                    size: 18,
                                    color: Colors.grey),
                              ),
                              hintText: 'Confirm Password'
                          ),
                         const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              updatePassword();
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
                      );
                    })
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
