import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/timetable_model.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';

class ClassTimeController extends GetxController{
  RxBool isDataLoading = false.obs;
  Rx<GetTimetableModel> getTimetableModel = GetTimetableModel().obs;
  RxList<MyClass> classList = <MyClass>[].obs;
  // RxInt? selectedClassId;
  RxInt selectedClassId = 0.obs;

  void getMyClass() {
    getMyClassListRepo().then((values) async {
      // print("value : $values");
      if(values != null) {
        // print(" selectedClassId : ${values[0].id}");
        selectedClassId.value = values[0].id;
        print("selectedClassId : ${selectedClassId?.value}");

        classList.clear();
        classList.addAll(values);
        getTimeTableData(classId: selectedClassId.value);

        print("classlist : ${classList?.value}");
      }
    });
  }

  Future<void> getTimeTableData({required int classId}) async {
    try {
      isDataLoading.value = true;

      Map body = {
        "class_id": classId
      };

      // Map body = {
      //   "class_id": 13
      // };

      final response = await http.post(
        Uri.parse(ApiUrls.getTimetable),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {

        var responseData = jsonDecode(response.body);
        print("Time Table responseData  : ${responseData}");

        getTimetableModel.value = GetTimetableModel.fromJson(responseData);
        isDataLoading.value = false;
      } else {
        isDataLoading.value = false;
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteTimetableAPI(BuildContext context,int id) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      final response = await http.delete(
        Uri.parse(ApiUrls.getTimetable+"/${id.toString()}"),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Time Table responseData  : ${responseData}");

        if(responseData['status']) {
          // Get.back();
          Helpers.hideLoader(loader);
          getTimeTableData(classId: selectedClassId.value);
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