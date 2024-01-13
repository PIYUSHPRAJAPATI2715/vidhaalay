import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/models/studentModel/student_attandance_model.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/resourses/api_constant.dart';

class GetStudentAttandanceController extends GetxController {
  Rx<GetStudentAttandanceModel> getStudentAttandanceModel = GetStudentAttandanceModel().obs;
  RxBool isDataLoading = true.obs;


  Future<void> getAttandanceData() async {
    try {
      print("eNTER");

      isDataLoading.value = true;

      SharedPreferences pref = await SharedPreferences.getInstance();
      int stuID = int.parse(await pref.getString('studentId')!);
      print("classID : $stuID");


      final response = await http.get(
        Uri.parse(ApiUrls.getStudentAttendance+'/$stuID'),
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