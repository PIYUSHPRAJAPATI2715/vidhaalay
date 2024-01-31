import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/models/TeacherModel/create_event_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';

import '../../widgets/resources.dart';


class CreateEventController extends GetxController {
  Rx<CreateEvent> createEventModel = CreateEvent().obs;

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
  // RxList selectClassData = [
  //   // 'Select Class',
  //   '7th', '8th', '9th', '10th',
  //   '11th', '12th',
  // ].obs;
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
        firstDate:  DateTime.now(),
        lastDate: DateTime(2099));

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


  Future<void> createEventAPI(BuildContext context) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      // isDataLoading.value = true;
      String eveName = capitalizeFirstLetter(eventName.text);

      Map body = {
          "event_name": eveName,
          "event_class_id": int.parse(selectClass!),
          "message": message.text,
          "date": dobController.text
      };
      // selectClass,

      final response = await http.post(
        Uri.parse(ApiUrls.createEvents),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Event responseData  : ${responseData}");

        createEventModel.value = CreateEvent.fromJson(responseData);

        if(createEventModel.value.status!) {
          Get.back();
          Helpers.hideLoader(loader);
        } else {
          Helpers.hideLoader(loader);
        }
        showToast(message:createEventModel.value.msg.toString());
      } else {

        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}