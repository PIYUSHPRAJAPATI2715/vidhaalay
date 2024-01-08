import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/terms_condition_model.dart';
import '../repositories/terms_condition_repo.dart';

class GetSettingsController extends GetxController {
  RxBool isTermsLoading = false.obs;
  Rx<TermsConditionModel> getTermsModel = TermsConditionModel().obs;


  Future getTermsData() async {
    isTermsLoading.value = false;
    await termsConditionRepo().then((value) {
      isTermsLoading.value = true;
      getTermsModel.value = value;
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTermsData();
  }
}
