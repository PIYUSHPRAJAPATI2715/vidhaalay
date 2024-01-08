
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/models/TeacherModel/class_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/exam_type_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/subject_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/teacher_list_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/class_list_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/exam_type_list_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/subject_list_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/teacher_list_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';
import 'package:http/http.dart' as http;

class CreateExamTimeTableController extends GetxController {
  RxList<MyClass> classList = <MyClass>[].obs;
  RxInt selectedClassId = 0.obs;


  RxBool isSubjectLoading = true.obs;
  Rx<SubjectList> getSubjectListModel = SubjectList().obs;
  String? selectedSubject;


  RxBool isTeacherLoading = false.obs;
  Rx<TeacherList> getTeacherListModel = TeacherList().obs;
  String? selectedTeacher;


  RxBool isExamTypeLoading = false.obs;
  Rx<ExamTypeList> getExamTypeModel = ExamTypeList().obs;
  String? selectedExamType;

  RxBool isClassLoading = false.obs;
  Rx<ClassList> getClassListModel = ClassList().obs;
  String? selectedClassForSeating;

  // String? selectedWeekday;
  // RxList<String> weekdayData = [
  //   'Monday', 'Tuesday', 'Wednesday','Thursday','Friday','Saturday'
  // ].obs;

  final fromTime = TextEditingController();
  final toTime = TextEditingController();
  TextEditingController dobController = TextEditingController();


  void getMyClass() {
    getMyClassListRepo().then((values) async {
      // print("value : $values");
      if(values != null) {
        selectedClassId.value = values[0].id;
        classList.clear();
        classList.addAll(values);
        getSubjectListData(classId: selectedClassId.value.toString());
      }
    });
  }

  Future getSubjectListData({required String classId}) async {
    isSubjectLoading.value = true;
    // isSubjectLoading = true.obs;

    await getSubjectListRepo(classId: "4").then((value) {
    // await getSubjectListRepo(classId: classId).then((value) {
      print("subject value : $value");
      getSubjectListModel.value = value;
      // isSubjectLoading = false.obs;
      isSubjectLoading.value = false;
    });
  }

  Future getExamTypeData() async {
    isExamTypeLoading.value = true;
    await getExamTypeListRepo().then((value) {
      print("exam type value : $value");
      getExamTypeModel.value = value;
      isExamTypeLoading.value = false;
    });
  }


  Future getTeacherListData() async {
    isTeacherLoading.value = true;
    await getTeacherListRepo().then((value) {
      print("teacher value : $value");
      getTeacherListModel.value = value;
      isTeacherLoading.value = false;
    });
  }

  Future getClassListData() async {
    isClassLoading.value = true;
    await getClassListRepo().then((value) {
      print("class value : $value");
      getClassListModel.value = value;
      isClassLoading.value = false;
    });
  }

  Future<void> createExamTimetableAPI({required BuildContext context}) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      // isDataLoading.value = true;

      String from = dobController.text +" "+ fromTime.text;
      String to = dobController.text +" "+ toTime.text;
      print(from);
      print(to);

      var body = {
        "exam_type_id": int.parse(selectedExamType!),
        "class_id": selectedClassId.value,
        "seat_class_id": int.parse(selectedClassForSeating!),
        "subject_id": int.parse(selectedSubject!),
        "teacher_id": int.parse(selectedTeacher!),
        // "from": "2023-03-12 04:30:08",
        // "to": "2023-03-12 05:30:08",
        "from": from,
        "to": to,
      };

      final response = await http.post(
        Uri.parse(ApiUrls.addTimetable),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Exam create responseData  : ${responseData}");

        if(responseData['status']) {
          selectedSubject = null;
          selectedTeacher = null;
          dobController.clear();
          fromTime.clear();
          toTime.clear();

          Helpers.hideLoader(loader);
        } else {
          Helpers.hideLoader(loader);
        }
        showToast(responseData['msg'].toString());
      } else {
        Helpers.hideLoader(loader);
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}