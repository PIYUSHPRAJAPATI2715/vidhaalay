import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/subject_list_model.dart';
import 'package:vidhaalay_app/models/studentModel/assignment_detail_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/repositories/teacher/subject_list_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';


class UpdateAssignmentController extends GetxController {
  // Rx<CreateAssignment> createAssignmentModel = CreateAssignment().obs;
  RxBool isDetailsLoading = false.obs;
  Rx<AssignmentDetails> getAssignmentDetailsModel = AssignmentDetails().obs;

  TextEditingController dobController = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController assignmentName = TextEditingController();

  RxString selectStudent = 'Select Student'.obs;
  RxList selectStudentData = [
    'Select Student',
    'ram',
    'ram',
    'ram',
  ].obs;

  String? selectClass;
  RxList<MyClass> selectClassData = <MyClass>[].obs;
  // RxInt selectClass = 0.obs;

  RxBool isSubjectLoading = true.obs;
  Rx<SubjectList> getSubjectListModel = SubjectList().obs;
  String? selectedSubject;

  void getMyClass() {
    getMyClassListRepo().then((values) async {
      if(values != null) {
        selectClass = values[0].id.toString();

        getSubjectListData(classId: selectClass.toString());

        selectClassData.clear();
        selectClassData.addAll(values);
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


  Future<void> getAssignmentDetailsData({required String id}) async {
    try {
      isDetailsLoading.value =  true;

      final response = await http.get(
        Uri.parse(ApiUrls.assignmentListUrl+"/$id"),
        headers: await getAuthHeader(),);

      print("ass Repository...${response.body}");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("assi details responseData  : ${responseData}");

        getAssignmentDetailsModel.value = AssignmentDetails.fromJson(responseData);
        message.text = getAssignmentDetailsModel.value.data!.detail!;
        assignmentName.text = getAssignmentDetailsModel.value.data!.assignmentName!;
        dobController.text = getAssignmentDetailsModel.value.data!.dueDate!;
        selectClass = getAssignmentDetailsModel.value.data!.classId!.toString();
        // selectedSubject = getAssignmentDetailsModel.value.data!.s!.toString();

        isDetailsLoading.value =  false;
      } else {
        isDetailsLoading.value =  false;
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateAssignmentAPI({required BuildContext context,required String id}) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      Map body = {
        "assignment_name": assignmentName.text,
        "subject_id": int.parse(selectedSubject!),
        "class_id" : int.parse(selectedSubject!),
        "detail": message.text,
        // "date": "${dobController.text}T23:55:06.957Z",
        "tagline": "${dobController.text}T23:55:06.957Z"
      };

      final response = await http.put(
        Uri.parse(ApiUrls.updateAssignment+"/$id"),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Assignment responseData  : ${responseData}");

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

  void selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF7ED957),
                // header background color
                onPrimary: Colors.white,
                // header text color
                onSurface: Color(0xFF7ED957), // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF7ED957), // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate:  DateTime.now(),
        lastDate: DateTime(2099));

    if (pickedDate != null) {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      dobController.text = dateFormat.format(pickedDate);
    }
  }

}