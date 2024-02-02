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

class GetTeacherProfileController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController uniqueIdController = TextEditingController();

  RxString? selectClass;
  // RxString selectClass = 'Select Subject'.obs;
  var selectClassData = [
    // 'Select Subject',
    'Science', 'English', 'Hindi',
    'Math', 'Computer',
  ];

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
      networkProfileImage = getProfileModel.value.data!.profileImage;
      // update();
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

  // Future getImageCamera() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (image == null) return;
  //
  //   final imageTemporary = File(image.path);
  //   imageNotes = imageTemporary;
  //   debugPrint(imageNotes.toString());
  //
  //   // validateImgeSize(imageNotes!);
  //   UpdateUserProfileApiCall(imageNotes!);
  // }
  //
  // Future getImageGallery() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image == null) return;
  //
  //   final imageTemporary = File(image.path);
  //   imageNotes = imageTemporary;
  //
  //   UpdateUserProfileApiCall(imageNotes!);
  //
  //   debugPrint(imageNotes.toString());
  // }
  //
  // void selectOption(BuildContext context) {
  //   showDialog<void>(
  //     context: context,
  //     builder: (BuildContext dialogContext) {
  //       return AlertDialog(
  //         backgroundColor: AppThemes.forgotBg,
  //         content: Container(
  //           height: 170,
  //           color: Colors.transparent,
  //           child: Center(
  //             child: Column(
  //               children: [
  //                 Text("Select Option", style: GoogleFonts.poppins(
  //                     fontWeight: FontWeight.w500,
  //                     fontSize: 17,
  //                     color: AppThemes.textBlackColor
  //                 ),),
  //                 SizedBox(height: 15,),
  //                 Card(
  //                   child: ListTile(
  //                     title: const Text("Camera"),
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                       // isUpdate = false;
  //                       getImageCamera();
  //                     },
  //                     leading: const Icon(
  //                       Icons.camera_alt,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ),
  //                 Card(
  //                   child: ListTile(
  //                     title: const Text("Gallery"),
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                       // isUpdate = false;
  //                       getImageGallery();
  //                       // pickGalleryImage();
  //                     },
  //                     leading: const Icon(
  //                       Icons.photo_library_rounded,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }




  updateProfile(BuildContext context) {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      updateProfileRepo(context: context,email: emailController.text.trim(),
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
      ).then((value) async {
        if(value.status == true){
          showToast(message:value.msg.toString());
        } else {
          showToast(message:value.msg.toString().toString());
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
