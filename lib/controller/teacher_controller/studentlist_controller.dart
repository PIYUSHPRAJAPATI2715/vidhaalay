
import 'dart:convert';

import 'package:get/get.dart';
import 'package:vidhaalay_app/models/TeacherModel/student_details_model.dart';
import 'package:vidhaalay_app/repositories/teacher/student_list_repo.dart';
import '../../models/TeacherModel/studentList_model.dart';
import 'package:http/http.dart' as http;

import '../../resourses/api_constant.dart';

class StudentListController extends GetxController{
  RxBool isLoading = false.obs;
  Rx<StudentList> getStudentListModel = StudentList().obs;
  RxBool isDetailsLoading = false.obs;
  Rx<StudentDetails> getStudentDetailsModel = StudentDetails().obs;


  Future getStudentListData() async {
    isLoading.value = true;
    await getStudetnListRepo(classId: '4').then((value) {
      getStudentListModel.value = value;
      isLoading.value = false;
    });
  }

  Future getStudetnDetails({required int stuId}) async {
    isDetailsLoading.value = true;

    http.Response response = await http.get(Uri.parse(ApiUrls.studentDetails+"/$stuId"), headers: await getAuthHeader());
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      getStudentDetailsModel.value = StudentDetails.fromJson(jsonDecode(response.body));
      isDetailsLoading.value = false;
    } else {
      isDetailsLoading.value = false;
      throw Exception(response.body);
    }
  }
}