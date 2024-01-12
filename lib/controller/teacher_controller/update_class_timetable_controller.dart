
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/controller/teacher_controller/class_time_controller.dart';
import 'package:vidhaalay_app/models/TeacherModel/class_timetable_details_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/subject_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/teacher_list_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/subject_list_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/teacher_list_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';
import 'package:http/http.dart' as http;

class UpdateClassTimeTableController extends GetxController {
  Rx<ClassTimetableDetails> getDetailsModel = ClassTimetableDetails().obs;
  RxBool isDetailsLoading = false.obs;

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

  Future<void> getTimeTableDetailsData({required String id}) async {
    try {
      isDetailsLoading.value =  true;

      final response = await http.get(
        Uri.parse(ApiUrls.getTimetable+"/$id"),
        headers: await getAuthHeader(),);

      print("Class Time table Repository...${response.body}");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Class Time table responseData  : ${responseData}");

        getDetailsModel.value = ClassTimetableDetails.fromJson(responseData);


        fromTime.text = getDetailsModel.value.data!.fromTime!;
        toTime.text = getDetailsModel.value.data!.toTime!;

        selectedClassId.value = getDetailsModel.value.data!.classId!;
        selectedSubject = getDetailsModel.value.data!.subjectId!.toString();
        selectedTeacher = getDetailsModel.value.data!.teacherId!.toString();
        selectedWeekday = getDetailsModel.value.data!.weekday!.toString();


        isDetailsLoading.value =  false;
      } else {
        isDetailsLoading.value =  false;
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future<void> updateExamTimeTableAPI({required BuildContext context,required String id}) async {
  //   try {
  //     OverlayEntry loader = Helpers.overlayLoader(context);
  //     Overlay.of(context).insert(loader);
  //
  //     // isDataLoading.value = true;
  //
  //     String from = dobController.text +" "+ fromTime.text;
  //     String to = dobController.text +" "+ toTime.text;
  //
  //     var body = {
  //       "class_id": selectedClassId.value,
  //       "exam_type_id": int.parse(selectedExamType!),
  //       "seat_class_id": int.parse(selectedClassForSeating!),
  //       "subject_id": int.parse(selectedSubject!),
  //       "teacher_id": int.parse(selectedTeacher!),
  //       // "from":"2024-01-08 04:30:00",
  //       // "to":"2024-01-08 05:30:00"
  //       "from": from,
  //       "to": to
  //     };
  //     print("body : $body");
  //
  //     final response = await http.put(
  //       // Uri.parse(ApiUrls.apiBaseUrl + "exam/24"),
  //       Uri.parse(ApiUrls.getExamTimetable+"/$id"),
  //       body: jsonEncode(body),
  //       headers: await getAuthHeader(),);
  //
  //     if (response.statusCode == 200) {
  //       var responseData = jsonDecode(response.body);
  //       print("Exam update responseData  : ${responseData}");
  //
  //       if(responseData['status']) {
  //
  //         Helpers.hideLoader(loader);
  //
  //         // Get.back();
  //         Get.back();
  //
  //         final examTimeTableController = Get.put(ExamTimeTableController());
  //         examTimeTableController.getExamTimeTableData();
  //
  //         selectedSubject = null;
  //         selectedTeacher = null;
  //         dobController.clear();
  //         fromTime.clear();
  //         toTime.clear();
  //
  //       } else {
  //         Helpers.hideLoader(loader);
  //       }
  //       showToast(responseData['msg'].toString());
  //     } else {
  //       Helpers.hideLoader(loader);
  //       throw Exception(response.body);
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  Future<void> updateClassTimetableAPI({required BuildContext context,required String id}) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      // isDataLoading.value = true;

      var body = {
        "class_id": selectedClassId.value,
        "subject_id": int.parse(selectedSubject!),
        "teacher_id": int.parse(selectedTeacher!),
        "weekday": selectedWeekday,
        "from_time": fromTime.text,
        "to_time": toTime.text
      };

      final response = await http.put(
        // Uri.parse(ApiUrls.apiBaseUrl + "exam/24"),
        Uri.parse(ApiUrls.getTimetable+"/$id"),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Class update responseData  : ${responseData}");

        if(responseData['status']) {

          Helpers.hideLoader(loader);
          // Get.back();

          final classTimeController = Get.put(ClassTimeController());

          // List<String> dateParts = dobController.text.split('-');
          // classTimeController.selectedIndex.value = int.parse(dateParts[2]) - 1;
          // classTimeController.selectedMonthIndex.value = int.parse(dateParts[1]) - 1;
          // print("sel Date Index: ${classTimeController.selectedIndex.value}");
          // print("sel Month Index: ${classTimeController.selectedMonthIndex.value}");
          // classTimeController.selectedDate = dobController.text;

          classTimeController.selectedClassId.value = selectedClassId.value;
          classTimeController.getTimeTableData();

          selectedSubject = null;
          selectedTeacher = null;
          fromTime.clear();
          toTime.clear();
          Get.back();

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