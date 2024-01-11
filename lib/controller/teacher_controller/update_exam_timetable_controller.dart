
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/controller/teacher_controller/exam_timetable_controller.dart';
import 'package:vidhaalay_app/models/TeacherModel/class_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/exam_timetable_details_model.dart';
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

class UpdateExamTimeTableController extends GetxController {
  Rx<ExamTimetableDetails> getDetailsModel = ExamTimetableDetails().obs;
  RxBool isDetailsLoading = false.obs;

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

  Future<void> updateExamTimeTableAPI({required BuildContext context,required String id}) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      // isDataLoading.value = true;

      String from = dobController.text +" "+ fromTime.text;
      String to = dobController.text +" "+ toTime.text;

      var body = {
        "class_id": selectedClassId.value,
        "exam_type_id": int.parse(selectedExamType!),
        "seat_class_id": int.parse(selectedClassForSeating!),
        "subject_id": int.parse(selectedSubject!),
        "teacher_id": int.parse(selectedTeacher!),
        // "from":"2024-01-08 04:30:00",
        // "to":"2024-01-08 05:30:00"
        "from": from,
        "to": to
      };
      print("body : $body");

      final response = await http.put(
        // Uri.parse(ApiUrls.apiBaseUrl + "exam/24"),
        Uri.parse(ApiUrls.getExamTimetable+"/$id"),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Exam update responseData  : ${responseData}");

        if(responseData['status']) {

          Helpers.hideLoader(loader);

          // Get.back();
          Get.back();

          final examTimeTableController = Get.put(ExamTimeTableController());
          examTimeTableController.getExamTimeTableData();

          selectedSubject = null;
          selectedTeacher = null;
          dobController.clear();
          fromTime.clear();
          toTime.clear();

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

  Future<void> getTimeTableDetailsData({required String id}) async {
    try {
      isDetailsLoading.value =  true;

      final response = await http.get(
          Uri.parse(ApiUrls.getExamTimetable+"/$id"),
          headers: await getAuthHeader(),);

    print("Time table Repository...${response.body}");

    if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    print("time table responseData  : ${responseData}");

    getDetailsModel.value = ExamTimetableDetails.fromJson(responseData);

    DateTime timestampUtc = DateTime.parse(getDetailsModel.value.data!.from!);
    String formattedDate = "${timestampUtc.year}-${(timestampUtc.month)}-${(timestampUtc.day)}";
    String formattedTime = "${timestampUtc.hour}:${(timestampUtc.minute)}:00";
    fromTime.text = formattedTime;
    dobController.text = formattedDate;

    DateTime timestampUtc1 = DateTime.parse(getDetailsModel.value.data!.to!);
    String formattedTime1 = "${timestampUtc1.hour}:${(timestampUtc1.minute)}:00";
    toTime.text = formattedTime1;

    selectedClassId.value = getDetailsModel.value.data!.classId!;
    selectedExamType = getDetailsModel.value.data!.examTypeId!.toString();
    selectedSubject = getDetailsModel.value.data!.subjectId!.toString();
    selectedTeacher = getDetailsModel.value.data!.teacherId!.toString();
    selectedClassForSeating = getDetailsModel.value.data!.seatClassId!.toString();
   

    isDetailsLoading.value =  false;
    } else {
    isDetailsLoading.value =  false;
    throw Exception(response.body);
    }
    } catch (e) {
    throw Exception(e.toString());
    }
  }

}