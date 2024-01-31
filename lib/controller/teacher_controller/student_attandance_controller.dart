import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/models/TeacherModel/add_attandance_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/get_attandance_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/studentList_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/student_list_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';
import 'package:http/http.dart' as http;

class StudentAttandanceController extends GetxController {
  RxList<MyClass> classList = <MyClass>[].obs;
  RxInt selectedClassId = 0.obs;

  // RxBool isLoading = false.obs;
  // Rx<StudentList> getStudentListModel = StudentList().obs;

  RxBool isAttandanceDataLoading = true.obs;
  Rx<GetAttandanceListData> getAttandanceListData = GetAttandanceListData().obs;

  RxList isPresent = [].obs;
  RxList<AddAttandanceModel> addAttandanceModel = <AddAttandanceModel>[].obs;

  void getMyClass() {
    getMyClassListRepo().then((values) async {
      // print("value : $values");
      if(values != null) {
        selectedClassId.value = values[0].id;
        classList.clear();
        classList.addAll(values);


        // getStudentListData(classId: selectedClassId.value.toString());
        getAttandanceListDataAPI(classId: selectedClassId.value.toString());

      }
    });
  }

  Future getAttandanceListDataAPI({required String classId}) async {
    isAttandanceDataLoading.value = true;

    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    print("Formatted Date: $formattedDate");

    var body = {
      "class_id": int.parse(classId),
      "date": formattedDate
    };

    http.Response response = await http.post(
        Uri.parse(ApiUrls.getAttendance),
        body: jsonEncode(body),
        headers: await getAuthHeader());
    print(response.statusCode);

    if (response.statusCode == 200) {
      print("Att responseData  : ${response.body}");
      getAttandanceListData.value = GetAttandanceListData.fromJson(jsonDecode(response.body));
      isAttandanceDataLoading.value = false;

    } else {
      // isAttandanceDataLoading.value = false;
      throw Exception(response.body);
    }
  }

  manageAddAttandance({required int studentId, required bool isPresent,}) {
    List<Map<String, dynamic>> listMap = addAttandanceModel.map((model) => model.toJson()).toList();
    // print("Value0 : ${listMap}");

    bool isStudentIdPresent = listMap.any((map) => map['student_id'] == studentId);
    // print("isStudentId4Present : $isStudentIdPresent");

    if(isStudentIdPresent) {
      int indexOfStudentId = listMap.indexWhere((map) => map['student_id'] == studentId);
      // print("indexOfStudentId : $indexOfStudentId");
      addAttandanceModel[indexOfStudentId] = AddAttandanceModel(classId: selectedClassId.value,studentId: studentId,present: isPresent);
    } else {
      addAttandanceModel.add(AddAttandanceModel(classId: selectedClassId.value,studentId: studentId,present: isPresent));
    }

    listMap.clear();
    listMap = addAttandanceModel.map((model) => model.toJson()).toList();
    print("Value0 : ${listMap}");
  }

  Future<void> addAttandanceAPI(BuildContext context) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

    List<Map<String, dynamic>> listMap = getAttandanceListData.value.data!.map((model) => model.toJson()).toList();
      print("listMap : $listMap");

      // List<Map<String, dynamic>> listMap = addAttandanceModel.map((model) => model.toJson()).toList();

      // Map body = {
      //   "event_name": eventName.text,
      //   "event_class_id": int.parse(selectClass!),
      //   "message": message.text,
      //   "date": dobController.text
      // };

      final response = await http.post(
        Uri.parse(ApiUrls.addAttendance),
        body: jsonEncode(listMap),
        headers: await getAuthHeader(),);

      print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Event responseData  : ${responseData}");

        if(responseData['status']) {
          // Get.back();
          Helpers.hideLoader(loader);
        } else {
          Helpers.hideLoader(loader);
        }
        showToast(message:responseData['msg'].toString());
      } else {

        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}