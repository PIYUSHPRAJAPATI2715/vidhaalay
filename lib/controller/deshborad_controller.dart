import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import '../models/get_school_details_model.dart';
import '../models/school_list_model.dart';
import '../repositories/get_school_details_repo.dart';
import '../repositories/school_list_repo.dart';
import 'package:http/http.dart' as http;


class GetSchoolListController extends GetxController {
  RxString roleType = "S".obs;
  RxBool isSchoolListLoading = false.obs;
  // RxBool isNoRecord = false.obs;
  RxBool isSchoolDetailsLoading = false.obs;

  Rx<SchoolListModel> getSchoolListModel = SchoolListModel().obs;
  Rx<SchoolDetailsModel> schoolDetailsModel = SchoolDetailsModel().obs;

  RxBool isTopSchoolListLoading = true.obs;
  Rx<SchoolListModel> topSchoolListModel = SchoolListModel().obs;

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

  Future getSearchSchoolListFunction(String query) async {
    isSchoolListLoading.value = false;
    await schoolListRepo(query,roleType.value).then((value) {
      isSchoolListLoading.value = true;
      getSchoolListModel.value = value;
      // if(value.data!.isEmpty){
      //   isNoRecord.value = true;
      // }else{
      //   isNoRecord.value = false;
      // }
      print(value);
    });
  }

  Future getSchoolDetailsFunction(String id) async {
    isSchoolDetailsLoading.value = false;
    await getSchoolDetailsRepo(id).then((value) {
      print("api Call00");

      isSchoolDetailsLoading.value = true;
      schoolDetailsModel.value = value;
    });
  }

  Future getTopLectureListRepo() async {
    isTopSchoolListLoading.value = true;
    // print("api Call00");

    // "/${roleType.value}"
    // "/S"

    http.Response response = await http.get(Uri.parse(ApiUrls.topschoolListUrl + "/${roleType.value}"), headers: await getAuthHeader());

    print(response.statusCode);

    if (response.statusCode == 200) {
      print("top school list : ${response.body}");

      topSchoolListModel.value = SchoolListModel.fromJson(jsonDecode(response.body));
      print(topSchoolListModel.value);

      isTopSchoolListLoading.value = false;
    } else {
      isTopSchoolListLoading.value = false;

      throw Exception(response.body);
    }
  }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSchoolListFunction();
    getTopLectureListRepo();
    // getSchoolDetailsFunction(3);
  }
}
