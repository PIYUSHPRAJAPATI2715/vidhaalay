
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/models/TeacherModel/add_exam_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/exam_result_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/exam_timetable_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/exam_type_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/student_details_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/repositories/teacher/exam_type_list_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';

class ExamResultStudentController extends GetxController {


  RxBool isDataLoading = true.obs;
  Rx<ExamResultModel> getExamResultModel = ExamResultModel().obs;

  RxBool isExamTypeLoading = true.obs;
  Rx<ExamTypeList> getExamTypeModel = ExamTypeList().obs;
  RxInt selectedExamType = 0.obs;

  String? selectedDate;

  Future getExamTypeData() async {
    isExamTypeLoading.value = true;
    await getExamTypeListRepo().then((values) {
      print("exam type value : $values");

      selectedExamType.value = values.data![0].id!;
      print("selectedExamType : ${selectedExamType?.value}");
      getExamTypeModel.value = values;

      getExamResultData();

      isExamTypeLoading.value = false;
    });
  }

  Future<void> getExamResultData() async {
    try {
      isDataLoading.value = true;

      SharedPreferences pref = await SharedPreferences.getInstance();
      int classId = int.parse(await pref.getString('classId')!);
      int stuID = int.parse(await pref.getString('studentId')!);


      print("classID : $classId");


      Map body = {
        "class_id": classId,
        "student_id": stuID,
        "exam_type_id":
        selectedExamType.value
      };

      print("body : $body");

      final response = await http.post(
        Uri.parse(ApiUrls.getExamResult),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);

      if (response.statusCode == 200) {

        var responseData = jsonDecode(response.body);
        print("Exam result responseData  : ${responseData}");

        getExamResultModel.value = ExamResultModel.fromJson(responseData);
        print("Exam result responseData0  : ${getExamResultModel.value}");

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