
import 'dart:convert';

import 'package:get/get.dart';
import 'package:vidhaalay_app/models/TeacherModel/student_details_model.dart';
import '../../models/TeacherModel/studentList_model.dart';
import 'package:http/http.dart' as http;

import '../../resourses/api_constant.dart';

class StudentListController extends GetxController{
  RxBool isLoading = false.obs;
  Rx<StudentList> getStudentListModel = StudentList().obs;
  RxBool isDetailsLoading = false.obs;
  Rx<StudentDetails> getStudentDetailsModel = StudentDetails().obs;

  Future<StudentList> getStudetnListRepo() async {
    http.Response response = await http.get(Uri.parse(ApiUrls.studentList+"/4"), headers: await getAuthHeader());
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);

      return StudentList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future getStudentListData() async {
    isLoading.value = true;
    await getStudetnListRepo().then((value) {
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