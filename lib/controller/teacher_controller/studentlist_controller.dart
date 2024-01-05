
import 'dart:convert';

import 'package:get/get.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/student_details_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/student_list_repo.dart';
import '../../models/TeacherModel/studentList_model.dart';
import 'package:http/http.dart' as http;

import '../../resourses/api_constant.dart';

class StudentListController extends GetxController{
  RxBool isLoading = false.obs;
  Rx<StudentList> getStudentListModel = StudentList().obs;
  RxBool isDetailsLoading = false.obs;
  Rx<StudentDetails> getStudentDetailsModel = StudentDetails().obs;

  RxList<MyClass> classList = <MyClass>[].obs;
  RxInt selectedClassId = 0.obs;

  void getMyClass() {
    getMyClassListRepo().then((values) async {
      // print("value : $values");
      if(values != null) {
        selectedClassId.value = values[0].id;
        classList.clear();
        classList.addAll(values);

        getStudentListData(classId: selectedClassId.value.toString());
      }
    });
  }

  Future getStudentListData({required String classId}) async {
    isLoading.value = true;
    await getStudetnListRepo(classId: classId).then((value) {
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