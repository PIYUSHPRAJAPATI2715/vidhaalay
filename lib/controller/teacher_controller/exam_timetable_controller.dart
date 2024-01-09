
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/models/TeacherModel/exam_timetable_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/exam_type_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/repositories/teacher/exam_type_list_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';

class ExamTimeTableController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<GetExamTimetableModel0> getExamTimetableModel = GetExamTimetableModel0().obs;

  RxList<MyClass> classList = <MyClass>[].obs;
  RxInt selectedClassId = 0.obs;

  RxBool isExamTypeLoading = false.obs;
  Rx<ExamTypeList> getExamTypeModel = ExamTypeList().obs;
  RxInt selectedExamType = 0.obs;
  // String? selectedExamType;

  String? selectedDate;



  void getMyClass() {
    getMyClassListRepo().then((values) async {
      // print("value : $values");
      if(values != null) {
        // print(" selectedClassId : ${values[0].id}");
        selectedClassId.value = values[0].id;
        print("selectedClassId : ${selectedClassId?.value}");

        classList.clear();
        classList.addAll(values);
        getExamTimeTableData();

        print("classlist : ${classList?.value}");
      }
    });
  }

  Future getExamTypeData() async {
    isExamTypeLoading.value = true;
    await getExamTypeListRepo().then((values) {
      print("exam type value : $values");

      selectedExamType.value = values.data![0].id!;
      print("selectedClassId : ${selectedClassId?.value}");

      getExamTypeModel.value = values;
      isExamTypeLoading.value = false;
    });
  }

  Future<void> getExamTimeTableData() async {
    try {
      isDataLoading.value = true;

      Map body = {
        "class_id": selectedClassId.value,
        "exam_type_id": selectedExamType.value,
        "date": selectedDate
      };

      print("body : $body");


      // Map body = {
      //   "class_id": 13
      // };

      final response = await http.post(
        Uri.parse(ApiUrls.getExamTimetable),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);

      if (response.statusCode == 200) {

        var responseData = jsonDecode(response.body);
        print("Exam Time Table responseData  : ${responseData}");

        getExamTimetableModel.value = GetExamTimetableModel0.fromJson(responseData);
        print("Exam Time Table responseData0  : ${getExamTimetableModel.value}");

        isDataLoading.value = false;

      } else {

        isDataLoading.value = false;
        throw Exception(response.body);

      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }



  Future<void> deleteExamTimetableAPI(BuildContext context,int id) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      final response = await http.delete(
        Uri.parse(ApiUrls.getExamTimetable+"/${id.toString()}"),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Time Table responseData  : ${responseData}");

        if(responseData['status']) {
          // Get.back();
          Helpers.hideLoader(loader);
          getExamTimeTableData();
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