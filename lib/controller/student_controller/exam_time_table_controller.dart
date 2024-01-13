
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/models/TeacherModel/exam_timetable_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/exam_type_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/repositories/teacher/exam_type_list_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';

class StudentExamTimeTableController extends GetxController {
  RxBool isDataLoading = true.obs;
  Rx<GetExamTimetableModel0> getExamTimetableModel = GetExamTimetableModel0().obs;

  RxBool isExamTypeLoading = true.obs;
  Rx<ExamTypeList> getExamTypeModel = ExamTypeList().obs;
  RxInt selectedExamType = 0.obs;
  // String? selectedExamType;

  String? selectedDate;

  RxInt selectedIndex = 0.obs;
  RxInt selectedMonthIndex = 0.obs;


  Future getExamTypeData() async {
    isExamTypeLoading.value = true;
    await getExamTypeListRepo().then((values) {
      print("exam type value : $values");

      selectedExamType.value = values.data![0].id!;
      // print("selectedClassId : ${selectedClassId?.value}");
      getExamTimeTableData();

      getExamTypeModel.value = values;
      isExamTypeLoading.value = false;
    });
  }

  Future<void> getExamTimeTableData() async {
    try {
      isDataLoading.value = true;

      SharedPreferences pref = await SharedPreferences.getInstance();
      int classId = int.parse(await pref.getString('classId')!);
      print("classID : $classId");


      Map body = {
        "class_id": classId,
        "exam_type_id": selectedExamType.value,
        "date": selectedDate
        // "class_id": 4,
        // "exam_type_id": 4,
        // "date": "2024-01-08"
      };

      print("body : $body");

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

}