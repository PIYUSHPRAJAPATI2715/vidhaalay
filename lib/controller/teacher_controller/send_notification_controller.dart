
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/studentList_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/teacher_list_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/student_list_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/teacher_list_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';
import 'package:http/http.dart' as http;

class SendNotificationController extends GetxController {
  RxInt selectedValue = 0.obs;

  final titleController = TextEditingController();

  // String selectStudent = 'Select Student';
  // var selectStudentData = [
  //   'Select Student',
  //   'ram',
  //   'ram',
  //   'ram',
  // ];

  String? selectClass;
  RxList<MyClass> selectClassData = <MyClass>[].obs;

  RxBool isStudentLoading = true.obs;
  Rx<StudentList> getStudentListModel = StudentList().obs;
  String? selectStudent;

  // String selectClass = 'Select Class';
  // var selectClassData = [
  //   'Select Class',
  //   '7th', '8th', '9th', '10th',
  //   '11th', '12th',
  // ];

  void getMyClass() {
    getMyClassListRepo().then((values) async {
      if(values != null) {
        selectClass = values[0].id.toString();
        getStudentListData(classId: selectClass!);
        selectClassData.clear();
        selectClassData.addAll(values);
      }
    });
  }

  Future getStudentListData({required String classId}) async {
    print("classId : $classId");
    isStudentLoading.value = true;
    await getStudetnListRepo(classId: classId).then((value) {
      getStudentListModel.value = value;
      isStudentLoading.value = false;
    });
  }

  Future<void> sendNotificationAPI({required BuildContext context, required bool isSingleUser}) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      // isDataLoading.value = true;

      Map body = isSingleUser ? {
        "class_id": selectClass,
        "student_id": selectStudent,
        "title": titleController.text,
        "message": "Hello class"
      } : {
        "class_id": selectClass,
        "title": titleController.text,
        "message": "Hello class"
      };
      print("body : $body");

      final response = await http.post(
        Uri.parse(ApiUrls.sendNotificationUrl),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("notification responseData  : ${responseData}");

        if(responseData['status']) {
          Get.back();
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