import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/timetable_model.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';

class StudentClassTimeController extends GetxController{
  RxBool isDataLoading = true.obs;
  Rx<GetTimetableModel> getTimetableModel = GetTimetableModel().obs;

  String? selectedDate;
  RxInt selectedIndex = 0.obs;
  RxInt selectedMonthIndex = 0.obs;

  Future<void> getTimeTableData() async {
    try {
      isDataLoading.value = true;
      SharedPreferences pref = await SharedPreferences.getInstance();
      int classId = int.parse(await pref.getString('classId')!);
      print("classID : $classId");

      Map body = {
        "class_id": classId,
        "date": selectedDate
        // "class_id": 2,
        // "date": "2024-01-08"
      };

      // Map body = {
      //   "class_id": 13
      // };
      print("body : $body");

      final response = await http.post(
        Uri.parse(ApiUrls.getTimetable),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {

        var responseData = jsonDecode(response.body);
        print("Time Table responseData  : ${responseData}");

        getTimetableModel.value = GetTimetableModel.fromJson(responseData);
        isDataLoading.value = false;
      } else {
        isDataLoading.value = false;
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}