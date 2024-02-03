import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/models/TeacherModel/event_details_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/event_list_model.dart';
import 'package:vidhaalay_app/models/studentModel/assignment_detail_model.dart';
import 'package:vidhaalay_app/models/studentModel/assignment_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/resourses/helper.dart';

class AssignmentListStudentController extends GetxController {

  RxBool isDataLoading = true.obs;
  RxBool isDetailsLoading = true.obs;
  Rx<AssignmentDetails> getAssignmentDetailsModel = AssignmentDetails().obs;
  Rx<GetAssignmentModel> getAssignmentModel = GetAssignmentModel().obs;
  RxString selDate = ''.obs;

  Future<void> getAssignmentData() async {
    try {
      print("eNTER");

      isDataLoading.value = true;

      SharedPreferences pref = await SharedPreferences.getInstance();
      int classID = int.parse(await pref.getString('classId')!);
      print("classID : $classID");

      Map body = {
        "date": "2024-01-19",
        "class_id": 6
        // "date": selDate.value,
        // "class_id": classID
      };
      print("body $body");

      final response = await http.post(
        Uri.parse(ApiUrls.assignmentListUrl),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("assign responseData  : ${responseData}");

        getAssignmentModel.value = GetAssignmentModel.fromJson(responseData);
        isDataLoading.value = false;

      } else {
        // isDataLoading.value = false;

        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> getAssignmentDetailsData({required String id}) async {
    try {
      isDetailsLoading.value =  true;

      final response = await http.get(
        Uri.parse(ApiUrls.assignmentListUrl+"/$id"),
        headers: await getAuthHeader(),);

      print("ass Repository...${response.body}");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("assi details responseData  : ${responseData}");

        getAssignmentDetailsModel.value = AssignmentDetails.fromJson(responseData);
        isDetailsLoading.value =  false;
      } else {
        isDetailsLoading.value =  false;
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}