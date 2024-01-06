
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/subject_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/teacher_list_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/subject_list_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/teacher_list_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';
import 'package:http/http.dart' as http;

class CreateTimeTableController extends GetxController {
  RxList<MyClass> classList = <MyClass>[].obs;
  RxInt selectedClassId = 0.obs;

  RxBool isSubjectLoading = true.obs;
  Rx<SubjectList> getSubjectListModel = SubjectList().obs;
  String? selectedSubject;

  RxBool isTeacherLoading = false.obs;
  Rx<TeacherList> getTeacherListModel = TeacherList().obs;
  String? selectedTeacher;

  String? selectedWeekday;
  RxList<String> weekdayData = [
    'Monday', 'Tuesday', 'Wednesday','Thursday','Friday','Saturday'
  ].obs;

  final fromTime = TextEditingController();
  final toTime = TextEditingController();


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

    await getSubjectListRepo(classId: '4').then((value) {
      print("subject value : $value");
      getSubjectListModel.value = value;
      // isSubjectLoading = false.obs;
      isSubjectLoading.value = false;
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

  Future<void> createtimetableAPI({required BuildContext context}) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      // isDataLoading.value = true;

      var body = [
        {
          "class_id": selectedClassId.value,
          "subject_id": int.parse(selectedSubject!),
          "teacher_id": int.parse(selectedTeacher!),
          "weekday": selectedWeekday,
          "from_time": fromTime.text,
          "to_time": toTime.text
        }
      ];
      // selectClass,

      final response = await http.post(
        Uri.parse(ApiUrls.addTimetable),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Event responseData  : ${responseData}");

        if(responseData['status']) {
          Helpers.hideLoader(loader);
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