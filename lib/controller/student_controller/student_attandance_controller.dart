import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay/models/studentModel/student_attandance_model.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay/resourses/api_constant.dart';

class GetStudentAttandanceController extends GetxController {
  Rx<GetStudentAttandanceModel> getStudentAttandanceModel = GetStudentAttandanceModel().obs;
  RxBool isDataLoading = true.obs;
  RxString selectedDate = "".obs;
  RxInt selectedIndex = 0.obs;
  RxInt selectedMonthIndex = 0.obs;
  RxInt selectedMonth = 0.obs;
  RxInt selectedYear = 0.obs;
  RxList daysInMonth = [].obs;

  Future<void> getAttandanceData() async {
    try {
      print("eNTER");

      isDataLoading.value = true;

      SharedPreferences pref = await SharedPreferences.getInstance();
      int stuID = int.parse(await pref.getString('id')!);
      print("classID : $stuID");
      print("selectedMonth : ${selectedMonth.value.toString()}");
      print("selectedYear : ${selectedYear.value.toString()}");


      final response = await http.get(
        Uri.parse(ApiUrls.getStudentAttendance+'/${selectedMonth.value.toString()}/${selectedYear.value.toString()}'),
        // body: jsonEncode(body),
        headers: await getAuthHeader(),);
      print("call back");
      print("att responseData  : ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("att responseData  : ${responseData}");

        getStudentAttandanceModel.value = GetStudentAttandanceModel.fromJson(responseData);
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