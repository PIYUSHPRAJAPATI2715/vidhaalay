
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class ExamResultController extends GetxController {
  RxBool isDetailsLoading = false.obs;
  Rx<StudentDetails> getStudentDetailsModel = StudentDetails().obs;

  RxBool isDataLoading = false.obs;
  Rx<ExamResultModel> getExamResultModel = ExamResultModel().obs;

  // RxList<MyClass> classList = <MyClass>[].obs;
  RxInt selectedClassId = 0.obs;

  RxBool isExamTypeLoading = false.obs;
  Rx<ExamTypeList> getExamTypeModel = ExamTypeList().obs;

  RxInt selectedExamType = 0.obs;
  // String? selectedExamType;

  String? selectedDate;
  RxInt stuId = 0.obs;



  // void getMyClass() {
  //   getMyClassListRepo().then((values) async {
  //     // print("value : $values");
  //     if(values != null) {
  //       // print(" selectedClassId : ${values[0].id}");
  //       selectedClassId.value = values[0].id;
  //       print("selectedClassId : ${selectedClassId?.value}");
  //
  //       classList.clear();
  //       classList.addAll(values);
  //       // getExamTimeTableData();
  //
  //       print("classlist : ${classList?.value}");
  //     }
  //   });
  // }

  Future getStudetnDetails({required int stuId}) async {
    print(" stuId : $stuId");
    isDetailsLoading.value = true;

    http.Response response = await http.get(Uri.parse(ApiUrls.studentDetails+"/$stuId"), headers: await getAuthHeader());
    print(response.statusCode);
    print("stud det : ${response.body}");

    if (response.statusCode == 200) {
      getStudentDetailsModel.value = StudentDetails.fromJson(jsonDecode(response.body));

      selectedClassId.value = getStudentDetailsModel.value.data!.classId!;
      print("selectedClassId : ${selectedClassId?.value}");

      getExamTypeData();
      isDetailsLoading.value = false;
    } else {
      isDetailsLoading.value = false;
      throw Exception(response.body);
    }
  }

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

      Map body = {
        "class_id": selectedClassId.value,
        "student_id": stuId.value,
        "exam_type_id":
        // 4
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

  Future<void> createExamResultAPI(BuildContext context) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      // isDataLoading.value = true;

      Map body = {
        "id": 0,
        "exam_id": 0,
        "class_id": 4,
        "student_id": 4,
        "exam_type_id": 4,
        "marks": "32",
        "totalMarks": 100,
        "passingMarks": 36
      };
      // selectClass,

      final response = await http.post(
        Uri.parse(ApiUrls.addExamResult),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("ADD Exam result responseData  : ${responseData}");

        // createEventModel.value = CreateEvent.fromJson(responseData);
        //
        // if(createEventModel.value.status!) {
        //   Get.back();
        //   Helpers.hideLoader(loader);
        // } else {
        //   Helpers.hideLoader(loader);
        // }
        // showToast(createEventModel.value.msg.toString());
      } else {

        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}