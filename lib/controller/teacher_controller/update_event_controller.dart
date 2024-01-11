import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/controller/teacher_controller/event_detail_controller.dart';
import 'package:vidhaalay_app/models/TeacherModel/event_details_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/event_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';
import 'package:http/http.dart' as http;

class UpdateEventController extends GetxController {
  Rx<EventDetails> getEventDetailsModel = EventDetails().obs;
  RxBool isDetailsLoading = false.obs;

  TextEditingController dobController = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController eventName = TextEditingController();

  RxString selectStudent = 'Select Student'.obs;
  RxList selectStudentData = [
    'Select Student',
    'ram',
    'ram',
    'ram',
  ].obs;

  // String selectClass = 'Select Class';
  String? selectClass;
  RxList<MyClass> selectClassData = <MyClass>[].obs;
  // RxInt selectClass = 0.obs;

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
        firstDate: DateTime(1990),
        lastDate: DateTime(2025));

    if (pickedDate != null) {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      dobController.text = dateFormat.format(pickedDate);
    }
  }

  void getMyClass() {
    getMyClassListRepo().then((values) async {
      if(values != null) {
        selectClass = values[0].id.toString();
        selectClassData.clear();
        selectClassData.addAll(values);
      }
    });
  }


  Future<void> getEventDetailsData({required String id}) async {
    try {
      isDetailsLoading.value =  true;

      final response = await http.get(
        Uri.parse(ApiUrls.eventsDetails+"/$id"),
        headers: await getAuthHeader(),);

      print("Event Repository...${response.body}");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Event responseData  : ${responseData}");

        getEventDetailsModel.value = EventDetails.fromJson(responseData);
        eventName.text = getEventDetailsModel.value.data!.eventName!;
        dobController.text = getEventDetailsModel.value.data!.date!;
        message.text = getEventDetailsModel.value.data!.message!;
        selectClass = getEventDetailsModel.value.data!.classId!.toString();

        isDetailsLoading.value =  false;
      } else {
        isDetailsLoading.value =  false;
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateEventAPI(BuildContext context,String id ,String name , String Class,String date,String message ) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      // isDataLoading.value = true;
      Map body = {
        "id": id,
        "event_name":name,
        "event_class_id": int.parse(selectClass!),
        "message":message,
        "date":date
      };
      // selectClass,
      print(body);

      final response = await http.post(
        Uri.parse(ApiUrls.updateEvents),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Event responseData  : ${responseData}");

        if(responseData['status']) {
          Get.back();
          Helpers.hideLoader(loader);
          final evenetDetailController = Get.put(EvenetDetailController());
          evenetDetailController.selectedClassId.value = int.parse(selectClass!);
          evenetDetailController.getEventData(classId: int.parse(selectClass!),dateFormat : date);
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