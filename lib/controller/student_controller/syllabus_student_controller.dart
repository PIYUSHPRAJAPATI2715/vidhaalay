import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/models/TeacherModel/class_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/subject_list_model.dart';
import 'package:vidhaalay_app/models/studentModel/syllabus_student_model.dart';
import 'package:vidhaalay_app/repositories/teacher/class_list_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/subject_list_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';

class SyllabusStudentController extends GetxController {
  RxBool isDataLoading = true.obs;
  Rx<GetSyllabusModel> getSyllabusModel = GetSyllabusModel().obs;

  RxBool isSubjectLoading = true.obs;
  Rx<SubjectList> getSubjectListModel = SubjectList().obs;
  int? selectedSubject;


  RxBool isClassLoading = true.obs;
  Rx<ClassList> getClassListModel = ClassList().obs;
  int? selectedClass;

  Future getClassListData() async {
    isClassLoading.value = true;
    await getClassListRepo().then((value) {
      print("class value : $value");
      getClassListModel.value = value;
      isClassLoading.value = false;
      selectedClass = value.data![0].id;
      getSubjectListData();
    });
  }

  Future getSubjectListData() async {
    isSubjectLoading.value = true;
    // isSubjectLoading = true.obs;

    SharedPreferences pref = await SharedPreferences.getInstance();
    String classID = await pref.getString('classId')!;

    await getSubjectListRepo(classId: selectedClass!.toString()).then((value) {
      print("subject value : $value");
      getSubjectListModel.value = value;
      getSyllabusData();
      isSubjectLoading.value = false;
      selectedSubject = getSubjectListModel.value.data![0].id;
      update();
    });
  }

  Future<void> getSyllabusData() async {
    try {
      print("eNTER");

      isDataLoading.value = true;

      // SharedPreferences pref = await SharedPreferences.getInstance();
      // int classID = int.parse(await pref.getString('classId')!);
      // print("classID : $classID");

      Map body = {
        "subject_id": selectedSubject,
        "class_id": selectedClass
      };
      print("body $body");

      final response = await http.post(
        Uri.parse(ApiUrls.syllabusUrl),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("assign responseData  : ${responseData}");

        getSyllabusModel.value = GetSyllabusModel.fromJson(responseData);
        isDataLoading.value = false;

      } else {
        // isDataLoading.value = false;

        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}