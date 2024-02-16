import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/repositories/profile_image_upload_repo.dart';
import 'package:vidhaalay_app/repositories/update_profile_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';
import '../../models/get_faq_model.dart';
import '../../models/get_notification_model.dart';
import '../../models/get_profile_model.dart';
import '../../repositories/get_notification_repo.dart';
import '../../repositories/get_profile_repo.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class GetProfileController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController uniqueIdController = TextEditingController();

  RxBool isProfileLoading = true.obs;
  Rx<GetProfileModel> getProfileModel = GetProfileModel().obs;
  String? networkProfileImage;
  RxString imagePath = "".obs;

  File? imageNotes;
  String selectedItemNotes = "Camera";

  Future getProfileData() async {
    isProfileLoading.value = false;
    await getProfileRepo().then((value) {
      isProfileLoading.value = true;
      getProfileModel.value = value;
      nameController.text = getProfileModel.value.data!.name.toString();
      emailController.text = getProfileModel.value.data!.email.toString();
      phoneController.text = getProfileModel.value.data!.mobile.toString();
      uniqueIdController.text = getProfileModel.value.data!.uniqueId.toString();
      networkProfileImage = getProfileModel.value.data!.profileImage.toString();
    });
  }


  void selectOption(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppThemes.forgotBg,
          content: Container(
            height: 170,
            color: Colors.transparent,
            child: Center(
              child: Column(
                children: [
                  Text("Select Option", style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: AppThemes.textBlackColor
                  ),),
                  SizedBox(height: 15,),
                  Card(
                    child: ListTile(
                      title: const Text("Camera"),
                      onTap: () {
                        Navigator.pop(context);
                        // isUpdate = false;
                        getImageCamera(context);
                      },
                      leading: const Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text("Gallery"),
                      onTap: () {
                        Navigator.pop(context);
                        // isUpdate = false;
                        getImageGallery(context);
                        // pickGalleryImage();
                      },
                      leading: const Icon(
                        Icons.photo_library_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future getImageCamera(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    final imageTemporary = File(image.path);
    imageNotes = imageTemporary;
    debugPrint(imageNotes.toString());
    bool isUpdated = await UpdateUserProfileApiCall(imageNotes!,context);
    if(isUpdated) {
      getProfileData();
    }
    // bool isUpdated = await UpdateUserProfileApiCall(imageNotes!);
    update();
  }

  Future getImageGallery(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    imageNotes = imageTemporary;
    update();

    // UpdateUserProfileApiCall(imageNotes!);
    bool isUpdated = await UpdateUserProfileApiCall(imageNotes!,context);
    if(isUpdated) {
      getProfileData();
    }

    debugPrint(imageNotes.toString());
    update();
  }

  // Future<void> UpdateUserProfileApiCall(File imageFile) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String token = pref.getString("cookie")!.toString().replaceAll('\"', '').toString();
  //
  //   Map<String, String> headers = {
  //     "Authorization": 'Bearer $token',
  //     "Content-type": "multipart/form-data"
  //   };
  //
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(ApiUrls.uploadProfileImageUrl),
  //   );
  //
  //
  //   request.headers.addAll(headers);
  //
  //   var contentType = MediaType.parse(
  //       lookupMimeType(imageFile.path) ?? 'image/jpeg');
  //
  //   var part = await http.MultipartFile.fromPath(
  //       'image', imageFile.path, contentType: contentType);
  //   request.files.add(part);
  //
  //   print("request: " + request.toString());
  //
  //   var res = await request.send();
  //   var responseBody = await res.stream.bytesToString();
  //
  //   print("This is response:" + res.toString());
  //
  //   if (res.statusCode == 200) {
  //     print('Response: $responseBody');
  //     showToast(message:"Profile image updated successfully.");
  //
  //   } else {
  //     if (res.statusCode == 500) {
  //       showToast(message:"Internal Server Error");
  //     } else {
  //       showToast(message:'Please Update Your Profile Picture!!!');
  //    }
  //   }
  // }

  // Future pickGalleryImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,);
  //   print("pickedFile : ${pickedFile!.path}");
  //   if(pickedFile != null) {
  //     imagePath.value = pickedFile.path;
  //     // File image = File(pickedFile.path);
  //     showToast(message:"Image picked.");
  //   } else {
  //     showToast(message:"No Image picked.");
  //     Get.back();
  //   }
  // }

  updateProfile(BuildContext context) {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      updateProfileRepo(context: context,email: emailController.text.trim(),
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
      ).then((value) async {
        if(value.status == true){

          bool isEmailVerify = value.data!.emailVerified!;
          bool isMobileVerify = value.data!.mobileVerified!;
          // String userRole = value.data!.userType.toString();
          print("isEmailVerify : $isEmailVerify");
          print("isMobileVerify : $isMobileVerify");

          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setBool('emailVerify', isEmailVerify);
          pref.setBool('mobileVerify', isMobileVerify);

          if (!isEmailVerify || !isMobileVerify) {
            showToast(message:"Please verify your details.");

            Get.offAllNamed(MyRouters.verifyOtpLogin, arguments: [
              value.data!.email.toString(),
              value.data!.mobile.toString(),
              isMobileVerify,
              isEmailVerify
            ]);
          } else {
            Get.back();
            // showToast(message: "Your profile has been saved");
            showToast(message:value.msg.toString());
          }

        } else {
          showToast(message:value.msg.toString().toString(),isError: true);
        }
      });
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileData();
  }
}
