import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/get_faq_model.dart';
import '../models/get_notification_model.dart';
import '../models/get_profile_model.dart';
import '../repositories/get_notification_repo.dart';
import '../repositories/get_profile_repo.dart';

class GetProfileController extends GetxController {
  RxBool isProfileLoading = false.obs;
  Rx<GetProfileModel> getProfileModel = GetProfileModel().obs;


  Future getProfileData() async {
    isProfileLoading.value = false;
    await getProfileRepo().then((value) {
      isProfileLoading.value = true;
      getProfileModel.value = value;
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileData();
  }
}
