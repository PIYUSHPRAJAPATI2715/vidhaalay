import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:vidhaalay_app/repositories/update_profile_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import '../models/get_faq_model.dart';
import '../models/get_notification_model.dart';
import '../models/get_profile_model.dart';
import '../repositories/get_notification_repo.dart';
import '../repositories/get_profile_repo.dart';

class GetProfileController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController uniqueIdController = TextEditingController();

  RxBool isProfileLoading = false.obs;
  Rx<GetProfileModel> getProfileModel = GetProfileModel().obs;


  Future getProfileData() async {
    isProfileLoading.value = false;
    await getProfileRepo().then((value) {
      isProfileLoading.value = true;
      getProfileModel.value = value;
      nameController.text = getProfileModel.value.data!.name.toString();
      emailController.text = getProfileModel.value.data!.email.toString();
      phoneController.text = getProfileModel.value.data!.mobile.toString();
      uniqueIdController.text = getProfileModel.value.data!.uniqueId.toString();
    });
  }

  updateProfile(BuildContext context) {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus!.unfocus();
      updateProfileRepo(context: context,email: emailController.text.trim(),
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
      ).then((value) async {
        if(value.status == true){
          showToast(value.msg.toString());
        }else{
          showToast(value.msg.toString().toString());
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
