import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/models/TeacherModel/event_details_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/event_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/studentModel/assignment_detail_model.dart';
import 'package:vidhaalay_app/models/studentModel/assignment_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/resourses/helper.dart';

class AssignmentListTeacherController extends GetxController {


  RxList<MyClass> classList = <MyClass>[].obs;
  RxInt selectedClassId = 0.obs;

  RxBool isDataLoading = true.obs;
  RxBool isDetailsLoading = false.obs;
  Rx<AssignmentDetails> getAssignmentDetailsModel = AssignmentDetails().obs;
  Rx<GetAssignmentModel> getAssignmentModel = GetAssignmentModel().obs;
  // RxString selDate = ''.obs;

  RxString selectedDate = "".obs;
  RxInt selectedIndex = 0.obs;
  RxInt selectedMonthIndex = 0.obs;



  void getMyClass() {
    getMyClassListRepo().then((values) async {
      if(values != null) {
        selectedClassId.value = values[0].id;
        classList.clear();
        classList.addAll(values);
        getAssignmentData();
      }
    });
  }

  Future<void> getAssignmentData() async {
    try {
      print("eNTER");

      isDataLoading.value = true;

      Map body = {
        "date": "2023-01-13",
        "class_id": 6
        // "date": selectedDate.value,
        // "class_id":  selectedClassId.value
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

  Future<void> deleteAssignmentAPI(BuildContext context,int id) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      final response = await http.delete(
        Uri.parse(ApiUrls.deleteAssignment+"/${id.toString()}"),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("assignment responseData  : ${responseData}");

        if(responseData['status']) {
          // Get.back();
          Helpers.hideLoader(loader);
          getAssignmentData();
        } else {
          Helpers.hideLoader(loader);
        }
        showToast(responseData['msg'].toString());
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}