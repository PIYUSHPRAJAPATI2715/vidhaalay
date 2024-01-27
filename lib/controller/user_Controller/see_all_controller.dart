import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:vidhaalay_app/models/get_school_details_model.dart';
import 'package:vidhaalay_app/models/school_list_model.dart';
import 'package:vidhaalay_app/repositories/get_school_details_repo.dart';
import 'package:vidhaalay_app/repositories/school_list_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:http/http.dart' as http;


class SeeAllController extends GetxController {
  RxString roleType = "S".obs;
  RxBool isSchoolListLoading = false.obs;
  Rx<SchoolListModel> getSchoolListModel = SchoolListModel().obs;

  RxBool isSchoolDetailsLoading = false.obs;
  Rx<SchoolDetailsModel> schoolDetailsModel = SchoolDetailsModel().obs;

  Future getSchoolListFunction() async {
    print("Enter");

    isSchoolListLoading.value = false;
    // update();

    await schoolListRepo('',roleType.value).then((value) {
      print("value $value");
      isSchoolListLoading.value = true;
      getSchoolListModel.value = value;
      // update();
      print(value);
    });
  }

  // Future getSchoolDetailsFunction(String id) async {
  //   isSchoolDetailsLoading.value = false;
  //   await getSchoolDetailsRepo(id).then((value) {
  //     print("api Call00");
  //
  //     isSchoolDetailsLoading.value = true;
  //     schoolDetailsModel.value = value;
  //   });
  // }
}
