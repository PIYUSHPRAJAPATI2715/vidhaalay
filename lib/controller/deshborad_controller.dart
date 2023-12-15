import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/get_school_details_model.dart';
import '../models/school_list_model.dart';
import '../repositories/get_school_details_repo.dart';
import '../repositories/school_list_repo.dart';


class GetSchoolListController extends GetxController {
  RxString roleType = "S".obs;
  RxBool isSchoolListLoading = false.obs;
  RxBool isSchoolDetailsLoading = false.obs;
  Rx<SchoolListModel> getSchoolListModel = SchoolListModel().obs;
  Rx<SchoolDetailsModel> schoolDetailsModel = SchoolDetailsModel().obs;


  Future getSchoolListFunction() async {
    isSchoolListLoading.value = false;
    await schoolListRepo('',roleType.value).then((value) {
      isSchoolListLoading.value = true;
      getSchoolListModel.value = value;
      print(value);
    });
  }

  Future getSchoolDetailsFunction(String id) async {
    isSchoolDetailsLoading.value = false;
    await getSchoolDetailsRepo(id).then((value) {
      isSchoolDetailsLoading.value = true;
      schoolDetailsModel.value = value;
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSchoolListFunction();
    // getSchoolDetailsFunction(3);
  }
}
