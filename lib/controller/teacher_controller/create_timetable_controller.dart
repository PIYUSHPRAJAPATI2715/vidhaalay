
import 'package:get/get.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/subject_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/teacher_list_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/subject_list_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/teacher_list_repo.dart';

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

}