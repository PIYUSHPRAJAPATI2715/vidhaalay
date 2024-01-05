import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/models/TeacherModel/add_attandance_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/studentList_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/student_list_repo.dart';

class StudentAttandanceController extends GetxController {
  RxList<MyClass> classList = <MyClass>[].obs;
  RxInt selectedClassId = 0.obs;

  RxBool isLoading = false.obs;
  Rx<StudentList> getStudentListModel = StudentList().obs;

  RxList isPresent = [].obs;
  RxList<AddAttandanceModel> addAttandanceModel = <AddAttandanceModel>[].obs;

  // List<BehaviorSubject<bool>> rxBools = List.generate(
  //   50,
  //       (index) => BehaviorSubject<bool>.seeded(false),
  // );

  // String selectedOption = '';

  // RxBool isPresent = false.obs;

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

      // List list = List.generate(
      //     getStudentListModel.value.data!.length, (_) => false);
      // isPresent.addAll(list);
      // print("list : ${list}");

      isPresent.value =  List.generate(
          getStudentListModel.value.data!.length, (_) => false);

      print("isPresent : ${isPresent.value}");

      isLoading.value = false;
    });
  }
}